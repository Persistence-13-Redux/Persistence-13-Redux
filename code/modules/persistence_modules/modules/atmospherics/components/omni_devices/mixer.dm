/obj/machinery/atmospherics/omni/mixer/New()
	..()
	if(!inputs)
		inputs = list()
	ADD_SAVED_VAR(inputs)
	ADD_SAVED_VAR(output)
	ADD_SAVED_VAR(mixing_inputs)

/obj/machinery/atmospherics/omni/mixer/Initialize()
	. = ..()
	do_init()


/obj/machinery/atmospherics/omni/mixer/after_load()
	update_ports()
	build_icons()
	for(var/datum/omni_port/P in ports)
		handle_port_change(P)
	..()

/obj/machinery/atmospherics/omni/mixer/proc/do_init()
	if(mapper_set())
		var/con = 0
		for(var/datum/omni_port/P in ports)
			switch(P.dir)
				if(NORTH)
					if(tag_north_con && tag_north == 1)
						P.concentration = tag_north_con
						con += max(0, tag_north_con)
				if(SOUTH)
					if(tag_south_con && tag_south == 1)
						P.concentration = tag_south_con
						con += max(0, tag_south_con)
				if(EAST)
					if(tag_east_con && tag_east == 1)
						P.concentration = tag_east_con
						con += max(0, tag_east_con)
				if(WEST)
					if(tag_west_con && tag_west == 1)
						P.concentration = tag_west_con
						con += max(0, tag_west_con)

	for(var/datum/omni_port/P in ports)
		P.air.volume = ATMOS_DEFAULT_VOLUME_MIXER

/obj/machinery/atmospherics/omni/mixer/proc/handle_port_change(var/datum/omni_port/P)
	switch(P.mode)
		if(ATM_NONE)
			initialize_directions &= ~P.dir
			P.disconnect()
		else
			initialize_directions |= P.dir
			P.connect()
	P.update = 1

