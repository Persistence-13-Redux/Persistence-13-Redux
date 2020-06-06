/datum/stockholder
	var/real_name = ""
	var/account_number = 0
	var/stocks = 0
	var/subscribed = 0

/datum/stockholder/New(var/_name = "", var/_account_number = 0, var/_stocks = 0, var/_subscribded = 0)
	..()
	real_name = _name
	account_number = _account_number
	stocks = _stocks
	subscribed = _subscribded