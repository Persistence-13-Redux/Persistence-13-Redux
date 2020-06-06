/obj/item/organ/internal/liver/Process()
	. = ..()
	var/scarring = get_scarring_level()
	if(owner.chem_effects[CE_ALCOHOL] && scarring) // If your liver is messed up, you can't hold liqour very well
		if(prob(scarring*scarring)) // Scarring 1 == 1%, Scarring 2 == 4%, Scarring 3 == 9%
			spawn owner.vomit()

/obj/item/organ/internal/liver/on_update_icon()
	. = ..()
	if(BP_IS_ROBOTIC(src))
		icon_state = "[initial(icon_state)]-prosthetic"
	else
		icon_state = initial(icon_state)