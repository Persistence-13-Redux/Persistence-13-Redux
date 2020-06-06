/obj/machinery/power/apc/New()
	..()
	ADD_SAVED_VAR(locked)
	ADD_SAVED_VAR(coverlocked)
	ADD_SAVED_VAR(has_electronics)
	ADD_SAVED_VAR(autoflag)
	//Don'st save the connected faction!! Otherwise it'll create duplicate factions on load

/obj/machinery/power/apc/check_updates()
	if(!area) return
	return ..()
/obj/machinery/power/apc/update()
	if(!area) return
	return ..()
/obj/machinery/power/apc/Process()
	if(!area) return
	return ..()
/obj/machinery/power/apc/update_channels(suppress_alarms = FALSE)
	if(!area) return
	return ..()
/obj/machinery/power/apc/reboot()
	if(!area) return
	return ..()