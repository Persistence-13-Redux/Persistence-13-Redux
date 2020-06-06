/obj/machinery/New()
	..()
	ADD_SAVED_VAR(extensions)
	ADD_SAVED_VAR(time_emped)
	ADD_SAVED_VAR(panel_open)
	ADD_SAVED_VAR(component_parts)
	ADD_SAVED_VAR(use_power)
	ADD_SAVED_VAR(malf_upgraded)
	ADD_SAVED_VAR(emagged)
	ADD_SAVED_VAR(stat)
	ADD_SAVED_VAR(faction_uid)
	ADD_SAVED_VAR(id_tag)
	ADD_SAVED_VAR(frequency)
	ADD_SAVED_VAR(radio_filter)
	ADD_SAVED_VAR(reason_broken)
	ADD_SAVED_VAR(stat_immune)

	ADD_SKIP_EMPTY(component_parts)

/obj/machinery/after_load()
	..()
	RefreshParts()

/obj/machinery/proc/assign_uid()
	uid = gl_uid
	gl_uid++
