//--------------------------------
//	.45 Rounds
//--------------------------------
/obj/item/ammo_casing/c45
	desc = "A .45 cartridge."
	caliber = CALIBER_45
	icon_state = "pistolcasing"
	spent_icon = "pistolcasing-spent"
	projectile_type = /obj/item/projectile/bullet/pistol/c45
	matter = list(MATERIAL_COPPER = 225, MATERIAL_LEAD = 225, MATERIAL_BRASS = 225)

/obj/item/ammo_casing/c45/practice
	desc = "A .45 practice cartridge."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	icon_state = "pistolcasing_p"
	matter = list(MATERIAL_COPPER = 225, MATERIAL_BRASS = 225)

/obj/item/ammo_casing/c45/rubber
	desc = "A .45 rubber cartridge."
	projectile_type = /obj/item/projectile/bullet/rubber
	icon_state = "pistolcasing_r"
	matter = list(MATERIAL_PLASTIC = 225, MATERIAL_STEEL = 10, MATERIAL_BRASS = 225)

/obj/item/ammo_casing/c45/flash
	desc = "A .45 flash shell casing."
	projectile_type = /obj/item/projectile/energy/flash
	matter = list(MATERIAL_COPPER = 225, MATERIAL_SULFUR = 225, MATERIAL_BRASS = 225)

/obj/item/ammo_casing/c45/emp
	name = ".45 haywire round"
	desc = "A .45 cartridge fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small
	icon_state = "pistolcasing_h"
	matter = list(MATERIAL_STEEL = 225, MATERIAL_URANIUM = 150, MATERIAL_BRASS = 225)
