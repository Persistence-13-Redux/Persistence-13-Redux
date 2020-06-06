// //Gather a tally of all the stocks owned in total
// proc/GetTotalStocksHoldings(var/real_name)
// 	var/total = 0
// 	for(var/datum/world_faction/business/faction in GLOB.all_world_factions)
// 		var/holding = faction.get_stockholder(real_name)
// 		if(holding)
// 			total += holding
// 	return total

// //
// //
// //
// /datum/world_faction/proc/add_stockholder(var/real_name, var/_ownership)
// 	return FALSE

// /datum/world_faction/business/add_stockholder(var/_real_name, var/_ownership)
// 	stock_holders[_real_name] = new/datum/stockholder(_real_name, get_money_account_by_name(_real_name), _ownership)

// /datum/world_faction/business/proc/subscribe_stockholder(var/real_name)
// 	if(real_name in stock_holders)
// 		var/datum/stockholder/holder = stock_holders[real_name]
// 		holder.subscribed = 1

// /datum/world_faction/business/proc/unsubscribe_stockholder(var/real_name)
// 	if(real_name in stock_holders)
// 		var/datum/stockholder/holder = stock_holders[real_name]
// 		holder.subscribed = 0

// /datum/world_faction/business/proc/get_stockholder_datum(var/real_name)
// 	if(real_name in stock_holders)
// 		var/datum/stockholder/holder = stock_holders[real_name]
// 		return holder

// /datum/world_faction/proc/get_stockholder(var/real_name)
// 	return null

// /datum/world_faction/business/get_stockholder(var/real_name)
// 	if(real_name in stock_holders)
// 		var/datum/stockholder/holder = stock_holders[real_name]
// 		return holder.stocks

// /datum/world_faction/business/proc/get_stockholder_subscribed(var/real_name)
// 	if(real_name in stock_holders)
// 		var/datum/stockholder/holder = stock_holders[real_name]
// 		return holder.subscribed

// /datum/world_faction/business/proc/has_proposal(var/real_name)
// 	for(var/datum/stock_proposal/proposal in proposals)
// 		if(proposal.started_by == real_name) return 1

// /datum/world_faction/business/proc/verify_orders()
// 	for(var/datum/stock_order/order in buyorders.L)
// 		var/datum/money_account/A = get_money_account_by_name(order.real_name)
// 		if(!A)
// 			buyorders.L -= order
// 			continue
// 		if(A.get_balance() < order.get_total_value())
// 			buyorders.L -= order
// 			continue
// 	for(var/datum/stock_order/order in sellorders.L)
// 		if(get_stockholder(order.real_name) < order.get_remaining_volume())
// 			sellorders.L -= order
// 			continue

// /datum/world_faction/business/proc/get_last_hour()
// 	if(!stock_sales_data.len) return 0
// 	return text2num(stock_sales_data[stock_sales_data.len])

// /datum/world_faction/business/proc/get_last_24()
// 	var/total = 0
// 	for(var/x in stock_sales_data)
// 		total += text2num(x)
// 	return total

// /datum/world_faction/business/proc/get_best_buy()
// 	if(!buyorders.L.len) return null
// 	var/datum/stock_order/order = buyorders.L[1]
// 	if(order)
// 		return order.price

// /datum/world_faction/business/proc/get_best_sell()
// 	if(!sellorders.L.len) return null
// 	var/datum/stock_order/order = sellorders.L[1]
// 	if(order)
// 		return order.price

// /datum/world_faction/business/proc/fill_order(var/datum/stock_order/buyorder, var/datum/stock_order/sellorder)
// 	if(buyorder.price > sellorder.price) return
// 	var/buyer_name = buyorder.real_name
// 	var/moving = min(buyorder.get_remaining_volume(), sellorder.get_remaining_volume())
// 	var/datum/stockholder/initial_holder = get_stockholder_datum(sellorder.real_name)
// 	if(initial_holder.stocks < moving)
// 		moving = initial_holder.stocks
// 	var/cost = moving * sellorder.price

// 	var/datum/money_account/buyer_acc = get_money_account_by_name(buyer_name)
// 	var/datum/money_account/seller_acc = get_money_account_by_name(sellorder.real_name)
// 	if(!buyer_acc || !seller_acc)
// 		return
// 	if(!buyer_acc.money >= cost)
// 		var/datum/stockholder/new_holder = get_stockholder_datum(buyer_name)
// 		if(!new_holder)
// 			new_holder = new()
// 			new_holder.real_name = buyer_name
// 			stock_holders |= new_holder
// 		buyer_acc.transfer(seller_acc, cost, "Sell Order for [moving] stocks of [uid]")
// 		sellorder.filled += moving
// 		buyorder.filled += moving
// 		stock_sales += moving
// 		if(!sellorder.get_remaining_volume())
// 			sellorders.L -= sellorder
// 		if(!buyorder.get_remaining_volume())
// 			buyorders.L -= buyorder
// 	else
// 		buyorders.L -= buyorder
// 		return 0

// /datum/world_faction/business/proc/cancel_order(var/datum/stock_order/order)
// 	buyorders.L -= order
// 	sellorders.L -= order

// /datum/world_faction/business/proc/add_buyorder(var/price, var/volume, var/real_name)
// 	var/datum/stock_order/order = new()
// 	order.price = price
// 	order.volume = volume
// 	order.real_name = real_name
// 	for(var/datum/stock_order/sell_order in sellorders.L)
// 		if(!order.get_remaining_volume()) break
// 		if(sell_order.price <= order.price)
// 			fill_order(order, sell_order)
// 	if(!order.get_remaining_volume()) // order filled
// 		return 1
// 	buyorders.Enqueue(order)

// /datum/world_faction/business/proc/add_sellorder(var/price, var/volume, var/real_name)
// 	var/datum/stock_order/order = new()
// 	order.price = price
// 	order.volume = volume
// 	order.real_name = real_name
// 	for(var/datum/stock_order/buy_order in buyorders.L)
// 		if(!order.get_remaining_volume()) break
// 		if(order.price <= buy_order.price)
// 			fill_order(buy_order, order)
// 	if(!order.get_remaining_volume()) // order filled
// 		return 1
// 	sellorders.Enqueue(order)

// /datum/world_faction/business/proc/get_buyvolume()
// 	var/volume = 0
// 	for(var/datum/stock_order/buy_order in buyorders.L)
// 		volume += buy_order.volume
// 	return volume

// /datum/world_faction/business/proc/get_sellvolume()
// 	var/volume = 0
// 	for(var/datum/stock_order/sell_order in sellorders.L)
// 		volume += sell_order.volume
// 	return volume

// /datum/world_faction/business/proc/get_buyprice(var/volume)
// 	var/final_price = 0
// 	var/remaining_volume = volume
// 	for(var/datum/stock_order/sell_order in sellorders.L)
// 		if(!remaining_volume) break
// 		var/transact = min(sell_order.get_remaining_volume(), remaining_volume)
// 		final_price += transact*sell_order.price
// 		remaining_volume -= transact
// 	return final_price


// /datum/world_faction/business/proc/create_proposal(var/real_name, var/func, var/target)
// 	var/datum/stock_proposal/proposal = new()
// 	proposal.started_by = real_name
// 	proposal.func = func
// 	proposal.target = target
// 	switch(func)
// 		if(STOCKPROPOSAL_CEOFIRE)
// 			proposal.required = 51
// 			proposal.name = "Proposal to fire the current CEO."
// 		if(STOCKPROPOSAL_CEOREPLACE)
// 			proposal.required = 51
// 			proposal.name = "Proposal to make [target] the CEO of the business."
// 		if(STOCKPROPOSAL_CEOWAGE)
// 			proposal.name = "Proposal to change CEO wage to [target]."
// 			if(target > get_ceo_wage())
// 				proposal.required = 75
// 			else
// 				proposal.required = 51
// 		if(STOCKPROPOSAL_CEOTAX)
// 			proposal.name = "Proposal to change CEO revenue share to [target]."
// 			if(target > ceo_tax)
// 				proposal.required = 75
// 			else
// 				proposal.required = 51
// 		if(STOCKPROPOSAL_STOCKHOLDERTAX)
// 			proposal.name = "Proposal to change stockholders revenue share to [target]."
// 			if(target < ceo_tax)
// 				proposal.required = 61
// 			else
// 				proposal.required = 51
// 		if(STOCKPROPOSAL_INSTANTDIVIDEND)
// 			proposal.name = "Proposal to enact an instant dividend of [target]%."
// 			proposal.required = 51
// 		if(STOCKPROPOSAL_PUBLIC)
// 			proposal.name = "Proposal to publically list the business on the stock market."
// 			proposal.required = 51
// 		if(STOCKPROPOSAL_UNPUBLIC)
// 			proposal.name = "Proposal to remove the business from the stock market listings.."
// 			proposal.required = 75
// 	proposals |= proposal
// 	proposal.connected_faction = src

// /datum/world_faction/business/proc/surrender_stocks(var/real_name)
// 	var/datum/stockholder/holder = get_stockholder_datum(real_name)
// 	if(holder)
// 		if(stock_holders.len == 1) // last stock holder
// 			stock_holders.Cut()
// 			LAZYREMOVE(GLOB.all_world_factions, src)
// 			qdel(src)
// 			return
// 		else
// 			var/remainder = holder.stocks % (stock_holders.len-1)
// 			var/division = (holder.stocks-remainder)/(stock_holders.len-1)
// 			stock_holders -= real_name
// 			for(var/datum/stockholder/secondholder in stock_holders)
// 				secondholder.stocks += division
// 			if(remainder)
// 				var/list/stock_holders_copy = stock_holders.Copy()
// 				for(var/x in 1 to remainder)
// 					if(!stock_holders_copy.len)
// 						stock_holders_copy = stock_holders.Copy()
// 					var/datum/stockholder/holderr = pick_n_take(stock_holders_copy)
// 					holderr.stocks++

// /datum/world_faction/business/proc/pass_proposal(var/datum/stock_proposal/proposal)
// 	if(!proposal) return
// 	switch(proposal.func)
// 		if(STOCKPROPOSAL_CEOFIRE)
// 			owner_name = ""
// 		if(STOCKPROPOSAL_CEOREPLACE)
// 			owner_name = proposal.target
// 			if(!get_record(proposal.target))
// 				add_member(proposal.target)
// 				var/datum/computer_file/report/crew_record/faction/record = new()
// 				if(record.load_from_global(proposal.target))
// 					records.faction_records |= record
// 		if(STOCKPROPOSAL_CEOWAGE)
// 			var/datum/accesses/access = CEO.accesses[1]
// 			access.pay = proposal.target
// 		if(STOCKPROPOSAL_CEOTAX)
// 			ceo_tax = proposal.target
// 		if(STOCKPROPOSAL_STOCKHOLDERTAX)
// 			stockholder_tax = proposal.target
// 		if(STOCKPROPOSAL_INSTANTDIVIDEND)
// 			instant_dividend(proposal.target)
// 		if(STOCKPROPOSAL_PUBLIC)
// 			public_stock = 1
// 		if(STOCKPROPOSAL_UNPUBLIC)
// 			public_stock = 0
// 			buyorders.L.Cut()
// 			sellorders.L.Cut()

// 	proposals -= proposal

// /datum/world_faction/business/proc/instant_dividend(var/target)
// 	if(target > 100) target = 100
// 	var/amount = (central_account.money/100)*target
// 	var/amount_taken = 0
// 	for(var/x in stock_holders)
// 		var/datum/stockholder/holder = stock_holders[x]
// 		var/holder_amount = round((amount/100)*holder.stocks)
// 		if(holder_amount)
// 			var/datum/money_account/target_account = get_account(holder.account_number)
// 			if(target_account)
// 				target_account.deposit(holder_amount, "Instant Dividend", "Nexus Economy Network")
// 				amount_taken += holder_amount
// 	if(amount_taken)
// 		central_account.withdraw(amount_taken, "Instant Dividend", "Nexus Economy Network")

// /datum/world_faction/business/proc/pay_dividends(var/datum/money_account/account, var/amount)
// 	var/ceo_amount
// 	var/stock_amount
// 	if(ceo_tax)
// 		ceo_amount = round((amount/100)*ceo_tax)
// 	if(stockholder_tax)
// 		stock_amount = round((amount/100)*stockholder_tax)
// 	if(ceo_amount)
// 		var/datum/character_records/CR = GetCharacterRecord(owner_name)
// 		if(CR)
// 			var/datum/money_account/target_account = get_money_account_by_name(owner_name)
// 			if(target_account)
// 				account.transfer(target_account, ceo_amount, "CEO Revenue Share")
// 			else
// 				log_error(" /datum/world_faction/business/proc/pay_dividends(): Can't find a linked bank account for [owner_name].")
// 		else
// 			log_error(" /datum/world_faction/business/proc/pay_dividends(): Can't find crew report for [owner_name].")
// 	if(stock_amount)
// 		var/amount_taken = 0
// 		for(var/x in stock_holders)
// 			var/datum/stockholder/holder = stock_holders[x]
// 			var/holder_amount = round((stock_amount/100)*holder.stocks)
// 			if(holder_amount)
// 				var/datum/money_account/target_account = get_account(holder.account_number)
// 				if(target_account)
// 					target_account.deposit(holder_amount, "Stockholder Revenue Share", "Nexus Economy Network")
// 					amount_taken += holder_amount
// 			if(amount_taken)
// 				account.withdraw(amount_taken, "Shareholder Revenue Share", "Nexus Economy Network")