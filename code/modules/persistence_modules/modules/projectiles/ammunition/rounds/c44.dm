//--------------------------------
//	.44 Rounds
//--------------------------------
/obj/item/ammo_casing/c44
	desc = "A .44 magnum cartridge."
	caliber = CALIBER_44
	projectile_type = /obj/item/projectile/bullet/pistol/c44
	icon_state = "magnumcasing"
	spent_icon = "magnumcasing-spent"
	matter = list(MATERIAL_COPPER = 400, MATERIAL_LEAD = 400, MATERIAL_BRASS = 400)

/obj/item/ammo_casing/c44/flash
	desc = "A .44 magnum flash cartridge."
	projectile_type = /obj/item/projectile/energy/flash
	matter = list(MATERIAL_COPPER = 400, MATERIAL_SULFUR = 400, MATERIAL_BRASS = 400)

/obj/item/ammo_casing/c44/rubber
	desc = "A .44 magnum rubber cartridge."
	projectile_type = /obj/item/projectile/bullet/rubber
	matter = list(MATERIAL_PLASTIC = 400, MATERIAL_STEEL = 10, MATERIAL_BRASS = 400)

/obj/item/ammo_casing/c44/emp
	name = ".44 haywire round"
	desc = "A .44 magnum rubber cartridge."
	projectile_type = /obj/item/projectile/ion/small
	matter = list(MATERIAL_STEEL = 400, MATERIAL_URANIUM = 200, MATERIAL_BRASS = 400)

/obj/item/ammo_casing/c44/nullglass
	name = ".44 haywire round"
	desc = "A .44 magnum casing with a nullglass coating"
	projectile_type = /obj/item/projectile/bullet/nullglass
	matter = list(MATERIAL_LEAD = 400, MATERIAL_NULLGLASS = 400, MATERIAL_BRASS = 400)
/obj/item/ammo_casing/c44/nullglass/disrupts_psionics()
	return src