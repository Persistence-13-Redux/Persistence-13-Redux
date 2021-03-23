/datum/AccountDB
	var/datum/AccountDB/Faction/factions = new()

/datum/AccountDB/Faction
	var/const/FACTION_TABLE = "factions"

//=========================
// Faction Records
//=========================
/datum/AccountDB/Faction/proc/GetFactionName(var/faction_uid)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT name FROM [FACTION_TABLE] WHERE uid = [dbcon_master.Quote(faction_uid)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return null

/datum/AccountDB/Faction/proc/GetFactionRecord(var/faction_uid)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [FACTION_TABLE] WHERE uid = [dbcon_master.Quote(faction_uid)];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/world_faction/F = new()
		F.before_load()
		F.parse_row(dbq.GetRowData())
		F.after_load()
		return F
	return null

/datum/AccountDB/Faction/proc/CommitFaction(var/datum/world_faction/faction)
	if(!check_connection()) return
	faction.before_save()
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [FACTION_TABLE] SET [faction.to_sql()] WHERE uid = [dbcon_master.Quote(faction.uid)];")
	faction.after_save()
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/AccountDB/Faction/proc/CreateFaction(var/datum/world_faction/faction)
	if(!check_connection()) return
	faction.before_save()
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [FACTION_TABLE] VALUES ([faction.to_sql()]);")
	faction.after_save()
	dbq.Execute()
	return dbq.RowsAffected() > 0

//=========================
// World Faction Overrides
//=========================
/datum/world_faction/proc/to_sql()
	//Make sure we only save the fields we can actually save only
	. = {"
	name =               [dbcon_master.Quote(name)],
	abbreviation =       [dbcon_master.Quote(abbreviation)],
	desc =               [dbcon_master.Quote(desc)],
	password =           [dbcon_master.Quote(password)],
	owner_name =         [dbcon_master.Quote(owner_name)],
	newtork_uid =        [dbcon_master.Quote(newtork_uid)],
	central_account_id = [dbcon_master.Quote(central_account_id)],
	expenses =           '[list2savedtext(expenses)]',
	status =             [status],
	hiring =             [hiring],
	"}

/datum/world_faction/proc/parse_row(var/list/row)
	uid = 					row["uid"]
	name = 					row["name"]
	abbreviation = 			row["abbreviation"]
	desc = 					row["description"]
	password = 				row["password"]
	owner_name = 			row["owner_name"]
	newtork_uid = 			row["newtork_uid"]
	central_account_id = 	text2num(row["bank_id"])
	expenses = 				savedtext2list(row["expenses"])
	status = 				text2num(row["status"])
	hiring = 				text2num(row["hiring"])

// /datum/world_faction/business/to_sql()
// 	. = ..()
// 	. = {"
// 	[.],
// 	remaining_stocks = [remaining_stocks]
// 	"}


// /datum/world_faction/business/parse_row(var/list/row)
// 	..()
// 	remaining_stocks = 		text2num(row["remaining_stocks"])