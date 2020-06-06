/datum/skill_buff/New(buff)
	if(buff)
		buffs = buff
	..(buffs)
	ADD_SAVED_VAR(buffs)