#define FAILED_DB_CONNECTION_CUTOFF 5 //Maximum amount of failed attempts to connect to the SQL DB
///////////////////////////
// Hook
///////////////////////////

//Hook on server startup that tries to auto-connect the server to the SQL database
/hook/startup/proc/connect_persistent_db()
	if(!PSDB.setup_master_database_connection())
		world.log << "Your server failed to establish a connection with the Master SQL database."
	else
		world.log << "Master SQL database connection established."
	return 1

///////////////////////////
// Procs
///////////////////////////
//
/datum/PersistentDB/proc/setup_master_database_connection()
	if(failed_master_db_connections > FAILED_DB_CONNECTION_CUTOFF)	//If it failed to establish a connection more than 5 times in a row, don't bother attempting to conenct anymore.
		return 0

	if(!psdbcon)
		psdbcon = new()

	var/user = sqllogin
	var/pass = sqlpass
	var/db = sqldb
	var/address = sqladdress
	var/port = sqlport

	psdbcon.Connect("dbi:mysql:[db]:[address]:[port]","[user]","[pass]")
	. = psdbcon.IsConnected()
	if ( . )
		failed_master_db_connections = 0	//If this connection succeeded, reset the failed connections counter.
	else
		failed_master_db_connections++		//If it failed, increase the failed connections counter.
		world.log << psdbcon.ErrorMsg()

	return .

/datum/PersistentDB/proc/establish_master_db_connection()
	if(failed_master_db_connections > FAILED_DB_CONNECTION_CUTOFF)
		return 0

	if(!psdbcon || !psdbcon.IsConnected())
		return setup_master_database_connection()
	else
		return 1

#undef FAILED_DB_CONNECTION_CUTOFF