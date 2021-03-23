var/global/datum/AccountDB/PSDB = new()

/datum/AccountDB


/datum/AccountDB/proc/check_connection()
	establish_master_db_connection()
	if(!dbcon_master.IsConnected())
		return FALSE
	return TRUE

