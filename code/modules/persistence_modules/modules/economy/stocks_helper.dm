
/*
	Ass
*/
// /proc/CreateStocksData(var/name, var/stocks_faction_uid)
// 	var/datum/world_faction/F = FindFaction(stocks_faction_uid)
// 	var/datum/stockholder/S = F?.get_stockholder(name)
// 	if(!S)
// 		F.add_stockholder(name, 0)

/proc/GetStocksData(var/name, var/stocks_faction_uid)
	var/datum/world_faction/F = FindFaction(stocks_faction_uid)
	return F?.get_stockholder(name)

/proc/TransferStocks(var/src_name, var/dest_name, var/stocks_faction_uid, var/amount)
	var/datum/world_faction/F = FindFaction(stocks_faction_uid)
	if(!F)
		log_error("Stock transfer failure: '[src_name]' -> '[dest_name]' of '[amount]' stocks of '[stocks_faction_uid]'. USR: [usr], SRC: [src_name]. Invalid Faction!!")
		return FALSE
	var/datum/stock_holdings/S = GetStocksData(src_name, stocks_faction_uid)
	if(!S || S.number_stocks < amount)
		log_error("Stock transfer failure: '[src_name]' -> '[dest_name]' of '[amount]' stocks of '[stocks_faction_uid]'. USR: [usr], SRC: [src_name]. Invalid source, or insufficient stocks!!")
		return FALSE

	var/datum/stock_holdings/D = GetStocksData(dest_name, stocks_faction_uid)
	//check if has existing stocks holding for this faction, if not create one.
	if(!D)
		if(!PSDB.factions.AddStockHolding(dest_name, stocks_faction_uid, amount))
			log_error("Stock transfer failure: '[src_name]' -> '[dest_name]' of '[amount]' stocks of '[stocks_faction_uid]'. USR: [usr], SRC: [src_name]. Failed to create stock holding record in DB!!")
			return FALSE
	else
		D.number_stocks += amount
		if(!D.commit())
			log_error("Stock transfer failure: '[src_name]' -> '[dest_name]' of '[amount]' stocks of '[stocks_faction_uid]'. USR: [usr], SRC: [src_name]. Failed to commit destination stock holdings record!!")
			return FALSE
	S.number_stocks -= amount
	//In case of failure, try to remove the money we just transfered
	if(!S.commit())
		log_error("Stock transfer failure: '[src_name]' -> '[dest_name]' of '[amount]' stocks of '[stocks_faction_uid]'. USR: [usr], SRC: [src_name]. Failed to commit source stock holdings record. Transaction reversed!!")
		D.number_stocks -= amount //Remove failed transfer
		D.commit()
		return FALSE
	return TRUE