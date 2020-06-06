// /datum/stock_contract

// /datum/stock_contract/contract_signed(var/obj/item/weapon/paper/contract/contract)
// 	var/datum/world_faction/business/connected_faction = FindFaction(contract.stocks_source_uid)
// 	if(connected_faction && istype(connected_faction))
// 		var/datum/stockholder/holder = connected_faction.get_stockholder_datum(contract.created_by)
// 		if(!holder || holder.stocks < contract.ownership)
// 			contract.cancel()
// 			return 0
// 		if(contract.finalize())
// 			var/datum/money_account/ACC
// 			if(contract.signed_account_number)
// 				ACC = get_account(text2num(contract.signed_account_number))
// 			else
// 				ACC = get_money_account_by_name(contract.signed_by)
// 			if(ACC)
// 				ACC.withdraw(contract.required_cash, "Stock Contract", "Stock Contract")
// 			var/datum/stockholder/newholder
// 			newholder = connected_faction.get_stockholder_datum(contract.signed_by)
// 			if(!newholder)
// 				newholder = new()
// 				newholder.real_name = contract.signed_by
// 				connected_faction.stock_holders[contract.signed_by] = newholder
// 			newholder.stocks += contract.ownership
// 			holder.stocks -= contract.ownership
// 			if(!holder.stocks)
// 				connected_faction.stock_holders -= holder.real_name
// 			return 1