/*
	Base Alcohols
*/
/datum/chemical_reaction/whiskey
	name = "Whiskey"
	result = /datum/reagent/ethanol/whiskey
	required_reagents = list(/datum/reagent/nutriment/flour = 5, /datum/reagent/nutriment/cornoil = 5, /datum/reagent/enzyme = 5)
	catalysts = list(/datum/reagent/woodpulp = 5)
	minimum_temperature = T0C + 80
	maximum_temperature = T0C + 90
	result_amount = 15
	mix_message = "The solution roils as it rapidly ferments. Then you distil it into a red-brown liquid."

/datum/chemical_reaction/specialwhiskey
	name = "Special blend whiskey"
	result = /datum/reagent/ethanol/specialwhiskey
	required_reagents = list(/datum/chemical_reaction/whiskey = 20, /datum/reagent/enzyme = 20, /datum/reagent/hydrazine = 5)
	catalysts = list(/datum/reagent/woodpulp = 10)
	minimum_temperature = T0C + 60
	maximum_temperature = T0C + 90
	result_amount = 40
	mix_message = "The solution roils as it rapidly ferments and thickens. Then you distil it into an intensely reddish-brown liquid."

/datum/chemical_reaction/rum
	name = "Rum"
	result = /datum/reagent/ethanol/rum
	required_reagents = list(/datum/reagent/drink/juice/sugarcane_juice = 5, /datum/reagent/enzyme = 5)
	minimum_temperature = T0C + 60
	maximum_temperature = T0C + 90
	result_amount = 15
	mix_message = "The solution roils as it rapidly ferments. Then you distil it into a brown-ish liquid."

/datum/chemical_reaction/gin
	name = "Gin"
	result = /datum/reagent/ethanol/gin
	required_reagents = list(/datum/reagent/drink/juice/berry/juniper = 5, /datum/reagent/water = 5, /datum/reagent/enzyme = 5)
	maximum_temperature = T0C + 60
	result_amount = 15
	mix_message = "The solution roils as it rapidly ferments. Then you distil it into a clear juniper scented liquid."

/datum/chemical_reaction/vermouth
	name = "Vermouth"
	result = /datum/reagent/ethanol/vermouth
	required_reagents = list(/datum/reagent/ethanol/wine = 5, /datum/reagent/blackpepper = 5)
	minimum_temperature = T0C + 60
	maximum_temperature = T0C + 90
	result_amount = 10
	mix_message = "The solution roils as it rapidly ferments into a clear spice scented liquid."

/datum/chemical_reaction/tequila
	name = "Tequila"
	result = /datum/reagent/ethanol/tequilla
	required_reagents = list(/datum/reagent/drink/juice/agave_sap = 5, /datum/reagent/enzyme = 5)
	minimum_temperature = T0C + 80
	maximum_temperature = T0C + 90
	result_amount = 15
	mix_message = "The solution roils as it rapidly ferments. Then you distil it into a clear liquid."

/datum/chemical_reaction/absinthe
	name = "absinthe"
	result = /datum/reagent/ethanol/absinthe
	required_reagents = list(/datum/reagent/nutriment/oil/aniseoil = 5, /datum/reagent/enzyme = 5)
	minimum_temperature = T0C + 80
	maximum_temperature = T0C + 90
	result_amount = 15
	mix_message = "The solution roils as it rapidly ferments. Then you distil it into a strongly scented green liquid."

/datum/chemical_reaction/cognac
	name = "cognac"
	result = /datum/reagent/ethanol/cognac
	required_reagents = list(/datum/reagent/ethanol/wine/premium = 5, /datum/reagent/enzyme = 5)
	catalysts = list(/datum/reagent/copper = 5)
	minimum_temperature = T0C + 80
	maximum_temperature = T0C + 90
	result_amount = 15
	mix_message = "The solution roils as it rapidly ferments. Then you distil it into a smooth, amber liquid."

/datum/chemical_reaction/premium_wine //white wine literally
	name = "premium wine"
	result = /datum/reagent/ethanol/wine/premium
	required_reagents = list(/datum/reagent/drink/juice/grape/green = 5, /datum/reagent/enzyme = 5)
	result_amount = 10
	mix_message = "The solution roils as it rapidly ferments."

/datum/chemical_reaction/deadrum
	name = "dead rum"
	result = /datum/reagent/ethanol/deadrum
	required_reagents = list(/datum/reagent/ethanol/grog = 5, /datum/reagent/enzyme = 5)
	catalysts = list(/datum/reagent/sodiumchloride = 5,	/datum/reagent/water = 5)
	result_amount = 5 //highly concentrated
	mix_message = "The solution roils as it rapidly ferments. A puff of saltwater scented black smoke erupts out of the mix."

/datum/chemical_reaction/hessia
	name = "Hessia"
	result = /datum/reagent/ethanol/hessia
	required_reagents = list(/datum/reagent/ethanol/pwine = 5, /datum/reagent/psilocybin = 5, /datum/reagent/enzyme = 5)
	catalysts = list(/datum/reagent/sugar = 1) //The irony!
	result_amount = 15

/datum/chemical_reaction/goodbeer
	name = "Good beer"
	result = /datum/reagent/ethanol/beer/good
	required_reagents = list(/datum/reagent/ethanol/beer = 5, /datum/reagent/ethanol/ale = 5)
	catalysts = list(/datum/reagent/enzyme = 1)
	result_amount = 3

/datum/chemical_reaction/ale
	name = "Ale"
	result = /datum/reagent/ethanol/ale
	required_reagents = list(/datum/reagent/nutriment/flour = 10)
	catalysts = list(/datum/reagent/enzyme = 5)
	result_amount = 10
	mix_message = "The solution roils as it rapidly ferments into a foaming amber liquid."
	maximum_temperature = T0C + 60

/datum/chemical_reaction/moonshine
	maximum_temperature = T0C + 60

/datum/chemical_reaction/wine
	maximum_temperature = T0C + 60

/datum/chemical_reaction/pwine
	maximum_temperature = T0C + 60

/datum/chemical_reaction/melonliquor
	maximum_temperature = T0C + 60

/datum/chemical_reaction/bluecuracao
	maximum_temperature = T0C + 60

/datum/chemical_reaction/spacebeer
	maximum_temperature = T0C + 60

/datum/chemical_reaction/vodka
	maximum_temperature = T0C + 60

/datum/chemical_reaction/vodka2
	maximum_temperature = T0C + 60

/datum/chemical_reaction/sake
	maximum_temperature = T0C + 60

/datum/chemical_reaction/kahlua
	maximum_temperature = T0C + 60






