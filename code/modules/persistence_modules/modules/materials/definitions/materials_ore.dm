//-------------------------------------
//	Ores
//-------------------------------------
/material/hematite
	ore_name = MATERIAL_HEMATITE //Fe2O3
	ore_matter = list(MATERIAL_IRON = 2000)
	asteroid_anger = 0.1
	icon_base = "stone"
	icon_reinf = "reinf_stone"

/material/rutile
	ore_matter = list(MATERIAL_TITANIUM = 2000)
	asteroid_anger = 0.2

/material/freibergite
	name = MATERIAL_FREIBERGITE
	icon_colour = "#b87333"
	ore_smelts_to = MATERIAL_COPPER
	ore_result_amount = 5
	ore_spread_chance = 10
	ore_name = MATERIAL_FREIBERGITE //(Ag,Cu,Fe)12(Sb,As)4S13
	ore_scan_icon = "mineral_common"
	ore_icon_overlay = "shiny"
	chem_products = list(
		/datum/reagent/copper = 12,
		/datum/reagent/iron = 12,
		/datum/reagent/silver = 12,
		/datum/reagent/sulfur = 14,
		)
	ore_matter = list(MATERIAL_COPPER = 1200, MATERIAL_SILVER = 1200, MATERIAL_IRON = 1200)
	asteroid_anger = 0.1

/material/bohmeite
	name = MATERIAL_BOHMEITE
	icon_colour = "#443832"
	ore_smelts_to = MATERIAL_COPPER
	ore_result_amount = 5
	ore_spread_chance = 10
	ore_name = MATERIAL_BOHMEITE
	ore_scan_icon = "mineral_common"
	ore_icon_overlay = "shiny"
	chem_products = list(
		/datum/reagent/copper = 12,
		/datum/reagent/aluminum = 12,
		)
	ore_matter = list(MATERIAL_COPPER = 1200, MATERIAL_GOLD = 1200, MATERIAL_ALUMINIUM = 1200)
	asteroid_anger = 0.25

/material/tetrahedrite
	name = MATERIAL_TETRAHEDRITE
	icon_colour = "#b87333"
	ore_smelts_to = MATERIAL_COPPER
	ore_result_amount = 5
	ore_spread_chance = 10
	ore_name = MATERIAL_TETRAHEDRITE //(Cu,Fe)12Sb4S13
	ore_scan_icon = "mineral_common"
	ore_icon_overlay = "shiny"
	chem_products = list(
		/datum/reagent/copper = 12,
		/datum/reagent/iron = 12,
		/datum/reagent/sulfur = 13,
		)
	ore_matter = list(MATERIAL_COPPER = 1800)
	asteroid_anger = 0.2

/material/ilmenite
	name = MATERIAL_ILMENITE
	icon_colour = "#d1e6e3"
	ore_smelts_to = MATERIAL_TITANIUM
	ore_result_amount = 5
	ore_spread_chance = 10
	ore_name = MATERIAL_ILMENITE //iron titanium oxide, FeTiO3
	ore_scan_icon = "mineral_uncommon"
	ore_icon_overlay = "shiny"
	chem_products = list(
		/datum/reagent/iron = 10,
		)
	ore_matter = list(MATERIAL_IRON = 1000, MATERIAL_TITANIUM = 1000)
	asteroid_anger = 0.2

/material/galena
	name = MATERIAL_GALENA
	icon_colour = "#a0a29a"
	ore_smelts_to = MATERIAL_LEAD
	ore_result_amount = 5
	ore_spread_chance = 10
	ore_name = MATERIAL_GALENA //Lead sulfide, PbS
	ore_scan_icon = "mineral_common"
	ore_icon_overlay = "shiny"
	chem_products = list(
		/datum/reagent/sulfur = 10,
		)
	ore_matter = list(MATERIAL_LEAD = 2000)
	asteroid_anger = 0.1

/material/cassiterite
	name = MATERIAL_CASSITERITE
	icon_colour = "#42270f"
	ore_smelts_to = MATERIAL_TIN
	ore_result_amount = 8
	ore_spread_chance = 10
	ore_name = MATERIAL_CASSITERITE //Tin oxide, SnO2
	ore_scan_icon = "mineral_common"
	ore_icon_overlay = "shiny"
	ore_matter = list(MATERIAL_TIN = 2000)
	asteroid_anger = 0.1

/material/sphalerite
	name = MATERIAL_SPHALERITE
	icon_colour = "#b9a85e"
	ore_smelts_to = MATERIAL_ZINC
	ore_result_amount = 8
	ore_spread_chance = 10
	ore_name = MATERIAL_SPHALERITE //Zinc oxide, (Zn,Fe)S
	ore_scan_icon = "mineral_common"
	ore_icon_overlay = "shiny"
	chem_products = list(
		/datum/reagent/sulfur = 5,
		/datum/reagent/iron = 5,
		)
	ore_matter = list(MATERIAL_ZINC = 2000)
	asteroid_anger = 0.1
