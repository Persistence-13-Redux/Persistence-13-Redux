//Search for a spawned human mob named "real_name"
/proc/get_human_by_real_name(var/real_name)
	for(var/mob/living/carbon/human/H in GLOB.human_mob_list)
		if(H.real_name == real_name)
			return H
	return null
