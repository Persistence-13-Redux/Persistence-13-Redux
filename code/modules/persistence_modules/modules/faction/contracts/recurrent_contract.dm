/datum/world_faction
	var/list/service_medical_business = list() // list of all organizations linked into the medical service for this business
	var/list/service_medical_personal = list() // list of all people linked int othe medical service for this business
	var/list/service_security_business = list() // list of all orgs linked to the security services
	var/list/service_security_personal = list() // list of all people linked to the security services


/obj/item/weapon/paper/contract/recurring
	var/sign_type = CONTRACT_BUSINESS
	var/contract_payee = ""
	var/contract_desc = ""
	var/contract_title = ""
	var/additional_function = CONTRACT_SERVICE_NONE
	var/contract_paytype = CONTRACT_PAY_NONE
	var/contract_balance = 0
	var/contract_pay = 0

//#TODO: figure out if this is even used?
/obj/item/weapon/paper/contract/recurring/show_content(mob/user, forceshow)
	// var/can_read = (istype(user, /mob/living/carbon/human) || isghost(user) || istype(user, /mob/living/silicon)) || forceshow
	// if(!forceshow && istype(user,/mob/living/silicon/ai))
	// 	var/mob/living/silicon/ai/AI = user
	// 	can_read = get_dist(src, AI.camera) < 2
	// var/info2 = info

	// switch(state)
	// 	if(CONTRACT_STATE_CANCELLED)
	// 		info2 += "<br>This contract has been cancelled. This can be shredded."
	// 	if(CONTRACT_STATE_FINALIZED)
	// 		info2 += "<br>This contract has been finalized. This is just for record keeping."
	// 	if(CONTRACT_STATE_SIGNED)
	// 		info2 += "<br>This contract has been signed and is pending finalization."
	// 	else 
	// 		if(src.Adjacent(user))
	// 			if(sign_type == CONTRACT_PERSON)
	// 				info2 += "<br>Signature:<br><A href='?src=\ref[src];sign=1'>Sign here</A>"
	// 			else
	// 				info2 += "<br>Organization signature:<br><A href='?src=\ref[src];sign=1'>Sign here</A>"

	// show_browser(user, "<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY bgcolor='[color]'>[can_read ? info2 : stars(info)][stamps]</BODY></HTML>", "window=[name]")
	// onclose(user, "[name]")

/obj/item/weapon/paper/contract/recurring/Sign(name, account_number, mob/user, obj/item/weapon/card/id/card)
	// if(is_closed()) 
	// 	return
	// if(sign_type == CONTRACT_BUSINESS)
	// 	var/obj/item/weapon/card/id/id = usr.GetIdCard()
	// 	if(id)
	// 		if(id.selected_faction_uid == contract_payee)
	// 			to_chat(usr, "An organization cannot sign its own contract.")
	// 			return 0
	// 		var/datum/world_faction/connected_faction = FindFaction(id.selected_faction_uid)
	// 		if(connected_faction)
	// 			if(has_access(list(core_access_contracts), list(), usr.GetAccess(connected_faction.uid)))
	// 				if(contract_paytype == CONTRACT_PAY_NONE || contract_pay <= connected_faction.central_account.money)
	// 					var/datum/recurring_contract/new_contract = new()
	// 					new_contract.name = contract_title
	// 					new_contract.payer_type = sign_type

	// 					new_contract.payee = contract_payee

	// 					new_contract.payer = connected_faction.uid
	// 					new_contract.details = contract_desc

	// 					new_contract.auto_pay = contract_paytype
	// 					new_contract.pay_amount = contract_pay
	// 					new_contract.balance = contract_balance
	// 					new_contract.func = additional_function
	// 					new_contract.signer_name = usr.real_name

	// 					GLOB.contract_database.add_contract(new_contract)
	// 					signed = 1
	// 					approved = 1
	// 					info = replacetext(info, "*Unsigned*", "[connected_faction.uid]")
	// 					signed_by = usr.real_name
	// 					update_icon()
	// 				else
	// 					to_chat(usr, "Insufficent funds to sign contract.")
	// 					return

	// 			else
	// 				to_chat(usr, "Access denied. Cannot sign contracts for [connected_faction.name].")
	// 				return
	// else if(contract_paytype == CONTRACT_PAY_NONE) 
	// 	if(contract_pay <= get_money_account_balance_by_name(usr.real_name))
	// 		var/datum/recurring_contract/new_contract = new()
	// 		new_contract.name = contract_title
	// 		new_contract.payer_type = sign_type

	// 		new_contract.payee = contract_payee

	// 		new_contract.payer = usr.real_name
	// 		new_contract.details = contract_desc

	// 		new_contract.auto_pay = contract_paytype
	// 		new_contract.pay_amount = contract_pay
	// 		new_contract.balance = contract_balance
	// 		new_contract.func = additional_function
	// 		new_contract.signer_name = usr.real_name

	// 		GLOB.contract_database.add_contract(new_contract)
	// 		signed = 1
	// 		approved = 1
	// 		update_icon()
	// 		info = replacetext(info, "*Unsigned*", "[usr.real_name]")
	// 		signed_by = usr.real_name
	// 	else
	// 		to_chat(usr, "Insufficent funds to sign contract.")
	// 		return
