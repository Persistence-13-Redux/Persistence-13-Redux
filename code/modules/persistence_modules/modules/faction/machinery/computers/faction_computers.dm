//NTOS stuff
//Get the connected network's faction from the underlying network card
/datum/extension/interactive/ntos/proc/get_network_faction()
	var/obj/item/weapon/stock_parts/computer/network_card/network_card = get_component(PART_NETWORK)
	return network_card? network_card.get_faction() : null

/datum/extension/interactive/ntos/proc/get_network()
	var/obj/item/weapon/stock_parts/computer/network_card/network_card = get_component(PART_NETWORK)
	return network_card? network_card.get_network() : null