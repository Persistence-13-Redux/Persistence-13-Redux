//=================================================================================
//	Overrides
//=================================================================================
/datum/reagent/paint/New(datum/reagents/holder)
	. = ..()
	ADD_SAVED_VAR(color)

/datum/reagent/thermite
	gas_specific_heat = 10
	gas_flags = XGM_GAS_FUEL | XGM_GAS_OXIDIZER | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO

/datum/reagent/napalm
	gas_specific_heat = 10
	gas_flags = XGM_GAS_FUEL  | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO

/datum/reagent/space_cleaner
	gas_specific_heat =50
	gas_flags = XGM_GAS_CONTAMINANT  | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO

/datum/reagent/lube
	gas_specific_heat = 100
	gas_flags = XGM_GAS_CONTAMINANT | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO

/datum/reagent/lube/oil // TODO: Robot Overhaul in general
	gas_specific_heat = 80
	gas_flags = XGM_GAS_CONTAMINANT | XGM_GAS_FUEL | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO

/datum/reagent/glycerol
	gas_specific_heat = 120
	gas_burn_product = GAS_CO

/datum/reagent/nitroglycerin
	gas_specific_heat = 10
	gas_flags = XGM_GAS_CONTAMINANT | XGM_GAS_FUEL | XGM_GAS_OXIDIZER | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO

#define COOLANT_LATENT_HEAT 19000 //Twice as good at cooling than water is, but may cool below 20c. It'll cause freezing that atmos will have to deal with..
/datum/reagent/coolant
	gas_specific_heat = COOLANT_LATENT_HEAT
#undef COOLANT_LATENT_HEAT

/datum/reagent/ultraglue
	gas_specific_heat = 20
	gas_flags = XGM_GAS_FUEL | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO

/datum/reagent/woodpulp
	gas_specific_heat = 50
	gas_flags = XGM_GAS_CONTAMINANT | XGM_GAS_FUEL | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO

/datum/reagent/helium
	gas_id = GAS_HELIUM

/datum/reagent/oxygen
	gas_id = GAS_OXYGEN

/datum/reagent/carbon_monoxide
	gas_id = GAS_CO

//=================================================================================
//	New Stuff
//=================================================================================
/datum/reagent/nitrogen
	name = "Nitrogen"
	gas_id = GAS_NITROGEN
	taste_description = "nothing"
	reagent_state = LIQUID
	color = COLOR_GREEN_GRAY

/datum/reagent/hydrogen
	name = "Hydrogen"
	gas_id = GAS_HYDROGEN
	taste_description = "nothing"
	reagent_state = LIQUID
	color = COLOR_BLUE_GRAY

/datum/reagent/carbon_dioxide
	name = "Carbon Dioxide"
	gas_id = GAS_CO2
	taste_description = "nothing"
	reagent_state = LIQUID
	color = COLOR_GRAY15

//	C20H24N2O2
/datum/reagent/quinine
	name = "Quinine"
	description = "A very bitter, uv fluorescent powder. Used in making tonic water."
	taste_description = "bitterness"
	taste_mult = 4
	reagent_state = SOLID
	color = COLOR_BROWN_ORANGE
	heating_point = T0C + 177
	metabolism = 0.02 //Takes a while to get flushed// 8-14h - kidneys

/datum/reagent/hydrogen_peroxide
	name = "hydrogen peroxide"
	description = "A very common chemical with some disinfectant properties."
	taste_description = "stingy"
	taste_mult = 2
	reagent_state = LIQUID
	heating_point = T0C + 150
	color = COLOR_BLUE_LIGHT
	touch_met = 5
/datum/reagent/hydrogen_peroxide/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	if(M.germ_level < INFECTION_LEVEL_TWO) // rest and antibiotics is required to cure serious infections
		M.germ_level -= min(removed, M.germ_level)
	for(var/obj/item/I in M.contents)
		I.was_bloodied = null
	M.was_bloodied = null
/datum/reagent/hydrogen_peroxide/touch_obj(var/obj/O)
	O.germ_level -= min(volume, O.germ_level)
	O.was_bloodied = null
/datum/reagent/hydrogen_peroxide/touch_turf(var/turf/T)
	T.germ_level -= min(volume, T.germ_level)
	for(var/obj/item/I in T.contents)
		I.was_bloodied = null
	for(var/obj/effect/decal/cleanable/blood/B in T)
		qdel(B)

/datum/reagent/methanol
	name = "methanol"
	description = "Methyl alcohol, cause blindness if injested.."
	taste_description = "cold"
	taste_mult = 4
	reagent_state = LIQUID
	heating_point = T0C + 64
	color = COLOR_BLUE_LIGHT
	gas_flags = XGM_GAS_CONTAMINANT | XGM_GAS_FUEL | XGM_GAS_REAGENT_GAS
	gas_burn_product = GAS_CO
	gas_specific_heat = 15

/datum/reagent/methanol/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(!M || !length(M.organs_by_name))
		return
	M.adjustToxLoss(removed * 2)
	var/obj/item/organ/internal/eyes/E = M.organs_by_name[BP_EYES]
	if(E && !BP_IS_ROBOTIC(E))
		E.take_internal_damage(removed * 2)  //Methanol causes blindness

//Gonna be used in a few upcoming things like cheap salves and stuff
//C15 H31 C O O C30 H61
/datum/reagent/beeswax
	name = "beeswax"
	description = "Beeswax, from bees."
	taste_description = "chewy"
	taste_mult = 2
	reagent_state = LIQUID
	heating_point = T0C + 64 //Melting point
	color = "#fff343"
	gas_burn_product = GAS_CO //Beeswax is loaded with carbon and hydrogen sooo

/datum/reagent/cellulose
	name = "Cellulose"
	description = "Organic polymer, and major component of plant cells. Found in wood and cotton."
	taste_description = "like wet paper bags"
	reagent_state = LIQUID
	color = "#dbd3a6"

/datum/reagent/toxin/salpeter
	name = "Salpeter"
	description = "Potassium nitrate. A useful chemical used in anything from fertilizers to food preservatives."
	taste_description = "like wet paper bags"
	reagent_state = SOLID
	color = "#ffffff"
	strength = 0.5
