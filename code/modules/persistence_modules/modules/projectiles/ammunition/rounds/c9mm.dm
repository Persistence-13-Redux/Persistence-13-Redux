//--------------------------------
//	9mm Rounds
//--------------------------------
/obj/item/ammo_casing/c9mm
	desc = "A 9mm cartridge."
	caliber = CALIBER_9MM
	icon_state = "smallcasing"
	spent_icon = "smallcasing-spent"
	projectile_type = /obj/item/projectile/bullet/pistol/c9mm
	matter = list(MATERIAL_COPPER = 200, MATERIAL_LEAD = 200, MATERIAL_BRASS = 200)

/obj/item/ammo_casing/c9mm/flash
	desc = "A 9mm flash cartridge."
	projectile_type = /obj/item/projectile/energy/flash
	matter = list(MATERIAL_COPPER = 200, MATERIAL_SULFUR = 200, MATERIAL_BRASS = 200)

/obj/item/ammo_casing/c9mm/rubber
	desc = "A 9mm rubber cartridge."
	projectile_type = /obj/item/projectile/bullet/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"
	matter = list(MATERIAL_STEEL = 10, MATERIAL_PLASTIC = 200, MATERIAL_BRASS = 200)

/obj/item/ammo_casing/c9mm/practice
	desc = "A 9mm practice cartridge."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	matter = list(MATERIAL_COPPER = 100, MATERIAL_BRASS = 100)

/obj/item/ammo_casing/c9mm/emp
	name = "9mm haywire round"
	desc = "A 9mm cartridge fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/tiny
	icon_state = "smallcasing_h"
	matter = list(MATERIAL_STEEL = 200, MATERIAL_URANIUM = 100, MATERIAL_BRASS = 200)