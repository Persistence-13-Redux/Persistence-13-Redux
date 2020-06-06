// /datum/stock_market
// 	var/takedata = 1 HOUR

// /datum/stock_market/proc/process()
// 	if(round_duration_in_ticks > takedata)
// 		takedata = round_duration_in_ticks + 1 HOUR
// 		TakeData()
// 	for(var/datum/world_faction/business/faction in GLOB.all_world_factions)
// 		faction.verify_orders()

// /datum/stock_market/proc/TakeData()
// 	for(var/datum/world_faction/business/faction in GLOB.all_world_factions)
// 		faction.stock_sales_data += "[faction.stock_sales]"
// 		if(faction.stock_sales_data.len > 24)
// 			faction.stock_sales_data.Cut(1,2)
// 		faction.stock_sales = 0