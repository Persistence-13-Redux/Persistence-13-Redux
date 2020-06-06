/obj/machinery/turretid
	frame_type = /obj/item/frame/turret_control

/obj/machinery/turretid/New()
	. = ..()
	ADD_SAVED_VAR(enabled)
	ADD_SAVED_VAR(lethal)
	ADD_SAVED_VAR(locked)
	ADD_SAVED_VAR(ailock)
	ADD_SAVED_VAR(check_arrest)
	ADD_SAVED_VAR(check_records)
	ADD_SAVED_VAR(check_weapons)
	ADD_SAVED_VAR(check_access)
	ADD_SAVED_VAR(check_anomalies)
	ADD_SAVED_VAR(check_synth)

/obj/machinery/turretid/Destroy()
	if(control_area)
		var/area/A = control_area
		if(A && istype(A))
			A.turret_controls -= src
	. = ..()

/obj/machinery/turretid/Initialize()
	power_change() //Checks power and initial settings
	. = ..()

/obj/machinery/turretid/power_change()
	. = ..()
	if(.)
		updateTurrets()

//Since we can't save references to areas, we'll do a little trick to
// save only the area name, and then restore it on save load.
/obj/machinery/turretid/before_save()
	. = ..()
	if(istype(control_area))
		custom_saved_vars["control_area"] = control_area.name

/obj/machinery/turretid/after_load()
	. = ..()
	if(istext(custom_saved_vars["control_area"]))
		control_area = get_area(custom_saved_vars["control_area"])

/obj/machinery/turretid/on_update_icon()
	..()
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = -30
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = 30
		if(EAST)
			src.pixel_x = -30
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = 30
			src.pixel_y = 0
