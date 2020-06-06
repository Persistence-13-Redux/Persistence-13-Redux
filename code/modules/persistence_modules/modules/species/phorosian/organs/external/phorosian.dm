
//EXTERNAL ORGANS
//Phoron reinforced bones woo.
/obj/item/organ/external/head/phorosian
	can_intake_reagents = 0
	min_broken_damage = 50
	glowing_eyes = TRUE
	var/eye_icon_location = 'icons/mob/human_races/species/diona/eyes.dmi'

/obj/item/organ/external/head/phorosian/get_eye_overlay()
	var/icon/I = get_eyes()
	if(glowing_eyes)
		var/image/eye_glow = image(I)
		eye_glow.layer = EYE_GLOW_LAYER
		eye_glow.plane = EFFECTS_ABOVE_LIGHTING_PLANE
		return eye_glow

/obj/item/organ/external/head/phorosian/get_eyes()
	return icon(icon = eye_icon_location, icon_state = "")

/obj/item/organ/external/chest/phorosian
	min_broken_damage = 50

/obj/item/organ/external/groin/phorosian
	min_broken_damage = 50

/obj/item/organ/external/arm/phorosian
	min_broken_damage = 45

/obj/item/organ/external/arm/right/phorosian
	min_broken_damage = 45

/obj/item/organ/external/leg/phorosian
	min_broken_damage = 45

/obj/item/organ/external/leg/right/phorosian
	min_broken_damage = 45

/obj/item/organ/external/foot/phorosian
	min_broken_damage = 30

/obj/item/organ/external/foot/right/phorosian
	min_broken_damage = 30

/obj/item/organ/external/hand/phorosian
	min_broken_damage = 30

/obj/item/organ/external/hand/right/phorosian
	min_broken_damage = 30