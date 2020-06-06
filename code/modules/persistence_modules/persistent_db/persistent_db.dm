//Global instance for accessing all the db interactions
var/global/datum/PersistentDB/PSDB = new()

///////////////////////////
// AccountDB
///////////////////////////
//Mainly an object used to regroup all procs related to getting data from the database on players, factions, and various other things
/datum/PersistentDB
	var/failed_master_db_connections = 0 //Counts the number of failed connections attempts
	var/DBConnection/psdbcon = new() //Connection datum to the persistent SQL DB

//If the database is not connected, will connect it, otherwise does nothing.
// returns true if the db can/is connected
/datum/PersistentDB/proc/check_connection()
	establish_master_db_connection()
	if(!psdbcon.IsConnected())
		return FALSE
	return TRUE

//Runs a query to find a matching results on a table with the specified condition. If there's a match returns 1, otherwise 0
/datum/PersistentDB/proc/DoesRecordExists(var/table_name, var/condition)
	if(!check_connection()) return
	var/DBQuery/dbq_exists = psdbcon.NewQuery("SELECT COUNT(1) FROM [table_name] WHERE [condition]")
	dbq_exists.Execute()
	dbq_exists.NextRow()
	var/list/results = dbq_exists.GetRowData()
	return text2num(results[1]) > 0