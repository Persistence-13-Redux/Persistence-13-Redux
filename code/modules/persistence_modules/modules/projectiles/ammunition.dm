/obj/item/ammo_casing
	mass = 8 GRAMS

/obj/item/ammo_casing/New()
	..()
	ADD_SAVED_VAR(BB)

//Make sure the base class doesn't fuck with the loaded values
/obj/item/ammo_magazine/Initialize()
	var/old_initial_ammo = initial_ammo
	var/old_caliber = caliber
	if(map_storage_loaded)
		initial_ammo = 0 
		caliber = null
	. = ..()
	if(map_storage_loaded)
		initial_ammo = old_initial_ammo
		caliber = old_caliber

/obj/item/ammo_magazine
	slot_flags = SLOT_BELT | SLOT_POCKET
	mass = 100 GRAMS

/obj/item/ammo_magazine/box
	w_class = ITEM_SIZE_NORMAL
