/*
	Object meant to allow player spawning on them when there's oxygen, and power.
*/
/obj/machinery/spawn_beacon
	name = "Immigration Beacon"
	var/spawnpoint_name = ""
	var/spawn_allowed = FALSE

/obj/machinery/spawn_beacon/New()
	. = ..()
	
/obj/machinery/spawn_beacon/Initialize(mapload)
	. = ..()

/obj/machinery/spawn_beacon/Destroy()
	return ..()

