/datum/AccountDB
	var/datum/AccountDB/CrewRecords/crew_records = new()

/datum/AccountDB/CrewRecords
	var/const/CREW_RECORDS_TABLE = "crew_records"

//=========================
// Records
//=========================
/datum/AccountDB/CrewRecords/proc/CreateGlobalCrewRecord(var/datum/computer_file/report/crew_record/records)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [CREW_RECORDS_TABLE] VALUES [records.to_sql()];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/datum/AccountDB/CrewRecords/proc/RemoveGlobalCrewRecord(var/real_name)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("DELETE FROM [CREW_RECORDS_TABLE] WHERE name = [dbcon_master.Quote(real_name)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/datum/AccountDB/CrewRecords/proc/GetGlobalCrewRecord(var/real_name)
	var/list/results = GetGlobalCrewRecords("name = [dbcon_master.Quote(real_name)]")
	return LAZYLEN(results)? results[1] : null

/datum/AccountDB/CrewRecords/proc/GetGlobalCrewRecords(var/condition)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [CREW_RECORDS_TABLE] WHERE [condition];")
	dbq.Execute()
	var/list/results = list()
	while(dbq.NextRow())
		var/datum/computer_file/report/crew_record/CR = new()
		CR.parse_row(dbq.GetRowData())
		results += CR
	return results

//Update the specified crew report to be up to date
/datum/AccountDB/CrewRecords/proc/UpdateGlobalCrewRecord(var/datum/computer_file/report/crew_record/records)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [CREW_RECORDS_TABLE] WHERE name = [dbcon_master.Quote(records.get_name())];")
	dbq.Execute()
	if(dbq.NextRow())
		records.parse_row(dbq.GetRowData())
		return records

/datum/AccountDB/CrewRecords/proc/GetGlobalCrewRecords_CKEY(var/ckey)
	return GetGlobalCrewRecords("ckey = [dbcon_master.Quote(ckey)]")

/datum/AccountDB/CrewRecords/proc/CommitGlobalCrewRecord(var/datum/computer_file/report/crew_record/records)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [CREW_RECORDS_TABLE] SET ([records.to_sql()]) WHERE name = [dbcon_master.Quote(records.get_name())];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/AccountDB/CrewRecords/proc/CommitFieldValue(var/real_name, var/datum/report_field/field)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [CREW_RECORDS_TABLE] SET ([field.to_sql()]) WHERE name = [dbcon_master.Quote(real_name)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

//=========================
// Overrides
//=========================

//----------------- Crew Reports ----------------- 
//Called when we should commit our changes
/datum/computer_file/report/proc/report_changed()
	return
/datum/computer_file/report/crew_record/report_changed()
	PSDB.crew_records.CommitGlobalCrewRecord(src)
/datum/computer_file/report/crew_record/faction/report_changed()
	return //Don't commit faction crew records!!

//Called when we should present up to date values to the user
/datum/computer_file/report/proc/update_report()
	return
/datum/computer_file/report/crew_record/update_report()
	PSDB.crew_records.UpdateGlobalCrewRecord(src)
/datum/computer_file/report/crew_record/faction/update_report()
	return //Don't update faction crew records!!

//Called to update only the field in the Database
/datum/computer_file/report/crew_record/proc/update_field_only(var/datum/report_field/field)
	return
/datum/computer_file/report/crew_record/update_field_only(var/datum/report_field/field)
	PSDB.crew_records.CommitFieldValue(src.get_name(), field.ID, field.value)
/datum/computer_file/report/crew_record/faction/update_field_only(var/datum/report_field/field)
	PSDB.factions.CommitFactionCrewRecordFieldValue(src.get_name(), src.get_faction(), field.ID, field.value)

//Sanitizes and sets the value from input.
/datum/report_field/set_value(given_value)
	. = ..()
	owner.report_changed()
/datum/report_field/simple_text/set_value(given_value)
	. = ..()
	owner.report_changed()
/datum/report_field/pencode_text/set_value(given_value)
	. = ..()
	owner.report_changed()
/datum/report_field/time/set_value(given_value)
	. = ..()
	owner.report_changed()
/datum/report_field/date/set_value(given_value)
	. = ..()
	owner.report_changed()
/datum/report_field/number/set_value(given_value)
	. = ..()
	owner.report_changed()
/datum/report_field/options/set_value(given_value)
	. = ..()
	owner.report_changed()

//When we need to provide up to date info
/datum/report_field/get_value()
	owner.update_report()
	. = ..()
/datum/report_field/pencode_text/get_value()
	owner.update_report()
	. = ..()
/datum/report_field/signature/get_value()
	owner.update_report()
	. = ..()

//Sql stuff
/datum/computer_file/report/crew_record/proc/parse_row(var/list/row)
	for(var/datum/report_field/F in fields)
		F.parse_row(row)
	if(row["photo_front"])
		photo_front = row["photo_front"]
	if(row["photo_side"])
		photo_side = row["photo_side"]

/datum/computer_file/report/crew_record/proc/to_sql()
	var/list/all_fields = list()
	. = ""
	for(var/datum/report_field/F in fields)
		all_fields += F.to_sql()
	all_fields += text("photo_front = []", photo_front)
	all_fields += text("photo_side = []", photo_side)
	return all_fields.Join(", ")

/datum/report_field/proc/parse_row(var/list/row)
	if(!(src.name in row))
		return
	value = row[src.name] //All field values are usually stored as text

/datum/report_field/proc/to_sql()
	return text("[] = []", name, dbcon_master.Quote(value))