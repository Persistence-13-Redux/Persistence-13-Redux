/obj/item/device/taperecorder
	matter = list(MATERIAL_ALUMINIUM = 250, MATERIAL_COPPER = 250, MATERIAL_PLASTIC = 500)
	mass = 500 GRAMS

/obj/item/device/taperecorder/New()
	..()
	ADD_SAVED_VAR(maintenance)
	ADD_SAVED_VAR(emagged)
	ADD_SAVED_VAR(mytape)
	ADD_SAVED_VAR(canprint)
	ADD_SAVED_VAR(recording)
	ADD_SAVED_VAR(playing)
	ADD_SAVED_VAR(playsleepseconds)

/obj/item/device/taperecorder/Initialize()
	. = ..()
	if(!map_storage_loaded)
		if(ispath(mytape))
			mytape = new mytape(src)
	queue_icon_update()

/obj/item/device/tape
	matter = list(MATERIAL_PLASTIC = 50, MATERIAL_ALUMINIUM = 20, MATERIAL_PLATINUM = 5)

/obj/item/device/tape/New()
	. = ..()
	ADD_SAVED_VAR(max_capacity)
	ADD_SAVED_VAR(used_capacity)
	ADD_SAVED_VAR(storedinfo)
	ADD_SAVED_VAR(timestamp)
	ADD_SAVED_VAR(ruined)
	ADD_SAVED_VAR(doctored)

	ADD_SKIP_EMPTY(storedinfo)
	ADD_SKIP_EMPTY(timestamp)

/obj/item/device/tape/attackby(obj/item/I, mob/user, params)
	if(isWirecutter(I) || isScissors(I))
		cut(user)
		return
	return ..()

