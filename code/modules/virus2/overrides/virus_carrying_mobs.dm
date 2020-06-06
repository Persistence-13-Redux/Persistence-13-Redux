/mob/living/simple_animal/hostile/vagrant/var/datum/disease2/disease/carried
/mob/living/simple_animal/hostile/vagrant/Initialize()
	. = ..()
	if(prob(25))
		carried = new/datum/disease2/disease()
		carried.makerandom(rand(2, 4))

/mob/living/simple_animal/hostile/vagrant/AttackingTarget()
	. = ..()
	if(ishuman(.) && !gripping && (cloaked || prob(health + ((maxHealth - health) * 2))))
		if(carried && length(gripping.virus2) == 0)
			infect_virus2(gripping, carried, 1)