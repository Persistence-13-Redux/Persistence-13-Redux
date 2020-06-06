
/obj/item/device/assembly/prox_sensor/New()
	. = ..()
	ADD_SAVED_VAR(scanning)
	ADD_SAVED_VAR(timing)
	ADD_SAVED_VAR(time)
	ADD_SAVED_VAR(range)