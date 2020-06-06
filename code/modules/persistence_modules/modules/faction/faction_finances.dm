/*
	Helper for dealing with money stuff for factions
*/
var/const/FACTION_TOTAL_SHARES = 100
//===============================
//	Main Account
//===============================
//Always use this, to ensure the account is properly loaded first!
/datum/world_faction/proc/get_central_account()
	if(!central_account)
		central_account = get_account(central_account_id)
	return central_account

//===============================
//	Taxes
//===============================
/datum/world_faction/proc/pay_tax(var/amount)
	if(!parent_faction_uid || parent_faction_uid == "") 
		return 0
	var/datum/world_faction/connected_faction = FindFaction(parent_faction_uid)
	if(!connected_faction) 
		return 0
	var/datum/money_account/acc = connected_faction.get_central_account()
	acc.transfer(central_account, round(amount/100 * connected_faction.tax_rate), "Tax to [connected_faction.name]")

/datum/world_faction/proc/pay_export_tax(var/amount)
	if(!parent_faction_uid || parent_faction_uid == "") 
		return 0
	var/datum/world_faction/connected_faction = FindFaction(parent_faction_uid)
	if(!connected_faction) 
		return 0
	var/datum/money_account/acc = connected_faction.get_central_account()
	acc.transfer(central_account, round(amount/100 * connected_faction.export_profit), "Export tax to [connected_faction.name]")
	return (amount/100 * connected_faction.export_profit)

/datum/world_faction/proc/set_tax_collector(var/_taxer_uid)
	parent_faction_uid = _taxer_uid

/datum/world_faction/proc/get_tax_collector_uid()
	return parent_faction_uid

//===============================
// Loans and Debts
//===============================
/datum/world_faction/proc/get_debt()
	var/datum/money_account/acc = get_central_account()
	return acc.get_loaned()

/datum/world_faction/proc/pay_debt()
	var/datum/money_account/acc = get_central_account()
	return acc.repay_loan()

//===============================
// Stocks
//===============================
/datum/stock_holdings
	var/owner
	var/faction_uid
	var/number_stocks
/datum/stock_holdings/proc/commit()
	if(PSDB.factions.HasStockHolding(owner, faction_uid))
		return PSDB.factions.SetStockHolding(owner, faction_uid, number_stocks)
	else
		return PSDB.factions.AddStockHolding(owner, faction_uid, number_stocks)

/*
	Return a list of /datum/stock_holdings for all characters owning faction stocks.
*/
/datum/world_faction/proc/get_stockholders()
	return PSDB.factions.GetStockHoldings_ByFactionUID(src.uid)

/*
	Returns the faction stocks owned by a given character.
	Or null if the character doesn't own any.
*/
/datum/world_faction/proc/get_stockholder(var/stockholder_name)
	var/list/datum/stock_holdings/SL = PSDB.factions.GetStockHoldings_ByShareholderAndFactionUID(stockholder_name, src.uid)
	return LAZYLEN(SL)? SL[1] : null

/*
	Hands out a given quantity of stocks to a sprcific characters.
	Will fail if there isn't enough stocks left for grabs.
*/
/datum/world_faction/proc/transfer_stocks(var/new_owner, var/stocks)
	var/faction_stocks = get_unowned_stocks()
	if(faction_stocks < stocks)
		return FALSE
	PSDB.factions.SetStockHolding(src.uid, src.uid, faction_stocks - stocks)

	//Create or change the amount of stocks onwed by the new owner
	var/list/datum/stock_holdings/OwnerStockHoldings = PSDB.factions.GetStockHoldings_ByShareholderAndFactionUID(new_owner, src.uid)
	if(!LAZYLEN(OwnerStockHoldings))
		return PSDB.factions.AddStockHolding(new_owner, src.uid, stocks)
	var/datum/stock_holdings/OwnerHoldings = OwnerStockHoldings[1]
	return PSDB.factions.SetStockHolding(new_owner, src.uid, stocks + (OwnerHoldings?.number_stocks))

/*
	Gets all stocks of the faction that aren't owned by an individual.
*/
/datum/world_faction/proc/get_unowned_stocks()
	var/list/datum/stock_holdings/FactionStockHoldings = PSDB.factions.GetStockHoldings_ByShareholderAndFactionUID(src.uid, src.uid)
	if(!FactionStockHoldings)
		return FALSE
	var/datum/stock_holdings/FactionStockHolding = FactionStockHoldings[1]
	return FactionStockHolding?.number_stocks

//===============================
// Stockholder Transactions
//===============================

/*
	Distribute a given ammount of money between all stockholders of the faction.
*/
/datum/world_faction/proc/pay_stockholders(var/total_to_split, var/purpose)
	total_to_split = max(total_to_split, 0)
	if(total_to_split == 0)
		return FALSE
	var/datum/money_account/FactionAccount = get_central_account()
	if(!FactionAccount)
		log_warning("Faction '[src.uid]' has no bank account! Account number: '[src.central_account_id]'")
		return FALSE
	if(!FactionAccount.withdraw(total_to_split, purpose, ""))
		return FALSE
	
	//Do a DB request to fetch all stocholders quickly
	var/amount_per_share = total_to_split / FACTION_TOTAL_SHARES
	var/list/datum/stock_holdings/holders = PSDB.factions.GetStockHoldings_ByFactionUID(src.uid)
	for(var/datum/stock_holdings/S in holders)
		var/datum/money_account/ShareholderAcc = get_money_account_by_name(S.owner)
		var/to_pay = amount_per_share * S.number_stocks
		//If the owner has no account for some reasons, refund his share later
		if(!ShareholderAcc)
			FactionAccount.deposit(to_pay, "Refund for unreachable shareholder account, named [S.owner].", "")
			log_warning(" /datum/world_faction/proc/pay_stockholders(): Can't find account for stockholder [S.owner], with [S.number_stocks] stocks. Issuing faction uid: [src.uid]")
			continue
		ShareholderAcc.deposit(to_pay, "[purpose]. Shareholder share of [GLOB.using_map.local_currency_name_short][total_to_split].", "")
	return TRUE