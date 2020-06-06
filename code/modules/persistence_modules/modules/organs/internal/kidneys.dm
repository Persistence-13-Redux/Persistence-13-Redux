/obj/item/organ/internal/kidneys/on_update_icon()
	. = ..()
	if(BP_IS_ROBOTIC(src))
		icon_state = "[initial(icon_state)]-prosthetic"
	else
		icon_state = initial(icon_state)