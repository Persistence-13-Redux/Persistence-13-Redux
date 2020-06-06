/obj/machinery/proc/ison()
	return !isoff()

/obj/machinery/proc/isactive()
	return use_power == POWER_USE_ACTIVE

/obj/machinery/proc/isidle()
	return use_power == POWER_USE_IDLE

/obj/machinery/proc/isoff()
	return use_power == POWER_USE_OFF

/obj/machinery/proc/turn_on()
	turn_active()

/obj/machinery/proc/turn_active()
	update_use_power(POWER_USE_ACTIVE)
	update_icon()

/obj/machinery/proc/turn_idle()
	update_use_power(POWER_USE_IDLE)
	update_icon()

/obj/machinery/proc/turn_off()
	update_use_power(POWER_USE_OFF)
	update_icon()