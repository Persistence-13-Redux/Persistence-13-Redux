GLOBAL_LIST_EMPTY(all_business)

/datum/world_faction/business
	var/datum/business_module/module
	// var/list/stock_holders = list()
	// var/datum/assignment/CEO
	var/list/proposals = list()

	var/ceo_tax = 0
	var/stockholder_tax = 0
	var/public_stock = 0

	var/datum/module_objective/hourly_objective
	var/hourly_assigned = 0
	var/datum/module_objective/daily_objective
	var/daily_assigned = 0
	var/datum/module_objective/weekly_objective
	var/weekly_assigned = 0

	var/commission = 0
	// var/PriorityQueue/buyorders
	// var/PriorityQueue/sellorders
	var/stock_sales = 0 // stock sales this hour
	var/list/stock_sales_data = list() // stock sales in the past 24 hours
	var/sales_short

//====================================================================
//	Initialisation
//====================================================================
/datum/world_faction/business/New(_uid, _name, _abbreviation, _short_tag, _purpose, _password, _owner_name)
	..()
	feed = new()
	library = new()
	// buyorders = new /PriorityQueue(/proc/cmp_buyorders_stock)
	// sellorders = new /PriorityQueue(/proc/cmp_sellorders_stock)
