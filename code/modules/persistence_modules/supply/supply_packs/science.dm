/decl/hierarchy/supply_pack/science/bombsuit_pack
	name = "Equipment - Scientist explosion resistant suit"
	contains = list(/obj/item/clothing/suit/bomb_suit,
					/obj/item/clothing/head/bomb_hood,
					/obj/item/clothing/shoes/eod)
	cost = 50
	containertype = /obj/structure/closet/bombcloset
	containername = "EOD closet"

/decl/hierarchy/supply_pack/science/virus
	name = "Samples - Virus (BIOHAZARD)"
	contains = list(/obj/item/weapon/virusdish/random = 4)
	cost = 25
	containertype = /obj/structure/closet/crate/secure
	containername = "virus sample crate"
	access = access_cmo

/decl/hierarchy/supply_pack/science/rnd
	name = "Parts - Research and Development boards"
	contains = list(/obj/item/weapon/stock_parts/circuitboard/rdserver,
					/obj/item/weapon/stock_parts/circuitboard/destructive_analyzer,
					/obj/item/weapon/stock_parts/circuitboard/autolathe,
					/obj/item/weapon/stock_parts/circuitboard/protolathe,
					/obj/item/weapon/stock_parts/circuitboard/circuit_imprinter,
					/obj/item/weapon/stock_parts/circuitboard/rdservercontrol,
					/obj/item/weapon/stock_parts/circuitboard/rdconsole)
	cost = 300
	containertype = /obj/structure/largecrate
	containername = "research startup crate"
//eva
/decl/hierarchy/supply_pack/science/softsuit
	name = "EVA - Scientist softsuit"
	contains = list(/obj/item/clothing/suit/space/softsuit/science,
					/obj/item/clothing/head/helmet/space/softsuit/science,
					/obj/item/clothing/shoes/magboots,
					/obj/item/weapon/tank/emergency/oxygen/engi)
	cost = 30
	containertype = /obj/structure/closet/crate/secure/large
	containername = "scientist softsuit crate"
	access = core_access_science_programs

/decl/hierarchy/supply_pack/science/voidsuit
	name = "EVA - Scientist voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/excavation,
					/obj/item/clothing/head/helmet/space/void/excavation,
					/obj/item/clothing/shoes/magboots)
	cost = 100
	containertype = /obj/structure/closet/crate/secure/large
	containername = "scientist voidsuit crate"
	access = core_access_science_programs

