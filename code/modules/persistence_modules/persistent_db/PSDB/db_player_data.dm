/*
	Player data contains any records that should be assigned to a given CKey, like amount of save slots and the like
*/
/datum/PersistentDB
	var/datum/db_records/Player/player = new()

/datum/db_records/Player
	var/const/PLAYER_DATA_TABLE = "player_data"

//=========================
// Player Data
//=========================
//Add a new player to the database
/datum/db_records/Player/proc/AddNewPlayer(var/ckey)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("INSERT INTO [PLAYER_DATA_TABLE] VALUES ckey = [SQL_HELPER.Quote(ckey)], max_save_slots = [DEFAULT_MAX_SAVE_SLOTS], bonus_notes = '';")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
	return FALSE

/datum/db_records/Player/proc/IsPlayerExist(var/ckey)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT ckey FROM [PLAYER_DATA_TABLE] WHERE ckey = [SQL_HELPER.Quote(ckey)];")
	dbq.Execute()
	if(dbq.NextRow())
		return TRUE
	return FALSE

//Set/Get the available save slots
/datum/db_records/Player/proc/GetPlayerMaxSaveSlots(var/ckey)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT max_save_slots FROM [PLAYER_DATA_TABLE] WHERE ckey = [SQL_HELPER.Quote(ckey)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return DEFAULT_MAX_SAVE_SLOTS

/datum/db_records/Player/proc/SetPlayerMaxSaveSlots(var/ckey, var/maxslots)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("UPDATE [PLAYER_DATA_TABLE] SET (max_save_slots = [maxslots]) WHERE ckey = [SQL_HELPER.Quote(ckey)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
	return FALSE

//Set/Get the bonus notes
/datum/db_records/Player/proc/GetPlayerBonusNotes(var/ckey)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT bonus_notes FROM [PLAYER_DATA_TABLE] WHERE ckey = [SQL_HELPER.Quote(ckey)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return null

/datum/db_records/Player/proc/SetPlayerBonusNotes(var/ckey, var/notes)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("UPDATE [PLAYER_DATA_TABLE] SET (bonus_notes = [notes]) WHERE ckey = [SQL_HELPER.Quote(ckey)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
	return FALSE

//Set/Get the last selected saved character slot
/datum/db_records/Player/proc/GetLastSelectedSaveSlot(var/ckey)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT last_selected_save_slot FROM [PLAYER_DATA_TABLE] WHERE ckey = [SQL_HELPER.Quote(ckey)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return null

/datum/db_records/Player/proc/SetLastSelectedSaveSlot(var/ckey, var/save_slot)
	if(!PSDB.check_connection()) return
	save_slot = sanitize_integer(save_slot, 0, MAXIMUM_GLOBAL_SAVE_SLOTS)
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("UPDATE [PLAYER_DATA_TABLE] SET (last_selected_save_slot = [save_slot]) WHERE ckey = [SQL_HELPER.Quote(ckey)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
	return FALSE
