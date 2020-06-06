/obj/machinery/atmospherics/pipeturbine
	obj_flags = OBJ_FLAG_ROTATABLE
	New()
		..()
		ADD_SAVED_VAR(kin_energy)
		ADD_SAVED_VAR(dP)
		ADD_SAVED_VAR(air_in)
		ADD_SAVED_VAR(air_out)

//	setup_initialize_directions()
		..()
		switch(dir)
			if(NORTH)
				initialize_directions = EAST|WEST
			if(SOUTH)
				initialize_directions = EAST|WEST
			if(EAST)
				initialize_directions = NORTH|SOUTH
			if(WEST)
				initialize_directions = NORTH|SOUTH

/obj/machinery/power/turbinemotor
	base_type = /obj/machinery/power/turbinemotor
	construct_state = /decl/machine_construction/default/panel_closed
	attackby(obj/item/weapon/W as obj, mob/user as mob)
		if(isMultitool(W))
			updateConnection()
			to_chat(user, "You refresh the turbine's connection!")
			return 
		return ..()