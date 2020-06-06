/datum/world_faction
	var/list/datum/supply_order/approved_orders = list()
	var/list/datum/supply_order/pending_orders = list()

/datum/world_faction/proc/queue_pending_order(var/datum/supply_order/O)
	pending_orders += O
	return TRUE

/datum/world_faction/proc/deny_pending_order(var/ordernum)
	for(var/datum/supply_order/O in pending_orders)
		if(O.ordernum == ordernum)
			pending_orders -= O
			return TRUE
	return FALSE

/datum/world_faction/proc/approve_pending_order(var/ordernum, var/payer = null, var/payer_has_expense = FALSE)
	var/datum/supply_order/SO = null
	for(var/datum/supply_order/O in pending_orders)
		if(O.ordernum == ordernum)
			SO = O
			break
	if(!SO)
		return FALSE
	var/object_cost = SO.object.cost*10
	if(get_member_available_expenses(payer) < object_cost)
		return FALSE
	pending_orders -= SO
	SO.paidby = payer
	if(payer_has_expense)
		add_to_member_expenses(payer, object_cost)
	queue_approved_order(SO)
	return TRUE

/datum/world_faction/proc/queue_approved_order(var/datum/supply_order/SO)
	central_account.withdraw(SO.object.cost * 10, "Import ([SO.object.name]) Auth: [SO.paidby] for [name]", "Central Authority Imports")
	approved_orders += SO
	return TRUE

/datum/world_faction/proc/dequeue_approved_order(var/datum/supply_order/O)
	central_account.deposit(O.object.cost * 10, "Refund for cancelled purchase of ([O.object.name]) Auth: [O.paidby] for [name]", "Central Authority Imports")
	O.paidby = null
	approved_orders -= O
	return TRUE

/datum/world_faction/proc/cancel_approved_order(var/ordernum, var/payer = null, var/payer_has_expense = FALSE)
	var/datum/supply_order/SO = null
	for(var/datum/supply_order/O in approved_orders)
		if(O.ordernum == ordernum)
			SO = O
	if(payer_has_expense)
		remove_from_member_expenses(payer, SO.object.cost*10)
	return dequeue_approved_order(SO)

/datum/world_faction/proc/finish_approved_order(var/ordernum, var/payer = null, var/payer_has_expense = FALSE)
	var/datum/supply_order/SO = null
	for(var/datum/supply_order/O in approved_orders)
		if(O.ordernum == ordernum)
			SO = O
	approved_orders -= SO
	return TRUE

/datum/world_faction/proc/pop_pending_order()
	var/datum/supply_order/so = null
	if(length(pending_orders))
		so = pending_orders[1]
		pending_orders.Remove(so)
	return so

/datum/world_faction/proc/pop_approved_order()
	var/datum/supply_order/so = null
	if(length(approved_orders))
		so = approved_orders[1]
		approved_orders.Remove(so)
	return so