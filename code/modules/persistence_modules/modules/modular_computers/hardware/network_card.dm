/obj/item/weapon/stock_parts/computer/network_card/after_load()
	..()
	get_network()

/obj/item/weapon/stock_parts/computer/network_card/New(var/l)
	..(l)
	ADD_SAVED_VAR(identification_id)
	ADD_SAVED_VAR(identification_string)
	ADD_SAVED_VAR(connected_to)
	ADD_SAVED_VAR(password)
	ADD_SAVED_VAR(locked)

/obj/item/weapon/stock_parts/computer/network_card/get_network_tag(list/routed_through) // Argument is a safety parameter for internal calls. Don't use manually.
	if(!connected_network)
		return null
	. = ..()
