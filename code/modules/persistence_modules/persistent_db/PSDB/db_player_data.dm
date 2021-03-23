/datum/AccountDB
	var/datum/AccountDB/Player/player = new()

/datum/AccountDB/Player
	var/const/PLAYER_DATA_TABLE = "player_data"

//=========================
// Player Data
//=========================
//Add a new player to the database
/datum/AccountDB/Player/proc/AddNewPlayer(var/ckey)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [PLAYER_DATA_TABLE] VALUES ckey = [dbcon_master.Quote(ckey)], max_save_slots = [DEFAULT_MAX_SAVE_SLOTS], bonus_notes = '';")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
	return FALSE

/datum/AccountDB/Player/proc/IsPlayerExist(var/ckey)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT ckey FROM [PLAYER_DATA_TABLE] WHERE ckey = [dbcon_master.Quote(ckey)];")
	dbq.Execute()
	if(dbq.NextRow())
		return TRUE
	return FALSE

//Set/Get the available save slots
/datum/AccountDB/Player/proc/GetPlayerMaxSaveSlots(var/ckey)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT max_save_slots FROM [PLAYER_DATA_TABLE] WHERE ckey = [dbcon_master.Quote(ckey)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return DEFAULT_MAX_SAVE_SLOTS

/datum/AccountDB/Player/proc/SetPlayerMaxSaveSlots(var/ckey, var/maxslots)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [PLAYER_DATA_TABLE] SET (max_save_slots = [maxslots]) WHERE ckey = [dbcon_master.Quote(ckey)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
	return FALSE

//Set/Get the bonus notes
/datum/AccountDB/Player/proc/GetPlayerBonusNotes(var/ckey)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT bonus_notes FROM [PLAYER_DATA_TABLE] WHERE ckey = [dbcon_master.Quote(ckey)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return null

/datum/AccountDB/Player/proc/SetPlayerBonusNotes(var/ckey, var/notes)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [PLAYER_DATA_TABLE] SET (bonus_notes = [notes]) WHERE ckey = [dbcon_master.Quote(ckey)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
	return FALSE

//Set/Get the last selected saved character slot
/datum/AccountDB/Player/proc/GetLastSelectedSaveSlot(var/ckey)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT last_selected_save_slot FROM [PLAYER_DATA_TABLE] WHERE ckey = [dbcon_master.Quote(ckey)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return null

/datum/AccountDB/Player/proc/SetLastSelectedSaveSlot(var/ckey, var/save_slot)
	if(!check_connection()) return
	save_slot = sanitize_integer(save_slot, 0, MAXIMUM_GLOBAL_SAVE_SLOTS)
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [PLAYER_DATA_TABLE] SET (last_selected_save_slot = [save_slot]) WHERE ckey = [dbcon_master.Quote(ckey)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
	return FALSE
