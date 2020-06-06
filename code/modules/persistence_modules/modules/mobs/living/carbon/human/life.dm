/mob/living/carbon/human/Life()
	if (HAS_TRANSFORMATION_MOVEMENT_HANDLER(src))
		return
	if(last_hud_update < world.time)
		last_hud_update = world.time + 15 SECONDS
		update_action_buttons()
	return ..()
