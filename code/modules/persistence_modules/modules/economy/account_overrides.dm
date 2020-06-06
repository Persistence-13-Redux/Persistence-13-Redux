/datum/money_account
	var/list/frozen_funds 	= list() //Funds frozen for a given entity. Format is entityname = sum
	var/list/owned_stocks 	= list() //Stocks held for a given faction. Format is faction uid = amount of stocks
	var/loaned_funds 		= 0 	 //Money loaned from the bank

/datum/money_account/proc/parse_row(var/list/row)
	account_number 		= text2num(row["id"]) //Account id is stored as varchar
	remote_access_pin 	= text2num(row["pin"])
	owner_name 			= row["owner_name"]
	account_name 		= row["name"]
	account_type 		= text2num(row["type"])
	money 				= text2num(row["money"])
	suspended 			= text2num(row["suspended"])
	security_level 		= text2num(row["security_level"])
	frozen_funds 		= savedtext2list(row["frozen_funds"])
	owned_stocks 		= savedtext2list(row["owned_stocks"])
	loaned_funds 		= text2num(row["loaned_funds"])

/datum/money_account/proc/to_sql()
	. = "id =              '[num2text(account_number)]'," //Account id is stored as varchar
	. += "pin =            [remote_access_pin],"
	. += "owner_name =     [SQL_HELPER.Quote(owner_name)],"
	. += "name =           [SQL_HELPER.Quote(account_name)],"
	. += "type =           [account_type],"
	. += "money =          [money],"
	. += "suspended =      [suspended],"
	. += "security_level = [security_level],"
	. += "frozen_funds =   '[list2savedtext(frozen_funds)]',"
	. += "owned_stocks =   '[list2savedtext(owned_stocks)]',"
	. += "loaned_funds =   [loaned_funds]"


//Freeze funds from the specified account, and hold them under a specified identifier
/datum/money_account/proc/freeze_funds(var/identifier, var/amount)
	if(amount < money)
		frozen_funds[identifier] = amount
		money -= amount
		return TRUE
	return FALSE

//Unfreeze the funds corresponding to the specified identifier. Returns amount unfrozen.
/datum/money_account/proc/unfreeze_funds(var/identifier)
	if(frozen_funds[identifier])
		var/amount = frozen_funds[identifier]
		money += amount
		return amount
	return null

/datum/money_account/proc/total_frozen()
	var/total = 0 
	for(var/key in frozen_funds)
		if(frozen_funds[key])
			total += frozen_funds[key]
	return total

/datum/money_account/proc/clear_frozen()
	var/total = total_frozen()
	money += total
	frozen_funds.Cut()

//
// Stocks
//
/datum/money_account/proc/set_stocks(var/faction_uid, var/amount)
	owned_stocks[faction_uid] = amount

/datum/money_account/proc/get_stocks(var/faction_uid)
	return owned_stocks[faction_uid]

/datum/money_account/proc/clear_stocks(var/faction_uid)
	set_stocks(faction_uid, 0)

/datum/money_account/proc/clear_all_stocks()
	owned_stocks.Cut()

//
//	Loans
//
/datum/money_account/proc/take_loan(var/amount, var/purpose)
	amount = max(amount, 0)
	if(!credit_check(amount))
		return FALSE
	loaned_funds += amount
	deposit(amount, purpose, "Loan", TRUE)
	return TRUE

//If no ammount specified will try repaying the entirety of the loans
/datum/money_account/proc/repay_loan(var/amount = -1)
	if(amount == -1)
		amount = loaned_funds
	amount = max(amount, 0)
	if(withdraw(amount, "Repay loan", "Loan"))
		loaned_funds -= amount
		return TRUE

/datum/money_account/proc/get_loaned()
	return loaned_funds

//Check to see if we should grant them a loan..
var/global/MAXIMUM_LOAN = 10000 //Lets begin with 10,000
var/global/MAXUMUM_TOTAL_LOAN = MAXIMUM_LOAN * 2 //Lets go for twice the maxumum single loan
/datum/money_account/proc/credit_check(var/amount)
	amount = max(amount, 0)
	if(amount > MAXIMUM_LOAN)
		return FALSE
	if((get_loaned() + amount) > MAXUMUM_TOTAL_LOAN)
		return FALSE
	//Check stocks holdings
	//Check business holdings
	//Check previous transactions
	return TRUE
	