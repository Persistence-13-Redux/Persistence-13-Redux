
/obj/item/weapon/stock_parts/circuitboard/turbine
	name = T_BOARD("gas turbine")
	build_path = /obj/machinery/power/turbine
	board_type = "machine"
	origin_tech = list(TECH_POWER = 4, TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/stack/cable_coil = 30,
		/obj/item/weapon/stock_parts/capacitor = 1,
		/obj/item/stack/material/plasteel = 10,
	)

/obj/item/weapon/stock_parts/circuitboard/compressor
	name = T_BOARD("compressor")
	build_path = /obj/machinery/compressor
	board_type = "machine"
	origin_tech = list(TECH_POWER = 4, TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/stack/cable_coil = 30,
		/obj/item/pipe = 2,
		/obj/item/stack/material/ocp = 10,
	)

/obj/item/weapon/stock_parts/circuitboard/pipeturbine
	name = T_BOARD("pipe turbine")
	build_path = /obj/machinery/atmospherics/pipeturbine
	board_type = "machine"
	origin_tech = list(TECH_POWER = 4, TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/stack/cable_coil = 30,
		/obj/item/pipe = 2,
		/obj/item/stack/material/plasteel = 10,
	)

/obj/item/weapon/stock_parts/circuitboard/turbinemotor
	name = T_BOARD("electric motor")
	build_path = /obj/machinery/power/turbinemotor
	board_type = "machine"
	origin_tech = list(TECH_POWER = 4, TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/stack/cable_coil = 30,
		/obj/item/weapon/stock_parts/capacitor = 2,
		/obj/item/stack/material/ocp = 10,
	)

/obj/item/weapon/stock_parts/circuitboard/generator
	name = T_BOARD("thermoelectric generator")
	build_path = /obj/machinery/power/generator
	board_type = "machine"
	origin_tech = list(TECH_POWER = 4, TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/stack/cable_coil = 30,
		/obj/item/weapon/stock_parts/capacitor = 2,
		/obj/item/stack/material/ocp = 10,
	)

/obj/item/weapon/stock_parts/circuitboard/circulator
	name = T_BOARD("circulator")
	build_path = /obj/machinery/atmospherics/binary/circulator
	board_type = "machine"
	origin_tech = list(TECH_POWER = 4, TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/stack/cable_coil = 30,
		/obj/item/pipe = 2,
		/obj/item/stack/material/plasteel = 10,
	)

/obj/item/weapon/stock_parts/circuitboard/cracker
	name = T_BOARD("molecular cracking unit")
	build_path = /obj/machinery/portable_atmospherics/cracker
	board_type = "machine"
	origin_tech = list(TECH_POWER = 4, TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/weapon/stock_parts/capacitor/ = 3, 
		/obj/item/weapon/stock_parts/matter_bin/ = 3,
	)
	additional_spawn_components = list(
		/obj/item/weapon/stock_parts/console_screen = 1,
		/obj/item/weapon/stock_parts/keyboard = 1,
		/obj/item/weapon/stock_parts/power/apc/buildable = 1
	)