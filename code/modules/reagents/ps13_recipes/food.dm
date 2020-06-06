/*
	Enzyme
*/
/datum/chemical_reaction/enzyme
	name = "Universal enzyme"
	result = /datum/reagent/enzyme
	required_reagents = list(/datum/reagent/water = 2, /datum/reagent/nutriment = 2, /datum/reagent/nutriment/flour = 2)
	result_amount = 1
	minimum_temperature = T0C + 20
	maximum_temperature = T0C + 60
	mix_message = "The mix oozes together and starts bubbling. It smells like yeast.."

//Alternate recipe to grow more of it
/datum/chemical_reaction/enzyme2
	name = "Universal enzyme"
	result = /datum/reagent/enzyme
	required_reagents = list(/datum/reagent/nutriment/flour = 2, /datum/reagent/enzyme = 2)
	result_amount = 4 //make it more efficient
	minimum_temperature = T0C + 20
	maximum_temperature = T0C + 60
	mix_message = "The mix oozes together and starts bubbling. It smells like yeast.."

/datum/chemical_reaction/cream
	name = "cream"
	result = /datum/reagent/drink/milk/cream
	required_reagents = list(/datum/reagent/drink/milk = 10)
	catalysts = list(/datum/reagent/nutriment/cornoil = 1)
	result_amount = 5
	mix_message = "The solution thickens into a smooth creamy substance."
	minimum_temperature = 50 CELSIUS //so it doesn't conflicts with cheese
	maximum_temperature = 60 CELSIUS

/datum/chemical_reaction/vinegar3
	name = "vinegar"
	result = /datum/reagent/nutriment/vinegar
	required_reagents = list(/datum/reagent/acid/acetic = 5, /datum/reagent/water = 15)
	result_amount = 20

/datum/chemical_reaction/sweettea_green2
	name = "Sweet Green Tea"
	result = /datum/reagent/drink/tea/icetea/green/sweet
	required_reagents = list(/datum/reagent/drink/tea/icetea/green = 3, /datum/reagent/nutriment/honey = 1)
	result_amount = 4
	mix_message = "The ice clinks together in the sweet tea."

/datum/chemical_reaction/honey_crystallization
	name = "Honey Crystallization"
	result = /datum/reagent/sugar
	required_reagents = list(/datum/reagent/nutriment/honey = 2)
	minimum_temperature = 100 CELSIUS
	result_amount = 1
