// /datum/stock_proposal
// 	var/func = 0
// 	var/required = 0
// 	var/list/supporting = list()
// 	var/datum/stockholder/started_by
// 	var/name
// 	var/target
// 	var/datum/world_faction/business/connected_faction


// /datum/stock_proposal/proc/is_supporting(var/real_name)
// 	for(var/datum/stockholder/holder in supporting)
// 		if(holder.real_name == real_name) return 1

// /datum/stock_proposal/proc/is_started_by(var/real_name)
// 	if(started_by == real_name) return 1


// /datum/stock_proposal/proc/get_support()
// 	var/amount = 0
// 	for(var/datum/stockholder/holder in supporting)
// 		amount += holder.stocks
// 	if(amount > required)
// 		pass_proposal()
// 	return amount

// /datum/stock_proposal/proc/pass_proposal()
// 	connected_faction.pass_proposal(src)
