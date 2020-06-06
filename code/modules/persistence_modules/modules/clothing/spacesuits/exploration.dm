//#TODO: Armor values
//Exploration
/obj/item/clothing/head/helmet/space/void/exploration
	name = "purple voidsuit helmet"
	desc = "A lightweight helmet designed to accommodate only the most opulent space explorers."
	icon_state = "helm_explorer"
	item_state = "helm_explorer"

	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	light_overlay = "explorer_light"

/obj/item/clothing/suit/space/void/exploration
	name = "purple voidsuit"
	desc = "A lightweight, general use voidsuit padded with soft cushioning to provide maximum comfort in the depths of space."
	icon_state = "void_explorer"
	item_state = "void_explorer"

	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/stack/flag,/obj/item/device/scanner/health,/obj/item/device/gps,/obj/item/weapon/pinpointer/radio,/obj/item/device/radio/beacon,/obj/item/weapon/material/hatchet/machete,/obj/item/weapon/shovel)

/obj/item/clothing/suit/space/void/exploration/prepared
	helmet = /obj/item/clothing/head/helmet/space/void/exploration
	boots = /obj/item/clothing/shoes/magboots
