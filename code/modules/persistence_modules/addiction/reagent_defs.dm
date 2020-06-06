/datum/reagent/ethanol
	var/global/list/drink_tipsy_messages = list(
		"You feel pleasantly warm.",
		"You feel nice and toasty.",
		"You're feeling pretty good.",
		"You're ready for a party.",
		"You wouldn't mind another drink.",
	)	
	
	var/global/list/drink_buzzed_messages = list(
		"You feel nice and toasty.",
		"Your face feels warm.",
		"You're full of energy.",
		"You're feeling very chatty.",
		"You wouldn't mind another drink.",
		"You're in a good mood."
	)	
	
	var/global/list/drink_drunk_messages = list(
		"You're having trouble keeping your balance.",
		"The world spins around you.",
		"You feel nice and toasty.",
		"You're full of energy.",
		"Your face is burning.",
		"You're feeling very chatty."
	)	
	
	var/global/list/drink_hammered_messages = list(
		"You feel like trash.",
		"The world spins around you.",
		"You're having trouble keeping your balance.",
		"You can't remember the last few minutes.",
		"You're absolutely hammered.",
		"You're completely trashed.",
		"You feel angry.",
		"You feel sad.",
		"You catch yourself staggering."
	)	

/datum/reagent/tramadol
	addictiveness = 2
	addiction_median_dose = 120
	parent_substance = /datum/reagent/tramadol
	addiction_display_name = "Opioids"

/datum/reagent/tramadol/oxycodone
	addictiveness = 4
	addiction_median_dose = 60

/datum/reagent/hyperzine
	addictiveness = 3
	addiction_median_dose = 30

/datum/reagent/nicotine
	addictiveness = 1
	addiction_median_dose = 40 // very small amounts of nicotine ever enter the blood.

/datum/reagent/space_drugs
	addictiveness = 10
	addiction_median_dose = 10

/datum/reagent/psilocybin
	addictiveness = 2
	addiction_median_dose = 5

	var/global/list/shroom_dose_messages = list(
		"The world spins pleasantly around you.",
		"You look down, and your hands aren't yours.",
		"The walls flow slowly, over and over again.",
		"You're not sure you've ever seen that color before.",
		"The floor is fascinating.",
		"Your arm feels very soft.",
		"There's a brief fluttering in your chest.",
		"You smile contentedly, for no reason.",
		"Breathing feels nice.",
		"You feel like you're in a dream.",
		"You forgot you could be as happy as this.",
		"Everything around you is crisp and clear.",
		"All things love you, and you love them.",
		"You feel a strong connection to the place around you.",
		"The door into yourself opens.",
		"Every emotion feels magnified.",
		"You dream of being yourself.",
		"You dream of being no one."
	)
	
/datum/reagent/phorostimulant
	name = "Phorostim"
	description = "A recreational stimulant derived from phoron."
	taste_description = "sharp"
	reagent_state = LIQUID
	color = "#ff3300"
	metabolism = REM * 0.15
	overdose = REAGENTS_OVERDOSE * 0.5

	addictiveness = 3
	addiction_median_dose = 30

	var/global/list/stim_dose_messages = list(
		"The world races, but not as fast as you.",
		"You feel on top of the world.",
		"You're in control.",
		"You can do anything.",
		"You've accomplished so much.",
		"Euphoria floods your mind.",
		"You need to talk to someone else.",
		"It's hard to stay calm!",
		"You need to do something with your hands.",
		"You have to stay busy.",
		"You feel like cleaning something.",
		"Your heart races like the wind.",
		"You find yourself blinking a lot.",
		"You can barely feel your face.",
		"The world flashes a pleasant orange.",
		"You think about space.",
		"You think about stone.",
		"Something alive flashes in the corner of your eye.",
		"The floor rumbles beneath you.",
		"You feel the urge to go on an adventure.",
		"You feel the urge to mine."
	)	
	
	var/global/list/stim_overdose_messages = list(
		"The world is spinning, far too fast.",
		"You stumble, your hands shaking.",
		"You're not in control.",
		"You need to move, but your body doesn't respond.",
		"Your heart beats out of your chest.",
		"You look down, and see endless slugs.",
		"Teeth gnash at you, from every direction.",
		"The ground shakes violently",
		"Everything is orange.",
		"You feel like you're going to die.",
		"This is too much engagement."
	)	

/datum/reagent/phorostimulant/overdose(var/mob/living/carbon/M, var/alien)
	..()
	M.adjustBrainLoss(1)
	if(ishuman(M) && prob(10))
		var/mob/living/carbon/human/H = M
		H.seizure()
	if(prob(10))
		to_chat(M, SPAN_DANGER("[pick(stim_overdose_messages)]"))
		
/datum/reagent/phorostimulant/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_DIONA)
		return
	if(prob(5))
		M.emote(pick("twitch", "blink_r", "shiver"))
		to_chat(M, "[pick(stim_dose_messages)]")
	M.add_chemical_effect(CE_SPEEDBOOST, 0.2)
	M.add_chemical_effect(CE_PULSE, 3)

