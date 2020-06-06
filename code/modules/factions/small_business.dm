// /proc/get_business(var/name)
// 	var/datum/small_business/found_faction
// 	for(var/datum/small_business/fac in GLOB.all_business)
// 		if(fac.name == name)
// 			found_faction = fac
// 			break
// 	return found_faction

// /proc/get_businesses(var/real_name)
// 	var/list/lis = list()
// 	for(var/datum/small_business/fac in GLOB.all_business)
// 		if(fac.is_allowed(real_name)) lis |= fac
// 	return lis

// /datum/small_business
// 	var/name = "" // can should never be changed and must be unique
// 	var/list/stock_holders = list() // Format list("real_name" = numofstocks) adding up to 100
// 	var/list/employees = list() // format list("real_name" = employee_data)

// 	var/datum/NewsFeed/feed

// 	var/datum/money_account/central_account

// 	var/ceo_name = ""
// 	var/ceo_payrate = 100
// 	var/ceo_title
// 	var/ceo_dividend = 0

// 	var/stock_holders_dividend = 0


// 	var/list/debts = list() // format list("Ro Laren" = "550") real_name = debt amount
// 	var/list/unpaid = list() // format list("Ro Laren" = numofshifts)

// 	var/list/connected_laces = list()

// 	var/tasks = ""
// 	var/sales_short = 0

// 	var/list/sales_long = list() // sales over the last 6 active hours
// 	var/list/proposals = list()
// 	var/list/proposals_old = list()

// 	var/tax_network = ""
// 	var/last_id_print = 0
// 	var/last_expense_print = 0
// 	var/last_balance = 0
// 	var/status = 1 // 1 = opened, 0 = closed

// /datum/small_business/New()
// 	central_account = create_account(name, 0)
// 	feed = new()
// 	feed.name = name
// 	feed.parent = src
// /datum/small_business/proc/get_debt()
// 	var/debt = 0
// 	for(var/x in debts)
// 		debt += text2num(debts[x])
// 	return debt
// /datum/small_business/proc/pay_debt()
// 	for(var/x in debts)
// 		var/debt = text2num(debts[x])
// 		if(!central_account.transfer(x, debt,"Postpaid Payroll"))
// 			return 0
// 		debts -= x

// /datum/small_business/contract_signed(var/obj/item/weapon/paper/contract/contract)
// 	if(get_stocks(contract.created_by) < contract.ownership)
// 		contract.cancel()
// 		return 0
// 	if(contract.finalize())
// 		if(contract.required_cash)
// 			var/datum/money_account/account = get_account(contract.pay_to)
// 			if(account)
// 				account.withdraw(contract.required_cash, contract.purpose, "[contract.signed_by] (via digital contract)")
// 		transfer_stock(contract.created_by, contract.signed_by, contract.ownership)
// 		return 1

// /datum/small_business/proc/transfer_stock(var/owner, var/new_owner, var/amount)
// 	var/holding = get_stocks(owner)
// 	if(holding < amount)
// 		return 0
// 	if(holding == amount)
// 		stock_holders -= owner
// 		if(new_owner in stock_holders)
// 			var/old_holding = get_stocks(new_owner)
// 			stock_holders[new_owner] = (old_holding + amount)
// 		else
// 			stock_holders[new_owner] = amount
// 	else
// 		stock_holders[owner] = (holding - amount)
// 		if(new_owner in stock_holders)
// 			var/old_holding = get_stocks(new_owner)
// 			stock_holders[new_owner] = (old_holding + amount)
// 		else
// 			stock_holders[new_owner] = amount

// /datum/small_business/proc/has_proposal(var/real_name)
// 	for(var/datum/proposal/proposal in proposals)
// 		if(proposal.started_by == real_name)
// 			return 1
// 	return 0



// /datum/small_business/proc/close()
// 	for(var/obj/item/organ/internal/stack/stack in connected_laces)
// 		clock_out(stack)
// 	status = 0

// /datum/small_business/proc/open()
// 	status = 1
// /datum/small_business/proc/is_allowed(var/real_name)
// 	if(real_name in employees)
// 		return 1
// 	if(real_name in stock_holders)
// 		return 1
// 	if(real_name == ceo_name)
// 		return 1

// /datum/small_business/proc/is_stock_holder(var/real_name)
// 	if(real_name in stock_holders)
// 		return 1

// /datum/small_business/proc/get_stocks(var/real_name)
// 	if(real_name in stock_holders)
// 		return text2num(stock_holders[real_name])
// 	return 0
// /datum/small_business/proc/is_clocked_in(var/real_name)
// 	for(var/obj/item/organ/internal/stack/stack in connected_laces)
// 		if(stack.get_owner_name() == real_name) return 1
// 	return 0

// /datum/small_business/proc/clock_in(var/obj/item/organ/internal/stack/stack)
// 	if(!stack) return
// 	connected_laces |= stack
// 	stack.business_mode = 1
// 	stack.connected_business = src.name
// 	stack.duty_status = 1
// /datum/small_business/proc/clock_out(var/obj/item/organ/internal/stack/stack)
// 	connected_laces -= stack
// 	stack.business_mode = 0
// 	stack.connected_business = ""
// 	stack.duty_status = 0
// /datum/small_business/proc/proposal_approved(var/datum/proposal/proposal)
// 	switch(proposal.func)
// 		if(1)
// 			if(ceo_name && ceo_name != "")
// 				var/old_name = ceo_name
// 				ceo_name = proposal.change
// 				UpdateIds(old_name)
// 			ceo_name = proposal.change
// 			UpdateIds(proposal.change)
// 		if(2)
// 			if(ceo_name && ceo_name != "")
// 				var/old_name = ceo_name
// 				ceo_name = ""
// 				UpdateIds(old_name)

// 		if(3)
// 			ceo_title = proposal.change
// 			if(ceo_name && ceo_name != "")
// 				UpdateIds(ceo_name)
// 		if(4)
// 			ceo_payrate = proposal.change
// 		if(5)
// 			ceo_dividend = proposal.change
// 		if(6)
// 			stock_holders_dividend = proposal.change

// 	if(proposals_old.len > 10)
// 		central_account.transaction_log.Cut(1,2)
// 	proposals -= proposal
// 	proposals_old += "*APPROVED* [proposal.name](Started by [proposal.started_by])"

// /datum/small_business/proc/proposal_denied(var/datum/proposal/proposal)
// 	proposals -= proposal
// 	proposals_old += "*DENIED* [proposal.name] (Started by [proposal.started_by])"

// /datum/small_business/proc/proposal_cancelled(var/datum/proposal/proposal)
// 	proposals -= proposal
// 	proposals_old += "*CANCELLED* [proposal.name] (Started by [proposal.started_by])"


// /datum/employee_data
// 	var/name = "" // real_name of the employee
// 	var/job_title = "New Hire"
// 	var/pay_rate = 25 // hourly rate of pay
// 	var/list/accesses = list()
// 	var/expense_limit = 0
// 	var/expenses = 0

// /datum/small_business/proc/get_expense_limit(var/real_name)
// 	if(real_name == ceo_name) return 100000
// 	if(real_name in employees)
// 		var/datum/employee_data/employee = employees[real_name]
// 		return employee.expense_limit
// 	return 0

// /datum/small_business/proc/get_expenses(var/real_name)
// 	if(real_name == ceo_name) return 0
// 	if(real_name in employees)
// 		var/datum/employee_data/employee = employees[real_name]
// 		return employee.expenses
// 	return 0

// /datum/small_business/proc/add_expenses(var/real_name, amount)
// 	if(real_name in employees)
// 		var/datum/employee_data/employee = employees[real_name]
// 		employee.expenses += amount
// 		return 1
// 	return 0

// /datum/small_business/proc/get_employee_data(var/real_name)
// 	if(real_name in employees)
// 		var/datum/employee_data/employee = employees[real_name]
// 		return employee
// 	return 0
// /datum/small_business/proc/is_employee(var/real_name)
// 	if(real_name in employees)
// 		return 1
// 	return 0

// /datum/small_business/proc/add_employee(var/real_name)
// 	if(real_name in employees)
// 		return 0
// 	var/datum/employee_data/employee = new()
// 	employee.name = real_name
// 	employees[real_name] = employee
// 	return 1

// /datum/small_business/proc/get_title(var/real_name)
// 	if(real_name in employees)
// 		var/datum/employee_data/employee = employees[real_name]
// 		return employee.job_title
// 	return 0

// /datum/small_business/proc/get_access(var/real_name)
// 	if(real_name in employees)
// 		var/datum/employee_data/employee = employees[real_name]
// 		return employee.accesses
// 	return 0

// /datum/small_business/proc/has_access(var/real_name, access)
// 	if(real_name == ceo_name) return 1
// 	if(real_name in employees)
// 		var/datum/employee_data/employee = employees[real_name]
// 		if(access in employee.accesses)
// 			return 1
// 	return 0


// /datum/small_business/proc/pay_tax(var/amount)
// 	if(!tax_network || tax_network == "") return 0
// 	var/datum/world_faction/connected_faction = FindFaction(tax_network)
// 	if(!connected_faction) return 0
// 	connected_faction.central_account.transfer(central_account, round(amount/100*connected_faction.tax_rate), "Tax")

// /datum/small_business/proc/pay_export_tax(var/amount, var/datum/world_faction/connected_faction)
// 	connected_faction.central_account.transfer(central_account, round(amount/100*connected_faction.export_profit), "Tax")
// 	return (amount/100*connected_faction.export_profit)