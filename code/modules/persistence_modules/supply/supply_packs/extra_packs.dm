//Good internals
/decl/hierarchy/supply_pack/atmospherics/internals_alt
	name = "Gear - High Quality Internals"
	contains = list(/obj/item/clothing/mask/breath = 8,
					/obj/item/weapon/tank/emergency/oxygen/double = 8)
	cost = 12
	containername = "internals crate"
	containertype = /obj/structure/closet/crate/internals

/decl/hierarchy/supply_pack/atmospherics/assorted_gas_masks
	name = "Gear - Assorted gas masks (x10)"
	contains = list(/obj/item/clothing/mask/gas = 5,
					/obj/item/clothing/mask/gas/half = 5)
	cost = 12
	containername = "gas masks crate"

/decl/hierarchy/supply_pack/atmospherics/inflatable
	contains = list(/obj/item/weapon/storage/briefcase/inflatable = 3)

//
/decl/hierarchy/supply_pack/atmospherics/airpump
	name = "Equipment - Four portable air pumps"
	contains = list(/obj/machinery/portable_atmospherics/powered/pump = 4)
	cost = 25
	containername = "portable air pumps crate"
	containertype = /obj/structure/largecrate

/decl/hierarchy/supply_pack/atmospherics/scrubber
	name = "Equipment - Four portable air scrubbers"
	contains = list(/obj/machinery/portable_atmospherics/powered/scrubber = 4)
	cost = 25
	containername = "portable air scrubbers crate"
	containertype = /obj/structure/largecrate

/decl/hierarchy/supply_pack/atmospherics/huge_scrubber
	name = "Equipment - Two large air scrubbers"
	contains = list(/obj/machinery/portable_atmospherics/powered/scrubber/huge = 2)
	cost = 35
	containername = "portable large air scrubber crate"
	containertype = /obj/structure/largecrate

/decl/hierarchy/supply_pack/atmospherics/gas_generator
	name = "Equipment - Gas generator"
	contains = list(/obj/machinery/portable_atmospherics/gas_generator)
	cost = 25
	containername = "gas generator crate"
	containertype = /obj/structure/largecrate

/decl/hierarchy/supply_pack/atmospherics/bulk_canister_air
	name = "Gas - Ten air canisters"
	contains = list(/obj/machinery/portable_atmospherics/canister/air = 10)
	cost = 100
	containername = "air canister crate"
	containertype = /obj/structure/largecrate

/decl/hierarchy/supply_pack/atmospherics/voidsuit
	name = "EVA - Atmospherics voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/atmos,
					/obj/item/clothing/head/helmet/space/void/atmos,
					/obj/item/clothing/shoes/magboots)
	cost = 100
	containername = "atmospherics voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = access_atmospherics

/decl/hierarchy/supply_pack/atmospherics/voidsuit_heavyduty
	name = "EVA - Heavy-duty atmospherics voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/atmos/alt,
					/obj/item/clothing/head/helmet/space/void/atmos/alt,
					/obj/item/clothing/shoes/magboots)
	cost = 120
	containername = "atmospherics voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = access_atmospherics


//refill packs
/decl/hierarchy/supply_pack/dispenser_cartridges/alcohol_reagents
	name = "Refills - Bar alcoholic dispenser refill"
	contains = list(
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/beer,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/kahlua,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/whiskey,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/wine,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/vodka,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/gin,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/rum,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/tequila,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/vermouth,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/cognac,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/ale,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/mead)
	cost = 50
	containername = "alcoholic drinks crate"

/decl/hierarchy/supply_pack/dispenser_cartridges/softdrink_reagents
	name = "Refills - Bar soft drink dispenser refill"
	contains = list(
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/water,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/green_tea,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/cola,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/smw,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/dr_gibb,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/spaceup,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/tonic,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/sodawater,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/lemon_lime,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/sugar,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/orange,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/lime,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/watermelon,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/coffee,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/cafe_latte,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/soy_latte,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/hot_coco,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/milk,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/cream,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/tea,
			/obj/item/weapon/reagent_containers/chem_disp_cartridge/ice)
	cost = 60
	containername = "soft drinks crate"
