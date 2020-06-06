
/obj/item/weapon/stock_parts/circuitboard/chem_dispenser
	name = "circuit board (Portable Chem Dispenser)"
	build_path = /obj/machinery/chemical_dispenser
	board_type = "machine"
	origin_tech = list(TECH_DATA = 3, TECH_BIO = 2, TECH_ENGINEERING = 3)
	req_components = list(
							/obj/item/weapon/reagent_containers/glass/beaker = 2,
							/obj/item/weapon/stock_parts/capacitor = 1,
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/stock_parts/circuitboard/chem_master
	name = T_BOARD("Chem Master 2999")
	build_path = /obj/machinery/chem_master/
	board_type = "machine"
	origin_tech = list(TECH_MATERIAL = 2, TECH_DATA = 3, TECH_BIO = 2, TECH_ENGINEERING = 2)
	req_components = list(
							/obj/item/weapon/reagent_containers/glass/beaker = 2,
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/stock_parts/circuitboard/crematorium
	name = T_BOARD("crematorium")
	build_path = /obj/machinery/incinerator/crematorium
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 1, TECH_BIO = 1)
	req_components = list(
		/obj/item/device/assembly/igniter = 1,
		/obj/item/weapon/stock_parts/micro_laser = 1,
		/obj/item/weapon/stock_parts/micro_laser = 1
	)
	additional_spawn_components = list(
		/obj/item/weapon/stock_parts/keyboard = 1,
		/obj/item/weapon/stock_parts/power/apc/buildable = 1,
	)

/obj/item/weapon/stock_parts/circuitboard/clonepod
	name = T_BOARD("cloning pod")
	build_path = /obj/machinery/clonepod
	board_type = "machine"
	origin_tech = list(TECH_DATA = 3, TECH_BIO = 3)
	req_components = list(
		/obj/item/stack/cable_coil = 2,
		/obj/item/weapon/stock_parts/scanning_module = 2,
		/obj/item/weapon/stock_parts/manipulator = 2,
		/obj/item/weapon/stock_parts/console_screen = 1
	)
	additional_spawn_components = list(
		/obj/item/weapon/stock_parts/keyboard = 1,
		/obj/item/weapon/stock_parts/power/apc/buildable = 1
	)
