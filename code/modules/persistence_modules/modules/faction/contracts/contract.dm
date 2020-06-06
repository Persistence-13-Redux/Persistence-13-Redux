GLOBAL_LIST_EMPTY(pending_contracts) //Keeps a list of all the contracts that aren't completed. format is UUID = contract

//## If you change those below, remember to update the database! ##
var/const/CONTRACT_STATE_NONE = 0
var/const/CONTRACT_STATE_CANCELLED = 1
var/const/CONTRACT_STATE_SIGNED = 2
var/const/CONTRACT_STATE_FINALIZED = 3

var/const/CONTRACT_TYPE_DEFAULT = "default"
var/const/CONTRACT_TYPE_STOCKS = "stocks"
var/const/CONTRACT_TYPE_CLONING = "cloning"

/obj/item/weapon/paper/contract
	name = "contract"
	icon_state = "contract"
	var/purpose						//Explanation of the purpose of the contract
	var/uuid						//Database UUID generated for the contract

	//Signer
	var/signer						//Name of the character or faction uid of the signer
	var/signer_account = 0			//Bank account of the signer

	//Issuer
	var/issuer						//Entity on the receiving hand. Either a faction uid or a character name
	var/issuer_account = 0			//Receiving bank account of the contract
	var/creator

	//Traded value
	var/value = 0					//Value of the contract or 0 if no money involved
	var/stocks = 0					//Amount of stocks involved in the contract
	var/stocks_source_uid 			//Faction uid of the stocks being traded

	//State
	var/state = CONTRACT_STATE_NONE	//Whether the contract is signed, cancelled, completed, or else
	var/contract_type = CONTRACT_TYPE_DEFAULT	//Allows keeping track of the "type" of contract. Is just a string to be used by the contract issuer.
	var/list/extra_fields			//Additional info/vars that the handlers may want to add to the generic contract

/obj/item/weapon/paper/contract/Initialize()
	. = ..()
	if(uuid && !is_closed())
		GLOB.pending_contracts[uuid] = src
	update_icon()

/obj/item/weapon/paper/contract/Destroy()
	if(uuid)
		if(!is_closed())
			//The contract being destroyed voids it
			cancel()
			commit_to_db()
		GLOB.pending_contracts -= uuid
		uuid = null
	return ..()

/obj/item/weapon/paper/contract/after_load()
	. = ..()
	sync_from_db()

/obj/item/weapon/paper/contract/before_save()
	. = ..()
	commit_to_db()

//Fetch contract details from the database
/obj/item/weapon/paper/contract/proc/sync_from_db()
	if(!uuid)
		log_debug("Couldn't sync contract [src] \ref[src] to database! Invalid UUID: [uuid]!!")
		return FALSE
	else
		. = PSDB.contracts.SetContract(src)
		GLOB.pending_contracts[uuid] = src

//Commit contracts details to the db
/obj/item/weapon/paper/contract/proc/commit_to_db()
	if(!uuid)
		uuid = PSDB.contracts.CreateContract(src)
		GLOB.pending_contracts[uuid] = src
	else
		return PSDB.contracts.SetContract(src)

/obj/item/weapon/paper/contract/proc/is_solvent()
	var/datum/money_account/Acc
	if(!signer_account || !(Acc = get_account(signer_account)))
		return FALSE
	return Acc.money < value

/obj/item/weapon/paper/contract/on_update_icon()
	switch(state)
		if(CONTRACT_STATE_CANCELLED)
			icon_state = "contract-cancelled"
		if(CONTRACT_STATE_FINALIZED)
			icon_state = "contract-approved"
		if(CONTRACT_STATE_SIGNED)
			icon_state = "contract-pending"
		else
			icon_state = "contract"

/obj/item/weapon/paper/contract/show_content(mob/user, forceshow)
	var/can_read = (istype(user, /mob/living/carbon/human) || isghost(user) || istype(user, /mob/living/silicon)) || forceshow
	if(!forceshow && istype(user,/mob/living/silicon/ai))
		var/mob/living/silicon/ai/AI = user
		can_read = get_dist(src, AI.camera) < 2
	var/info2 = info
	switch(state)
		if(CONTRACT_STATE_CANCELLED)
			info2 += "<br>This contract has been cancelled. This can be shredded."
		if(CONTRACT_STATE_FINALIZED)
			info2 += "<br>This contract has been finalized. This is just for record keeping."
		if(CONTRACT_STATE_SIGNED)
			info2 += "<br>This contract has been signed and is pending finalization."
		if(CONTRACT_STATE_NONE)
			if(Adjacent(user))
				info2 += "<br><A href='?src=\ref[src];sign=1'>Sign here</A>"
	show_browser(user, "<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY bgcolor='[color]'>[can_read ? info2 : stars(info)][stamps]</BODY></HTML>", "window=[name]")
	onclose(user, "[name]")

/obj/item/weapon/paper/contract/attackby(var/obj/item/weapon/P, var/mob/user)
	if(istype(P, /obj/item/weapon/pen))
		return
	if (isPDA(P) || istype(P, /obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/I = P.GetIdCard()
		if(I && Sign_with_card(I, user))
			return 1
	return ..()

/obj/item/weapon/paper/contract/proc/Sign_with_card(var/obj/item/weapon/card/id/I, var/mob/user)
	var/account_number = I?.associated_account_number
	if(!account_number)
		to_chat(user, SPAN_WARNING("\The [I] doesn't have a bank account linked to it!"))
		return FALSE
	return Sign(I.registered_name, account_number, user, I)

/obj/item/weapon/paper/contract/proc/Sign(var/name, var/account_number, var/mob/user, var/obj/item/weapon/card/id/card = null)
	if(signer && state == CONTRACT_STATE_SIGNED)
		to_chat(user, SPAN_WARNING("You cannot sign a [src] twice!"))
		return FALSE
	if(is_closed())
		to_chat(user, SPAN_WARNING("This [src] is already completed."))
		return FALSE
	if(!user || user.incapacitated(INCAPACITATION_DEFAULT))
		to_chat(user, SPAN_WARNING("You cannot sign a [src] in your state.."))
		return FALSE
	var/datum/money_account/linked_account = AccessProtectedBankAccount(account_number, user, card)
	if(!CheckBankAccountUsable(linked_account))
		return FALSE
	if(linked_account.get_balance() < value && !linked_account.freeze_funds(contract_id(), value))
		to_chat(usr, "\icon[src][SPAN_WARNING("You lack the funds to cover the [value] [GLOB.using_map.local_currency_name]!")]")
		return FALSE
	
	signer_account = account_number
	signer = name
	state = CONTRACT_STATE_SIGNED
	info = replacetext(info, "*Unsigned*", "[signer]")
	commit_to_db()
	update_icon()

/obj/item/weapon/paper/contract/Topic(href, href_list)
	if(!usr || usr.incapacitated(INCAPACITATION_DEFAULT))
		return
	if(href_list["sign"])
		var/datum/money_account/linked_account = get_money_account_by_name(usr.real_name)
		Sign(usr.real_name, linked_account.account_number, usr)
		return
	return ..()

/obj/item/weapon/paper/contract/proc/cancel()
	if(is_closed())
		update_icon()
		return
	state = CONTRACT_STATE_CANCELLED
	var/datum/money_account/A = get_account(signer_account)
	if(A)
		A.unfreeze_funds(contract_id())
	info = replacetext(info, "*Unsigned*", "*Cancelled*")
	if(!uuid)
		return
	commit_to_db()
	update_icon()

/obj/item/weapon/paper/contract/proc/contract_id()
	return uuid

/obj/item/weapon/paper/contract/proc/finalize()
	if(!signer || signer == "")
		if(usr) to_chat(usr, SPAN_WARNING("Needs a signer to finalize the contract!"))
		return FALSE
	if(!uuid)
		log_error("Contract [src]\ref[src] was finalized without a UUID by [usr]\ref[usr]!")
		return FALSE
	if(value)
		var/datum/money_account/A = get_account(signer_account)
		if(!A)
			if(usr) to_chat(usr, SPAN_WARNING("The bank account for the signer couldn't be found!"))
			return FALSE
		if((A.money < value))
			if(usr) to_chat(usr, SPAN_WARNING("Not enough funds in [signer]'s account!"))
			return FALSE
		if(A.withdraw(value, purpose, "Digital Contract"))
			A.unfreeze_funds(contract_id()) //Unfreeze the money we held up
		var/datum/money_account/DA
		if(issuer && issuer_account && (DA = get_account(issuer_account)))
			DA.deposit(value, purpose, "Digital Contract")

	if(stocks)
		if(!TransferStocks(issuer, signer, stocks_source_uid, stocks))
			if(usr) to_chat(usr, SPAN_WARNING("Couldn't transfer the stocks! Refunded the contract!"))
			//Restore pre-finalize state
			if(value)
				var/datum/money_account/A = get_account(signer_account)
				if(A)
					A.deposit(value, "Refund for aborted contract [name] #[uuid], from [issuer]", "Digital Contract")
					A.freeze_funds(contract_id(), value) //Freeze the funds again
				var/datum/money_account/DA
				if(issuer && issuer_account && (DA = get_account(issuer_account)))
					DA.withdraw(value, "Refunded aborted contract [name] #[uuid], to [signer]", "Digital Contract")
			return FALSE

	state = CONTRACT_STATE_FINALIZED
	GLOB.pending_contracts -= src //We're not pending anymore
	update_icon()
	return TRUE

/obj/item/weapon/paper/contract/proc/is_closed()
	return state == CONTRACT_STATE_CANCELLED || state == CONTRACT_STATE_FINALIZED

// /datum/proc/contract_signed(var/obj/item/weapon/paper/contract/contract)
// 	return 0

// /datum/proc/contract_cancelled(var/obj/item/weapon/paper/contract/contract)
// 	return 0

//Helper proc to make a stock contract
/proc/MakeStockContract(var/loc, var/text, var/title, var/purpose, var/issuer, var/issuer_account, var/creator, var/amount_to_pay, var/amt_stocks, var/faction_uid)
	var/obj/item/weapon/paper/contract/C = MakeMiscContract(loc, text, title, purpose, issuer, issuer_account, creator, amount_to_pay, CONTRACT_TYPE_STOCKS, FALSE)
	C.stocks = amt_stocks
	C.stocks_source_uid = faction_uid
	C.commit_to_db()
	C.update_icon()
	return C

/proc/MakeMiscContract(var/loc, var/text, var/title, var/purpose, var/issuer, var/issuer_account, var/creator, var/amount_to_pay, var/contract_type = CONTRACT_TYPE_DEFAULT, var/should_commit= TRUE)
	var/obj/item/weapon/paper/contract/C = new(loc, text, title)
	C.name = title
	C.purpose = purpose
	C.issuer = issuer
	C.issuer_account = issuer_account
	C.creator = creator
	C.value = amount_to_pay
	if(should_commit)
		C.commit_to_db()
	C.update_icon()
	return C

