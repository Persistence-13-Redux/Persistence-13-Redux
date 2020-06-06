/material/plastic
	energy_combustion = 46.3

/material/cardboard
	value = 1
	energy_combustion = 8

/material/cloth
	hardness = MATERIAL_SOFT
	weight = 1
	energy_combustion = 8
	stack_type = /obj/item/stack/material/cloth
	value = 5

/material/carpet
	weight = 1
	hardness = MATERIAL_SOFT

/material/pink_goo
	name = "pinkgoo"
	stack_type = /obj/item/stack/material/edible/pink_goo_slab
	icon_colour = "#ff6a6a"
	icon_base = "solid"
	integrity = 5
	explosion_resistance = 0
	hardness = MATERIAL_SOFT
	brute_armor = 1
	weight = 8
	melting_point = T0C+300
	ignition_point = T0C+288
	stack_origin_tech = list(TECH_BIO = 2)
	sheet_singular_name = "slab"
	sheet_plural_name = "slabs"
	conductive = 0
	//By default don't put much chem products
	chem_products = list(
				/datum/reagent/nutriment = 10,
				/datum/reagent/nutriment/protein = 10,
				/datum/reagent/blood = 10,
				)

	
//Wax sheets, now using the material system, like everything else
/material/wax
	name = MATERIAL_BEESWAX
	sheet_singular_name = "piece"
	sheet_plural_name = "pieces"
	stack_type = /obj/item/stack/material/edible/beeswax
	icon_colour = "#fff343"
	icon_base = "puck"
	integrity = 10
	hardness = MATERIAL_SOFT
	weight = 4
	explosion_resistance = 0
	brute_armor = 0
	conductive = 0
	melting_point = T0C+62
	ignition_point = T0C+204
	chem_products = list(
		/datum/reagent/beeswax = 20,
	)