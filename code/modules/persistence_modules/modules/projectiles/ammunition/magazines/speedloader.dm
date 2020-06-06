/obj/item/ammo_magazine/speedloader
	name = "speed loader"
	desc = "A speed loader for revolvers."
	mag_type = SPEEDLOADER
	w_class = ITEM_SIZE_SMALL
	mass = 10 GRAMS
/obj/item/ammo_magazine/speedloader/Initialize()
	. = ..()
	if(!map_storage_loaded)
		SetName("speed loader ([caliber])")

//----------------------------------
//	standard .22lr speedloader
//----------------------------------
/obj/item/ammo_magazine/speedloader/c22lr
	icon = 'code/modules/persistence_modules/icons/obj/items/ammo/speedloader_revolver_small.dmi'
	icon_state = "spdloader_small"
	caliber = CALIBER_22LR
	ammo_type = /obj/item/ammo_casing/c22lr
	matter = list(MATERIAL_STEEL = 1440)
	max_ammo = 6
	multiple_sprites = 1
/obj/item/ammo_magazine/speedloader/c22lr/empty
	initial_ammo = 0

//----------------------------------
//	standard .357 speedloader
//----------------------------------
/obj/item/ammo_magazine/speedloader/c357
	icon_state = "spdloader"
	caliber = CALIBER_357
	ammo_type = /obj/item/ammo_casing/c357
	matter = list(MATERIAL_STEEL = 1440)
	max_ammo = 6
	multiple_sprites = 1
/obj/item/ammo_magazine/speedloader/c357/empty
	initial_ammo = 0

//----------------------------------
//	standard .38 speedloader
//----------------------------------
/obj/item/ammo_magazine/speedloader/c38
	icon_state = "spdloader"
	caliber = CALIBER_38
	ammo_type = /obj/item/ammo_casing/c38
	matter = list(MATERIAL_STEEL = 1260)
	max_ammo = 6
	multiple_sprites = 1
/obj/item/ammo_magazine/speedloader/c38/empty
	initial_ammo = 0
/obj/item/ammo_magazine/speedloader/c38/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/c38/rubber

//----------------------------------
//	standard .44 speedloader
//----------------------------------
/obj/item/ammo_magazine/speedloader/c44
	icon_state = "spdloader_magnum"
	caliber = CALIBER_44
	ammo_type = /obj/item/ammo_casing/c44
	matter = list(MATERIAL_STEEL = 1260)
	max_ammo = 6
	multiple_sprites = 1
/obj/item/ammo_magazine/speedloader/c44/empty
	initial_ammo = 0
/obj/item/ammo_magazine/speedloader/c44/rubber
	labels = list("rubber")
	ammo_type = /obj/item/ammo_casing/c44/rubber
/obj/item/ammo_magazine/speedloader/c44/emp
	labels = list("emp")
	ammo_type = /obj/item/ammo_casing/c44/emp
/obj/item/ammo_magazine/speedloader/c44/nullglass
	labels = list("psi")
	ammo_type = /obj/item/ammo_casing/c44/nullglass

//----------------------------------
//	standard .50 speedloader
//----------------------------------
/obj/item/ammo_magazine/speedloader/c50
	icon_state = "spdloader_magnum"
	caliber = CALIBER_50
	ammo_type = /obj/item/ammo_casing/c50
	matter = list(MATERIAL_STEEL = 1260)
	max_ammo = 6
	multiple_sprites = 1
/obj/item/ammo_magazine/speedloader/c50/empty
	initial_ammo = 0