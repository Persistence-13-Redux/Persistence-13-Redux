/obj/item/ammo_magazine/clip
	name = "clip"
	desc = "A clip for reloading a fixed magazine rifle quickly."
	mag_type = SPEEDLOADER
	w_class = ITEM_SIZE_SMALL
	matter = list(MATERIAL_STEEL = 100)
	mass = 5 GRAMS

/obj/item/ammo_magazine/speedloader/Initialize()
	. = ..()
	SetName("clip ([caliber])")

//----------------------------------
//	Clip 9mm
//----------------------------------
/obj/item/ammo_magazine/clip/c9mm
	icon = 'code/modules/persistence_modules/icons/obj/items/ammo/clip_c96.dmi'
	icon_state = "7.63mm_clip" //Since this should be a modern replica, we'll avoid the 7.63mm round..
	caliber = CALIBER_9MM
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 9
	multiple_sprites = 1
/obj/item/ammo_magazine/clip/c9mm/empty
	initial_ammo = 0

//----------------------------------
//	Clip 7.62mm
//----------------------------------
/obj/item/ammo_magazine/clip/c762
	icon_state = "stripper"
	caliber = CALIBER_762MM
	ammo_type = /obj/item/ammo_casing/c762
	max_ammo = 5
	multiple_sprites = 1
/obj/item/ammo_magazine/clip/c762/empty
	initial_ammo = 0