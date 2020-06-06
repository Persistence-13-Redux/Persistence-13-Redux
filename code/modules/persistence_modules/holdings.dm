/datum/personal_limits
	var/stock_limit = 0
	var/shuttle_limit = 0
	var/cost = 0

	
/datum/personal_limits/one
	stock_limit = 125

/datum/personal_limits/two
	stock_limit = 175
	shuttle_limit = 1
	cost = 3000

/datum/personal_limits/three
	stock_limit = 225
	shuttle_limit = 2
	cost = 6500

/datum/personal_limits/four
	stock_limit = 275
	shuttle_limit = 3
	cost = 10000

/datum/computer_file/report/crew_record/proc/get_limits()
	switch(get_network_level())
		if(1)
			return new /datum/personal_limits/one()
		if(2)
			return new /datum/personal_limits/two()
		if(3)
			return new /datum/personal_limits/three()
		if(4)
			return new /datum/personal_limits/four()
		else
			return new /datum/personal_limits/one()


/datum/computer_file/report/crew_record/proc/upgrade(var/mob/user)
	var/cost = get_upgrade_cost()
	var/datum/money_account/linked_account = get_money_account_by_name(get_name())
	var/network_level = get_network_level()
	if(network_level >= 4) return
	if(linked_account.get_balance() < cost)
		to_chat(user, SPAN_WARNING("Insufficent funds."))
		return
	linked_account.withdraw(cost, "Nexus Account Upgrade", "Nexus Account Upgrade")
	network_level++
	set_network_level(network_level)

/datum/computer_file/report/crew_record/proc/get_stock_limit()
	switch(get_network_level())
		if(1)
			var/datum/personal_limits/limit = new /datum/personal_limits/one()
			return limit.stock_limit
		if(2)
			var/datum/personal_limits/limit = new /datum/personal_limits/two()
			return limit.stock_limit
		if(3)
			var/datum/personal_limits/limit = new /datum/personal_limits/three()
			return limit.stock_limit
		if(4)
			var/datum/personal_limits/limit = new /datum/personal_limits/four()
			return limit.stock_limit
		else
			var/datum/personal_limits/limit = new /datum/personal_limits/one()
			return limit.stock_limit
			
/datum/computer_file/report/crew_record/proc/get_shuttle_limit()
	switch(get_network_level())
		if(1)
			var/datum/personal_limits/limit = new /datum/personal_limits/one()
			return limit.shuttle_limit
		if(2)
			var/datum/personal_limits/limit = new /datum/personal_limits/two()
			return limit.shuttle_limit
		if(3)
			var/datum/personal_limits/limit = new /datum/personal_limits/three()
			return limit.shuttle_limit
		if(4)
			var/datum/personal_limits/limit = new /datum/personal_limits/four()
			return limit.shuttle_limit
		else
			var/datum/personal_limits/limit = new /datum/personal_limits/one()
			return limit.shuttle_limit
			
			
/datum/computer_file/report/crew_record/proc/get_upgrade_cost()
	switch(get_network_level())
		if(1)
			var/datum/personal_limits/limit = new /datum/personal_limits/two()
			return limit.cost
		if(2)
			var/datum/personal_limits/limit = new /datum/personal_limits/three()
			return limit.cost
		if(3)
			var/datum/personal_limits/limit = new /datum/personal_limits/four()
			return limit.cost

/datum/computer_file/report/crew_record/proc/get_upgrade_desc()
	switch(get_network_level())
		if(1)
			return "Increase stock limit to 175 and gain a personal shuttle."
		if(2)
			return "Increase stock limit to 225 and gain another personal shuttle."
		if(3)
			return "Increase stock limit to 275 and gain another personal shuttle."
