/mob/living/carbon/human/bullet_act(var/obj/item/projectile/P, var/def_zone)

	def_zone = check_zone(def_zone)
	if(!has_organ(def_zone))
		return PROJECTILE_FORCE_MISS //if they don't have the organ in question then the projectile just passes by.

	//Shields
	var/shield_check = check_shields(P.damage, P, null, def_zone, "the [P.name]")
	if(shield_check)
		if(shield_check < 0)
			return shield_check
		else
			P.on_hit(src, 100, def_zone)
			return 100
	var/blocked = ..(P, def_zone)
	var/obj/item/organ/external/organ = get_organ(def_zone)
	var/penetrating_damage = ((P.force + P.armor_penetration) * P.penetration_modifier) - blocked

	//Embed or sever artery
	if(P.can_embed() && !(species.species_flags & SPECIES_FLAG_NO_EMBED) && prob(22.5 + max(penetrating_damage, -10)) && !(prob(50) && (organ.sever_artery())))
		var/obj/item/weapon/material/shard/shrapnel/SP = new P.shrapnel_type()
		SP.SetName((P.name != "shrapnel")? "[P.name] shrapnel" : "shrapnel")
		SP.desc = "[SP.desc] It looks like it was fired from [P.shot_from]."
		SP.forceMove(organ)
		organ.embed(SP)

	projectile_hit_bloody(P, P.force*blocked_mult(blocked), def_zone)
