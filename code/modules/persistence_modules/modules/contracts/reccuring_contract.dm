/datum/recurring_contract
	var/name
	var/payee_type = CONTRACT_BUSINESS
	var/payer_type = CONTRACT_BUSINESS

	var/payee = ""
	var/payer = ""

	var/details = ""

	var/payee_cancelled = 0
	var/payee_completed = 0
	var/payee_clear = 0

	var/payer_cancelled = 0
	var/payer_completed = 0
	var/payer_clear = 0

	var/auto_pay = CONTRACT_PAY_NONE
	var/pay_amount = 0
	var/balance = 0

	var/last_pay = 0 // real time the payment went through

	var/func = "None"

	var/status = CONTRACT_STATUS_OPEN

	var/signer_name = ""

	var/cancel_party = ""
	var/cancel_reason = ""


// /datum/recurring_contract/after_load()
// 	add_services()

// /datum/recurring_contract/proc/get_status()
// 	switch(status)
// 		if(CONTRACT_STATUS_CANCELLED)
// 			return "Cancelled"
// 		if(CONTRACT_STATUS_COMPLETED)
// 			return "Completed"
// 		if(CONTRACT_STATUS_OPEN)
// 			return "Ongoing"

// /datum/recurring_contract/proc/get_paytype()
// 	switch(auto_pay)
// 		if(CONTRACT_PAY_NONE)
// 			return "None"
// 		if(CONTRACT_PAY_HOURLY)
// 			return "[pay_amount] Hourly"
// 		if(CONTRACT_PAY_DAILY)
// 			return "[pay_amount] Daily"
// 		if(CONTRACT_PAY_WEEKLY)
// 			return "[pay_amount] Weekly"

// /datum/recurring_contract/proc/get_marked(var/uid, var/type = CONTRACT_BUSINESS)
// 	if(payee_type == type)
// 		if(uid == payee)
// 			if(payee_completed)
// 				return 1
// 	if(payer_type == type)
// 		if(uid == payer)
// 			if(payer_completed)
// 				return 1

// /datum/recurring_contract/proc/handle_payment()
// 	var/datum/money_account/payer_account
// 	var/datum/money_account/payee_account
// 	if(payer_type == CONTRACT_BUSINESS)
// 		var/datum/world_faction/faction = FindFaction(payer)
// 		if(faction)
// 			payer_account = faction.get_central_account()
// 	else
// 		payer_account = get_money_account_by_name(payer)
// 	if(payer_account)
// 		if(payee_type == CONTRACT_BUSINESS)
// 			var/datum/world_faction/faction = FindFaction(payee)
// 			if(faction)
// 				payee_account = faction.get_central_account()
// 		else
// 			payee_account = get_money_account_by_name(payee)
// 		if(payee_account)
// 			if(payer_account.get_balance() >= pay_amount)
// 				payer_account.transfer(payee_account, pay_amount, "Contract Payment")
// 				last_pay = world.realtime
// 				if(balance > 0)
// 					balance -= pay_amount
// 					if (balance < 0)
// 						payer_account.transfer(payee_account, balance, "Reconciliation")
// 						balance = 0
// 					if (balance == 0)
// 						payee_completed = 1
// 						payer_completed = 1
// 				return 1
// 	return 0

// /datum/recurring_contract/proc/add_services()
// 	var/datum/world_faction/faction = FindFaction(payee)
// 	if(!faction) return
// 	if(CONTRACT_STATUS_OPEN)
// 		if(func == CONTRACT_SERVICE_MEDICAL)
// 			if(payer_type == CONTRACT_BUSINESS)
// 				faction.service_medical_business |= payer
// 			else
// 				faction.service_medical_personal |= payer
// 		if(func == CONTRACT_SERVICE_SECURITY)
// 			if(payer_type == CONTRACT_BUSINESS)
// 				faction.service_security_business |= payer
// 			else
// 				faction.service_security_personal |= payer

// /datum/recurring_contract/proc/remove_services()
// 	var/datum/world_faction/faction = FindFaction(payee)
// 	if(!faction) return
// 	if(CONTRACT_STATUS_OPEN)
// 		if(func == CONTRACT_SERVICE_MEDICAL)
// 			if(payer_type == CONTRACT_BUSINESS)
// 				faction.service_medical_business -= payer
// 			else
// 				faction.service_medical_personal -= payer
// 		if(func == CONTRACT_SERVICE_SECURITY)
// 			if(payer_type == CONTRACT_BUSINESS)
// 				faction.service_security_business -= payer
// 			else
// 				faction.service_security_personal -= payer

// /datum/recurring_contract/proc/update_status()
// 	if(CONTRACT_STATUS_OPEN)
// 		if(payee_completed && payer_completed)
// 			status = CONTRACT_STATUS_COMPLETED
// 		if(payee_cancelled)
// 			cancel_party = payee
// 			status = CONTRACT_STATUS_CANCELLED
// 			cancel_reason = "Manual Cancel"
// 		if(payer_cancelled)
// 			if (balance > 0) return
// 			cancel_party = payer
// 			status = CONTRACT_STATUS_CANCELLED
// 			cancel_reason = "Manual Cancel"
// 	if(payer_clear && payee_clear)
// 		GLOB.contract_database.all_contracts -= src

// /datum/recurring_contract/proc/process()
// 	if(auto_pay == CONTRACT_PAY_HOURLY)
// 		if(world.realtime >= (last_pay + 1 HOUR))
// 			if(!handle_payment())
// 				if (balance <= 0)
// 					cancel_party = payer
// 					cancel_reason = "Insufficent funds for autopay"
// 					status = CONTRACT_STATUS_CANCELLED
// 					remove_services()
// 	if(auto_pay == CONTRACT_PAY_DAILY)
// 		if(world.realtime >= (last_pay + 1 DAY))
// 			if(!handle_payment())
// 				if (balance <= 0)
// 					cancel_party = payer
// 					cancel_reason = "Insufficent funds for autopay"
// 					status = CONTRACT_STATUS_CANCELLED
// 					remove_services()
// 	if(auto_pay == CONTRACT_PAY_WEEKLY)
// 		if(world.realtime >= (last_pay + 7 DAYS))
// 			if(!handle_payment())
// 				if (balance <= 0)
// 					cancel_party = payer
// 					cancel_reason = "Insufficent funds for autopay"
// 					status = CONTRACT_STATUS_CANCELLED
// 					remove_services()
// 	update_status()
