var/global/datum/CharacterSaveManager/CharacterSaves = new()
/datum/CharacterSaveManager

/*
	Character save slots stuff
*/
/datum/CharacterSaveManager/proc/GetMaxSaveSlots(var/ckey)
	return PSDB.player.GetPlayerMaxSaveSlots(ckey)

/datum/CharacterSaveManager/proc/SetMaxSaveSlots(var/ckey, var/maxslots)
	return PSDB.player.SetPlayerMaxSaveSlots(ckey, maxslots)

/datum/CharacterSaveManager/proc/GetBonusNotes(var/ckey)
	return PSDB.player.GetPlayerBonusNotes(ckey)

/datum/CharacterSaveManager/proc/SetBonusNotes(var/ckey, var/notes)
	return PSDB.player.SetPlayerBonusNotes(ckey, notes)

/*
	Save a character and despawn it.
*/
/datum/CharacterSaveManager/proc/SaveCharacter(var/mob/living/character, var/ckey, var/preferred_save_slot = -1, var/new_status = CHARACTER_RECORD_STATUS_CRYO)
	if(!character)
		return FALSE
	if(!ckey)
		ckey = LAST_CKEY(character)
		if(!ckey) return FALSE

	if(preferred_save_slot > GetMaxSaveSlots(ckey))
		preferred_save_slot = -1 //Save as unassigned save

	var/datum/character_records/crec = GetCharacterRecord(character.real_name)
	if(!crec)
		crec = CreateCharacterRecord(character.real_name, ckey)

	if(crec.get_save_slot() == -1)
		crec.set_save_slot(preferred_save_slot)

	//save a copy to the BD
	crec.load_from_mob(character)
	crec.set_saved_character(character)
	crec.set_status(GLOB.character_record_status[new_status])


	try
		crec.commit()
	catch(var/exception/e)
		log_error("SaveCharacter(\ref[character][character], [ckey], [preferred_save_slot]) failed with : [e]")
		message_admins("SaveCharacter(\ref[character][character], [ckey], [preferred_save_slot]) failed with : [e]")
		return FALSE

	//Despawn + dispose
	character.ckey = null
	qdel(character)
	return TRUE

/*
	Make the character(s) in the specified save slot read as dead, and de-assigned from the specified save slot
*/
/datum/CharacterSaveManager/proc/ClearSaveSlot(var/ckey, var/preferred_save_slot)
	if(!ckey)
		return
	if(preferred_save_slot > GetMaxSaveSlots(ckey))
		return
	var/list/datum/character_records/crlist = GetCharacterRecordsForCKEYAndSaveSlot(ckey, preferred_save_slot)
	if(!LAZYLEN(crlist))
		warning("Couldn't clear save slot [preferred_save_slot] for [ckey]!")
		return
	//Set any characters with that save slot to dead and with an undefined save slot
	for(var/datum/character_records/C in crlist)
		C.set_save_slot(-1)
		C.set_status(CHARACTER_RECORD_STATUS_DEAD)

/*
	Try to find a free slot from all the available slot for a given player's ckey
*/
/datum/CharacterSaveManager/proc/GetFreeSaveSlot(var/ckey)
	return PSDB.characters.GetFirstFreeSaveSlot(ckey)

/*
	Clear a character slot, and perma-kill the character
*/
/datum/CharacterSaveManager/proc/PermaKillCharacter(var/mob/char)
	if(!char)
		return
	CRASH("IMPLEMENT ME!")

