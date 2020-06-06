GLOBAL_DATUM_INIT(FactionNetManager, /datum/faction_network_manager, new /datum/faction_network_manager())

/datum/faction_network_manager
	var/global/list/faction_networks = list() //Format is network (id = network)

//Allow to quickly get a network with the given uid
/datum/faction_network_manager/proc/GetNetwork(var/uid)
	LoadNetworkIfNeeded()
	return (uid in faction_networks)? faction_networks[uid] : null

/datum/faction_network_manager/proc/AddNetwork(var/datum/ntnet/faction/N)
	if(!istype(N))
		return FALSE
	if(!N.uid)
		return FALSE
	faction_networks[N.uid] = N
	return TRUE

/datum/faction_network_manager/proc/LoadNetworkIfNeeded()
	if(!length(faction_networks))
		var/list/datum/ntnet/faction/NW = PSDB.factions.GetAllFactionNetworks()
		for(var/datum/ntnet/faction/N in NW)
			faction_networks[N.uid] = N

//Create a brand new network
/datum/faction_network_manager/proc/CreateNetwork(var/uid)
	var/datum/ntnet/faction/N = GetNetwork(uid)
	if(!isnull(N))
		return N
	N = new/datum/ntnet/faction()
	N.uid = uid
	N.name = uid
	AddNetwork(N)
	N.commit_to_db()
	callHook("ntnet_created", list(N, N.uid))
	return faction_networks[uid]

//Delete a faction network from the DB
/datum/faction_network_manager/proc/DeleteNetwork(var/uid)
	var/datum/ntnet/faction/N = GetNetwork(uid)
	if(isnull(N))
		return FALSE
	
	//Make sure anything using the network stops doing so now..
	callHook("ntnet_deleting", list(N, N.uid))

	//Delete its DB record
	N.delete_from_db()

	//Flush it from our network cache
	qdel(N)
	faction_networks[uid] = null
	return TRUE
	