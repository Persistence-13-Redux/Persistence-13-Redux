/obj/item/organ/internal/heart/on_update_icon()
	. = ..()
	if(BP_IS_ROBOTIC(src))
		icon_state = "heart-prosthetic"
	else if((status & ORGAN_DEAD) && dead_icon)
		icon_state = dead_icon
	else
		icon_state = initial(icon_state)