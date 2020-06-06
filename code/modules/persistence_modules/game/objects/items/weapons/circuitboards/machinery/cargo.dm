#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/weapon/stock_parts/circuitboard/recycler
	name = T_BOARD("Recycler")
	build_path = /obj/machinery/recycler
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_MATERIALS = 1)
	req_components = list(
		/obj/item/weapon/stock_parts/matter_bin = 1,
		/obj/item/weapon/stock_parts/manipulator = 1)

/obj/item/weapon/stock_parts/circuitboard/incinerator
	name = T_BOARD("incinerator")
	build_path = /obj/machinery/incinerator
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 1, TECH_BIO = 1)
	req_components = list(
		/obj/item/device/assembly/igniter = 1,
		/obj/item/weapon/stock_parts/micro_laser = 1,
		/obj/item/weapon/stock_parts/micro_laser = 1)

/obj/item/weapon/stock_parts/circuitboard/telepad
	name = T_BOARD("Telepad")
	build_path = /obj/machinery/telepad_cargo
	board_type = "machine"
	origin_tech = list(TECH_BLUESPACE = 1)
	req_components = list(
		/obj/item/weapon/stock_parts/matter_bin = 1,
		/obj/item/weapon/stock_parts/manipulator = 1,
		/obj/item/weapon/stock_parts/scanning_module = 1,
		/obj/item/weapon/stock_parts/capacitor = 1)
