//equipment
/decl/hierarchy/supply_pack/operations/mule
	name = "Equipment - MULEbot"
	contains = list()
	cost = 20
	containertype = /obj/structure/largecrate/animal/mulebot
	containername = "mulebot crate"

/decl/hierarchy/supply_pack/operations/bureaucracy
	contains = list(/obj/item/weapon/material/clipboard,
					 /obj/item/weapon/material/clipboard,
					 /obj/item/weapon/pen/red,
					 /obj/item/weapon/pen/blue,
					 /obj/item/weapon/pen/green,
					 /obj/item/device/camera_film,
					 /obj/item/weapon/folder/blue,
					 /obj/item/weapon/folder/red,
					 /obj/item/weapon/folder/yellow,
					 /obj/item/weapon/hand_labeler,
					 /obj/item/stack/tape_roll,
					 /obj/structure/filingcabinet/chestdrawer{anchored = 0},
					 /obj/item/weapon/paper_bin)

/decl/hierarchy/supply_pack/operations/fax
	name = "Bureaucracy - Fax machine"
	contains = list(/obj/machinery/photocopier/faxmachine)
	cost = 80
	containertype = /obj/structure/largecrate
	containername = "fax machine crate"

//eva
/decl/hierarchy/supply_pack/operations/softsuit_emergency
	name = "EVA - Emergency softsuit"
	contains = list(/obj/item/clothing/suit/space/emergency,
					/obj/item/clothing/head/helmet/space/emergency,
					/obj/item/weapon/tank/emergency/oxygen/engi)
	cost = 15
	containertype = /obj/structure/closet/crate/large
	containername = "emergency softsuit crate"

/decl/hierarchy/supply_pack/operations/softsuit
	name = "EVA - Basic softsuit"
	contains = list(/obj/item/clothing/suit/space,
					/obj/item/clothing/head/helmet/space,
					/obj/item/clothing/shoes/magboots,
					/obj/item/weapon/tank/emergency/oxygen/engi)
	cost = 30
	containertype = /obj/structure/closet/crate/large
	containername = "EVA softsuit crate"

/decl/hierarchy/supply_pack/operations/salvagedsuit
	name = "EVA - Salvaged voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/engineering/salvage,
					/obj/item/clothing/head/helmet/space/void/engineering/salvage,
					/obj/item/clothing/shoes/magboots)
	cost = 50
	containertype = /obj/structure/closet/crate/large
	containername = "salvaged voidsuit crate"

/decl/hierarchy/supply_pack/operations/voidsuit
	name = "EVA - Basic voidsuit"
	contains = list(/obj/item/clothing/suit/space/void,
					/obj/item/clothing/head/helmet/space/void,
					/obj/item/clothing/shoes/magboots)
	cost = 100
	containertype = /obj/structure/closet/crate/large
	containername = "basic voidsuit crate"


/decl/hierarchy/supply_pack/operations/voidsuit_purple
	name = "EVA - Deluxe purple voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/exploration,
					/obj/item/clothing/head/helmet/space/void/exploration,
					/obj/item/clothing/shoes/magboots)
	cost = 300 //Expensive because moderately protects armor & heat
	containertype = /obj/structure/closet/crate/large
	containername = "purple voidsuit crate"

/decl/hierarchy/supply_pack/operations/voidsuit_red
	name = "EVA - Red voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/pilot,
					/obj/item/clothing/head/helmet/space/void/pilot,
					/obj/item/clothing/shoes/magboots)
	cost = 100
	containertype = /obj/structure/closet/crate/large
	containername = "red voidsuit crate"