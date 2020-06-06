/datum/stored_items/vending_products
	var/initial_name = "generic"	//When products are stored by name, instead of by type, this name will be what's compared

/datum/stored_items/vending_products/New(var/atom/storing_object, var/path, var/name = null, var/amount = 0, var/price = 0, var/color = null, var/category = CAT_NORMAL)
	..()
	ADD_SAVED_VAR(price)
	ADD_SAVED_VAR(display_color)
	ADD_SAVED_VAR(category)
	ADD_SAVED_VAR(initial_name)