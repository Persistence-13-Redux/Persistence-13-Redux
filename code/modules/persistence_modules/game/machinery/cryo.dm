/obj/machinery/atmospherics/unary/cryo_cell/New()
	..()
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(occupant)
	ADD_SAVED_VAR(beaker)

/obj/machinery/atmospherics/unary/cryo_cell/Initialize()
	. = ..()
	initialize_directions = dir
	if(node) return
	var/node_connect = dir
	for(var/obj/machinery/atmospherics/target in get_step(src,node_connect))
		if(target.initialize_directions & get_dir(target,src))
			node = target
			break
	update_icon()

/obj/machinery/atmospherics/unary/cryo_cell/MouseDrop_T(atom/movable/O as mob|obj, mob/user as mob)
	if(O.loc == user) //no you can't pull things out of your ass
		return
	if(user.restrained() || user.stat || user.weakened || user.stunned || user.paralysis || user.resting) //are you cuffed, dying, lying, stunned or other
		return
	if(get_dist(user, src) > 1 || get_dist(user, O) > 1 || user.contents.Find(src)) // is the mob anchored, too far away from you, or are you too far away from the source
		return
	if(!ismob(O)) //humans only
		return
	if(istype(O, /mob/living/simple_animal) || istype(O, /mob/living/silicon)) //animals and robutts dont fit
		return
	if(!ishuman(user) && !isrobot(user)) //No ghosts or mice putting people into the sleeper
		return
	if(user.loc==null) // just in case someone manages to get a closet into the blue light dimension, as unlikely as that seems
		return
	if(!istype(user.loc, /turf) || !istype(O.loc, /turf)) // are you in a container/closet/pod/etc?
		return
	if(occupant)
		user << "\blue <B>The cryo cell is already occupied!</B>"
		return
/*	if(isrobot(user))
		if(!istype(user:module, /obj/item/weapon/robot_module/medical))
			user << "<span class='warning'>You do not have the means to do this!</span>"
			return*/
	var/mob/living/L = O
	if(!istype(L) || L.buckled)
		return
	if(L.abiotic())
		user << "\red <B>Subject cannot have abiotic items on.</B>"
		return
	for(var/mob/living/carbon/slime/M in range(1,L))
		if(M.Victim == L)
			usr << "[L.name] will not fit into the cryo cell because they have a slime latched onto their head."
			return
	if(put_mob(L))
		if(L == user)
			visible_message("[user] climbs into the cryo cell.", 3)
		else
			visible_message("[user] puts [L.name] into the cryo cell.", 3)
			if(user.pulling == L)
				user.pulling = null

/obj/machinery/atmospherics/unary/cryo_cell/OnTopic(user, href_list)
	if(href_list["ejectBeaker"]) //Try to put the beaker in hands before the base class put it on the floor
		if(beaker)
			if(Adjacent(usr) && !issilicon(usr))
				usr.put_in_hands(beaker)
			beaker = null
		return TOPIC_REFRESH
	. = ..()

/obj/machinery/atmospherics/unary/cryo_cell/process_occupant()
	if(air_contents.total_moles < 10)
		return
	if(occupant)
		if(occupant.stat == DEAD)
			return
		occupant.set_stat(UNCONSCIOUS)
		if(occupant.bodytemperature < 225)
			if (occupant.getToxLoss())
				occupant.adjustToxLoss(max(-1, -10/occupant.getToxLoss()))
			var/heal_brute = occupant.getBruteLoss() ? min(1, 20/occupant.getBruteLoss()) : 0
			var/heal_fire = occupant.getFireLoss	() ? min(1, 20/occupant.getFireLoss()) : 0
			occupant.heal_organ_damage(heal_brute,heal_fire)
		var/has_cryo_medicine = occupant.reagents.has_any_reagent(list(/datum/reagent/cryoxadone, /datum/reagent/clonexadone, /datum/reagent/nanitefluid)) >= REM
		if(beaker && !has_cryo_medicine)
			beaker.reagents.trans_to_mob(occupant, REM, CHEM_BLOOD)

/obj/machinery/atmospherics/unary/cryo_cell/go_out()
	if(!( occupant ))
		return
	if (occupant.client)
		occupant.client.eye = occupant.client.mob
		occupant.client.perspective = MOB_PERSPECTIVE
	occupant.forceMove(get_step(loc, SOUTH))	//this doesn't account for walls or anything, but i don't forsee that being a problem.
	if (occupant.bodytemperature < 261 && occupant.bodytemperature >= 70) //Patch by Aranclanos to stop people from taking burn damage after being ejected
		occupant.bodytemperature = 261									  // Changed to 70 from 140 by Zuhayr due to reoccurance of bug.
	occupant = null
	current_heat_capacity = initial(current_heat_capacity)
	update_use_power(POWER_USE_IDLE)
	update_icon()
	SetName(initial(name))
	return