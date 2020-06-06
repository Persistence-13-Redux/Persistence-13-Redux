
/datum/dna/after_load()
	. = ..()
	GLOB.reg_dna[unique_enzymes] = real_name