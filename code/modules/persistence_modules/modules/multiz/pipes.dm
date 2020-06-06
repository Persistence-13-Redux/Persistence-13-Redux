/obj/machinery/atmospherics/pipe/zpipe
	maximum_pressure = 70*ONE_ATMOSPHERE
	fatigue_pressure = 55*ONE_ATMOSPHERE
	alert_pressure = 55*ONE_ATMOSPHERE

/obj/machinery/atmospherics/pipe/zpipe/New()
	..()
	switch(dir)
		if(SOUTH)
			initialize_directions = SOUTH
		if(NORTH)
			initialize_directions = NORTH
		if(WEST)
			initialize_directions = WEST
		if(EAST)
			initialize_directions = EAST
		if(NORTHEAST)
			initialize_directions = NORTH
		if(NORTHWEST)
			initialize_directions = WEST
		if(SOUTHEAST)
			initialize_directions = EAST
		if(SOUTHWEST)
			initialize_directions = SOUTH

/obj/machinery/atmospherics/pipe/zpipe/after_load()
	..()
	switch(dir)
		if(SOUTH)
			initialize_directions = SOUTH
		if(NORTH)
			initialize_directions = NORTH
		if(WEST)
			initialize_directions = WEST
		if(EAST)
			initialize_directions = EAST
		if(NORTHEAST)
			initialize_directions = NORTH
		if(NORTHWEST)
			initialize_directions = WEST
		if(SOUTHEAST)
			initialize_directions = EAST
		if(SOUTHWEST)
			initialize_directions = SOUTH

/obj/machinery/atmospherics/pipe/zpipe/proc/normalize_dir()
	if(dir == (NORTH|SOUTH))
		set_dir(NORTH)
	else if(dir == (EAST|WEST))
		set_dir(EAST)

/obj/machinery/atmospherics/pipe/zpipe/up/atmos_init()
	normalize_dir()
	return ..()

/obj/machinery/atmospherics/pipe/zpipe/down/atmos_init()
	normalize_dir()
	..()

