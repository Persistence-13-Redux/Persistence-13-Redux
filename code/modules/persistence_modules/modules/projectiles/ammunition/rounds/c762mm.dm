//--------------------------------
//	7.62mm Rounds (.308)
//--------------------------------
/obj/item/ammo_casing/c762
	desc = "A 7.62mm cartridge."
	caliber = CALIBER_762MM
	projectile_type = /obj/item/projectile/bullet/rifle/c762
	icon_state = "rifle_mil"
	spent_icon = "rifle_mil-spent"
	matter = list(MATERIAL_STEEL = 1200, MATERIAL_COPPER = 1200, MATERIAL_BRASS = 1200)

/obj/item/ammo_casing/c762/practice
	desc = "A 7.62mm practice cartridge."
	projectile_type = /obj/item/projectile/bullet/rifle/c762/practice
	icon_state = "rifle_mil_p"
	matter = list(MATERIAL_COPPER = 600, MATERIAL_BRASS = 600)