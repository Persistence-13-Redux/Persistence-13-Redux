/datum/map/nexus
	// Networks that will show up as options in the camera monitor program
	station_networks = list(
		NETWORK_PUBLIC,
		"nexus",
		"nexussec",
		"refuge",
	)

// Networks
/obj/machinery/camera/network/nexus
	network = list("nexus")

/obj/machinery/camera/network/nexus_security
	network = list("nexussec")

/obj/machinery/camera/network/refugee
	network = list("refuge")

/obj/effect/landmark/map_data/nexus
	height = 3

