//Use this to handle payment by using common payment items like expense cards and IDs
// Tax cut and account are for when a secondary account gets a cut of the money charged
/proc/HandlePaymentItems(var/mob/user, 
		var/obj/item/I, 
		var/transaction_amount, 
		var/datum/money_account/target_account, 
		var/purpose = "Payment", 
		var/source = "", 
		var/tax_cut = 0, 
		var/datum/money_account/tax_account = null,
		var/tax_account_purpose = "")
	
	if(istype(I, /obj/item/weapon/card/id))
		return PayWithIDCard(user, I, transaction_amount, target_account, purpose, source, tax_cut, tax_account, tax_account_purpose)
	else if(istype(I, /obj/item/weapon/card/expense))
		return PayWithExpenseCard(user, I, transaction_amount, target_account, purpose, source, tax_cut, tax_account, tax_account_purpose)
	return FALSE

//For a given payment item, returns the account that would pay using said item, or null
/proc/GetAccountFromPaymentItems(var/mob/user, var/obj/item/I)
	if(istype(I, /obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/ID = I
		return get_account(ID.associated_account_number)
	else if(istype(I, /obj/item/weapon/card/expense))
		var/obj/item/weapon/card/expense/EXP = I
		var/datum/world_faction/F = EXP? FindFaction(EXP.linked) : null
		return F?.get_central_account()
	return null

//Pay using a standard id card's account information
/proc/PayWithIDCard(var/mob/user, var/obj/item/weapon/card/id/I, var/transaction_amount, var/datum/money_account/target, var/purpose = "Payment", var/source = "", var/tax_cut = 0, var/datum/money_account/tax = null, var/tax_account_purpose = "")
	if(!I.associated_account_number || (I.associated_account_number && !get_money_account_exists(I.associated_account_number)))
		to_chat(user, SPAN_WARNING("No valid account linked to this card!"))
		return FALSE
	
	//Try access with security level 0 first
	var/datum/money_account/linked_account = attempt_account_access(I.associated_account_number, null, 0)
	if(!linked_account)
		//If nothing, try with security level 2
		var/pin = input("Enter pin code. Leave blank for none.", "Account pin") as num|null
		if(pin) 
			linked_account = attempt_account_access(I.associated_account_number, pin)

	if(!linked_account)
		to_chat(user, SPAN_WARNING("The account linked to \the [I] does not exist, or couldn't be accessed with the credentials supplied."))
		return  FALSE
	if(linked_account.suspended)
		linked_account = null
		to_chat(user, SPAN_WARNING("The account linked to \the [I] has been suspended."))
		return FALSE
	if(transaction_amount > linked_account.get_balance())
		to_chat(user, SPAN_WARNING("The account linked to \the [I] has insuficient funds to complete the transaction. You need [transaction_amount - linked_account.get_balance()] more [GLOB.using_map.local_currency_name]."))
		return FALSE

	if(PayWithTaxes(linked_account, target, tax, transaction_amount, tax_cut, purpose, source, tax_account_purpose))
		to_chat(user, SPAN_NOTICE("Payment succesful! Account [linked_account.account_name] has been charged [GLOB.using_map.local_currency_name_short][transaction_amount]."))
		return linked_account
	to_chat(user, SPAN_WARNING("Payment failed. Couldn't withdraw the neccessry funds for an unspecified reason. Contact your banking institution."))
	return FALSE

//Always charges the specified account the value of "to_pay".
//If there's a target account, the sum of to_pay - tax_cut will be deposited in the target account.
//If there's a tax account and a tax_cut value, the tax_cut amount will be deposited into the tax account, and the difference with to_pay in the target account if there is one
/proc/PayWithTaxes(var/datum/money_account/source, var/datum/money_account/target, var/datum/money_account/tax, var/to_pay, var/tax_cut = 0, var/purpose = "", var/source = "", var/tax_account_purpose = "")
	if(!source)
		return
	if(!source.withdraw(to_pay, purpose, source))
		return
	if(target)
		target.deposit(to_pay - tax_cut, purpose, source)
	if(tax)
		tax.deposit(tax_cut, tax_account_purpose? tax_account_purpose : purpose, "Cut on:" + source)
	return TRUE
	
//Pay using a faction issued expense card
/proc/PayWithExpenseCard(var/mob/user, var/obj/item/weapon/card/expense/expense_card, var/to_pay, var/datum/money_account/target, var/purpose = "Payment", var/source = "", var/tax_cut = 0, var/datum/money_account/tax = null, var/tax_account_purpose = "")
	if(!expense_card.valid)
		to_chat(user, SPAN_WARNING("\The [expense_card] is devalidated!"))
		return FALSE
	if(!expense_card.linked)
		to_chat(user, SPAN_WARNING("\The [expense_card] has no linked issuer!"))
		return FALSE
	var/datum/world_faction/F = FindFaction(expense_card.linked)
	if(!F)
		to_chat(user, SPAN_WARNING("The issuer of the [expense_card], \"[expense_card.linked]\" does not exists!"))
		return FALSE
	var/datum/money_account/source_account = F.get_central_account()
	if(!source_account)
		to_chat(user, SPAN_WARNING("The account for the issuer of the [expense_card], \"[expense_card.linked]\" does not exists!"))
		return FALSE
	var/available = F.get_member_available_expenses(expense_card.owner_name)
	if(available < to_pay)
		to_chat(user, SPAN_WARNING("This exceeds the expense limit attributed to [expense_card.owner_name] by [GLOB.using_map.local_currency_name_short][to_pay - available]."))
		return FALSE
	if(source_account.get_balance() < to_pay)
		to_chat(user, SPAN_WARNING("The account for the issuer of the [expense_card] does not have enough funds. Lacking [GLOB.using_map.local_currency_name_short][to_pay - source_account.get_balance()]."))
		return FALSE

	if(PayWithTaxes(source_account, target, tax, to_pay, tax_cut, purpose, source, tax_account_purpose))
		F.add_to_member_expenses(expense_card.owner_name, to_pay)
		to_chat(user, SPAN_NOTICE("Payment successful! [source_account.account_name] was debited [GLOB.using_map.local_currency_name_short][to_pay]."))
		return source_account
	to_chat(user, SPAN_WARNING("Payment failed. Couldn't withdraw the neccessry funds for an unspecified reason. Contact your banking institution."))
	return FALSE

/proc/CheckBankAccountUsable(var/datum/money_account/A, var/mob/user)
	if(!A)
		to_chat(user, SPAN_WARNING("The account couldn't be found!"))
		return FALSE
	if(A.suspended)
		to_chat(user, SPAN_WARNING("The account is currently suspended!"))
		return FALSE
	return TRUE

//Try to access the account, and interactively ask the user to enter their credentials. Supply a card if one is used in the payment.
//It'll handle security stuff for us
/proc/AccessProtectedBankAccount(var/account_number, var/mob/user, var/obj/item/weapon/card/id/card = null)
	if(!get_money_account_exists(account_number))
		return null
	//Try access with security level 0 first
	var/datum/money_account/acc = attempt_account_access(account_number, null, 0)
	if(!acc)
		//If nothing, try with security level 2
		var/pin = input(user, "Pin code required. Leave blank to cancel.", "Account pin") as num|null
		if(pin) 
			acc = attempt_account_access(account_number, pin, card && card.associated_account_number == account_number ? 2 : 1)
	return acc

