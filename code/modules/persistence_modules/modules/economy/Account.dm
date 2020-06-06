// /datum/money_account
// 	var/list/loan //Loans taken from the bank
	

/datum/money_account/add_transaction(var/datum/transaction/T, is_source)
	. = ..()
	//Ensure the DB is up to date
	PSDB.bank.AddTransaction(T)
	PSDB.bank.CommitBankAccount(src)

/proc/get_money_account_exists(var/account_number)
	return PSDB.bank.DoesBankAccountExistsByID(account_number)

/proc/get_account_balance(var/account_number)
	var/datum/money_account/D
	for(D in all_money_accounts)
		if(D.account_number == account_number)
			return D.get_balance()
	D = PSDB.bank.GetBankAccountByID(account_number)
	if(D)
		all_money_accounts |= D //Add it to the cache
		return D.get_balance()

/proc/get_money_account_balance_by_name(var/owner_name)
	var/datum/money_account/D
	for(D in all_money_accounts)
		if(D.owner_name == owner_name)
			return D.get_balance()
	D = PSDB.bank.GetBankAccountByOwnerName(owner_name)
	if(D)
		all_money_accounts |= D //Add it to the cache
		return D.get_balance()

/proc/get_money_account_by_name(var/owner_name)
	var/datum/money_account/D
	for(D in all_money_accounts)
		if(D.owner_name == owner_name)
			return D
	D = PSDB.bank.GetBankAccountByOwnerName(owner_name)
	if(D)
		all_money_accounts |= D //Add it to the cache
