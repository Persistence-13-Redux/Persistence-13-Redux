/datum/AccountDB/Faction
	var/const/FACTION_SHARE_HOLDINGS_TABLE = "faction_share_holdings"

//=========================
// Faction Stocks
//=========================
/datum/AccountDB/Faction/proc/GetStockHoldings_ByShareholder(var/owner_name)
	return GetStockHoldings("owner = [dbcon_master.Quote(owner_name)]")
/datum/AccountDB/Faction/proc/GetStockHoldings_ByFactionUID(var/faction_uid)
	return GetStockHoldings("faction_uid = [dbcon_master.Quote(faction_uid)]")
/datum/AccountDB/Faction/proc/GetStockHoldings_ByShareholderAndFactionUID(var/owner_name, var/faction_uid)
	return GetStockHoldings("faction_uid = [dbcon_master.Quote(faction_uid)] AND owner = [dbcon_master.Quote(owner_name)]")
/datum/AccountDB/Faction/proc/GetStockHoldings(var/condition)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [FACTION_SHARE_HOLDINGS_TABLE] WHERE [condition];")
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

/datum/AccountDB/Faction/proc/SetStockHolding(var/owner_name, var/faction_uid, var/new_amount)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [FACTION_SHARE_HOLDINGS_TABLE] SET stocks = [new_amount] WHERE owner = [dbcon_master.Quote(owner_name)] AND faction_uid = [dbcon_master.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/AccountDB/Faction/proc/AddStockHolding(var/owner_name, var/faction_uid, var/amount)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [FACTION_SHARE_HOLDINGS_TABLE] VALUES owner = [dbcon_master.Quote(owner_name)], faction_uid = [dbcon_master.Quote(faction_uid)], stocks = [amount];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/AccountDB/Faction/proc/DeleteStockHolding(var/owner_name, var/faction_uid)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("DELETE FROM [FACTION_SHARE_HOLDINGS_TABLE] WHERE owner = [dbcon_master.Quote(owner_name)] AND faction_uid = [dbcon_master.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/AccountDB/Faction/proc/HasStockHolding(var/owner_name, var/faction_uid)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT COUNT(id) FROM [FACTION_SHARE_HOLDINGS_TABLE] WHERE owner = [dbcon_master.Quote(owner_name)] AND faction_uid = [dbcon_master.Quote(faction_uid)];")
	dbq.Execute()
	if(dbq.RowsAffected() <= 0)
		return FALSE
	dbq.NextRow()
	var/list/row = dbq.GetRowData()
	var/nbrec = text2num(row[1])
	return nbrec > 0