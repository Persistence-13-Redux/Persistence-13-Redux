//
// Bats
//
/mob/living/simple_animal/hostile/asteroid/locusectums
	name = "locusectums"
	desc = "A swarm of of terrible locusectum."
	icon = 'icons/mob/simple_animal/bats.dmi'
	icon_state = "bat"
	icon_living = "bat"
	icon_dead = "bat_dead"
	icon_gib = "bat_dead"
	speak_chance = 0
	response_help = "pets the"
	response_disarm = "gently pushes aside the"
	response_harm = "hits the"
	attack_sound = 'sound/weapons/bite.ogg'
	attacktext = "bit"

	turns_per_move = 3
	speed = 4
	maxHealth = 20
	health = 20
	harm_intent_damage = 8
	melee_damage_lower = 4
	melee_damage_upper = 10
	environment_smash = 1
	meat_amount = 2
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat

/mob/living/simple_animal/hostile/asteroid/locusectums/AttackingTarget()
	. =..()
	var/mob/living/L = .
	if(istype(L))
		if(prob(15))
			L.Stun(1)

/mob/living/simple_animal/hostile/asteroid/locusectums/Allow_Spacemove()
	return TRUE