/datum/db_records/Faction
	var/const/FACTION_CREW_RECORDS_TABLE 	= "faction_crew_records"
	var/FACTION_CREW_RECORDS_ALIASES = ""

/datum/db_records/Faction/New()
	. = ..()
	FACTION_CREW_RECORDS_ALIASES = {"
	[FACTION_CREW_RECORDS_TABLE].name AS name,
	[FACTION_CREW_RECORDS_TABLE].branch AS branch,
	[FACTION_CREW_RECORDS_TABLE].rank AS rank,
	[FACTION_CREW_RECORDS_TABLE].public_record AS public_record,
	[FACTION_CREW_RECORDS_TABLE].criminalStatus AS criminalStatus,
	[FACTION_CREW_RECORDS_TABLE].secRecord AS secRecord,
	[FACTION_CREW_RECORDS_TABLE].custom_title AS custom_title,
	[FACTION_CREW_RECORDS_TABLE].employement_status AS employement_status,
	[FACTION_CREW_RECORDS_TABLE].assignment_uid AS assignment_uid,
	[FACTION_CREW_RECORDS_TABLE].work_status AS work_status,
	*"} 

//=========================
// Faction Crew Records
//=========================

/*
*/
/datum/db_records/Faction/proc/CreateFactionCrewRecord(var/datum/computer_file/report/crew_record/faction/records, var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("INSERT INTO [FACTION_CREW_RECORDS_TABLE] VALUES faction_uid = [SQL_HELPER.Quote(faction_uid)], [records.to_sql()];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/*
*/
/datum/db_records/Faction/proc/RemoveFactionCrewRecord(var/real_name, var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("DELETE FROM [FACTION_CREW_RECORDS_TABLE] WHERE name = [SQL_HELPER.Quote(real_name)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/*
*/
/datum/db_records/Faction/proc/UpdateFactionCrewRecord(var/datum/computer_file/report/crew_record/faction/records, var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT * FROM [FACTION_CREW_RECORDS_TABLE] WHERE name = [SQL_HELPER.Quote(records.get_name())] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	if(dbq.NextRow())
		records.parse_row(dbq.GetRowData())
		return records

/*
*/
/datum/db_records/Faction/proc/CommitFactionCrewRecord(var/datum/computer_file/report/crew_record/faction/records, var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery({"
			UPDATE [FACTION_CREW_RECORDS_TABLE] 
			SET ([records.to_sql()]) 
			WHERE name = [SQL_HELPER.Quote(records.get_name())] AND 
				  faction_uid = [SQL_HELPER.Quote(faction_uid)];
		"})
	dbq.Execute()
	if(dbq.RowsAffected())
		return TRUE

/*
	Get a faction crew record for the given character name and search in the given faction
*/
/datum/db_records/Faction/proc/GetFactionCrewRecord(var/real_name, var/faction_uid)
	var/list/results = GetFactionCrewRecords("name = [SQL_HELPER.Quote(real_name)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)]")
	return LAZYLEN(results)? results[1] : null

/*
*/
/datum/db_records/Faction/proc/GetFactionCrewRecords_CKEY(var/ckey)
	return GetFactionCrewRecords("ckey = [SQL_HELPER.Quote(ckey)]")

/*
	Get the crew records of only those who are employed by the faction
*/
/datum/db_records/Faction/proc/GetFactionCrewRecords_Employes(var/faction_uid)
	return GetFactionCrewRecords({"
			faction_uid = [SQL_HELPER.Quote(faction_uid)] AND 
			employment_status IN ([SQL_HELPER.Quote(EMPLOYMENT_STATUS_EMPLOYED)], [SQL_HELPER.Quote(EMPLOYMENT_STATUS_SUSPENDED)]) AND 
			assignment_uid IS NOT NULL
		"})

/*
	Get all employees that are clocked in and have not been paid for "not_paid_for" time
*/
/datum/db_records/Faction/proc/GetFactionCrewRecords_EmployesToPay(var/faction_uid, var/not_paid_for)
	return GetFactionCrewRecords({"
			time_last_pay > [REALTIMEOFDAY - not_paid_for] AND
			work_status [GLOB.work_status_numbers[WORK_STATUS_ON_DUTY]] AND
			faction_uid = [SQL_HELPER.Quote(faction_uid)] AND 
			employment_status IN ([SQL_HELPER.Quote(EMPLOYMENT_STATUS_EMPLOYED)], [SQL_HELPER.Quote(EMPLOYMENT_STATUS_SUSPENDED)]) AND 
			assignment_uid IS NOT NULL
		"})

/*
*/
/datum/db_records/Faction/proc/GetFactionCrewRecords(var/condition)
	if(!PSDB.check_connection()) return
	//Since the inner join will give us columns with names we can're really use, set a few aliases

	//Run a inner join to get all the values we don't store in the faction record which are in the global record.
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery({"
		SELECT [FACTION_CREW_RECORDS_ALIASES] 
		FROM [FACTION_CREW_RECORDS_TABLE] 
		INNER JOIN [PSDB.crew_records.CREW_RECORDS_TABLE] ON [FACTION_CREW_RECORDS_TABLE].name = [PSDB.crew_records.CREW_RECORDS_TABLE].name 
		WHERE [condition];
	"})
	dbq.Execute()
	var/list/results = list()
	while(dbq.NextRow())
		var/datum/computer_file/report/crew_record/faction/CR = new()
		CR.parse_row(dbq.GetRowData())
		results += CR
	return results



/datum/db_records/Faction/proc/SetFactionCrewRecord_WorkStatus(var/real_name, var/faction_uid, var/is_on_duty)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery({"
		UPDATE [FACTION_CREW_RECORDS_TABLE] 
		SET [FACTION_CREW_RECORDS_TABLE].work_status = [is_on_duty] 
		WHERE name = [SQL_HELPER.Quote(real_name)] AND 
			faction_uid = [SQL_HELPER.Quote(faction_uid)];
	"})
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/CommitFactionCrewRecordFieldValue(var/real_name, var/faction_uid, var/field_ID, var/field_value)
	if(!PSDB.check_connection()) return
	var/value
	if(istext(field_value))
		value = SQL_HELPER.Quote(field_value)
	else
		value = field_value
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("UPDATE [FACTION_CREW_RECORDS_TABLE] SET [FACTION_CREW_RECORDS_TABLE].[field_ID] = [value] WHERE name = [SQL_HELPER.Quote(real_name)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0


/datum/db_records/Faction/proc/GetFactionEmployees_Names(var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT * FROM [FACTION_CREW_RECORDS_TABLE] WHERE employment_status = [SQL_HELPER.Quote(EMPLOYMENT_STATUS_EMPLOYED)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	var/list/membernames = list()
	while(dbq.NextRow())
		var/list/row = dbq.GetRowData()
		membernames += row["name"]
	return membernames

//=========================
// Overrides
//=========================
GLOBAL_LIST_INIT(work_status_numbers, list(WORK_STATUS_ON_DUTY = 0, WORK_STATUS_OFF_DUTY = 1))

/datum/computer_file/report/crew_record/faction/proc/get_work_status_as_num()
	return GLOB.work_status_numbers[get_work_status()]

/datum/computer_file/report/crew_record/faction/proc/set_work_status_as_num(var/status as num)
	status = between( 0, status, (length(GLOB.work_status_numbers) - 1) )
	set_work_status(GLOB.work_status_numbers[status + 1])

// /datum/computer_file/report/crew_record/faction/to_sql()
// 	//Make sure we only save the fields we can actually save only
// 	. = {"
// 	name = [SQL_HELPER.Quote(get_name())],
// 	branch = [SQL_HELPER.Quote(get_branch())],
// 	rank = [SQL_HELPER.Quote(get_rank())],
// 	public_record = [SQL_HELPER.Quote(get_public_record())],
// 	criminalStatus = [SQL_HELPER.Quote(get_criminalStatus())],
// 	secRecord = [SQL_HELPER.Quote(get_secRecord())],
// 	custom_title = [SQL_HELPER.Quote(get_custom_title())],
// 	employement_status = [SQL_HELPER.Quote(get_employement_status())],
// 	assignment_uid = [SQL_HELPER.Quote(get_assignment_uid())],
// 	work_status = [get_work_status_as_num()]
// 	"}

