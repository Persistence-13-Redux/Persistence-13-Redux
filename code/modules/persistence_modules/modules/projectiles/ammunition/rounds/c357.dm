//--------------------------------
//	.357 Rounds
//--------------------------------
/obj/item/ammo_casing/c357
	desc = "A .357 cartridge."
	caliber = CALIBER_357
	icon_state = "magnumcasing"
	spent_icon = "magnumcasing-spent"
	projectile_type = /obj/item/projectile/bullet/pistol/c357
	matter = list(MATERIAL_COPPER = 300, MATERIAL_LEAD = 300, MATERIAL_BRASS = 300)

/obj/item/ammo_casing/c357/practice
	desc = "A .357 practice cartridge."
	caliber = CALIBER_357
	icon_state = "magnumcasing"
	spent_icon = "magnumcasing-spent"
	projectile_type = /obj/item/projectile/bullet/pistol/c357
	matter = list(MATERIAL_COPPER = 150, MATERIAL_BRASS = 150)
