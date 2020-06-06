
/datum/reagent
	var/addictiveness = 0						// Soft measure of how addiction a substance is.
	var/addiction_median_dose = 0				// The dosage at which addiction is 50% likely
	var/datum/reagent/parent_substance = null	// Used to generalize addiction between related substances e.g. alcohols, opioids
	var/addiction_display_name
	var/severe_ticks = 0						// Bursts of severe symptoms of withdrawal unique to each level

/datum/reagent/New()
	. = ..()
	if(!addiction_display_name)
		addiction_display_name = name

//Addiction and Withdrawal//
/datum/reagent/proc/withdrawal_act_stage1(mob/living/carbon/human/M)
	if(severe_ticks > 0)
		severe_ticks--
		M.add_chemical_effect(CE_SLOWDOWN, 1)

/datum/reagent/proc/withdrawal_act_stage2(mob/living/carbon/human/M)
	if(severe_ticks > 0)
		severe_ticks--
		M.add_chemical_effect(CE_SLOWDOWN, 3)
		if(prob(5)) M.eye_blurry = 10
		if(prob(10)) M.adjustHalLoss(10)
	M.add_chemical_effect(CE_PULSE, 1)

/datum/reagent/proc/withdrawal_act_stage3(mob/living/carbon/human/M)
	if(severe_ticks > 0)
		severe_ticks--
		M.add_chemical_effect(CE_SLOWDOWN, 3)
		M.make_jittery(5)
		if(prob(10))
			M.vomit()
			M.eye_blurry = 10
	M.add_chemical_effect(CE_PULSE, 1)
	M.add_chemical_effect(CE_SLOWDOWN, 1)
	if(prob(10)) M.adjustHalLoss(5)

/datum/reagent/proc/withdrawal_act_stage4(mob/living/carbon/human/M)
	if(severe_ticks > 0)
		severe_ticks--
		M.make_jittery(10)
		if(prob(10)) M.hallucination(25, 30)
		if(prob(5)) M.adjustHalLoss(10)
	M.add_chemical_effect(CE_PULSE, 1)
	M.add_chemical_effect(CE_SLOWDOWN, 4)
	if(prob(5))
		M.vomit()
		M.eye_blurry = 10
	if(prob(10)) M.adjustHalLoss(5)