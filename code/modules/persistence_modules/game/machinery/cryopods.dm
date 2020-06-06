GLOBAL_LIST_EMPTY(cryopods)

/*
	Modified PS13 crypods
		Save and despawn characters safely.
*/
/obj/machinery/cryopod
	req_access = list(core_access_command_programs)
	allow_occupant_types = list(/mob/living/carbon/human, /mob/living/silicon/robot, /obj/item/organ/internal/stack)
	time_till_despawn = 60 SECONDS
	time_entered = 0
	var/tmp/time_despawn = 0 //Time in world.time to despawn the occupant
	var/tmp/despawning = FALSE //Poor man's mutex, to prevent despawn from being called twice and break the save
	applies_stasis = 1

	var/network = "default"

	// These items are preserved when the process() despawn proc occurs.
	preserve_items = list(
		// /obj/item/integrated_circuit/manipulation/bluespace_rift,
		// /obj/item/integrated_circuit/input/teleporter_locator,
		// /obj/item/weapon/card/id/captains_spare,
		/obj/item/weapon/aicard,
		/obj/item/device/mmi,
		/obj/item/device/paicard,
		// /obj/item/weapon/gun,
		// /obj/item/weapon/pinpointer,
		// /obj/item/clothing/suit,
		// /obj/item/clothing/shoes/magboots,
		///obj/item/blueprints,
		// /obj/item/clothing/head/helmet/space,
		// /obj/item/weapon/storage/internal
	)

/obj/machinery/cryopod/should_never_save(list/L)
	L += "occupant"
	L += "time_till_despawn"
	L += "time_entered"
	L += "last_no_computer_message"
	. = ..(L)

/obj/machinery/cryopod/New()
	..()
	GLOB.cryopods |= src
	ADD_SAVED_VAR(announce)
	ADD_SAVED_VAR(network)

/obj/machinery/cryopod/before_save()
	if(occupant && !despawning)
		despawn_occupant()
	..()

/obj/machinery/cryopod/Destroy()
	if(announce)
		QDEL_NULL(announce)
	if(occupant)
		var/mob/living/ocmob = occupant
		occupant.forceMove(loc)
		if(ocmob)
			ocmob.resting = 1
	for(var/atom/movable/A in InsertedContents())
		A.forceMove(get_turf(src))
	GLOB.cryopods -= src
	. = ..()

/obj/machinery/cryopod/check_occupant_allowed(mob/M)
	var/correct_type = 0
	for(var/type in allow_occupant_types)
		if(istype(M, type))
			correct_type = 1
			break

	if(!correct_type) return 0

	for(var/type in disallow_occupant_types)
		if(istype(M, type))
			return 0

	return 1

/obj/machinery/cryopod/examine(mob/user)
	. = ..()
	if (occupant && user.Adjacent(src))
		occupant.examine(arglist(args))

//Lifted from Unity stasis.dm and refactored.
/obj/machinery/cryopod/Process()
	if(occupant)
		if(applies_stasis && iscarbon(occupant) && (world.time > time_entered + 20 SECONDS))
			var/mob/living/carbon/C = occupant
			C.SetStasis(2)

		//Allow a one minute gap between entering the pod and actually despawning.
		if (time_despawn > world.time && (occupant.ckey))
			return

		if(occupant.client && !occupant.is_dead()) //Occupant is living
//			if(!control_computer)
//				if(!find_control_computer())
//					log_debug("[src] \ref[src] ([x], [y], [z]): No control computer, skipping advanced stuff.")

			despawn_occupant()

// This function can not be undone; do not call this unless you are sure
// Also make sure there is a valid control computer
/obj/machinery/cryopod/robot/despawn_occupant()
	var/mob/living/silicon/robot/R = occupant
	if(!istype(R)) return ..()
	// qdel(R.mmi)
	// for(var/obj/item/I in R.module) // the tools the borg has; metal, glass, guns etc
	// 	for(var/obj/item/O in I) // the things inside the tools, if anything; mainly for janiborg trash bags
	// 		O.forceMove(R)
	// 	qdel(I)
	// qdel(R.module)
	. = ..()

// This function can not be undone; do not call this unless you are sure
// Also make sure there is a valid control computer
/obj/machinery/cryopod/despawn_occupant(var/autocryo = 0)
	if(!occupant)
		return 0
	if(despawning)
		log_error("[src]\ref[src] tried to despawn occupant [occupant]\ref[occupant] twice!")
		return 0

	despawning = TRUE //Make sure we don't try to despawn twice at the same time for whatever reasons
	var/mob/character
	var/key
	var/saveslot = 0
	//var/islace = istype(occupant, /obj/item/organ/internal/stack)
	occupant.should_save = 1
	var/datum/character_records/Chr = GetCharacterRecord(occupant.real_name)
	if(!Chr)
		log_error("Couldn't find a character record for [occupant]\ref[occupant]. Crypod [src]\ref[src].")
		return
	if(istype(occupant, /obj/item/organ/internal/stack))
		var/obj/item/organ/internal/stack/S = occupant
		if(S.brainmob.ckey)
			S.brainmob.stored_ckey = S.brainmob.ckey
			key = S.brainmob.ckey
		else
			key = S.brainmob.stored_ckey
		name = S.get_owner_name()
		character = S.brainmob
		saveslot = Chr.get_save_slot()
		S.brainmob.OnCryo(src)
		S.brainmob.saved_cryonet.cryonet_faction_uid = faction_uid
		S.brainmob.saved_cryonet.cryonet_name = network
		S.brainmob.spawn_type = CHARACTER_SPAWN_TYPE_CRYONET
		S.loc = src
	else
		var/mob/M = occupant
		if(M.ckey)
			M.stored_ckey = M.ckey
			key = M.ckey
		else
			key = M.stored_ckey
		name = M.real_name
		character = M
		//saveslot = M.save_slot
		if(!autocryo)
			M.saved_cryonet.cryonet_faction_uid = req_access_faction
			M.saved_cryonet.cryonet_name = network
			M.spawn_type = CHARACTER_SPAWN_TYPE_CRYONET
			M.loc = src

	//key = copytext(key, max(findtext(key, "@"), 1)) //WTF is that for?

	//Update any existing objectives involving this mob.
	for(var/datum/objective/O in all_objectives)
		// We don't want revs to get objectives that aren't for heads of staff. Letting
		// them win or lose based on cryo is silly so we remove the objective.
		if(O.target == occupant.mind)
			if(O.owner && O.owner.current)
				to_chat(O.owner.current, "<span class='warning'>You get the feeling your target is no longer within your reach...</span>")
			qdel(O)

	//Handle job slot/tater cleanup.
	if(occupant.mind)
		if(occupant.mind.assigned_job)
			occupant.mind.assigned_job.clear_slot()

		if(occupant.mind.objectives.len)
			occupant.mind.objectives = null
			occupant.mind.special_role = null



	icon_state = base_icon_state

	//TODO: Check objectives/mode, update new targets if this mob is the target, spawn new antags?


	//Make an announcement and log the person entering storage.

	// Titles should really be fetched from data records
	//  and records should not be fetched by name as there is no guarantee names are unique
	var/role_alt_title = occupant.mind ? occupant.mind.role_alt_title : "Unknown"

	if(control_computer)
		control_computer.frozen_crew += "[occupant.real_name], [role_alt_title] - [stationtime2text()]"
		control_computer._admin_logs += "[key_name(occupant)] ([role_alt_title]) at [stationtime2text()]"
	log_and_message_admins("[key_name(occupant)] ([role_alt_title]) entered cryostorage.")
	announce.autosay("[character.real_name] [on_store_message]", "[on_store_name]", character.get_faction())
	visible_message(SPAN_NOTICE("\The [initial(name)] hums and hisses as it moves [on_store_name] into storage."), range = 3)
	
	//SScharacter_setup.save_character(saveslot, key, character)
	// var/mob/new_player/player = new()
	// player.loc = locate(200,200,19)
	// if(occupant.client)
	// 	occupant.client.eye = player
	// player.ckey = occupant.ckey
	// if(istype(occupant, /mob/))
	// 	var/mob/M = occupant
	// 	M.stored_ckey = null
	// 	M.ckey = null
	// occupant.loc = null
	// occupant.stored_ckey = null
	// occupant.ckey = null
	//occupant = null //For some reasons the mob sometimes stay stuck in there if the qdel has some issues.. so we clear it early

	if(!CharacterSaves.SaveCharacter(character))
		to_chat(character, SPAN_DANGER("\The [src] eject you suddenly!! (Something went wrong with saving your character. Please advise an admin!)"))
		eject()
		return

	time_despawn = 0
	time_entered = 0
	despawning = FALSE
	QDEL_NULL(occupant)
	SetName(initial(src.name))
	update_icon()


/obj/machinery/cryopod/attempt_enter(var/mob/target, var/mob/user)
	if(!req_access_faction)
		to_chat(user, "<span class='notice'>\The [src] hasn't been connected to an organization.</span>")
		return 0
	if(occupant)
		to_chat(user, "<span class='notice'>\The [src] is in use.</span>")
		return 0
	if(!check_occupant_allowed(target))
		to_chat(user, "<span class='notice'>\The [target] cannot be inserted into \the [src].</span>")
		return 0
	if(!user.incapacitated() && !user.anchored && user.Adjacent(src) && user.Adjacent(target))
		visible_message("[user] starts putting [target] into \the [src].", range = 3)
		if(!do_after(user, 20, src)|| QDELETED(target))
			return
		set_occupant(target)

		// Book keeping!
		log_and_message_admins("has entered a stasis pod")

		//Despawning occurs when process() is called with an occupant without a client.
		src.add_fingerprint(target)

//Like grap-put, but for mouse-drop.
/obj/machinery/cryopod/MouseDrop_T(var/mob/target, var/mob/user)
	if(!check_occupant_allowed(target))
		return
	if(occupant)
		to_chat(user, "<span class='notice'>\The [src] is in use.</span>")
		return

	user.visible_message("<span class='notice'>\The [user] begins placing \the [target] into \the [src].</span>", "<span class='notice'>You start placing \the [target] into \the [src].</span>")
	attempt_enter(target, user)

/obj/machinery/cryopod/attackby(var/obj/item/I as obj, var/mob/user as mob)
	if(istype(I, /obj/item/grab))
		var/obj/item/grab/grab = I
		if(occupant)
			to_chat(user, "<span class='notice'>\The [src] is in use.</span>")
			return

		if(!req_access_faction)
			to_chat(user, "<span class='notice'>\The [src] hasn't been connected to an organization.</span>")
			return

		if(!ismob(grab.affecting))
			return

		if(!check_occupant_allowed(grab.affecting))
			return

		attempt_enter(grab.affecting, user)
		return
	if(component_attackby(I, user))
		return TRUE


/obj/machinery/cryopod/set_occupant(var/mob/living/carbon/occupant, var/silent)
	src.occupant = occupant
	if(!occupant)
		SetName(initial(name))
		return
	if(occupant.buckled)
		occupant.buckled.unbuckle_mob(occupant) //Make sure to clear the buckled state
	. = ..()

/obj/machinery/cryopod/attack_hand(var/mob/user = usr)
	if(stat)	// If there are any status flags, it shouldn't be opperable
		return

	user.set_machine(src)
	src.add_fingerprint(user)

	var/datum/world_faction/faction = FindFaction(req_access_faction)

	var/data[]
	data += "<hr><br><b>Cryopod Control</b></br>"
	data += "This cryopod is [faction ? "connected to " + faction.name : "Not Connected"]<br><hr>"
	if(faction)
		data += "It's cryopod network is set to [network]<br><br>"
		data += "<a href='?src=\ref[src];enter=1'>Enter Pod</a><br>"
		data += "<a href='?src=\ref[src];eject=1'>Eject Occupant</a><br><br>"
		data += "Those authorized can <a href='?src=\ref[src];disconnect=1'>disconnect this pod from the logistics network</a> or <a href='?src=\ref[src];connect_net=1'>connect to a different cryonetwork</a>."
	else
		data += "Those authorized can <a href='?src=\ref[src];connect=1'>connect this pod to a network</a>"

	show_browser(user, data, "window=cryopod")
	onclose(user, "cryopod")

/obj/machinery/cryopod/OnTopic(var/mob/user = usr, href_list)
	if(href_list["enter"])
		attempt_enter(user, user)
	if(href_list["eject"])
		go_out()
	if(href_list["connect"])
		req_access_faction = user.get_faction()
		if(!allowed(user))
			req_access_faction = ""
	if(href_list["disconnect"])
		if(allowed(user))
			req_access_faction = ""
	if(href_list["connect_net"])
		if(allowed(user))
			var/datum/world_faction/F = src.get_faction()
			var/choice = input(usr,"Enter CryoNet Filter to use.","Choose CryoNet filter",null) as null|text
			if(choice)
				network = choice
	if(href_list["despawn"])
		if(user == occupant)
			despawn_occupant()

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/obj/machinery/cryopod/personal
	name = "personal cryogenic freezer"
	desc = "A man-sized pod for entering suspended animation. This type ensures you return to the same cryopod you entered."

// /obj/machinery/cryopod/personal/attackby(var/obj/item/O, var/mob/user = usr)
// 	src.add_fingerprint(user)
// 	if(occupant)
// 		to_chat(user, "<span class='notice'>\The [src] is in use.</span>")
// 		return
// 	if(istype(O, /obj/item/grab))
// 		var/obj/item/grab/G = O
// 		if(check_occupant_allowed(G.affecting))
// 			user.visible_message("<span class='notice'>\The [user] begins placing \the [G.affecting] into \the [src].</span>", "<span class='notice'>You start placing \the [G.affecting] into \the [src].</span>")
// 			if(do_after(user, 20, src))
// 				if(!G || !G.affecting) return
// 			insertOccupant(G.affecting, user)
// 			return
// 	if(istype(O, /obj/item/organ/internal/stack))
// 		insertOccupant(O, user)
// 		return
// 	if(InsertedContents())
// 		to_chat(user, "<span class='notice'>\The [src] must be emptied of all stored users first.</span>")
// 		return
// 	return ..()

// /obj/machinery/cryopod/personal/insertOccupant(var/atom/movable/A, var/mob/user = usr)
// 	if(occupant)
// 		to_chat(user, "<span class='notice'>\The [src] is in use.</span>")
// 		return 0

// 	if(!check_occupant_allowed(A))
// 		to_chat(user, "<span class='notice'>\The [A] cannot be inserted into \the [src].</span>")
// 		return 0

// 	var/mob/M
// 	if(istype(A, /mob))
// 		M = A
// 		if(M.buckled)
// 			to_chat(user, "<span class='warning'>Unbuckle the subject before attempting to move them.</span>")
// 			return 0

// 		src.add_fingerprint(M)
// 		M.stop_pulling()
// 		to_chat(M, "<span class='notice'><b>Simply wait one full minute to be sent back to the lobby where you can switch characters.</b>(<a href='?src=\ref[src];despawn=1'>despawn now</a>)</span>")

// 	if(istype(A, /obj/item/organ/internal/stack))
// 		var/obj/item/organ/internal/stack/S = A
// 		if(!S.brainmob)
// 			to_chat(user, "<span class='notice'>\The [S] is inert.</span>")
// 			return 0
// 		M = S.brainmob
// 		user.drop_from_inventory(A)

// 	name = "[initial(name)] ([M.real_name])"
// 	icon_state = "cryopod_closed"

// 	occupant = A
// 	A.forceMove(src)
// 	time_despawn = world.time + time_till_despawn
// 	src.add_fingerprint(user)


/obj/machinery/cryopod/personal/attack_hand(var/mob/user = usr)
	user.set_machine(src)
	src.add_fingerprint(user)
	var/data[]
	data += "<hr><br><b>Cryopod Control</b></br>"
	data += "<a href='?src=\ref[src];enter=1'>Enter Pod</a><br>"
	data += "<a href='?src=\ref[src];eject=1'>Eject Occupant</a><br><br>"
	show_browser(user, data, "window=cryopod")
	onclose(user, "cryopod")

/obj/machinery/cryopod/personal/OnTopic(var/mob/user = usr, href_list)
	if(href_list["enter"])
		attempt_enter(user, user)
	if(href_list["eject"])
		go_out()

/obj/machinery/cryopod/personal/despawn_occupant(var/autocryo = 0)
	if(!occupant)
		return 0
	if(despawning)
		log_error("[src]\ref[src] tried to despawn occupant [occupant]\ref[occupant] twice!")
		return 0

	despawning = TRUE //Make sure we don't try to despawn twice at the same time for whatever reasons
	var/mob/character
	var/key
	var/saveslot = 0
	occupant.should_save = 1
	if(istype(occupant, /obj/item/organ/internal/stack))
		var/obj/item/organ/internal/stack/S = occupant
		if(S.brainmob.ckey)
			S.brainmob.stored_ckey = S.brainmob.ckey
			key = S.brainmob.ckey
		else
			key = S.brainmob.stored_ckey
		name = S.get_owner_name()
		character = S.brainmob
		//saveslot = S.brainmob.save_slot
		// S.brainmob.spawn_personal = 1
		// S.brainmob.spawn_p_x = x
		// S.brainmob.spawn_p_y = y
		// S.brainmob.spawn_p_z = z
		// S.brainmob.spawn_type = CHARACTER_SPAWN_TYPE_CRYONET
	else
		var/mob/M = occupant
		if(M.ckey)
			M.stored_ckey = M.ckey
			key = M.ckey
		else
			key = M.stored_ckey
		name = M.real_name
		character = M
		//saveslot = M.save_slot
		// M.saved_cryonet.cryonet_faction_uid = null
		// M.saved_cryonet.cryonet_name
		// M.spawn_personal = 1
		// M.spawn_p_x = x
		// M.spawn_p_y = y
		// M.spawn_p_z = z
		// M.spawn_type = CHARACTER_SPAWN_TYPE_CRYONET

	var/datum/character_records/CharR = GetCharacterRecord(name)
	saveslot = CharR? CharR.get_save_slot() : -1
	character.saved_cryonet.cryonet_faction_uid = null
	character.saved_cryonet.cryonet_name = network
	character.spawn_type = CHARACTER_SPAWN_TYPE_PERSONAL

	key = copytext(key, max(findtext(key, "@"), 1))

	// if(!saveslot)
	// 	saveslot = SScharacter_setup.find_character_save_slot(occupant, key)

	if(!CharacterSaves.SaveCharacter(character))
		to_chat(character, SPAN_DANGER("\The [src] eject you suddenly!! (Something went wrong with saving your character. Please advise an admin!)"))
		eject()
		return
	else
		visible_message(SPAN_NOTICE("\The [initial(name)] hums and hisses as it moves [character.real_name] into storage."), range = 3)

	time_despawn = 0
	time_entered = 0
	despawning = FALSE
	QDEL_NULL(occupant)
	SetName(initial(src.name))
	update_icon()

	//SScharacter_setup.save_character(saveslot, key, character)
	// SetName(initial(src.name))
	// update_icon()
	// icon_state = base_icon_state
	// var/mob/new_player/player = new()
	// player.loc = locate(200,200,19)
	// if(occupant.client)
	// 	occupant.client.eye = player
	// if(istype(occupant, /mob/))
	// 	var/mob/M = occupant
	// 	M.stored_ckey = null
	// 	M.ckey = null
	// occupant.loc = null
	// qdel(occupant)
	// occupant = null
	// time_despawn = 0
	// despawning = FALSE
