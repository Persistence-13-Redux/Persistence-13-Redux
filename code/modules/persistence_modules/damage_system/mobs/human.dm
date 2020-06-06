/mob/living/carbon/human/getAttackDamage(mob/target, hitzone)
	var/datum/unarmed_attack/AT = get_unarmed_attack(target, hitzone)
	return AT.get_unarmed_damage()

/mob/living/carbon/human/getAttackVerbs(mob/target, hitzone)
	var/datum/unarmed_attack/AT = get_unarmed_attack(target, hitzone)
	return AT.attack_verb

/mob/living/carbon/human/getAttackDamageFlags(mob/target, hitzone)
	var/datum/unarmed_attack/AT = get_unarmed_attack(target, hitzone)
	return AT.damage_flags()

/mob/living/carbon/human/getAttackIsWallbreaker(mob/target, hitzone)
	if(MUTATION_HULK in mutations)
		return TRUE
	return FALSE

/mob/living/carbon/human/getAttackDamageType(mob/target, hitzone)
	var/datum/unarmed_attack/AT = get_unarmed_attack(target, hitzone)
	return AT.get_damage_type()