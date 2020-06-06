//--------------------------------
//	14.5mm Rounds
//--------------------------------
/obj/item/ammo_casing/c145
	name = "shell casing"
	desc = "A 14.5mm shell."
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = CALIBER_145MM
	projectile_type = /obj/item/projectile/bullet/rifle/c145
	matter = list(MATERIAL_TUNGSTEN = 2500, MATERIAL_STEEL = 1000, MATERIAL_COPPER = 500, MATERIAL_BRASS = 2500)

/obj/item/ammo_casing/c145/apds
	name = "APDS shell casing"
	desc = "A 14.5mm Armour Piercing Discarding Sabot shell."
	projectile_type = /obj/item/projectile/bullet/rifle/c145/apds
	matter = list(MATERIAL_TUNGSTEN = 2250, MATERIAL_PLASTIC = 2000, MATERIAL_COPPER = 500, MATERIAL_BRASS = 2250)