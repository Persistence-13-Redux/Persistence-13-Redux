/mob/living/bullet_act(var/obj/item/projectile/P, var/def_zone)
	. = ..()
	//Stun Beams
	//if(P.taser_effect)
	if(P.damage_type == STUN)
		stun_effect_act(0, P.agony, def_zone, P)

