//--------------------------------
//	40mm Rocket Rounds
//--------------------------------
/obj/item/ammo_casing/rocket
	name = "40mm HE rocket"
	desc = "A high explosive rocket designed to be fired from a launcher."
	icon_state = "rocketshell"
	projectile_type = /obj/item/missile
	caliber = CALIBER_40MM_ROCKET
	matter = list(MATERIAL_ALUMINIUM = 2500, MATERIAL_ZINC = 2500, MATERIAL_SULFUR = 1000, MATERIAL_GRAPHITE = 2500)

/obj/item/ammo_casing/rocket/incendiary
	name = "40mm HEI rocket"
	desc = "A high explosive incendiary rocket designed to be fired from a launcher."
	icon_state = "rocketshell"
	projectile_type = /obj/item/missile/incendiary
	caliber = CALIBER_40MM_ROCKET
	matter = list(MATERIAL_ALUMINIUM = 2500, MATERIAL_ZINC = 2500, MATERIAL_SULFUR = 1000, MATERIAL_GRAPHITE = 2500, MATERIAL_PHOSPHORITE = 2500)