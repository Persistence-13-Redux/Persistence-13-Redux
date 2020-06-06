/datum/material_market_entry
	var/name = ""
	var/typepath = /obj/item/stack/material
	var/PriorityQueue/buyorders
	var/PriorityQueue/sellorders
	var/sales = 0 // sales this hour
	var/list/sales_data = list() // sales in the past 24 hours

/datum/material_market_entry/New()
	// buyorders = new /PriorityQueue(/proc/cmp_buyorders)
	// sellorders = new /PriorityQueue(/proc/cmp_sellorders)

/datum/material_market_entry/proc/get_last_hour()
	if(!sales_data.len) return 0
	return text2num(sales_data[sales_data.len])

/datum/material_market_entry/proc/get_last_24()
	var/total = 0
	for(var/x in sales_data)
		total += text2num(x)
	return total

/datum/material_market_entry/proc/get_best_buy()
	if(!buyorders.L.len) return null
	var/datum/material_order/order = buyorders.L[1]
	if(order)
		return order.price

/datum/material_market_entry/proc/get_best_sell()
	if(!sellorders.L.len) return null
	var/datum/material_order/order = sellorders.L[1]
	if(order)
		return order.price

/datum/material_market_entry/proc/fill_order(var/datum/material_order/buyorder, var/datum/material_order/sellorder)
	// if(buyorder.price > sellorder.price) return
	// var/buyer_name = ""
	// var/seller_name = ""
	// var/datum/world_faction/buyerfaction
	// var/datum/world_faction/sellerfaction
	// var/moving = min(buyorder.get_remaining_volume(), sellorder.get_remaining_volume())
	// var/cost = moving*sellorder.price
	// if(buyorder.admin_order)
	// 	buyer_name = "Nexus Economic Module"
	// else
	// 	buyerfaction = FindFaction(buyorder.faction_uid)
	// 	if(!buyerfaction || !buyerfaction.cargo_telepads.len)
	// 		buyorders.L -= buyorder
	// 		return 0
	// 	buyer_name = buyerfaction.name
	// if(sellorder.admin_order)
	// 	seller_name = "Nexus Economic Module"
	// else
	// 	sellerfaction = FindFaction(sellorder.faction_uid)
	// 	if(!sellerfaction)
	// 		sellorders.L -= sellorder
	// 		return 0
	// 	seller_name = sellerfaction

	// if(!buyerfaction || buyerfaction.central_account.money >= cost)
	// 	if(!sellerfaction || sellerfaction.take_inventory(typepath, moving))
	// 		if(buyerfaction)
	// 			buyerfaction.give_inventory(typepath, moving)
	// 			buyerfaction.central_account.withdraw(cost, "Buy Order for [moving] units of [name]", "Material Marketplace")
	// 		if(sellerfaction)
	// 			//transfer the money
	// 			sellerfaction.central_account.deposit(cost, "Sell Order for [moving] units of [name]", "Material Marketplace")
	// 		sellorder.filled += moving
	// 		buyorder.filled += moving
	// 		sales += moving
	// 		if(!sellorder.get_remaining_volume())
	// 			sellorders.L -= sellorder
	// 		if(!buyorder.get_remaining_volume())
	// 			buyorders.L -= buyorder
	// 	else
	// 		sellorders.L -= sellorder
	// 		return 0
	// else
	// 	buyorders.L -= buyorder
	// 	return 0

/datum/material_market_entry/proc/cancel_order(var/datum/material_order/order)
	// buyorders.L -= order
	// sellorders.L -= order

/datum/material_market_entry/proc/add_buyorder(var/price, var/volume, var/faction_uid)
	var/datum/material_order/order = new()
	order.price = price
	order.volume = volume
	order.faction_uid = faction_uid
	for(var/datum/material_order/sell_order in sellorders.L)
		if(!order.get_remaining_volume()) break
		if(sell_order.price <= order.price)
			fill_order(order, sell_order)
	if(!order.get_remaining_volume()) // order filled
		return 1
	buyorders.Enqueue(order)

/datum/material_market_entry/proc/add_sellorder(var/price, var/volume, var/faction_uid)
	var/datum/material_order/order = new()
	order.price = price
	order.volume = volume
	order.faction_uid = faction_uid
	for(var/datum/material_order/buy_order in buyorders.L)
		if(!order.get_remaining_volume()) break
		if(order.price <= buy_order.price)
			fill_order(buy_order, order)
	if(!order.get_remaining_volume()) // order filled
		return 1
	sellorders.Enqueue(order)

/datum/material_market_entry/proc/get_buyvolume()
	var/volume = 0
	for(var/datum/material_order/buy_order in buyorders.L)
		volume += buy_order.volume
	return volume

/datum/material_market_entry/proc/get_sellvolume()
	var/volume = 0
	for(var/datum/material_order/sell_order in sellorders.L)
		volume += sell_order.volume
	return volume

/datum/material_market_entry/proc/get_buyprice(var/volume)
	var/final_price = 0
	var/remaining_volume = volume
	for(var/datum/material_order/sell_order in sellorders.L)
		if(!remaining_volume) break
		var/transact = min(sell_order.get_remaining_volume(), remaining_volume)
		final_price += transact*sell_order.price
		remaining_volume -= transact
	return final_price

/datum/material_market_entry/proc/verify_orders()
	for(var/datum/material_order/order in buyorders.L)
		if(order.admin_order) continue
		var/datum/world_faction/faction = FindFaction(order.faction_uid)
		if(!faction || !faction.central_account)
			buyorders.L -= order
			continue
		if(faction.central_account.money < order.get_total_value())
			buyorders.L -= order
			continue
	for(var/datum/material_order/order in sellorders.L)
		if(order.admin_order) continue
		var/datum/world_faction/faction = FindFaction(order.faction_uid)
		if(!faction || !faction.inventory)
			sellorders.L -= order
			continue
		if(faction.inventory.vars[name] < order.get_remaining_volume())
			sellorders.L -= order
			continue

/datum/material_market_entry/proc/add_buyorder_admin(var/price, var/volume)
	var/datum/material_order/order = new()
	order.price = price
	order.volume = volume
	order.admin_order = 1
	for(var/datum/material_order/sell_order in sellorders.L)
		if(!order.get_remaining_volume()) break
		if(sell_order.price <= order.price)
			fill_order(order, sell_order)
	if(!order.get_remaining_volume()) // order filled
		return 1
	buyorders.Enqueue(order)

/datum/material_market_entry/proc/add_sellorder_admin(var/price, var/volume)
	var/datum/material_order/order = new()
	order.price = price
	order.volume = volume
	order.admin_order = 1
	for(var/datum/material_order/buy_order in buyorders.L)
		if(!order.get_remaining_volume()) break
		if(order.price <= buy_order.price)
			fill_order(buy_order, order)
	if(!order.get_remaining_volume()) // order filled
		return 1
	sellorders.Enqueue(order)

/datum/material_market_entry/proc/quick_buy(var/volume, var/faction_uid)
	var/final_price = 0
	var/remaining_volume = volume
	for(var/datum/material_order/sell_order in sellorders.L)
		if(!remaining_volume) break
		var/transact = min(sell_order.get_remaining_volume(), remaining_volume)
		final_price += transact*sell_order.price
		remaining_volume -= transact
	add_buyorder(final_price, volume, faction_uid)

/datum/material_market_entry/proc/get_sellprice(var/volume)
	var/final_price = 0
	var/remaining_volume = volume
	for(var/datum/material_order/buy_order in buyorders.L)
		if(!remaining_volume) break
		var/transact = min(buy_order.get_remaining_volume(), remaining_volume)
		final_price += transact*buy_order.price
		remaining_volume -= transact
	return final_price

/datum/material_market_entry/proc/quick_sell(var/volume, var/faction_uid)
	var/final_price = 0
	var/remaining_volume = volume
	for(var/datum/material_order/buy_order in buyorders.L)
		if(!remaining_volume) break
		var/transact = min(buy_order.get_remaining_volume(), remaining_volume)
		final_price += transact*buy_order.price
		remaining_volume -= transact
	add_sellorder(final_price, volume, faction_uid)