//--------------------------------
//	5.56mm Rounds
//--------------------------------
/obj/item/ammo_casing/c556
	desc = "A 5.56mm cartridge."
	caliber = CALIBER_556MM
	projectile_type = /obj/item/projectile/bullet/rifle/c556
	icon_state = "riflecasing"
	spent_icon = "riflecasing-spent"
	matter = list(MATERIAL_STEEL = 800, MATERIAL_COPPER = 800, MATERIAL_BRASS = 800)

/obj/item/ammo_casing/c556/practice
	desc = "A 5.56mm practice cartridge."
	projectile_type = /obj/item/projectile/bullet/rifle/c556/practice
	matter = list(MATERIAL_COPPER = 400, MATERIAL_BRASS = 400)
