
/proc/GetGlobalCrewRecord(var/name)
	return PSDB.crew_records.GetGlobalCrewRecord(name)

/proc/GetPlayerMaxSaveSlots(var/ckey)
	return PSDB.player.GetPlayerMaxSaveSlots(ckey)

// /datum/psdb
// 	var/const/CHAR_RECORDS_TABLE = "char_records"
// 	var/const/EMAIL_TABLE = "email_accounts"

// /datum/psdb/proc/check_connection()
// 	establish_master_db_connection()
// 	if(!dbcon_master.IsConnected())
// 		return FALSE
// 	return TRUE

// /datum/psdb/proc/fetch_email_account(var/address)
// 	var/list/datum/computer_file/data/email_account/L = _do_fetch_email_account("address = '[address]'")
// 	return (L && length(L))? L[1] : null
// /datum/psdb/proc/fetch_email_account_by_name(var/owner_name)
// 	var/list/datum/computer_file/data/email_account/L = _do_fetch_email_account("owner_name = '[owner_name]'")
// 	return (L && length(L))? L[1] : null

// /datum/psdb/proc/_do_fetch_email_account(var/condition)
// 	if(!check_connection()) return
// 	var/list/datum/computer_file/data/email_account/EA = list()
// 	var/DBQuery/select_query = dbcon_master.NewQuery("SELECT * FROM [EMAIL_TABLE] WHERE [condition]")
// 	select_query.Execute()
// 	while(select_query.NextRow())
// 		var/datum/computer_file/data/email_account/ACC = new()
// 		ACC.parse_row(select_query.GetRowData())
// 		EA.Add(ACC)
// 	return EA

// /datum/psdb/proc/_do_fetch_character_records(var/condition)
// 	if(!check_connection()) return
// 	var/list/datum/character_records/CL = list()
// 	var/DBQuery/select_query = dbcon_master.NewQuery("SELECT * FROM [CHAR_RECORDS_TABLE] WHERE [condition]")
// 	select_query.Execute()
// 	while(select_query.NextRow())
// 		var/datum/character_records/CR = new/datum/character_records()
// 		CR.parse_row(select_query.GetRowData())
// 		CL.Add(CR)
// 	return CL

// /datum/psdb/proc/fetch_character_record(var/real_name)
// 	var/list/records = _do_fetch_character_records("real_name = '[real_name]'")
// 	return (records && length(records))? records[1] : null

// /datum/psdb/proc/fetch_character_records_ckey(var/ckey)
// 	return _do_fetch_character_records("ckey = '[ckey]'")

// /datum/psdb/proc/commit_character_records_list(var/list/rowdata, var/real_name)
// 	if(!check_connection()) return
// 	var/fields = ""
// 	for(var/key in rowdata)
// 		var/val = rowdata[key]
// 		if(islist(val))
// 			val = list2params(val)
// 		else if(istext(val))
// 			val = "'[val]'"
// 		else if(isloc(val)) //isloc returns true if its an obj, area, mob, turf
// 			//We don't want to save those at all
// 			log_warning(" /datum/psdb/proc/commit_character_records(): Attempted to save a physical entity as part of character records!! [val]")
// 			val = "\ref[val]" //keep a ref at least
// 		else if(istype(val, /datum))
// 			var/datum/D = val
// 			D.before_save()
// 			val = datum2text(D)
// 			D.after_save()
// 		fields = "[fields][length(fields)? "," : ""] [key] = [val]"

// 	//Check if we already have an existing entry
// 	var/DBQuery/select_query = dbcon_master.NewQuery("SELECT * FROM [CHAR_RECORDS_TABLE] WHERE real_name = '[real_name]'")
// 	select_query.Execute()
// 	if(select_query.NextRow())
// 		//Overwrite
// 		dbcon_master.NewQuery("UPDATE [CHAR_RECORDS_TABLE] SET [fields] WHERE real_name = '[real_name]'").Execute()
// 	else
// 		//Insert
// 		dbcon_master.NewQuery("INSERT INTO [CHAR_RECORDS_TABLE] VALUES ([fields])").Execute()


// //Handy macros to add fieds to interact with
// #define MAKE_GET_FIELD(CON, TABLE, FIELD) /datum/psdb/proc/get_##TABLE_##FIELD(var/condition){var/DBQuery/dbq = CON.NewQuery("SELECT ##FIELD FROM ##TABLE [condition? "WHERE [condition]" : ""]");dbq.Execute();return dbq;}
// #define MAKE_SET_FIELD(CON, TABLE, FIELD) /datum/psdb/proc/set_##TABLE_##FIELD(var/value, var/condition){var/DBQuery/dbq = CON.NewQuery("UPDATE ##TABLE SET ##FIELD = [istext(value)? "'[value]'" : value] [condition? "WHERE [condition]" : ""]");dbq.Execute();return dbq;}

// #define MAKE_GET_TABLE_ROWS_FIELDS(CON, TABLE, FIELD) /datum/psdb/proc/get_rows_##TABLE(var/condition){var/DBQuery/dbq = CON.NewQuery("SELECT ##FIELD FROM ##TABLE [condition? "WHERE [condition]" : ""]");dbq.Execute();return dbq;}
// #define MAKE_GET_TABLE_ROWS(CON, TABLE, FIELD) MAKE_GET_TABLE_ROWS_FIELDS(CON,TABLE,*);
// #define MAKE_INSERT_TABLE_ROW(CON, TABLE)  /datum/psdb/proc/insert_rows_##TABLE(var/list/values){var/DBQuery/dbq = CON.NewQuery("INSERT INTO ##TABLE VALUES ([replacetext(list2text(values), "'", "\""])");dbq.Execute();return dbq;}

// #define MAKE_FIELD(FIELD, TABLE) MAKE_GET_FIELD(dbcon_master, TABLE, FIELD);MAKE_SET_FIELD(dbcon_master, TABLE, FIELD);MAKE_GET_TABLE_ROWS_FIELDS(dbcon_master,TABLE,FIELD);
// #define MAKE_TABLE(TABLE) MAKE_INSERT_TABLE_ROW(dbcon_master,TABLE);MAKE_GET_TABLE_ROWS(dbcon_master,TABLE);



