#ifndef T_BOARD
#error T_BOARD macro is not defined but we need it! 
#endif

/obj/item/weapon/stock_parts/circuitboard/cable_layer
	name = T_BOARD("cable layer")
	build_path = /obj/machinery/cablelayer
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 1)
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 2,
	)

/obj/item/weapon/stock_parts/circuitboard/pipe_layer
	name = T_BOARD("pipe layer")
	build_path = /obj/machinery/pipelayer
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 1)
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 2,
	)
