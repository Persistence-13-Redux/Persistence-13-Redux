/datum/PersistentDB
	var/datum/db_records/Faction/factions = new()

/datum/db_records/Faction
	var/const/FACTION_TABLE = "factions"
	var/const/NETWORK_TABLE = "networks"

//=========================
// Faction Records
//=========================
/datum/db_records/Faction/proc/GetFactionName(var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT name FROM [FACTION_TABLE] WHERE uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return null

/datum/db_records/Faction/proc/GetFactionRecord(var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT * FROM [FACTION_TABLE] WHERE uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/world_faction/F = new()
		F.before_load()
		F.parse_row(dbq.GetRowData())
		F.after_load()
		return F
	return null

/datum/db_records/Faction/proc/CommitFaction(var/datum/world_faction/faction)
	if(!PSDB.check_connection()) return
	faction.before_save()
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("UPDATE [FACTION_TABLE] SET [faction.to_sql()] WHERE uid = [SQL_HELPER.Quote(faction.uid)];")
	faction.after_save()
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/CreateFaction(var/datum/world_faction/faction)
	if(!PSDB.check_connection()) return
	faction.before_save()
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("INSERT INTO [FACTION_TABLE] VALUES ([faction.to_sql()]);")
	faction.after_save()
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/DeleteFaction(var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("DELETE FROM [FACTION_TABLE] WHERE uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

//=========================
// Networks
//=========================
/datum/db_records/Faction/proc/CommitFactionNetwork(var/datum/ntnet/faction/network)
	var/already_exists = PSDB.DoesRecordExists(NETWORK_TABLE, "uid = [SQL_HELPER.Quote(network.uid)]")
	var/DBQuery/dbq
	if(already_exists)
		dbq = PSDB.psdbcon.NewQuery("UPDATE [NETWORK_TABLE] SET [network.to_sql()] WHERE uid = [SQL_HELPER.Quote(network.uid)];")
	else
		dbq = PSDB.psdbcon.NewQuery("INSERT INTO [NETWORK_TABLE] VALUES [network.to_sql()];")
	network.before_save()
	dbq.Execute()
	network.after_save()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/GetFactionNetwork(var/network_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT * FROM [NETWORK_TABLE] WHERE uid = [SQL_HELPER.Quote(network_uid)];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/ntnet/faction/N = new()
		N.before_load()
		N.parse_row(dbq.GetRowData())
		N.after_load()
		return N
	return null

/datum/db_records/Faction/proc/GetAllFactionNetworks()
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT * FROM [NETWORK_TABLE];")
	dbq.Execute()
	var/list/datum/ntnet/faction/networks = list()
	while(dbq.NextRow())
		var/datum/ntnet/faction/N = new()
		N.before_load()
		N.parse_row(dbq.GetRowData())
		N.after_load()
		networks += N
	return networks

/datum/db_records/Faction/proc/DeleteFactionNetwork(var/network_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("DELETE FROM [NETWORK_TABLE] WHERE uid = [SQL_HELPER.Quote(network_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0