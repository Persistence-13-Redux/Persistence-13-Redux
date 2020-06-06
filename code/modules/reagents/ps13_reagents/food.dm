/datum/reagent/drink/juice/agave_sap
	name = "Agave sap"
	description = "A sweet sap extracted from agave plants."
	taste_description = "sweet"
	reagent_state = LIQUID
	nutrition = 2
	adj_drowsy = -2
	adj_sleepy = -2
	//Turns to sugar when heated
	heating_point = T100C
	heating_message = "The solution crystalizes."
	heating_products = list(/datum/reagent/sugar)

/datum/reagent/drink/juice/sugarcane_juice
	name = "Sugar cane juice"
	description = "The sweet sweet juice extracted from the sugar cane"
	taste_description = "sweet"
	reagent_state = LIQUID
	nutrition = 2
	adj_drowsy = -2
	adj_sleepy = -2
	//Turns to sugar when heated
	heating_point = T100C
	heating_message = "The solution crystalizes."
	heating_products = list(/datum/reagent/sugar)

/datum/reagent/nutriment/oil/aniseoil
	name = "Anise Oil"
	description = "An oil produced from anise seeds. Helps reduces flatulences."
	taste_description = "licorice"
	taste_mult = 0.1
	reagent_state = LIQUID
	nutriment_factor = 2
	color = COLOR_LIME

/datum/reagent/drink/juice/berry/juniper
	name = "Juniper Berry Juice"
	description = "A bitter blend of juniper berries."
	taste_description = "bitter berries"
	taste_mult = 8
	color = "#660099"

	glass_name = "bitter berry juice"
	glass_desc = "Who cares?"

/datum/reagent/drink/juice/grape/green
	name = "Green grapes juice"
	description = "Mashed green grapes juice!"
	taste_description = "sweet and slightly acidic"
	taste_mult = 1
	color = "#42ed2f"

	glass_name = "green grape juice"
	glass_desc = "Its grapes! Its green! Its juice!"
