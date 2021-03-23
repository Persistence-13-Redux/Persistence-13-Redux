/datum/AccountDB
	var/datum/AccountDB/CharacterRecords/characters = new()

/datum/AccountDB/CharacterRecords
	var/const/CHAR_RECORDS_TABLE = "character_records"

//=========================
// Records
//=========================

/*
	Create a brand new record in the database for a player's character.
	The operation will fail if the name exists already since its a primary key.
*/
/datum/AccountDB/CharacterRecords/proc/CreateCharacterRecord(var/real_name, var/ckey)
	if(!check_connection()) return
	var/saveslot = GetFirstFreeSaveSlot(ckey)
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [CHAR_RECORDS_TABLE] VALUES real_name = [dbcon_master.Quote(real_name)], ckey = [dbcon_master.Quote(ckey)], save_slot = [saveslot];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/*
*/
/datum/AccountDB/CharacterRecords/proc/RemoveCharacterRecord(var/real_name)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("DELETE FROM [CHAR_RECORDS_TABLE] WHERE real_name = [dbcon_master.Quote(real_name)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/*
*/
/datum/AccountDB/CharacterRecords/proc/GetCharacterRecord(var/real_name)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [CHAR_RECORDS_TABLE] WHERE real_name = [dbcon_master.Quote(real_name)];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/character_records/CR = new()
		CR.parse_row(dbq.GetRowData())
		return CR

/*
	Returns all the character records for the matching player ckey, and optionally a given save slot id. 
*/
/datum/AccountDB/CharacterRecords/proc/GetCharacterRecordsForCKEY(var/ckey, var/save_slot = null)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [CHAR_RECORDS_TABLE] WHERE ckey = [dbcon_master.Quote(ckey)] [save_slot?" AND save_slot = [save_slot]" : ""];")
	dbq.Execute()
	var/list/result = list()
	while(dbq.NextRow())
		var/datum/character_records/CR = new()
		CR.parse_row(dbq.GetRowData())
		result += CR
	return result

/*
	Overwrite the existing character records in the DB with the one passed in parameter
*/
/datum/AccountDB/CharacterRecords/proc/CommitCharacterRecord(var/datum/character_records/records)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [CHAR_RECORDS_TABLE] SET ([records.to_sql()]) WHERE real_name = [dbcon_master.Quote(records.get_real_name())];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/*
	Returns the first save slot id, not assigned to a character, for the given player.
*/
/datum/AccountDB/CharacterRecords/proc/GetFirstFreeSaveSlot(var/ckey)
	if(!check_connection()) return
	var/max = CharacterSaves.GetMaxSaveSlots(ckey)
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT save_slot FROM [CHAR_RECORDS_TABLE] WHERE ckey = [dbcon_master.Quote(ckey)] AND save_slot BETWEEN 1 and [max] ORDERBY save_slot ASC;")
	dbq.Execute()
	if(!dbq.RowsAffected())
		return 1
	var/counter = 1
	while(dbq.NextRow())
		if(counter < text2num(dbq.item[1]))
			return counter //If we get to a point where the next entry has a higher save slot value, we've found a free slot!
		counter++
	if(counter < max)
		return counter
	return -1 //Last resort return -1

/*
	Returns the character name in the slot specified for the player's character records with the matching ckey.
*/
/datum/AccountDB/CharacterRecords/proc/GetCharacterName(var/ckey, var/save_slot)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT name FROM [CHAR_RECORDS_TABLE] WHERE ckey = [dbcon_master.Quote(ckey)] AND save_slot = [save_slot];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return null

//=========================
// Overrides
//=========================
