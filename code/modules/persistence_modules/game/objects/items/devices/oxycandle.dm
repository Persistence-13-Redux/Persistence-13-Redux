/obj/item/device/oxycandle/New()
	..()
	ADD_SAVED_VAR(air_contents)
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(volume) //Used to store burning duration really..
	ADD_SAVED_VAR(target_pressure)

/obj/item/device/oxycandle/Initialize()
	. = ..()
	if(on == 2)
		matter = list(MATERIAL_STEEL = 1 SHEET) //if its burnt remove the rest
	queue_icon_update()

/obj/item/device/oxycandle/afterattack(var/obj/O, var/mob/user, var/proximity)
	if(proximity && istype(O) && on)
		O.HandleObjectHeating(src, user, 500)
	. = ..()

/obj/item/device/oxycandle/Process()
	if(!loc)
		return
	var/turf/pos = get_turf(src)
	if(volume <= 0 || !pos || (pos.turf_flags & TURF_IS_WET)) //Now uses turf flags instead of whatever aurora did
		matter = list(MATERIAL_STEEL = 1 SHEET) //if its burnt remove the rest
	. = ..()


