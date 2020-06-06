/mob/living/carbon/brain/New()
	..()
	ADD_SAVED_VAR(container)
	ADD_SAVED_VAR(timeofhostdeath)
	ADD_SAVED_VAR(emp_damage)

/mob/living/carbon/brain/SetupReagents()
	. = ..()
	create_reagents(1000)

/mob/living/carbon/brain/proc/add_lace_action()
	return