/obj/machinery/atmospherics/tvalve
	var/mirrored = FALSE

/obj/machinery/atmospherics/tvalve/bypass
	icon_state = "map_tvalve1"
	state = 1

/obj/machinery/atmospherics/tvalve/New()
	. = ..()
	ADD_SAVED_VAR(state)

// /obj/machinery/atmospherics/tvalve/setup_initialize_directions()
// 	switch(dir)
// 		if(NORTH)
// 			initialize_directions = SOUTH|NORTH|EAST
// 		if(SOUTH)
// 			initialize_directions = NORTH|SOUTH|WEST
// 		if(EAST)
// 			initialize_directions = WEST|EAST|SOUTH
// 		if(WEST)
// 			initialize_directions = EAST|WEST|NORTH

//Do it again and take into account the mirrored var
/obj/machinery/atmospherics/tvalve/atmos_init()
	..()

	var/node1_dir
	var/node2_dir
	var/node3_dir

	node1_dir = turn(dir, 180)
	node2_dir = turn(dir, mirrored? 90 : -90)
	node3_dir = dir

	init_nodes(node1_dir, node2_dir, node3_dir)

/obj/machinery/atmospherics/tvalve/mirrored
	mirrored = TRUE

/obj/machinery/atmospherics/tvalve/mirrored/bypass
	icon_state = "map_tvalvem1"
	mirrored = TRUE
	state = 1

// /obj/machinery/atmospherics/tvalve/mirrored/setup_initialize_directions()
// 	switch(dir)
// 		if(NORTH)
// 			initialize_directions = SOUTH|NORTH|WEST
// 		if(SOUTH)
// 			initialize_directions = NORTH|SOUTH|EAST
// 		if(EAST)
// 			initialize_directions = WEST|EAST|NORTH
// 		if(WEST)
// 			initialize_directions = EAST|WEST|SOUTH

/obj/machinery/atmospherics/tvalve/mirrored/digital
	// radio_filter 	= RADIO_ATMOSIA
	mirrored 		= TRUE

/obj/machinery/atmospherics/tvalve/digital/bypass
	mirrored = TRUE
/obj/machinery/atmospherics/tvalve/mirrored/bypass
	mirrored = TRUE
/obj/machinery/atmospherics/tvalve/mirrored/digital/bypass
	mirrored = TRUE
