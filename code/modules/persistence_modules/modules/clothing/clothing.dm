//
// GLOVES
//
/obj/item/clothing/gloves/New()
	. = ..()
	ADD_SAVED_VAR(wired)
	ADD_SAVED_VAR(cell)
	ADD_SAVED_VAR(clipped)
	ADD_SAVED_VAR(ring)
	ADD_SAVED_VAR(wearer)

/obj/item/clothing/gloves/Destroy()
	QDEL_NULL(cell)
	ring = null
	wearer = null
	. = ..()

/obj/item/clothing/gloves/cut_fingertops()
	if (clipped)
		return
	siemens_coefficient = max(siemens_coefficient, 0.75)
	return ..()

//
// HEAD
//
/obj/item/clothing/head
	//Light defaults
	light_max_bright = 0.9
	light_inner_range = 2
	light_outer_range = 10
	light_falloff_curve = 2
//	light_color = COLOUR_LTEMP_100W_TUNGSTEN

/obj/item/clothing/head/New()
	. = ..()
	ADD_SAVED_VAR(brightness_on)
	ADD_SAVED_VAR(on)

/obj/item/clothing/head/after_load()
	. = ..()
	if(on)
		update_flashlight(loc)

//
// MASK
//
/obj/item/clothing/mask/New()
	..()
	ADD_SAVED_VAR(voicechange)
	ADD_SAVED_VAR(hanging)

/obj/item/clothing/mask/Initialize()
	. = ..()
	queue_icon_update()

//
// SHOES
//
/obj/item/clothing/shoes/New()
	. = ..()
	ADD_SAVED_VAR(holding)

/obj/item/clothing/shoes/Initialize()
	. = ..()
	queue_icon_update()

//
// UNDER
//
/obj/item/clothing/under/New()
	..()
	ADD_SAVED_VAR(sensor_mode)
	ADD_SAVED_VAR(rolled_down)
	ADD_SAVED_VAR(rolled_sleeves)