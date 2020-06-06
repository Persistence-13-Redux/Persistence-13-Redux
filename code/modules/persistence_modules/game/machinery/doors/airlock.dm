/obj/machinery/door/airlock
	var/closeOtherDir = 0 //Direction to look in for another door to close/open when this one opens/closes
	var/haskeypad = FALSE

/obj/machinery/door/airlock/New(var/newloc, var/obj/structure/door_assembly/assembly=null)
	..()

	if(electronics && !electronics.autoset)
		req_access_faction = electronics.req_access_faction
	
	ADD_SAVED_VAR(aiControlDisabled)
	ADD_SAVED_VAR(haskeypad)
	ADD_SAVED_VAR(hackProof)
	ADD_SAVED_VAR(door_color)
	ADD_SAVED_VAR(stripe_color)
	ADD_SAVED_VAR(symbol_color)
	ADD_SAVED_VAR(brace)
	ADD_SAVED_VAR(safe)
	ADD_SAVED_VAR(justzap)
	ADD_SAVED_VAR(electronics)
	ADD_SAVED_VAR(mineral)
	ADD_SAVED_VAR(lockdownbyai)
	ADD_SAVED_VAR(closeOtherId)
	ADD_SAVED_VAR(closeOtherDir)
	ADD_SAVED_VAR(aiControlDisabled)
	ADD_SAVED_VAR(hackProof)
	ADD_SAVED_VAR(welded)
	ADD_SAVED_VAR(locked)
	ADD_SAVED_VAR(lock_cut_state)
	ADD_SAVED_VAR(lights)
	ADD_SAVED_VAR(aiDisabledIdScanner)
	ADD_SAVED_VAR(aiHacking)
	ADD_SAVED_VAR(autoclose)

/obj/machinery/door/airlock/Initialize()
	if(QDELETED(src) || !loc) //Don't waste time initing if its been deleted already
		return INITIALIZE_HINT_QDEL
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/door/airlock/create_electronics(var/electronics_type = /obj/item/weapon/airlock_electronics)
	if (haskeypad)
		electronics_type = /obj/item/weapon/airlock_electronics/keypad_electronics
	. = ..(electronics_type)

/obj/machinery/door/airlock/attackby(var/obj/item/C, var/mob/user)
	if(isScrewdriver(C) && !src.p_open)
		if(allowed(usr))
			src.p_open = 1
		else
			to_chat(usr, "<span class='warning'>You begin to carefully pry open the access panel on the [src]...</span>")
			if(do_after(user,40,src))
				if(prob(70))
					usr.visible_message("[usr] forcefully prys open the access panel on the [src]!", "You manage to pry open the access panel on the [src]!")
					src.p_open = 1
				else
					to_chat(usr, "<span class='warning'>Your hand slips!</span>")
			update_icon()
		return 1
	return ..()


//Later on during init check for a nearby door
/obj/machinery/door/airlock/LateInitialize()
	. = ..()
	if(src.closeOtherId != null)
		for (var/obj/machinery/door/airlock/A in world)
			if(A.closeOtherId == src.closeOtherId && A != src)
				src.closeOther = A
				break
	if (src.closeOtherDir)
		cyclelinkairlock()

/obj/machinery/door/airlock/proc/cyclelinkairlock()
	if (closeOther)
		closeOther.closeOther = null
		closeOther = null
	if (!closeOtherDir)
		return
	var/limit = world.view
	var/turf/T = get_turf(src)
	var/obj/machinery/door/airlock/FoundDoor
	do
		T = get_step(T, closeOtherDir)
		FoundDoor = locate() in T
		if (FoundDoor && FoundDoor.closeOtherDir != get_dir(FoundDoor, src))
			FoundDoor = null
		limit--
	while(!FoundDoor && limit)
	if (!FoundDoor)
		log_world("### MAP WARNING, [src] at [src.x],[src.y],[src.z] failed to find a valid airlock to cyclelink with!")
		return
	FoundDoor.closeOther = src
	closeOther = FoundDoor

