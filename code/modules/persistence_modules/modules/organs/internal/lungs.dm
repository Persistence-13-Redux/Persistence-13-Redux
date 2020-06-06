/obj/item/organ/internal/lungs
	max_pressure_diff = 2*ONE_ATMOSPHERE

/obj/item/organ/internal/lungs/New(mob/living/carbon/holder)
	. = ..()
	ADD_SAVED_VAR(active_breathing)
	ADD_SAVED_VAR(oxygen_deprivation)
	ADD_SAVED_VAR(breathing)

/obj/item/organ/internal/lungs/after_load()
	..()
	sync_breath_types()

/obj/item/organ/internal/lungs/sync_breath_types()
	min_breath_pressure = species.breath_pressure ? species.breath_pressure : 16
	. = ..()

/obj/item/organ/internal/lungs/Process()
	..()
	if(!owner)
		return
	var/scarring = get_scarring_level()
	if(scarring && active_breathing && !owner.is_asystole())
		if(prob(1) && scarring > 2) // Very bad scarring
			owner.visible_message(
				"<B>\The [owner]</B> coughs up blood!",
				"<span class='warning'>You cough up blood!</span>",
				"You hear someone coughing!",
			)

			owner.drip(1)

		if(prob(1) && scarring > 1) // Normal scarring
			var/msg_pick = pick("gasp", "cough")
			owner.visible_message(
				"<B>\The [owner]</B> [msg_pick]s, wheezing!",
				"<span class='warning'>Your chest feels tight!</span>",
				"You hear someone [msg_pick]ing with a wheeze!",
			)

		if(prob(2)) // Slight scarring
			owner.emote("cough")

/obj/item/organ/internal/lungs/on_update_icon()
	. = ..()
	if(BP_IS_ROBOTIC(src))
		icon_state = "[initial(icon_state)]-prosthetic"
	else
		icon_state = initial(icon_state)