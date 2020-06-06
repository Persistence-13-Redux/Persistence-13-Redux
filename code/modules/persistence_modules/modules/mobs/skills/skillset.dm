/datum/skillset/New(mob/mob)
	..()
	ADD_SAVED_VAR(skill_list)
	ADD_SAVED_VAR(owner)
	ADD_SAVED_VAR(skill_buffs)

	ADD_SKIP_EMPTY(skill_list)
	ADD_SKIP_EMPTY(owner)
	ADD_SKIP_EMPTY(skill_buffs)

/datum/skillset/after_load()
	. = ..()
	for(var/datum/skill_buff/sb in skill_buffs)
		sb.skillset = src //Make sure our skill_buffs have the correct owner
	for(var/datum/skill_verb/SV in GLOB.skill_verbs)
		if(SV.should_have_verb(src))
			SV.give_to_skillset(src)

/mob/get_skill_value(skill_path)
	return istype(skillset)? skillset.get_value(skill_path) : null
