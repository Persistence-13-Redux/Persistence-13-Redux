/datum/seed/berry/New()
	. = ..()
	mutants += "juniperberries"

/datum/seed/berry/blue/New()
	. = ..()
	mutants += "juniperberries"

/datum/seed/grapes/green
	chems = list(/datum/reagent/nutriment = list(1,10), /datum/reagent/kelotane = list(3,5), /datum/reagent/drink/juice/grape/green = list(10,10))

/datum/seed/sugarcane/New()
	. = ..()
	chems[/datum/reagent/drink/juice/sugarcane_juice] = list(4,5)

// Alien weeds.
/datum/seed/xenomorph
	name = "xenomorph"
	seed_name = "alien weed"
	display_name = "alien weeds"
	force_layer = OBJ_LAYER
	chems = list(/datum/reagent/toxin/phoron = list(1,3))

/datum/seed/xenomorph/New()
	..()
	set_trait(TRAIT_PLANT_ICON,"vine2")
	set_trait(TRAIT_IMMUTABLE,1)
	set_trait(TRAIT_PRODUCT_COLOUR,"#3d1934")
	set_trait(TRAIT_FLESH_COLOUR,"#3d1934")
	set_trait(TRAIT_PLANT_COLOUR,"#3d1934")
	set_trait(TRAIT_PRODUCTION,1)
	set_trait(TRAIT_YIELD,-1)
	set_trait(TRAIT_SPREAD,2)
	set_trait(TRAIT_POTENCY,50)

//
// New plants
//


/datum/seed/agave
	name = "agave"
	seed_name = "agave"
	display_name = "agave"
	chems = list(/datum/reagent/nutriment = list(2,6), /datum/reagent/drink/juice/agave_sap = list(4,5))
/datum/seed/agave/New()
	..()
	set_trait(TRAIT_HARVEST_REPEAT,1)
	set_trait(TRAIT_MATURATION,4)
	set_trait(TRAIT_PRODUCTION,6)
	set_trait(TRAIT_YIELD,4)
	set_trait(TRAIT_POTENCY,10)
	set_trait(TRAIT_PRODUCT_ICON,"stalk")
	set_trait(TRAIT_PRODUCT_COLOUR,"#6bbd9f")
	set_trait(TRAIT_PLANT_COLOUR,"#6bbd9f")
	set_trait(TRAIT_PLANT_ICON,"stalk3")
	set_trait(TRAIT_IDEAL_HEAT, T0C + 40)
	set_trait(TRAIT_IDEAL_LIGHT, 7)
	set_trait(TRAIT_WATER_CONSUMPTION, 2)

/datum/seed/berry/juniper
	name = "juniper berries"
	seed_name = "juniper berries"
	display_name = "juniper tree"
	mutants = list("blueberries", "berries","poisonberries","glowberries")
	chems = list(/datum/reagent/nutriment = list(1,10), /datum/reagent/drink/juice/berry/juniper = list(10,10))
	kitchen_tag = "juniperberries"
/datum/seed/berry/juniper/New()
	..()
	set_trait(TRAIT_PRODUCT_COLOUR,"#1c227c")

/datum/seed/anise
	name = "anise"
	seed_name = "anise"
	display_name = "anise"
	chems = list(/datum/reagent/nutriment = list(1,2), /datum/reagent/nutriment/oil/aniseoil = list(2,5))
/datum/seed/anise/New()
	..()
	set_trait(TRAIT_HARVEST_REPEAT,1)
	set_trait(TRAIT_MATURATION,3)
	set_trait(TRAIT_PRODUCTION,6)
	set_trait(TRAIT_YIELD,3)
	set_trait(TRAIT_POTENCY,10)
	set_trait(TRAIT_PRODUCT_ICON,"nuts")
	set_trait(TRAIT_PRODUCT_COLOUR, COLOR_LIME)
	set_trait(TRAIT_PLANT_ICON,"bush2")
	set_trait(TRAIT_IDEAL_LIGHT, 5)