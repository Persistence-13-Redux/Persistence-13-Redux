/obj/machinery/atmospherics/unary/outlet_injector
	volume_rate = 250	//flow rate limit

/obj/machinery/atmospherics/unary/outlet_injector/New()
	..()
	ADD_SAVED_VAR(injecting)
	ADD_SAVED_VAR(volume_rate)

/obj/machinery/atmospherics/unary/outlet_injector/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(isWrench(O))
		dismantle()
		return
	return ..()

/obj/machinery/atmospherics/unary/outlet_injector/dismantle()
	new /obj/item/pipe(loc, src)
	qdel(src)

/obj/machinery/atmospherics/unary/outlet_injector/attack_hand(mob/user)
	use_power = !use_power
	user.visible_message( \
		SPAN_NOTICE("\The [user] turns \the [src] [use_power ? "on" : "off"]."), \
		SPAN_NOTICE("You turn \the [src] [use_power ? "on" : "off"]."))
	update_icon()
