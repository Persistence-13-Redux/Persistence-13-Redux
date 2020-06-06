/datum/db_records/Faction
	var/const/FACTION_SHARE_HOLDINGS_TABLE = "faction_share_holdings"

//=========================
// Faction Stocks
//=========================
/datum/db_records/Faction/proc/GetStockHoldings_ByShareholder(var/owner_name)
	return GetStockHoldings("owner = [SQL_HELPER.Quote(owner_name)]")
/datum/db_records/Faction/proc/GetStockHoldings_ByFactionUID(var/faction_uid)
	return GetStockHoldings("faction_uid = [SQL_HELPER.Quote(faction_uid)]")
/datum/db_records/Faction/proc/GetStockHoldings_ByShareholderAndFactionUID(var/owner_name, var/faction_uid)
	return GetStockHoldings("faction_uid = [SQL_HELPER.Quote(faction_uid)] AND owner = [SQL_HELPER.Quote(owner_name)]")
/datum/db_records/Faction/proc/GetStockHoldings(var/condition)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT * FROM [FACTION_SHARE_HOLDINGS_TABLE] WHERE [condition];")
	dbq.Execute()
	var/list/datum/stock_holdings/results = list()
	while(dbq.NextRow())
		var/list/row = dbq.GetRowData()
		var/datum/stock_holdings/S = new()
		S.owner = row["owner"]
		S.faction_uid = row["faction_uid"]
		S.number_stocks = row["stocks"]
		results += S
	return results

/datum/db_records/Faction/proc/SetStockHolding(var/owner_name, var/faction_uid, var/new_amount)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("UPDATE [FACTION_SHARE_HOLDINGS_TABLE] SET stocks = [new_amount] WHERE owner = [SQL_HELPER.Quote(owner_name)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/AddStockHolding(var/owner_name, var/faction_uid, var/amount)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("INSERT INTO [FACTION_SHARE_HOLDINGS_TABLE] VALUES owner = [SQL_HELPER.Quote(owner_name)], faction_uid = [SQL_HELPER.Quote(faction_uid)], stocks = [amount];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/DeleteStockHolding(var/owner_name, var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("DELETE FROM [FACTION_SHARE_HOLDINGS_TABLE] WHERE owner = [SQL_HELPER.Quote(owner_name)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/HasStockHolding(var/owner_name, var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT COUNT(id) FROM [FACTION_SHARE_HOLDINGS_TABLE] WHERE owner = [SQL_HELPER.Quote(owner_name)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	if(dbq.RowsAffected() <= 0)
		return FALSE
	dbq.NextRow()
	var/list/row = dbq.GetRowData()
	var/nbrec = text2num(row[1])
	return nbrec > 0

//Deletes all existing stocks for a given faction in circulation
/datum/db_records/Faction/proc/DeleteAllFactionStocks(var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("DELETE FROM [FACTION_SHARE_HOLDINGS_TABLE] where faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected()