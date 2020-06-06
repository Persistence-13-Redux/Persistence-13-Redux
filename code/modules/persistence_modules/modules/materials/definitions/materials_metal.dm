/material/uranium
	melting_point = 1405
	integrity = 50
	asteroid_anger = 0.2

/material/gold
	asteroid_anger = 0.2
	ore_matter = list(MATERIAL_GOLD = 2000)
	melting_point = 1337
	icon_base = "metal"
	icon_reinf = "metal"
	door_icon_base = "metal"

/material/gold/bronze //Need to disabled that crap for now
	name = "ERROR"
	ore_smelts_to = null
	ore_compresses_to = null
	sale_price = null

/material/copper
	chem_products = list(
		/datum/reagent/copper = 12,
		)
	ore_smelts_to = null
	ore_result_amount = 0
	ore_spread_chance = 0
	ore_name = null
	ore_scan_icon = null
	ore_icon_overlay = null
	sale_price = 1
	integrity = 50
	melting_point = 1357

/material/silver
	icon_base = "metal"
	icon_reinf = "metal"
	door_icon_base = "metal"
	table_icon_base = "metal"
	integrity = 75
	asteroid_anger = 0.1
	ore_matter = list(MATERIAL_SILVER = 1200)
	melting_point = 1234

/material/aluminium
	hardness = 15
	energy_combustion = 31
	melting_point = 933

/material/steel
	melting_point = 1643
	door_icon_base = "metal"
	table_icon_base = "metal"

/material/plasteel/titanium
	integrity = 250
	melting_point = 1941
	weight = 15
	hardness = MATERIAL_VERY_HARD
	ore_smelts_to = MATERIAL_TITANIUM

/material/osmium
	lore_text = "An extremely dense metal."
	melting_point = 3306
	integrity = 500
	weight = 50

/material/tritium
	ore_smelts_to = MATERIAL_TRITIUM
	ore_name = "raw tritium"
	ore_scan_icon = "mineral_rare"
	ore_icon_overlay = "gems"
	melting_point = 14

/material/deuterium
	ore_smelts_to = MATERIAL_DEUTERIUM
	ore_name = "raw deuterium"
	ore_scan_icon = "mineral_rare"
	ore_icon_overlay = "gems"
	melting_point = 14
	melting_point = 14

/material/mhydrogen
	melting_point = 14
	energy_combustion = 141.86
	asteroid_anger = 0.8

/material/platinum
	ore_matter = list(MATERIAL_PLATINUM = 1000)
	melting_point = 2041
	integrity = 80
	asteroid_anger = 0.2

/material/iron
	energy_combustion = 5.2
	asteroid_anger = 0.05
	hardness = 15
	melting_point = 1811
	integrity = 110

//
// New Metals
//

/material/lead
	name = MATERIAL_LEAD
	stack_type = /obj/item/stack/material/lead
	integrity = 80
	melting_point = 600
	icon_colour = "#6d6a65"
	weight = 40
	hardness = 3
	sheet_singular_name = "ingot"
	sheet_plural_name = "ingots"
	chem_products = list(/datum/reagent/lead = 20)

/material/tin
	name = MATERIAL_TIN
	stack_type = /obj/item/stack/material/tin
	integrity = 60
	melting_point = 505
	icon_colour = "#d3d4d5"
	weight = 22
	hardness = 10
	sheet_singular_name = "ingot"
	sheet_plural_name = "ingots"

/material/zinc //Used in batteries, and for stopping corrosion
	name = MATERIAL_ZINC
	stack_type = /obj/item/stack/material/zinc
	integrity = 50
	melting_point = 692
	icon_colour = "#bac4c8"
	weight = 20
	hardness = 5
	sheet_singular_name = "ingot"
	sheet_plural_name = "ingots"
	energy_combustion = 5.3

/material/boron
	name = MATERIAL_BORON
	integrity = 300
	weight = 25
	hardness = 30
	melting_point = 2349 //K
	icon_colour = COLOR_GRAY15
	ore_smelts_to = MATERIAL_BORON
	ore_result_amount = 10
	ore_spread_chance = 15
	ore_name = MATERIAL_BORON
	ore_scan_icon = "mineral_common"
	stack_origin_tech = list(TECH_MATERIAL = 5)
	xarch_ages = list(
		"thousand" = 999,
		"million" = 999,
		"billion" = 13,
		"billion_lower" = 10
		)
	xarch_source_mineral = MATERIAL_BORON
	ore_icon_overlay = "nugget"
	chem_products = list(/datum/reagent/boron = 20)
	sheet_singular_name = "ingot"
	sheet_plural_name = "ingots"
	sale_price = 2
	ore_matter = list(MATERIAL_BORON = 2000)

/material/bronze
	name = MATERIAL_BRONZE
	stack_type = /obj/item/stack/material/bronze
	weight = 20
	hardness = 40
	integrity = 120
	melting_point = 950
	icon_colour = "#cd7f32"
	ore_smelts_to = null
	ore_compresses_to = null
	alloy_materials = list(MATERIAL_TIN = 240, MATERIAL_COPPER = 1760) //Bronze is  ~12% tin
	alloy_product = TRUE

/material/brass
	name = MATERIAL_BRASS
	stack_type = /obj/item/stack/material/brass
	weight = 18
	hardness = 20
	integrity = 80
	melting_point = 900
	icon_colour = "#b5a642"
	ore_smelts_to = null
	ore_compresses_to = null
	alloy_materials = list(MATERIAL_ZINC = 600, MATERIAL_COPPER = 1400) //Brass is ~30% zinc
	alloy_product = TRUE

/material/tungsten
	name = MATERIAL_TUNGSTEN
	stack_type = /obj/item/stack/material/tungsten
	integrity = 250 // Tungsten ain't no bitch
	melting_point = 16000 //It should actually be 3,695K, not 16,000K.. but whatever
	icon_colour = "#8888aa"
	weight = 32 // Tungsten B-Ball bats OP AF
	stack_origin_tech = list(TECH_MATERIAL = 4)
	sheet_singular_name = "ingot"
	sheet_plural_name = "ingots"
	ore_smelts_to = MATERIAL_TUNGSTEN
	ore_result_amount = 5
	ore_spread_chance = 10
	ore_name = MATERIAL_TUNGSTEN
	ore_scan_icon = "mineral_uncommon"
	ore_icon_overlay = "shiny"
	chem_products = list(
				/datum/reagent/tungsten = 20
				)
	ore_matter = list(MATERIAL_TUNGSTEN = 2000)
	asteroid_anger = 0.1
