/datum/material_marketplace
	var/datum/material_market_entry/steel/steel
	var/datum/material_market_entry/glass/glass
	var/datum/material_market_entry/copper/copper
	var/datum/material_market_entry/gold/gold
	var/datum/material_market_entry/silver/silver
	var/datum/material_market_entry/wood/wood
	var/datum/material_market_entry/cloth/cloth
	var/datum/material_market_entry/leather/leather
	var/datum/material_market_entry/phoron/phoron
	var/datum/material_market_entry/diamond/diamond
	var/datum/material_market_entry/uranium/uranium
	var/list/all_products = list()
	var/takedata = 1 HOUR


/datum/material_marketplace/New()
	steel = new()
	glass = new()
	copper = new()
	gold = new()
	silver = new()
	wood = new()
	cloth = new()
	leather = new()
	phoron = new()
	diamond = new()
	uranium = new()
	all_products |= steel
	all_products |= glass
	all_products |= copper
	all_products |= gold
	all_products |= silver
	all_products |= wood
	all_products |= cloth
	all_products |= leather
	all_products |= phoron
	all_products |= diamond
	all_products |= uranium

/datum/material_marketplace/proc/process()
	if(round_duration_in_ticks > takedata)
		takedata = round_duration_in_ticks + 1 HOUR
		TakeData()
	for(var/datum/world_faction/faction in GLOB.all_world_factions)
		faction.rebuild_inventory()
	for(var/datum/material_market_entry/entry in all_products)
		entry.verify_orders()

/datum/material_marketplace/proc/TakeData()
	for(var/datum/material_market_entry/entry in all_products)
		entry.sales_data += "[entry.sales]"
		if(entry.sales_data.len > 24)
			entry.sales_data.Cut(1,2)
		entry.sales = 0