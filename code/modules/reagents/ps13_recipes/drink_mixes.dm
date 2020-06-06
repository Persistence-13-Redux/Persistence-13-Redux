/*
	Drink Mixes
*/
/datum/chemical_reaction/bluebird
	name = "Blue Bird"
	result = /datum/reagent/ethanol/bluebird
	required_reagents = list(/datum/reagent/ethanol/gin = 1, /datum/reagent/ethanol/bluecuracao = 1, /datum/reagent/drink/juice/lemon = 1)
	result_amount = 3
	
/datum/chemical_reaction/bj
	name = "BJ"
	result = /datum/reagent/ethanol/bj
	required_reagents = list(/datum/reagent/ethanol/coffee/kahlua = 1, /datum/reagent/drink/milk/cream = 1)
	result_amount = 2
	
/datum/chemical_reaction/starrycola
	name = "Starry Cola"
	result = /datum/reagent/ethanol/starrycola
	required_reagents = list(/datum/reagent/ethanol/moonshine = 1, /datum/reagent/drink/space_cola = 2)
	result_amount = 3
	
/datum/chemical_reaction/calvincraig
	name = "Calvin Craig"
	result = /datum/reagent/ethanol/calvincraig
	required_reagents = list(/datum/reagent/drink/dr_gibb = 1, /datum/reagent/drink/space_up = 1, /datum/reagent/sugar = 1,  /datum/reagent/drink/juice/lemon = 1, /datum/reagent/ethanol/melonliquor = 2)
	result_amount = 6
	
/datum/chemical_reaction/white_russian2
	name = "White Russian"
	result = /datum/reagent/ethanol/white_russian
	required_reagents = list(/datum/reagent/ethanol/bj = 2, /datum/reagent/ethanol/vodka = 1)
	result_amount = 3