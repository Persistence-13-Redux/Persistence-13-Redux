// /obj/structure/window
	// hitsound = 'sound/effects/Glasshit.ogg'
	// sound_destroyed = "shatter"
	// damthreshold_brute 	= 5
	// damthreshold_burn = 5

/obj/structure/window/after_load()
	. = ..()
	reinf_material = custom_saved_vars["reinf_material"]
	if(istext(reinf_material))
		reinf_material = SSmaterials.get_material_by_name(reinf_material)
	else
		reinf_material = null

/obj/structure/window/before_save()
	. = ..()
	if(reinf_material)
		custom_saved_vars["reinf_material"] = reinf_material.name

// /obj/structure/window/basic
// 	init_material = MATERIAL_GLASS
// 	damage_per_fire_tick = 2.0
// 	maxhealth = 60

// /obj/structure/window/phoronbasic
// 	maxhealth = 80
// 	damthreshold_brute 	= 10
// 	damthreshold_burn = 10

// /obj/structure/window/phoronreinforced
// 	maxhealth = 200
// 	damthreshold_brute 	= 10
// 	damthreshold_burn = 10

// /obj/structure/window/reinforced
// 	maxhealth = 90
// 	damthreshold_brute 	= 10
// 	damthreshold_burn = 5

// /obj/structure/window/shuttle
// 	maxhealth = 200
// 	damthreshold_brute 	= 10
// 	damthreshold_burn = 10

/obj/structure/window/fiberglass
	name = "fiberglass window"
	desc = "It looks strong and sleek. It may not even shatter."
	icon_state = "rwindow"
	basestate = "rwindow"
	maxhealth = 120
	init_material = MATERIAL_FIBERGLASS
	init_reinf_material = MATERIAL_STEEL
	damage_per_fire_tick = 5.0 // These windows are not built for fire
	color = GLASS_COLOR_FROSTED
	// damthreshold_brute 	= 15
	// damthreshold_burn = 2
