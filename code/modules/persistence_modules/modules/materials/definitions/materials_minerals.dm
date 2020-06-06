//Overrides
/material/pitchblende
	ore_name = MATERIAL_PITCHBLENDE
	chem_products = list(
		/datum/reagent/radium = 20,
		/datum/reagent/uranium = 40
		)
	ore_matter = list(MATERIAL_URANIUM = 2000)
	asteroid_anger = 0.3

/material/graphite
	ore_compresses_to = MATERIAL_GRAPHITE
	energy_combustion = 32.7
	asteroid_anger = 0.05
	ignition_point= T0C + 700
	melting_point = T0C + 3500
	stack_type = /obj/item/stack/material/carbon
	ore_matter = list(MATERIAL_GRAPHITE = 2000)

/material/quartz
	asteroid_anger = 0.05
	ore_matter = list(MATERIAL_QUARTZ = 2000)

/material/pyrite
	asteroid_anger = 0.1
	ore_matter = list(MATERIAL_SULFUR = 2000, MATERIAL_IRON = 1000)

/material/spodumene //LiAl(SiO3)2
	chem_products = list(
		/datum/reagent/lithium = 20,
		/datum/reagent/silicon = 40,
		/datum/reagent/aluminum = 20,
		)
	asteroid_anger = 0.05
	ore_matter = list(MATERIAL_ALUMINIUM = 500, MATERIAL_LITHIUM = 500, MATERIAL_SAND = 500)
	energy_combustion = 43.1

/material/cinnabar
	chem_products = list(
		/datum/reagent/mercury  = 20,
		/datum/reagent/toxin/bromide = 5, //Shouldn't be in cinnabar, but whatever
	)
	asteroid_anger = 0.1
	ore_matter = list(MATERIAL_CINNABAR = 2000)

/material/phosphorite
	asteroid_anger = 0.2
	ore_matter = list(MATERIAL_PHOSPHORITE = 2000)

/material/rocksalt
	chem_products = list(
		/datum/reagent/sodium = 10,
		/datum/reagent/toxin/chlorine = 10
	)
	stack_type = /obj/item/stack/material/salt
	asteroid_anger = 0.05
	ore_matter = list(MATERIAL_ROCK_SALT = 2000)
	energy_combustion = 9.23

/material/potash
	asteroid_anger = 0.1
	ore_matter = list(MATERIAL_POTASH = 2000)

/material/bauxite
	asteroid_anger = 0.15
	ore_matter = list(MATERIAL_BAUXITE = 2000)
	energy_combustion = 31

/material/sand
	ore_matter = list(MATERIAL_SAND = 2000)

/material/phoron
	ore_matter = list(MATERIAL_PHORON = 2000)
	energy_combustion = 150
	asteroid_anger = 0.8

/material/phoron/supermatter
	asteroid_anger = 2.5

//
//New Materials
//
/material/sulfur
	name = MATERIAL_SULFUR
	icon_colour = "#edff21"
	flags = MATERIAL_BRITTLE
	conductive = 0
	hardness = MATERIAL_SOFT
	weight = 10
	integrity = 5
	ignition_point= T0C + 232
	melting_point = T0C + 115
	sheet_singular_name = "brick"
	sheet_plural_name = "bricks"
	ore_name = "native " + MATERIAL_SULFUR
	ore_result_amount = 10
	ore_spread_chance = 10
	ore_scan_icon = "mineral_common"
	ore_icon_overlay = "lump"
	chem_products = list(
		/datum/reagent/sulfur = 20,
		)
	ore_compresses_to = MATERIAL_SULFUR
	ore_matter = list(MATERIAL_SULFUR = 2000)
	energy_combustion = 9.23
	asteroid_anger = 0.05
