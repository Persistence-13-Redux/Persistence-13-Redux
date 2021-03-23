/datum/AccountDB
	var/datum/AccountDB/Email/email = new()

/datum/AccountDB/Email
	var/const/EMAIL_ACCOUNT_TABLE	= "email_accounts"
	var/const/EMAIL_MESSAGES_TABLE 	= "emails"

//=========================
// Email Account
//=========================
/datum/AccountDB/Email/proc/CreateEmailAccount(var/datum/computer_file/data/email_account/account)
	if(!account) return
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [EMAIL_ACCOUNT_TABLE] VALUES [account.to_sql()];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/datum/AccountDB/Email/proc/GetEmailAccountByName(var/realname)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [EMAIL_ACCOUNT_TABLE] WHERE owner_name = [dbcon_master.Quote(realname)];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/computer_file/data/email_account/A = new()
		A.parse_row(dbq.GetRowData())
		return A

/datum/AccountDB/Email/proc/GetEmailAccount(var/address)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [EMAIL_ACCOUNT_TABLE] WHERE address = [dbcon_master.Quote(address)];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/computer_file/data/email_account/A = new()
		A.parse_row(dbq.GetRowData())
		return A

/datum/AccountDB/Email/proc/CommitEmailAccount(var/datum/computer_file/data/email_account/account)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [EMAIL_ACCOUNT_TABLE] SET ([account.to_sql()]) WHERE address = [dbcon_master.Quote(account.login)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

//=========================
// Emails
//=========================
/datum/AccountDB/Email/proc/CreateEmailMessage(var/datum/computer_file/data/email_message/M)
	if(!check_connection()) return
	//Then add it to the table
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [EMAIL_MESSAGES_TABLE] VALUES [M.to_sql()];")
	dbq.Execute()
	if(!dbq.RowsAffected())
		return FALSE
	//Get the last id affected in the BD, and set it in the email message
	var/DBQuery/dbqID = dbcon_master.NewQuery("SELECT MAX(id) FROM [EMAIL_MESSAGES_TABLE];")
	dbqID.Execute()
	M.__internal_idx = 0
	if(dbqID.NextRow())
		var/list/dat = dbqID.GetRowData()
		M.__internal_idx = text2num(dat["id"])
	return M

/datum/AccountDB/Email/proc/GetEmailMessage(var/internal_index)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [EMAIL_MESSAGES_TABLE] WHERE id = [internal_index];")
	dbq.Execute()
	if(dbq.NextRow())
		var/datum/computer_file/data/email_message/M = new()
		M.parse_row(dbq.GetRowData())
		return M

/datum/AccountDB/Email/proc/GetEmailMessageBySender(var/sender_address)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [EMAIL_MESSAGES_TABLE] WHERE source = [dbcon_master.Quote(sender_address)];")
	dbq.Execute()
	var/list/datum/computer_file/data/email_message/ML = list()
	while(dbq.NextRow())
		var/datum/computer_file/data/email_message/M = new()
		M.parse_row(dbq.GetRowData())
		ML += M
	return ML

/datum/AccountDB/Email/proc/GetEmailMessageByReceiver(var/receiver_address)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [EMAIL_MESSAGES_TABLE] WHERE receiver = [dbcon_master.Quote(receiver_address)];")
	dbq.Execute()
	var/list/datum/computer_file/data/email_message/ML = list()
	while(dbq.NextRow())
		var/datum/computer_file/data/email_message/M = new()
		M.parse_row(dbq.GetRowData())
		ML += M
	return ML

/datum/AccountDB/Email/proc/CommitEmailMessage(var/datum/computer_file/data/email_message/M)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [EMAIL_MESSAGES_TABLE] SET ([M.to_sql()]) WHERE id = [M.__internal_idx];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

//=========================
// Overrides
//=========================

// ----------------- Email Accounts ----------------- 
/datum/computer_file/data/email_account/proc/parse_row(var/list/row)
	login = row["address"]
	fullname = row["account_name"]
	password = row["password"]
	suspended = row["suspended"]
	can_login = row["can_login"]

/datum/computer_file/data/email_account/proc/to_sql()
	. = "address = [dbcon_master.Quote(login)],"
	. += "account_name = [dbcon_master.Quote(fullname)],"
	. += "password = [dbcon_master.Quote(password)],"
	. += "suspended = [suspended != 0],"
	. += "can_login = [can_login != 0]"

// ----------------- Email Messages ----------------- 
/datum/computer_file/data/email_message
	var/__internal_idx = 0
	var/__internal_owner //Account owning the email, or null

/datum/computer_file/data/email_account/receive_mail(var/datum/computer_file/data/email_message/received_message, var/relayed)
	received_message.__internal_owner = login
	received_message = PSDB.email.CreateEmailMessage(received_message) //Add to database + update internal index for tracking purpose
	. = ..(received_message, relayed)

/datum/computer_file/data/email_message/proc/parse_row(var/list/row)
	__internal_idx 			= text2num(row["id"])
	__internal_owner 		= row["owner"]
	source 					= row["source"]
	title 					= row["title"]
	stored_data 			= row["stored_data"]
	attachment 				= text2datum(row["attachment"])
	spam 					= text2num(row["spam"])
	unread 					= text2num(row["unread"])
	metadata 				= row["metadata"]
	timestamp 				= row["timestamp"]
	

/datum/computer_file/data/email_message/proc/to_sql()
	. = "owner = '[__internal_owner]',"
	. += "source = '[source]',"
	. += "title = '[title]',"
	. += "stored_data = '[stored_data]',"
	. += "attachment = '[datum2text(attachment)]',"
	. += "spam = [spam != 0],"
	. += "unread = [unread != 0],"
	. += "metadata = '[metadata]',"
	. += "timestamp = '[timestamp]'"