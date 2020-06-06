/obj/item/weapon/stock_parts/circuitboard/holopad
	name = T_BOARD("Holopad")
	build_path = /obj/machinery/hologram/holopad
	board_type = "machine"
	origin_tech = list(TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/capacitor = 1,
							/obj/item/weapon/stock_parts/scanning_module = 1)

/obj/item/weapon/stock_parts/circuitboard/holopad_longrange
	name = T_BOARD("Long Range Holopad")
	build_path = /obj/machinery/hologram/holopad/longrange
	board_type = "machine"
	origin_tech = list(TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/subspace/ansible = 1,
							/obj/item/weapon/stock_parts/subspace/filter = 1,
							/obj/item/weapon/stock_parts/subspace/crystal = 1,
							/obj/item/weapon/stock_parts/capacitor = 1,
							/obj/item/weapon/stock_parts/scanning_module = 1)
