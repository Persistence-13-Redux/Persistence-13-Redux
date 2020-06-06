/mob/living/simple_animal
	//Grabbing up 
	holder_type = /obj/item/weapon/holder

/mob/living/simple_animal/New()
	. = ..()
	ADD_SAVED_VAR(name) //For renamed pets
	ADD_SAVED_VAR(desc)
	ADD_SAVED_VAR(bleed_ticks)
	ADD_SAVED_VAR(meat_amount) //for mess-ups subtracting from the meat amount

/mob/living/simple_animal/after_load()
	..()
	if(stat == DEAD)
		death()

