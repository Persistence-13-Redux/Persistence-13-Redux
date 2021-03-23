/datum/AccountDB
	var/datum/AccountDB/Bank/bank = new()

/datum/AccountDB/Bank
	var/const/BANK_ACCOUNT_TABLE	= "bank_accounts"
	var/const/BANK_TRANSACTION_TABLE = "bank_transactions"

//=========================
// Money Account
//=========================
/datum/AccountDB/Bank/proc/AddBankAccount(var/datum/money_account/account)
	if(!account) return
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [BANK_ACCOUNT_TABLE] VALUES [account.to_sql()];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/datum/AccountDB/Bank/proc/RemoveBankAccount(var/account_id)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("DELETE FROM [BANK_ACCOUNT_TABLE] WHERE id = [dbcon_master.Quote(account_id)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/datum/AccountDB/Bank/proc/GetBankAccountByOwnerName(var/owner_name)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [BANK_ACCOUNT_TABLE] WHERE owner_name = [dbcon_master.Quote(owner_name)];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/money_account/A = new()
		A.parse_row(dbq.GetRowData())
		if(A)
			A.transaction_log = GetTransactions(A.account_number)
		return A

/datum/AccountDB/Bank/proc/GetBankAccountByID(var/account_id)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [BANK_ACCOUNT_TABLE] WHERE id = [dbcon_master.Quote(account_id)];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/money_account/A = new()
		A.parse_row(dbq.GetRowData())
		if(A)
			A.transaction_log = GetTransactions(A.account_number)
		return A

/datum/AccountDB/Bank/proc/CommitBankAccount(var/datum/money_account/account)
	if(!account) return
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [BANK_ACCOUNT_TABLE] SET ([account.to_sql()]) WHERE id = '[account.account_number]';")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/datum/AccountDB/Bank/proc/DoesBankAccountExistsByID(var/account_id)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT id FROM [BANK_ACCOUNT_TABLE] WHERE id = [dbcon_master.Quote(account_id)];")
	dbq.Execute()
	if(dbq.NextRow())
		return dbq.item[1]
	return FALSE

//=========================
// Money Transaction Account
//=========================
/datum/AccountDB/Bank/proc/AddTransaction(var/datum/transaction/T)
	if(!T) return
	if(!check_connection()) return
	var/DBQuery/dbq
	if(!T.__internal_idx)
		dbq = dbcon_master.NewQuery("INSERT INTO [BANK_TRANSACTION_TABLE] VALUES [T.to_sql()];")
	else
		dbq = dbcon_master.NewQuery("UPDATE [BANK_TRANSACTION_TABLE] SET ([T.to_sql()]) WHERE id = [T.__internal_idx];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/datum/AccountDB/Bank/proc/GetTransactions(var/account_id)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [BANK_TRANSACTION_TABLE] WHERE source = [dbcon_master.Quote(account_id)] OR target = [dbcon_master.Quote(account_id)];")
	dbq.Execute()
	var/list/datum/transaction/results = list()
	while(dbq.NextRow())
		var/datum/transaction/T = new()
		T.parse_row(dbq.GetRowData())
		results += T
	return results

/datum/AccountDB/Bank/proc/RemoveTransactions(var/account_id)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("DELETE FROM [BANK_TRANSACTION_TABLE] WHERE source = [dbcon_master.Quote(account_id)] OR target = [dbcon_master.Quote(account_id)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/datum/AccountDB/Bank/proc/RemoveTransaction(var/account_id)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("DELETE FROM [BANK_TRANSACTION_TABLE] WHERE id = [dbcon_master.Quote(account_id)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE
