//--------------------------------
//	.50 Rounds
//--------------------------------
/obj/item/ammo_casing/c50
	desc = "A .50AE cartridge."
	caliber = CALIBER_50
	projectile_type = /obj/item/projectile/bullet/pistol/c50
	icon_state = "magnumcasing"
	spent_icon = "magnumcasing-spent"
	matter = list(MATERIAL_COPPER = 600, MATERIAL_LEAD = 600, MATERIAL_BRASS = 600)

/obj/item/ammo_casing/c50/practice
	desc = "A .50AE practice cartridge."
	caliber = CALIBER_50
	projectile_type = /obj/item/projectile/bullet/pistol/c50
	matter = list(MATERIAL_STEEL = 300, MATERIAL_BRASS = 300)
