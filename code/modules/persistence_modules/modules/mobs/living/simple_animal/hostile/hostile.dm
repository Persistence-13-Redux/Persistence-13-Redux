//Allow attacking objects identified as enemies
/mob/living/simple_animal/hostile/AttackingTarget()
	. = ..()
	if(isobj(target_mob))
		if(!prob(get_accuracy()))
			visible_message(SPAN_NOTICE("\The [src] misses its attack on \the [target_mob]!"))
			return
		var/obj/O = target_mob
		O.attack_generic(src, rand(melee_damage_lower,melee_damage_upper), attacktext, environment_smash, damtype, defense, melee_damage_flags)
		return O