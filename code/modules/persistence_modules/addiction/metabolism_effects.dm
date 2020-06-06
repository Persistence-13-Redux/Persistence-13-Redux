#define MAX_WITHDRAWAL_INCREASE 	10
#define MIN_TIME_TO_WITHDRAWAL		750
#define WITHDRAWAL_THRESHOLD   		50

/datum/reagents/metabolism/New(var/max = 100, mob/living/carbon/parent_mob, var/met_class)
	. = ..()
	ADD_SAVED_VAR(metabolism_class)
	ADD_SAVED_VAR(parent)

/datum/metabolism_effects
	var/mob/living/carbon/parent

	var/list/datum/reagent/withdrawal_levels = list() // Level of 'withdrawal' of the parent mob. Higher levels result in worse symptoms.
	var/list/datum/reagent/addiction_levels = list()  // Level of 'addiction'  of the parent mob. Higher levels result in a faster rate of withdrawal symptoms.
	var/list/last_doses						= list()

/datum/metabolism_effects/New(mob/living/carbon/parent_mob)
	..()

	if(istype(parent_mob))
		parent = parent_mob

	ADD_SAVED_VAR(parent)
	ADD_SAVED_VAR(withdrawal_levels)
	ADD_SAVED_VAR(addiction_levels)
	ADD_SAVED_VAR(last_doses)

/datum/metabolism_effects/proc/check_reagent(datum/reagent/RT, var/volume, var/removed)
	// Addiction
	var/datum/reagent/ref_reagent = new RT
	var/datum/reagent/addict_reagent = (ref_reagent.parent_substance ? new ref_reagent.parent_substance : ref_reagent)

	if(!is_type_in_list(addict_reagent, addiction_levels))
		var/add_addiction_prob = 100 * (1 - (Root(0.5, ref_reagent.addiction_median_dose/removed)))
		if(prob(add_addiction_prob))
			addiction_levels.Add(addict_reagent)
			addiction_levels[addict_reagent] = 10
			withdrawal_levels.Add(addict_reagent)
			withdrawal_levels[addict_reagent] = 0

			last_doses.Add(addict_reagent)
			last_doses[addict_reagent] = parent.life_tick

	else
		for(var/addiction in addiction_levels)
			var/datum/reagent/A = addiction
			if(istype(addict_reagent, A))
				addiction_levels[A] += (ref_reagent.addictiveness) * removed
				last_doses[A] = parent.life_tick
				withdrawal_levels[A] = 0

	qdel(addict_reagent)
	qdel(ref_reagent)

/datum/metabolism_effects/proc/process()

	for(var/addiction in addiction_levels)
		var/datum/reagent/R = addiction
		if(!R)
			addiction_levels.Remove(R)
			withdrawal_levels.Remove(R)
			last_doses.Remove(R)
			continue

		if(addiction_levels[R] <= 0)
			to_chat(parent, SPAN_NOTICE("You feel like you've gotten over your need for [R.addiction_display_name]."))
			addiction_levels.Remove(R)
			withdrawal_levels.Remove(R)
			last_doses.Remove(R)
			continue

		if(last_doses[R] + MIN_TIME_TO_WITHDRAWAL >= parent.life_tick)
			continue

		withdrawal_levels[R] += min(MAX_WITHDRAWAL_INCREASE, addiction_levels[R]/50)

		process_withdrawal(R)

/datum/metabolism_effects/proc/process_withdrawal(var/datum/reagent/R)
	if(addiction_levels[R] < WITHDRAWAL_THRESHOLD)
		if(prob(5))
			to_chat(parent, SPAN_NOTICE("You feel like having some [R.addiction_display_name] right about now."))
			addiction_levels[R]-- // At this stage exponential subtractions will result in ridiculous floating points; a flat decrease is preferable.
	else switch(withdrawal_levels[R])
		if(0 to 100)
			if(prob(5))
				if(prob(50)) to_chat(parent, SPAN_NOTICE("You feel like having some [R.addiction_display_name] right about now.")) // We'll give players an indication that their addiction is going away
				addiction_levels[R]--
		if(100 to 400)
			if(prob(5))
				to_chat(parent, SPAN_NOTICE("You're getting a headache. You could really go for some [R.addiction_display_name]."))
				addiction_levels[R]--
				R.severe_ticks = 10
			R.withdrawal_act_stage1(parent)
		if(400 to 600)
			if(prob(5))
				to_chat(parent, SPAN_NOTICE("You're not feeling so good. You need some [R.addiction_display_name]."))
				R.severe_ticks = 10
				addiction_levels[R] *= 0.95
			R.withdrawal_act_stage2(parent)
			addiction_levels[R]--
		if(600 to 750) // This is where symptoms generally get difficult to manage. Decreasing the time it takes for reductions to really kick in will stop frustration
			if(prob(5))
				to_chat(parent, SPAN_DANGER("You have an intense craving for [R.addiction_display_name]! You're really starting to feel ill!"))
				R.severe_ticks = 10
				addiction_levels[R] *= 0.90
			R.withdrawal_act_stage3(parent)
			addiction_levels[R]--
		if(800 to INFINITY)
			if(prob(5))
				to_chat(parent, SPAN_DANGER("You feel horrible! You NEED [R.addiction_display_name]!"))
				R.severe_ticks = 10
				addiction_levels[R] *= 0.85
			R.withdrawal_act_stage4(parent)
			addiction_levels[R] -= 5

/datum/metabolism_effects/proc/clear_effects()
	addiction_levels.Cut()
	withdrawal_levels.Cut()
	last_doses.Cut()

#undef MAX_WITHDRAWAL_INCREASE
#undef MIN_TIME_TO_WITHDRAWAL
#undef WITHDRAWAL_THRESHOLD