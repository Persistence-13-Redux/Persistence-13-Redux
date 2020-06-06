//--------------------------------
//	.38 Rounds
//--------------------------------
/obj/item/ammo_casing/c38
	desc = "A .38 cartridge."
	caliber = CALIBER_38
	icon_state = "smallcasing"
	spent_icon = "smallcasing-spent"
	projectile_type = /obj/item/projectile/bullet/pistol/c38
	matter = list(MATERIAL_COPPER = 100, MATERIAL_LEAD = 100, MATERIAL_BRASS = 100)

/obj/item/ammo_casing/c38/rubber
	desc = "A .38 rubber cartridge."
	projectile_type = /obj/item/projectile/bullet/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"
	matter = list(MATERIAL_PLASTIC = 100, MATERIAL_STEEL = 10, MATERIAL_BRASS = 100)

/obj/item/ammo_casing/c38/emp
	name = ".38 haywire round"
	desc = "A .38 cartridge fitted with a single-use ion pulse generator."
	icon_state = "empcasing"
	projectile_type = /obj/item/projectile/ion/small
	matter = list(MATERIAL_STEEL = 100, MATERIAL_URANIUM = 50, MATERIAL_BRASS = 100)

