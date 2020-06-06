/obj/structure/closet/secure_closet/miner/empty/WillContain()
	return list()

/obj/item/weapon/pickaxe/New()
	. = ..()
	ADD_SAVED_VAR(build_from_parts)
	ADD_SAVED_VAR(hardware_color)

//	New Stuff
/obj/item/device/flashlight/lantern
	name = "lantern"
	icon_state = "lantern"
	desc = "A mining lantern."
	matter = list(MATERIAL_STEEL = 0.5 SHEETS, MATERIAL_GLASS = 0.25 SHEETS)