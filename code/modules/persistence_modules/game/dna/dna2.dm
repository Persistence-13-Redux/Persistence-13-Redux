/datum/dna/New()
	. = ..()
	ADD_SAVED_VAR(uni_identity)
	ADD_SAVED_VAR(struc_enzymes)
	ADD_SAVED_VAR(unique_enzymes)
	ADD_SAVED_VAR(dirtyUI)
	ADD_SAVED_VAR(dirtySE)
	ADD_SAVED_VAR(b_type)
	ADD_SAVED_VAR(real_name)
	ADD_SAVED_VAR(s_base)
	ADD_SAVED_VAR(body_markings)
	ADD_SAVED_VAR(SE)
	ADD_SAVED_VAR(UI)

// /datum/dna/after_load()
// 	. = ..()
	//Don't reset anything. Otherwise it makes bad things happen
	// unique_enzymes = md5(real_name)
	// GLOB.reg_dna[unique_enzymes] = real_name
	// UpdateUI()
	// UpdateSE()

/datum/dna/ResetUIFrom(var/mob/living/carbon/human/character)
	if(!istype(character))
		return //Only humans have hair styles and etc..
	. = ..()

/datum/dna/ready_dna(mob/living/carbon/human/character)
	real_name = character.real_name
	b_type = character.b_type
	species = character.species? character.species.name : SPECIES_HUMAN
	. = ..()

/datum/dna/proc/get_dna_hash()
	return unique_enzymes