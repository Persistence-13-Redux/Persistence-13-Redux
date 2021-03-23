#define FAILED_DB_CONNECTION_CUTOFF 5

var/global/failed_master_db_connections = 0
var/global/DBConnection/dbcon_master = new()

/hook/startup/proc/connectMasterDB()
	if(!setup_master_database_connection())
		world.log << "Your server failed to establish a connection with the Master SQL database."
	else
		world.log << "Master SQL database connection established."
	return 1

//
proc/setup_master_database_connection()
	if(failed_master_db_connections > FAILED_DB_CONNECTION_CUTOFF)	//If it failed to establish a connection more than 5 times in a row, don't bother attempting to conenct anymore.
		return 0

	if(!dbcon_master)
		dbcon_master = new()

	var/user = sqllogin
	var/pass = sqlpass
	var/db = sqldb
	var/address = sqladdress
	var/port = sqlport

	dbcon_master.Connect("dbi:mysql:[db]:[address]:[port]","[user]","[pass]")
	. = dbcon_master.IsConnected()
	if ( . )
		failed_master_db_connections = 0	//If this connection succeeded, reset the failed connections counter.
	else
		failed_master_db_connections++		//If it failed, increase the failed connections counter.
		world.log << dbcon_master.ErrorMsg()

	return .

proc/establish_master_db_connection()
	if(failed_master_db_connections > FAILED_DB_CONNECTION_CUTOFF)
		return 0

	if(!dbcon_master || !dbcon_master.IsConnected())
		return setup_master_database_connection()
	else
		return 1

#undef FAILED_DB_CONNECTION_CUTOFF