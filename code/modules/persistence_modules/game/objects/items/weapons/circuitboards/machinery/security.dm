#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it!
#endif

/obj/item/weapon/stock_parts/circuitboard/metal_detector
	name = T_BOARD("Metal Detector")
	build_path = /obj/machinery/metal_detector
	board_type = "machine"
	origin_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 3)
	req_components = list(
							/obj/item/weapon/stock_parts/scanning_module = 3,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/stock_parts/circuitboard/microscope
	name = T_BOARD("Microscope")
	build_path = /obj/machinery/microscope
	board_type = "machine"
	origin_tech = list(TECH_DATA = 2, TECH_BIO = 3, TECH_ENGINEERING = 3)
	req_components = list(
							/obj/item/weapon/stock_parts/scanning_module = 1,
							/obj/item/stack/material/glass = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/stock_parts/circuitboard/dnaforensics
	name = T_BOARD("DNA Analyzer")
	build_path = /obj/machinery/dnaforensics
	board_type = "machine"
	origin_tech = list(TECH_DATA = 2, TECH_BIO = 3, TECH_ENGINEERING = 3)
	req_components = list(
							/obj/item/weapon/stock_parts/scanning_module = 1,
							/obj/item/stack/material/glass = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)


/obj/item/weapon/stock_parts/circuitboard/doppler_array
	name = T_BOARD("doppler array")
	build_path = /obj/machinery/doppler_array
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_DATA = 2)
	req_components = list(
							/obj/item/weapon/stock_parts/scanning_module = 3,
							/obj/item/weapon/stock_parts/console_screen = 1,
							/obj/item/weapon/stock_parts/subspace/ansible = 1,
							)