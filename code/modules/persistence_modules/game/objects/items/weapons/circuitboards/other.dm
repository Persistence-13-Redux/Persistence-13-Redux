
// /obj/item/weapon/stock_parts/circuitboard/vendor
// 	name = T_BOARD("Booze-O-Mat Vendor")
// 	build_path = /obj/machinery/vending/boozeomat
// 	board_type = "machine"
// 	origin_tech = list(TECH_DATA = 1)
// 	req_components = list(
// 							/obj/item/weapon/vending_refill/boozeomat = 3)

// 	var/list/names_paths = list(/obj/machinery/vending/boozeomat = "Booze-O-Mat",
// 							/obj/machinery/vending/coffee = "Solar's Best Hot Drinks",
// 							/obj/machinery/vending/snack = "Getmore Chocolate Corp",
// 							/obj/machinery/vending/cola = "Robust Softdrinks",
// 							/obj/machinery/vending/cigarette = "ShadyCigs Deluxe"
// 							)

// /obj/item/weapon/stock_parts/circuitboard/vendor/attackby(obj/item/I, mob/user, params)
// 	if(istype(I, /obj/item/weapon/screwdriver))
// 		set_type(pick(names_paths), user)


// /obj/item/weapon/stock_parts/circuitboard/vendor/proc/set_type(typepath, mob/user)
// 		build_path = typepath
// 		name = T_BOARD("[names_paths[build_path]] Vendor")
// 		user << "<span class='notice'>You set the board to [names_paths[build_path]].</span>"
// 		req_components = list(text2path("/obj/item/weapon/vending_refill/[copytext("[build_path]", 24)]") = 3)



/obj/item/weapon/stock_parts/circuitboard/jukebox
	name = T_BOARD("Jukebox")
	build_path = /obj/machinery/media/jukebox
	board_type = "machine"
	origin_tech = list(TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/capacitor = 1,
							/obj/item/weapon/stock_parts/console_screen = 1,
							/obj/item/stack/cable_coil = 1)



/obj/item/weapon/stock_parts/circuitboard/reagentgrinder
	name = T_BOARD("All-in-one Grinder")
	build_path = /obj/machinery/reagentgrinder
	board_type = "machine"
	origin_tech = list(TECH_MATERIAL = 2, TECH_ENGINEERING = 1, TECH_BIO = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 1,
							/obj/item/weapon/stock_parts/capacitor = 1,
							/obj/item/weapon/stock_parts/manipulator = 1,)

/obj/item/weapon/stock_parts/circuitboard/photocopier
	name = T_BOARD("photocopier")
	build_path = /obj/machinery/photocopier/
	board_type = "machine"
	origin_tech = list(TECH_MATERIAL =1, TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 2,
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/stock_parts/circuitboard/atm
	name = T_BOARD("ATM")
	build_path = /obj/machinery/atm
	board_type = "machine"
	origin_tech = list(TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 2,
							/obj/item/weapon/stock_parts/manipulator = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/stock_parts/circuitboard/teleporter_hub
	name = T_BOARD("teleporter hub")
	build_path = /obj/machinery/teleport/hub
	board_type = "machine"
	origin_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 5, TECH_MATERIAL = 4, TECH_BLUESPACE = 5)
	req_components = list(
							/obj/item/weapon/stock_parts/subspace/crystal = 3,
							/obj/item/weapon/stock_parts/matter_bin = 1)

/obj/item/weapon/stock_parts/circuitboard/teleporter_station
	name = T_BOARD("teleporter station")
	build_path = /obj/machinery/teleport/station
	board_type = "machine"
	origin_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4, TECH_BLUESPACE = 4)
	req_components = list(
							/obj/item/weapon/stock_parts/subspace/crystal = 2,
							/obj/item/weapon/stock_parts/capacitor = 2,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/stock_parts/circuitboard/smartfridge
	name = T_BOARD("smartfridge")
	build_path = /obj/machinery/smartfridge/
	board_type = "machine"
	origin_tech = list(TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/matter_bin = 3)

	var/list/names_paths = list(/obj/machinery/smartfridge/ = "Smart Fridge",
							/obj/machinery/smartfridge/seeds = "MegaSeed Servitor",
							/obj/machinery/smartfridge/secure/extract = "Slime Extract Storage",
							/obj/machinery/smartfridge/secure/medbay = "Refrigerated Medicine Storage",
							/obj/machinery/smartfridge/secure/virology = "Refrigerated Virus Storage",
							/obj/machinery/smartfridge/chemistry = "Smart Chemical Storage",
							/obj/machinery/smartfridge/chemistry/virology = "Smart Virus Storage",
							/obj/machinery/smartfridge/drinks = "Drink Showcase",
							/obj/machinery/smartfridge/drying_rack = "Drying Rack",)

/obj/item/weapon/stock_parts/circuitboard/smartfridge/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/screwdriver))
		set_type(pick(names_paths), user)

/obj/item/weapon/stock_parts/circuitboard/smartfridge/proc/set_type(typepath, mob/user)
		build_path = typepath
		name = T_BOARD("[names_paths[build_path]]")
		user << "<span class='notice'>You set the board to [names_paths[build_path]].</span>"

/obj/item/weapon/stock_parts/circuitboard/libraryscanner
	name = T_BOARD("book scanner")
	build_path = /obj/machinery/libraryscanner
	board_type = "machine"
	origin_tech = list(TECH_MATERIAL =1, TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/computer/hard_drive/portable = 1,
							/obj/item/weapon/stock_parts/scanning_module = 1,
							/obj/item/weapon/stock_parts/console_screen = 1)

/obj/item/weapon/stock_parts/circuitboard/bookbinder
	name = T_BOARD("book binder")
	build_path = /obj/machinery/bookbinder
	board_type = "machine"
	origin_tech = list(TECH_MATERIAL =1, TECH_DATA = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/computer/nano_printer = 1,
							/obj/item/weapon/stock_parts/manipulator = 1)

/obj/item/weapon/stock_parts/circuitboard/mass_driver
	name = T_BOARD("Mass driver")
	build_path = /obj/machinery/mass_driver
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 4)
	req_components = list(
							/obj/item/weapon/stock_parts/manipulator = 6,
							/obj/item/stack/cable_coil = 20,
							/obj/item/weapon/stock_parts/capacitor = 6)

/obj/item/weapon/stock_parts/circuitboard/igniter
	name = T_BOARD("Igniter")
	build_path = /obj/machinery/igniter
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 4)
	req_components = list(	/obj/item/device/assembly/igniter = 1,
							/obj/item/stack/cable_coil = 20,
							/obj/item/weapon/stock_parts/capacitor = 1)

/obj/item/weapon/stock_parts/circuitboard/custom_vending_machine
	name = T_BOARD("Custom vending machine")
	build_path = /obj/machinery/vending/custom
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 4)
	req_components = list(
		/obj/item/weapon/stock_parts/console_screen = 2,
		/obj/item/weapon/stock_parts/manipulator = 2,
		/obj/item/weapon/stock_parts/matter_bin = 4,
		)

/obj/item/weapon/stock_parts/circuitboard/icecream_vat
	name = T_BOARD("icecream vat")
	build_path = /obj/machinery/icecream_vat
	board_type = "machine"
	origin_tech = list(TECH_POWER = 1, TECH_ENGINEERING = 1)
	req_components = list(
							/obj/item/weapon/stock_parts/manipulator = 2,
							/obj/item/weapon/stock_parts/matter_bin = 2,
							/obj/item/weapon/reagent_containers/glass/bucket = 2)