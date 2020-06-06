/obj/machinery/power/turbine
	base_type = /obj/machinery/power/turbine
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/compressor
	base_type = /obj/machinery/compressor
	construct_state = /decl/machine_construction/default/panel_closed

/obj/machinery/computer/turbine_computer
	base_type = /obj/machinery/computer/turbine_computer

/obj/machinery/compressor/New()
	..()
	gas_contained = new
	inturf = get_step(src, dir)
	ADD_SAVED_VAR(gas_contained)
	ADD_SAVED_VAR(starter)
	ADD_SAVED_VAR(rpm)
	ADD_SAVED_VAR(rpmtarget)

/obj/machinery/compressor/Initialize()
	var/oldgas = gas_contained

	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/compressor/LateInitialize()
	. = ..()
	turbine = locate() in get_step(src, get_dir(inturf, src))
	if(!turbine)
		stat |= BROKEN
	else
		turbine.stat &= !BROKEN
		turbine.compressor = src

/obj/machinery/compressor/Destroy()
	inturf = null
	return ..()

/obj/machinery/compressor/Process()
	if(!starter)
		return
	if(!turbine)
		stat |= BROKEN
		return
	return ..()

/obj/machinery/compressor/on_update_icon()
	. = ..()
	overlays.Cut()
	if(rpm>50000)
		overlays += image(icon, "comp-o4", FLY_LAYER)
	else if(rpm>10000)
		overlays += image(icon, "comp-o3", FLY_LAYER)
	else if(rpm>2000)
		overlays += image(icon, "comp-o2", FLY_LAYER)
	else if(rpm>500)
		overlays += image(icon, "comp-o1", FLY_LAYER)

/obj/machinery/power/turbine/LateInitialize()
	..()
	compressor = locate() in get_step(src, get_dir(outturf, src))
	if(!compressor)
		set_broken(TRUE)
	else
		compressor.set_broken(FALSE)
		compressor.turbine = src

/obj/machinery/power/turbine/Process()
	if(!compressor.starter)
		return
	if(!compressor)
		set_broken(TRUE)
		return
	return ..()

/obj/machinery/power/turbine/on_update_icon()
	. = ..()
	overlays.Cut()
	if(lastgen > 100)
		overlays += image(icon, "turb-o", FLY_LAYER)

