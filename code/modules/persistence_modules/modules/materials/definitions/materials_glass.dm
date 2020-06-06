/material/glass/fiberglass
	name = MATERIAL_FIBERGLASS
	display_name = "fiberglass"
	stack_type = /obj/item/stack/material/glass/fiberglass
	flags = null //Fiberglass isn't very brittle
	icon_colour = "#bbbbcc"
	opacity = 0.4
	integrity = 125
	melting_point = T0C + 90 // It's slightly more susceptible to fire than normal glass
	tableslam_noise = 'sound/weapons/tablehit1.ogg'
	hitsound = 'sound/weapons/tablehit1.ogg'
	weight = 10
	brute_armor = 4 // It's very tough against brute damage though
	burn_armor = 1
	shard_type = SHARD_SPLINTER
	stack_origin_tech = list(TECH_MATERIAL = 2)
	destruction_desc = "splinters"
	window_options = list("One Direction" = 1, "Full Window" = 4)
	chem_products = list(
				/datum/reagent/silicon = 20,
				/datum/reagent/toxin/plasticide = 2
				)
