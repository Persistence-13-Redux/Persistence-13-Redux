/decl/hierarchy/supply_pack/engineering/electrical
	contains = list(/obj/item/weapon/storage/toolbox/electrical = 2,
					/obj/item/clothing/gloves/insulated = 2,
					/obj/item/weapon/cell = 2,
					/obj/item/weapon/cell/high = 2)

/decl/hierarchy/supply_pack/engineering/bluespacerelay
	name = "Parts - Emergency bluespace relay parts"
	contains = list(/obj/item/weapon/stock_parts/circuitboard/bluespacerelay,
					/obj/item/weapon/stock_parts/manipulator,
					/obj/item/weapon/stock_parts/manipulator,
					/obj/item/weapon/stock_parts/subspace/filter,
					/obj/item/weapon/stock_parts/subspace/crystal,
					/obj/item/weapon/storage/toolbox/electrical)
	cost = 75
	containername = "emergency bluespace relay assembly kit"
	containertype = /obj/structure/closet/crate/secure
	access = core_access_leader

/decl/hierarchy/supply_pack/engineering/electrical
	containertype = /obj/structure/closet/secure_closet/engineering_electrical
	access = core_access_engineering_programs

/decl/hierarchy/supply_pack/engineering/electrical
	name = "Gear - Insulated gloves"
	contains = list(/obj/item/clothing/gloves/insulated = 3)
	cost = 20
	containername = "insulated glove crate"
	containertype = /obj/structure/closet/crate/secure
	access = core_access_engineering_programs

//equipment
/decl/hierarchy/supply_pack/engineering/emitter
	name = "Equipment - Emitters"
	contains = list(/obj/machinery/power/emitter = 2)
	cost = 12
	containertype = /obj/structure/closet/crate/secure/large
	containername = "emitter crate"
	access = core_access_engineering_programs

/decl/hierarchy/supply_pack/engineering/gyrotron
	name = "Equipment - Gyrotrons"
	contains = list(/obj/machinery/power/emitter/gyrotron = 2)
	cost = 50
	containertype = /obj/structure/closet/crate/secure/large
	containername = "gyrotron crate"
	access = core_access_engineering_programs

/decl/hierarchy/supply_pack/engineering/field_gen
	name = "Equipment - Field generator"
	contains = list(/obj/machinery/field_generator = 2)
	containertype = /obj/structure/closet/crate/large
	cost = 10
	containername = "field generator crate"
	access = core_access_engineering_programs

/decl/hierarchy/supply_pack/engineering/antibreach
	name = "Equipment - Anti-breach shields"
	contains = list(/obj/machinery/shieldgen = 4)
	containername = "anti-breach shield crate"
	containertype = /obj/structure/largecrate
	cost = 40

/decl/hierarchy/supply_pack/engineering/shieldgens
	name = "Equipment - Standard shield generators"
	contains = list(/obj/machinery/shieldwallgen = 2)
	cost = 20
	containertype = /obj/structure/closet/crate/secure/large
	containername = "wall shield generators crate"
	access = core_access_engineering_programs

decl/hierarchy/supply_pack/engineering/cablelayer
	name = "Equipment - Automatic cable layer"
	contains = list(/obj/machinery/cablelayer)
	containername = "automatic cable layer crate"
	containertype = /obj/structure/closet/crate/large
	cost = 50

decl/hierarchy/supply_pack/engineering/floorlayer
	name = "Equipment - Automatic floor layer"
	contains = list(/obj/machinery/floorlayer)
	containername = "automatic floor layer crate"
	containertype = /obj/structure/closet/crate/large
	cost = 50

decl/hierarchy/supply_pack/engineering/pipelayer
	name = "Equipment - Automatic pipe layer"
	contains = list(/obj/machinery/pipelayer)
	containername = "automatic pipe layer crate"
	containertype = /obj/structure/closet/crate/large
	cost = 50

/decl/hierarchy/supply_pack/engineering/engineering_cables
	name = "Bulk Cables Crate x300"
	contains = list(/obj/item/stack/cable_coil = 10)
	cost = 35
	containername = "\improper Bulk Cables Crate"

/decl/hierarchy/supply_pack/engineering/radsuit
	contains = list(/obj/item/clothing/suit/radiation = 6,
			/obj/item/clothing/head/radiation = 6,
			/obj/item/device/geiger = 6)

/decl/hierarchy/supply_pack/engineering/weldingmaskpainted
	num_contained = 1
	name = "Gear - Painted welding mask"
	contains = list(/obj/item/clothing/head/welding/demon,
					/obj/item/clothing/head/welding/knight,
					/obj/item/clothing/head/welding/fancy,
					/obj/item/clothing/head/welding/engie,
					/obj/item/clothing/head/welding/carp)
	cost = 5
	containername = "painted welding mask"

/decl/hierarchy/supply_pack/engineering/voidsuit_heavyduty
	name = "EVA - Heavy-duty engineering voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/engineering/alt,
					/obj/item/clothing/head/helmet/space/void/engineering/alt,
					/obj/item/clothing/shoes/magboots)
	containername = "heavy-duty engineering voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	cost = 180
	access = core_access_engineering_programs

/decl/hierarchy/supply_pack/engineering/softsuit
	name = "EVA - Engineering softsuit"
	contains = list(/obj/item/clothing/suit/space/softsuit/engineering,
					/obj/item/clothing/head/helmet/space/softsuit/engineering,
					/obj/item/clothing/shoes/magboots,
					/obj/item/weapon/tank/emergency/oxygen/engi)
	containername = "engineering softsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	cost = 30
	access = core_access_engineering_programs

/decl/hierarchy/supply_pack/engineering/emergency_floodlights
	name = "Equipment - Emergency floodlights(x4)"
	contains = list(/obj/machinery/floodlight = 4)
	cost = 50
	containertype = /obj/structure/largecrate
	containername = "emergency floodlights crate"