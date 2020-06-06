/mob/living/carbon/human/fixblood()
	for(var/datum/reagent/blood/B in vessel.reagent_list)
		if(B.type == /datum/reagent/blood)
			B.data = list(
				"donor" = weakref(src),
				"donor_name" = real_name,
				"species" = species.name,
				"blood_DNA" = dna.unique_enzymes,
				"blood_colour" = species.get_blood_colour(src),
				"blood_type" = dna.b_type,
				"trace_chem" = null
			)
			B.color = B.data["blood_colour"]

//Add a field for the name of the donor for use in saving and etc
/mob/living/carbon/get_blood_data()
	var/data = ..()
	data["donor_name"] = src.real_name ? src.real_name : src.name
	return data