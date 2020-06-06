/mob/living/simple_animal/hostile/scarybat
	name = "locusectums"
	desc = "A swarm of of terrible locusectum."
	meat_amount = 2
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/meat
	melee_damage_lower = 4
	faction = "asteroid"

/mob/living/simple_animal/hostile/scarybat/Destroy()
	owner = null
	return ..()

/mob/living/simple_animal/hostile/scarybat/Allow_Spacemove(var/check_drift = 0)
	return 1 // Ripped from space carp, no more floating
