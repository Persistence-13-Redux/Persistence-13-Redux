

// /datum/world_faction/business/after_load()
// 	if(CEO)
// 		if(!CEO.accesses.len)
// 			var/datum/accesses/access = new()
// 			access.name = "CEO"
// 			access.pay = 45
// 			access.expense_limit = 10000000
// 			CEO.accesses |= access
// 		else
// 			var/datum/accesses/access = CEO.accesses[1]
// 			access.expense_limit = 10000000
// 	..()

// /datum/world_faction/business/proc/get_ceo_wage()
// 	return CEO.get_pay(1)

// /datum/world_faction/business/get_assignment(var/assignment, var/real_name)
// 	if(real_name == owner_name)
// 		return CEO
// 	return ..()

// /datum/world_faction/business/close_business()
// 	for(var/obj/item/organ/internal/stack/stack in connected_laces)
// 		if(stack.owner)
// 			to_chat(stack.owner, "Your neural lace vibrates letting you know that [src.name] is closed for business and you have been automatically clocked out.")
// 		if(employment_log.len > 100)
// 			employment_log.Cut(1,2)
// 		employment_log += "At [stationdate2text()] [stationtime2text()] [stack.owner.real_name] clocked out."
// 	connected_laces.Cut()
// 	..()


//Create a new business and return it
/proc/CreateBusiness(var/uid, var/name, var/leadername, var/leaderpay = 0, var/starting_funds = 0, var/list/obj/item/weapon/paper/contract/contracts = list())
	if(!name || !uid)
		return
	if(FindFaction(uid))
		return
	for(var/obj/item/weapon/paper/contract/contract in contracts)
		if(contract.is_solvent())
			contract.cancel()
			return 0
	
	var/datum/world_faction/business/new_business = new(uid, name, "", "", "", null, leadername)
	new_business.add_member(leadername)
	new_business.setup_ceo(leadername)

	var/datum/money_account/CA = new_business.get_central_account()
	CA.deposit(starting_funds, "Business commitment balance")

	if(contracts)
		for(var/obj/item/weapon/paper/contract/contract in contracts)
			contract.finalize()
			//new_business.add_stockholder(contract.signer, contract.stocks)
			contracts -= contract
	LAZYDISTINCTADD(GLOB.all_world_factions, new_business)
	return new_business
