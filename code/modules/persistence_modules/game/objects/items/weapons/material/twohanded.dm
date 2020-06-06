/obj/item/weapon/material/twohanded/update_force()
	..()
	base_name = name
	if(damage_flags() & DAM_EDGE)
		force_wielded = material.get_edge_damage()
	else
		force_wielded = material.get_blunt_damage()
	force_wielded = round(force_wielded*force_divisor)
	force_unwielded = round(force_wielded*unwielded_force_divisor)
	force = force_unwielded
	throwforce = round(force*thrown_force_divisor)

/obj/item/weapon/material/twohanded/fireaxe
	attack_cooldown_modifier = 2
	force_wielded = 30