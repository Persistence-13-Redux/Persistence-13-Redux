//
// GREED
//
/mob/living/simple_animal/hostile/asteroid/greed
	name = "GREED" // never uncapitalize GREED
	desc = "A sanity-destroying otherthing."
	icon = 'icons/mob/simple_animal/critter.dmi'
	speak_emote = list("gibbers")
	icon_state = "otherthing"
	icon_living = "otherthing"
	icon_dead = "otherthing-dead"
	attacktext = "chomped"
	attack_sound = 'sound/weapons/bite.ogg'

	speed = 4
	health = 60
	maxHealth = 60
	melee_damage_lower = 15
	melee_damage_upper = 25
	move_to_delay = 12

	meat_amount = 10
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat/xenomeat

/mob/living/simple_animal/hostile/asteroid/greed/Allow_Spacemove()
	return TRUE
