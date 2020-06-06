/obj/item/weapon/stock_parts/computer/scanner/medical
	var/datum/dna/stored_dna = null
	var/list/connected_pods = list()

/obj/item/weapon/stock_parts/computer/scanner/medical/New()
	..()
	ADD_SAVED_VAR(stored_dna)
	ADD_SKIP_EMPTY(stored_dna)

/obj/item/weapon/stock_parts/computer/scanner/medical/can_use_scanner(mob/user, mob/living/carbon/human/target, proximity = TRUE)
	if(!..())
		return 0
	if(MUTATION_CLUMSY in user.mutations)
		return 0
	if(!istype(target))
		return 0
	if(target.isSynthetic())
		to_chat(user, SPAN_WARNING("\The [src] is designed for organic humanoid patients only."))
		return 0
	return 1

/obj/item/weapon/stock_parts/computer/scanner/medical/do_on_attackby(mob/user, obj/item/target)
	if(istype(target, /obj/item/organ))
		var/obj/item/organ/O = target
		stored_dna = O.dna
		return 1
	if(istype(target, /obj/item/weapon/reagent_containers/syringe))
		var/obj/item/weapon/reagent_containers/syringe/S = target
		if(!S.reagents)
			return
		if(S.reagents.total_volume == 0)
			return
		var/datum/reagent/blood/cnt = S.reagents.get_master_reagent()
		if(!istype(cnt) || !islist(cnt.get_data()))
			return
		var/list/data = cnt.get_data()
		stored_dna = data["blood_DNA"]
		return 1
	return ..()

/obj/item/weapon/stock_parts/computer/scanner/medical/proc/search_for_pods()
	var/turf/location = get_turf(loc)
	if(location)
		for(var/obj/machinery/clonepod/pod in view(8, location))
			if(pod.stat || !pod.anchored) 
				continue
			connected_pods |= pod
	if(connected_pods.len < 1)
		to_chat(usr, "No pods in range could be connected!")

/obj/item/weapon/stock_parts/computer/scanner/medical/proc/clear_dna()
	stored_dna = null