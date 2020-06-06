/decl/hierarchy/supply_pack/custodial/janitor
	contains = list(/obj/item/clothing/shoes/galoshes,
					/obj/item/weapon/reagent_containers/glass/bucket,
					/obj/item/weapon/mop,
					/obj/item/weapon/caution = 4,
					/obj/item/weapon/storage/bag/trash,
					/obj/item/device/lightreplacer,
					/obj/item/weapon/reagent_containers/spray/cleaner,
					/obj/item/weapon/storage/box/lights/mixed,
					/obj/item/weapon/reagent_containers/glass/rag,
					/obj/item/weapon/grenade/chem_grenade/cleaner = 3,
					/obj/structure/mopbucket)

/decl/hierarchy/supply_pack/custodial/lightbulbs
	name = "Equipment - Replacement lights"
	contains = list(/obj/item/weapon/storage/box/lights/mixed = 3)
	cost = 6
	containername = "replacement lights crate"

/decl/hierarchy/supply_pack/custodial/mousetrap
	name = "Equipment - Pest control"
	contains = list(/obj/item/weapon/storage/box/mousetraps = 3)
	cost = 3
	containername = "pest control crate"

//equipment
/decl/hierarchy/supply_pack/custodial/janicart
	name = "Equipment - Janitorial cart"
	contains = list(/obj/structure/janitorialcart)
	cost = 35
	containertype = /obj/structure/largecrate
	containername = "janitorial cart crate"
