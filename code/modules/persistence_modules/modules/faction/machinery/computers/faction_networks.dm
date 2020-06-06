/obj/item/weapon/stock_parts/computer/network_card
	var/network_uid
	var/datum/ntnet/faction/connected_network

/obj/item/weapon/stock_parts/computer/network_card/get_faction()
	if(!connected_network)
		get_network()
	return connected_network?.get_faction()

/obj/item/weapon/stock_parts/computer/network_card/proc/get_network()
	if(connected_network && connected_network.uid == network_uid)
		return connected_network
	else
		connect_to_network(network_uid)

/obj/item/weapon/stock_parts/computer/network_card/proc/disconnect_from_network()
	network_uid = null
	connected_network = null

/obj/item/weapon/stock_parts/computer/network_card/proc/connect_to_network(var/netuid)
	network_uid = netuid
	connected_network = GLOB.FactionNetManager.GetNetwork(network_uid)

