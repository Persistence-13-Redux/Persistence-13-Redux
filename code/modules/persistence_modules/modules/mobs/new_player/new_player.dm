//
//
//
//Force update the client panels when loading is done!
/hook/roundstart/proc/refresh_new_player_panels()
	for(var/mob/new_player/P in GLOB.player_list)
		P?.Topic(src, list("refresh" = 1))
	return TRUE

//////////////////////////////////
// Persistent New Player
//////////////////////////////////
/mob/new_player/persistent
	var/chosen_slot = 0
	var/datum/browser/latejoin_panel

/mob/new_player/persistent/New()
	..()
	verbs -= /mob/proc/toggle_antag_pool //no antags

///
/mob/new_player/persistent/proc/update_new_player_panel()
	var/output = list()
	var/selected_save_slot = PSDB.player.GetLastSelectedSaveSlot(client.ckey)
	client.prefs.real_name = PSDB.characters.GetCharacterName(client.ckey, selected_save_slot)
	output += "<div align='center'>"
	output += "<i>[GLOB.using_map.get_map_info()]</i>"
	output +="<hr>"

	if(GAME_STATE < RUNLEVEL_GAME)
		output += "<span class='average'><b>The Game Is Loading..</b></span><br><br>"
	else
		//This stuff should only be done once everything is set up or bad things happen
		output += "<hr>Current character: <b>[client.prefs.real_name]</b>[client.prefs.job_high ? ", [client.prefs.job_high]" : null]<br>"
		output += "<a href='byond://?src=\ref[src];show_preferences=1'>Setup Character</A> "
		output += "<a href='byond://?src=\ref[src];late_join=1'>Join Game!</A>"

	if(!IsGuestKey(src.key))
		establish_db_connection()
		if(dbcon.IsConnected())
			var/isadmin = 0
			if(src.client && src.client.holder)
				isadmin = 1
			var/DBQuery/query = dbcon.NewQuery("SELECT id FROM erro_poll_question WHERE [(isadmin ? "" : "adminonly = false AND")] Now() BETWEEN starttime AND endtime AND id NOT IN (SELECT pollid FROM erro_poll_vote WHERE ckey = \"[ckey]\") AND id NOT IN (SELECT pollid FROM erro_poll_textreply WHERE ckey = \"[ckey]\")")
			query.Execute()
			var/newpoll = 0
			while(query.NextRow())
				newpoll = 1
				break

			if(newpoll)
				output += "<b><a href='byond://?src=\ref[src];showpoll=1'>Show Player Polls</A> (NEW!)</b> "
			else
				output += "<a href='byond://?src=\ref[src];showpoll=1'>Show Player Polls</A> "

	if(check_rights(R_ADMIN | R_DEBUG | R_INVESTIGATE, null, client))
		output += "<a href='byond://?src=\ref[src];observe=1'>Observe</A>"
	output += "<br/><a href='byond://?src=\ref[src];refresh=1'>Refresh</A>"
	output += "</div>"

	// Update or open
	if(panel)
		panel.set_content(JOINTEXT(output))
		panel.update(TRUE)
	else 
		panel = new(src, "Welcome","Welcome to [GLOB.using_map.full_name]", 560, 280, src)
		panel.set_window_options("can_close=0")
		panel.set_content(JOINTEXT(output))
		panel.open()

/mob/new_player/persistent/new_player_panel(force = FALSE)
	if(!SScharacter_setup.initialized && !force)
		return // Not ready yet.
	update_new_player_panel()

/mob/new_player/persistent/Stat()
	. = ..()
	if(statpanel("Lobby"))
		if(GAME_STATE != RUNLEVEL_LOBBY)
			stat("Players : [GLOB.player_list.len]")

//Stops the lobby music and close the main menu panels
/mob/new_player/persistent/proc/transitionToGame()
	close_spawn_windows()
	sound_to(src, sound(null, repeat = 0, wait = 0, volume = 85, channel = GLOB.lobby_sound_channel))

// /mob/new_player/proc/loadCharacter()
// 	if(!config.enter_allowed && !check_rights(R_ADMIN|R_MOD, 0, src))
// 		to_chat(usr, "<span class='notice'>There is an administrative lock on entering the game!</span>")
// 		return
// 	if(!chosen_slot)
// 		return
// 	if(spawning)
// 		return
// 	spawning = TRUE

// 	//Resume playing
// 	if(CheckResumeExistingCharacter())
// 		qdel(src)
// 		return
// 	// for(var/mob/M in SSmobs.mob_list)
// 	// 	if(M.loc && !M.perma_dead && M.type != /mob/new_player && (M.stored_ckey == ckey || M.stored_ckey == "@[ckey]"))
// 	// 		transitionToGame() //Don't forget to close the panel and stop the lobby music
// 	// 		if(istype(M, /mob/observer))
// 	// 			qdel(M)
// 	// 			continue
// 	// 		M.ckey = ckey
// 	// 		M.update_icons()
// 	// 		spawn(200)
// 	// 			M.redraw_inv() //Make sure icons shows up
// 	// 		qdel(src)
// 	// 		return

// 	//Observer Spawn
// 	if(chosen_slot == -1)
// 		transitionToGame() //Don't forget to close the panel and stop the lobby music
// 		var/mob/observer/ghost/observer = new()
// 		observer.started_as_observer = 1
// 		observer.forceMove(GLOB.cryopods.len ? get_turf(pick(GLOB.cryopods)) : locate(100, 100, 1))
// 		observer.ckey = ckey
// 		qdel(src)
// 		return

// 	sleep(10) //Wait possibly for the file to unlock???
// 	var/list/datum/character_records/CL = PSDB.characters.GetCharacterRecordsForCKEY(ckey, chosen_slot)
// 	var/datum/character_records/C
// 	if(!CL || !length(CL))
// 		return FALSE
// 	C = CL[1]
	
// 	var/mob/character
// 	try
// 		character = C.restore_saved_character()
// 	catch(var/exception/e)
// 		message_admins("[ckey], slot [chosen_slot] failed loading the saved character: [e]")
	
// 	if(!character)
// 		message_admins("[ckey], slot [chosen_slot], load character failed during join.")
// 		to_chat(src, "Your character is not loading correctly. Contact Brawler.")
// 		spawning = FALSE
// 		return
// 	if (!GetGlobalCrewRecord(character.real_name))
// 		var/datum/computer_file/report/crew_record/new_record = CreateModularRecord(character)
// 		GLOB.all_crew_records |= new_record
// 	var/turf/spawnTurf

// 	if(character.spawn_type == CHARACTER_SPAWN_TYPE_CRYONET)
// 		// var/datum/world_faction/faction = FindFaction(character.spawn_loc)
// 		// var/assignmentSpawnLocation = faction?.get_assignment(faction?.get_record(character.real_name)?.assignment_uid, character.real_name)?.cryo_net
// 		// if (assignmentSpawnLocation == "Last Known Cryonet")
// 		// 	// The character's assignment is set to spawn in their last cryo location
// 		// 	// Do nothing, leave it the way it is.
// 		// else if (assignmentSpawnLocation)
// 		// 	// The character has a special cryo network set to override their normal spawn location
// 		// 	character.spawn_loc_2 = assignmentSpawnLocation
// 		// else
// 		// 	// The character doesn't have a spawn_loc_2, so use the one for their assignment or the default
// 		// 	character.spawn_loc_2 = " default"

// 		// if(character.spawn_personal)
// 		// 	var/turf/T = locate(character.spawn_p_x,character.spawn_p_y,character.spawn_p_z)
// 		// 	if(T)
// 		// 		for(var/obj/machinery/cryopod/pod in T.contents)
// 		// 			spawnTurf = T
// 		// 			break
// 		// if(!spawnTurf)
// 		// 	for(var/obj/machinery/cryopod/pod in GLOB.cryopods)
// 		// 		if(!pod.loc)
// 		// 			qdel(pod)
// 		// 			continue
// 		// 		if(pod.req_access_faction == character.spawn_loc)
// 		// 			if(pod.network == character.spawn_loc_2)
// 		// 				spawnTurf = get_turf(pod)
// 		// 				break
// 		// 			else
// 		// 				spawnTurf = get_turf(pod)
// 		// 		else if(!spawnTurf)
// 		// 			spawnTurf = get_turf(pod)

// 		if(!spawnTurf)
// 			log_and_message_admins("WARNING! No cryopods avalible for spawning! Get some spawned and connected to the starting factions uid (req_access_faction)")
// 			spawnTurf = locate(102, 98, 1)

// 	else if(character.spawn_type == CHARACTER_SPAWN_TYPE_FRONTIER_BEACON || character.spawn_type == CHARACTER_SPAWN_TYPE_IMPORT)
// 		// var/obj/item/weapon/card/id/W = character.GetIdCard()
// 		// if(W)
// 		// 	W.selected_faction_uid = "nexus"
// 		// var/list/obj/machinery/frontier_beacon/possibles = list()
// 		// var/list/obj/machinery/frontier_beacon/possibles_unsafe = list()
// 		// for(var/obj/machinery/frontier_beacon/beacon in GLOB.frontierbeacons)
// 		// 	if(!beacon.loc)
// 		// 		continue
// 		// 	if(beacon.req_access_faction == character.spawn_loc && beacon.citizenship_type == character.spawn_cit)
// 		// 		//Check the beacon position to see if they're safe
// 		// 		var/turf/T = get_turf(beacon)
// 		// 		var/radlevel = SSradiation.get_rads_at_turf(T)
// 		// 		var/airstatus = IsTurfAtmosUnsafe(T)
// 		// 		if(airstatus || radlevel > 0)
// 		// 			possibles_unsafe += beacon
// 		// 		else
// 		// 			possibles += beacon

// 		// if(possibles.len)
// 		// 	spawnTurf = get_turf(pick(possibles)) //Pick one randomly
// 		// else if(possibles_unsafe.len)
// 		// 	spawnTurf = get_turf(pick(possibles_unsafe))
// 		// 	var/radlevel = SSradiation.get_rads_at_turf(spawnTurf)
// 		// 	var/airstatus = IsTurfAtmosUnsafe(spawnTurf)
// 		// 	log_and_message_admins("Couldn't find a safe spawn beacon. Spawning [character] at [spawnTurf] ([spawnTurf.x], [spawnTurf.y], [spawnTurf.z])! Warning player!", character, spawnTurf)
// 		// 	var/reply = alert(src, "Warning. Your selected spawn location seems to have unfavorable conditions. You may die shortly after spawning. \
// 		// 	Spawn anyway? More information: [airstatus] Radiation: [radlevel] Bq", "Atmosphere warning", "Abort", "Spawn anyway")
// 		// 	if(reply == "Abort")
// 		// 		spawning = FALSE
// 		// 		new_player_panel(TRUE)
// 		// 		return
// 		// 	else
// 		// 		// Let the staff know, in case the person complains about dying due to this later. They've been warned.
// 		// 		log_and_message_admins("User [src.client] spawned as [character] at [spawnTurf]([spawnTurf.x], [spawnTurf.y], [spawnTurf.z]) with dangerous atmosphere.")

// 		// if(!spawnTurf)
// 		// 	log_and_message_admins("WARNING! No frontier beacons avalible for spawning! Get some spawned and connected to the starting factions uid (req_access_faction)")
// 		// 	spawnTurf = locate(world.maxx / 2 , world.maxy /2, 1)

// 	else if(character.spawn_type == CHARACTER_SPAWN_TYPE_LACE_STORAGE)
// 		// spawnTurf = GetLaceStorage(character)
// 		// if(!spawnTurf)
// 		// 	log_and_message_admins("WARNING! Unable To Find Any Spawn Turf!!! Prehaps you didn't include a map?")
// 		// 	return

// 	//Close the menu and stop the lobby music once we're sure we're spawning
// 	transitionToGame()
// 	character.after_spawn()

// 	if(!character.mind)
// 		mind.active = 1
// 		mind.original = character
// 		mind.transfer_to(character)	//won't transfer key since the mind is not active

// 	character.forceMove(spawnTurf)
// 	character.stored_ckey = key
// 	character.key = key
// 	character.last_ckey = ckey

// 	//Make sure dna is spread to limbs
// 	character.dna.ready_dna(character)
// 	character.sync_organ_dna()

// 	//GLOB.minds |= character.mind
// 	character.regenerate_icons()
// 	character.update_inv_back()
// 	character.update_inv_wear_id()
// 	character.update_inv_belt()
// 	character.update_inv_pockets()
// 	character.update_inv_l_hand()
// 	character.update_inv_r_hand()
// 	character.update_inv_s_store()
// 	character.redraw_inv()

// 	//Execute post-spawn stuff
// 	character.finishLoadCharacter()	// This is ran because new_players don't like to stick around long.
// 	return 1


// /mob/new_player/persistent/proc/CheckResumeExistingCharacter()
// 	for(var/mob/M in SSmobs.mob_list)
// 		if(isobserver(M) && LAST_CKEY(M) == ckey) //Clean up observers..
// 			qdel(M)
// 			continue
// 		if(!M.loc || !isliving(M) || LAST_CKEY(M) != ckey)
// 			continue
// 		var/datum/character_records/C = GetCharacterRecord(M.real_name)
// 		if(!C || C.get_status() == CHARACTER_RECORD_STATUS_DEAD)
// 			continue
// 		chosen_slot = C.get_save_slot()
// 		to_chat(src, SPAN_NOTICE("A character is already in game."))
// 		GetGlobalCrewRecord(M.real_name) //Will cache the character record from the DB
// 		if(GAME_STATE >= RUNLEVEL_GAME)
// 			transitionToGame()
// 			M.update_icons()
// 			M.key = key
// 			return TRUE
// 	return FALSE

/mob/new_player/persistent/proc/GetCryonetSpawnLocation(var/mob/character)
	var/datum/world_faction/F = FindFaction(character.saved_cryonet.cryonet_faction_uid)
	if(!F)
		return null
	for(var/obj/machinery/cryopod/Cryo in GLOB.cryopods)
		if(Cryo.faction_uid == character.saved_cryonet.cryonet_faction_uid && Cryo.network == character.saved_cryonet.cryonet_name)
			return get_turf(Cryo)
	return null

/mob/new_player/persistent/proc/GetPersonalPodSpawnLocation(var/mob/character)
	for(var/obj/machinery/cryopod/personal/Cryo in GLOB.cryopods)
		if(Cryo.network == character.saved_cryonet.cryonet_name)
			return get_turf(Cryo)
	return null

/mob/new_player/persistent/proc/GetLaceStorageSpawnLocation(var/mob/character)
	return

/mob/new_player/persistent/proc/GetFrontierBeaconSpawnLocation(var/mob/character)
	for(var/obj/machinery/frontier_beacon/F in GLOB.frontierbeacons)
		if(F.faction_uid == character.get_faction_uid())
			return F
	return 

/mob/new_player/persistent/proc/GetEmergencySpawnPosition()
	return locate(world.maxx/2, world.maxy/2, 1)

/mob/new_player/persistent/proc/SpawnSavedCharacter(var/character_name)
	var/datum/character_records/CR = GetCharacterRecord(character_name)
	if(!CR)
		to_chat(usr, SPAN_DANGER("Something went very wrong and your character couldn't be retrieved from the database! This can probably be fixed. Please advise the admins!"))
		CRASH("/mob/new_player/persistent/proc/SpawnSavedCharacter(): Couldn't find character '[character_name]' in the character database!")

	//Check if the character can be spawned at all
	var/char_status = CR.get_status()
	if(char_status == CHARACTER_RECORD_STATUS_DEAD)
		to_chat(usr, SPAN_DANGER("This character is deceased for good. Please pick another character, or make a new one!"))
		return

	var/mob/character = CR.restore_saved_character()
	if(!character)
		to_chat(usr, SPAN_DANGER("Something went very wrong and your character couldn't be loaded from the save! This can probably be fixed. Please advise the admins!"))
		CRASH("/mob/new_player/persistent/proc/SpawnSavedCharacter(): Couldn't load saved character '[character_name]', something went wrong during restoration!")
	var/turf/spawnTurf
	switch(character.spawn_type)
		if(CHARACTER_SPAWN_TYPE_CRYONET)
			spawnTurf = GetCryonetSpawnLocation(character)
		if(CHARACTER_SPAWN_TYPE_PERSONAL)
			spawnTurf = GetPersonalPodSpawnLocation(character)
		if(CHARACTER_SPAWN_TYPE_FRONTIER_BEACON || CHARACTER_SPAWN_TYPE_IMPORT)
			spawnTurf = GetFrontierBeaconSpawnLocation(character)
		if(CHARACTER_SPAWN_TYPE_LACE_STORAGE)
			spawnTurf = GetLaceStorageSpawnLocation(character)

	//Emergency spawn location
	if(!spawnTurf)
		spawnTurf = GetEmergencySpawnPosition() //Map default spawn location
		var/choice = alert(usr, 
			"Failed to find a valid spawn position for your character. Will attempt to spawn at coordinates ([spawnTurf.x], [spawnTurf.y], [spawnTurf.z]), is that ok? (Please tell the admins about this!)",
			"Warning!",
			"Spawn",
			"Abort")
		if(choice == "Abort")
			return

	//Get the mob ready
	transitionToGame()
	if(!character.mind)
		mind.active = TRUE
		mind.original = character
		mind.transfer_to(character)	//won't transfer key since the mind is not active

	character.forceMove(spawnTurf)
	character.key = key

	character.update_icons()
	character.after_spawn()
	character.OnFinishLoadCharacter()	// This is ran because new_players don't like to stick around long.

	//Make sure to commit the character as active
	CR.set_status(GLOB.character_record_status[CHARACTER_RECORD_STATUS_ACTIVE])
	CR.commit()
	return character

/mob/new_player/persistent/proc/import_ps13_human(var/mob/living/carbon/human/orig_human)
	//DNA
	var/datum/dna/DNA
	if(!isnull(orig_human.dna))
		DNA = orig_human.dna.Clone()

	//Specie
	var/specie_name = orig_human.get_species()
	if(!length(specie_name))
		if(DNA?.species)
			specie_name = DNA.species
		else
			specie_name = SPECIES_HUMAN

	//Recreate the character using a fresh new mob
	var/mob/living/carbon/human/H = new/mob/living/carbon/human(, specie_name)
	H.real_name = orig_human.real_name
	H.b_type  = orig_human.b_type
	H.gender   = orig_human.gender

	H.h_style = orig_human.h_style
	H.f_style = orig_human.f_style

	H.r_hair  = orig_human.r_hair
	H.g_hair  = orig_human.g_hair
	H.b_hair  = orig_human.b_hair

	H.r_facial = orig_human.r_facial
	H.g_facial = orig_human.g_facial
	H.b_facial = orig_human.b_facial

	H.r_eyes   = orig_human.r_eyes 
	H.g_eyes   = orig_human.g_eyes
	H.b_eyes   = orig_human.b_eyes

	H.r_skin   = orig_human.r_skin
	H.g_skin   = orig_human.g_skin
	H.b_skin   = orig_human.b_skin
	H.s_tone   = orig_human.s_tone

	//Disability bits
	H.disabilities = orig_human.disabilities

	var/list/BM = list()
	for(var/obj/item/organ/external/E in orig_human.organs)
		if(length(E.markings))
			BM[E.organ_tag] = E.markings.Copy()
	//Copy over to new mob
	for(var/obj/item/organ/external/E in H.organs)
		E.s_tone = H.s_tone
		if(BM[E.organ_tag])
			E.markings = BM[E.organ_tag]
	
	//Everyting was copied over to the new character, so regenerate the DNA from it
	H.dna.ready_dna(H)
	H.sync_organ_dna()
	H.force_update_limbs()
	H.update_eyes()
	H.regenerate_icons()
	return H

//Since the lace code differs a lot, we're gonna have to go for a standard MMI. it'll be easier to fix too later on
/mob/new_player/persistent/proc/import_ps13_robot(var/mob/M)
	var/mob/living/silicon/robot/R = new()
	var/obj/item/device/mmi/MMI = new(R)
	var/obj/item/organ/internal/brain/B = new(MMI)
	B.dna = M.dna
	MMI.brainobj = B
	R.mmi = MMI
	R.real_name = M.real_name
	R.dna = M.dna
	return R

//Allow loading nexus saved characters
/mob/new_player/persistent/proc/import_ps13_character_save(var/ckey, var/slot)
	var/fullpath = "data/player_saves/[copytext(ckey,1,2)]/[ckey]/[slot].sav"
	var/mob/M
	var/savefile/F = new(fullpath)
	from_file(F["mob"], M)
	M.after_spawn() //Runs after_load
	M.delete_inventory(TRUE) //Make sure to delete everything, since some things might be broken

	if(ishuman(M))
		. = import_ps13_human(M)
	else if(isrobot(M))
		. = import_ps13_robot(M)
	else
		. = M //Nothing else to do here

// /mob/new_player/persistent/proc/deleteCharacter()
// 	. = TRUE
// 	var/list/datum/character_records/CL = GetCharacterRecordsForCKEYAndSaveSlot(ckey, chosen_slot)
// 	if(!CL || length(CL))
// 		return FALSE
// 	var/datum/character_records/C = CL[1] //Only handle the first one we find.
// 	var/charname = C.get_real_name()
// 	if(input("Are you SURE you want to delete [charname]? THIS IS PERMANENT. enter the character\'s full name to conform.", "DELETE A CHARACTER", "") == charname)
// 		. = PSDB.characters.RemoveCharacterRecord(charname)
// 	close_spawn_windows()

// /mob/new_player/persistent/create_character(var/turf/spawn_turf)
// 	. = ..()

// /mob/new_player/persistent/Topic(href, href_list) // This is a full override; does not call parent.
// 	if(usr != src)
// 		return TOPIC_NOACTION
// 	if(!client)
// 		return TOPIC_NOACTION

// 	// if(href_list["refresh"])
// 	// 	update_new_player_panel()
// 	// 	return

// 	return ..()

