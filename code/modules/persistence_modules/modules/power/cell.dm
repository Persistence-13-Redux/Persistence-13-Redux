/obj/item/weapon/cell/New()
	. = ..()
	ADD_SAVED_VAR(charge)

//Keep base class from overwriting the loaded maxcharge
/obj/item/weapon/cell/device/variable/Initialize(mapload, charge_amount)
	var/old_maxcharge = maxcharge
	. = ..()
	if(map_storage_loaded)
		maxcharge = old_maxcharge

/obj/item/weapon/cell/device/standard
	maxcharge = 100
/obj/item/weapon/cell/device/high
	maxcharge = 200
/obj/item/weapon/cell/device/super
	name = "super device power cell"
	desc = "A small power cell using advanced materials and techniques for even more power. Generally used in guns."
	icon_state = "sdevice"
	maxcharge = 300
	matter = list(MATERIAL_STEEL = 80, MATERIAL_GLASS = 10)

/obj/item/weapon/cell/device/standard/empty/New()
	..()
	charge = 0
/obj/item/weapon/cell/crap/empty/New()
	..()
	charge = 0


	

