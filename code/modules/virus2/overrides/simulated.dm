//We're doing another pass to spread viruses into turfs
/turf/simulated/add_blood(mob/living/carbon/human/M as mob)
	if (!..())
		return 0

	if(!istype(M))
		return 0

	var/obj/effect/decal/cleanable/blood/B = locate() in contents
	if(B && B.blood_DNA && !B.blood_DNA[M.dna.unique_enzymes])
		B.virus2 = virus_copylist(M.virus2)
		return 1 //we bloodied the floor