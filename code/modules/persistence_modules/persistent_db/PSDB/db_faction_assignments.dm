/datum/db_records/Faction
	var/const/FACTION_ASSIGNMENT_TABLE 			= "faction_assignments"
	var/const/FACTION_ASSIGNMENT_CATEGORY_TABLE = "faction_assignment_categories"

//=========================
// Loading Helper
//=========================
//Load all categories for a faction, and their assignments
/datum/db_records/Faction/proc/LoadAssignmentCategories(var/faction_uid)
	var/list/datum/assignment_category/categories = GetAssignmentCategories_ByFaction(faction_uid)
	if(!categories)
		return null
	for(var/datum/assignment_category/C in categories)
		var/list/datum/assignment/AL = GetAssignment_ByCategory(C.uid, faction_uid)
		for(var/datum/assignment/A in AL)
			C.add_assignment(A)
	return categories

/datum/db_records/Faction/proc/CommitAssignmentCategories(var/list/datum/assignment_category/CL)
	//Commit each categories
	for(var/datum/assignment_category/C in CL)
		if(!DoesAssignmentCategoryExists(C.faction_uid, C.uid))
			CreateAssignmentCategory(C.faction_uid, C.uid)
		SetAssignmentCategory(C.faction_uid, C.uid, C)

		//Then copy the assignments to their table
		for(var/key in C.assignments)
			var/datum/assignment/A = C.assignments[key]
			if(!DoesAssignmentExists(A.uid, C.faction_uid, A.category_uid))
				CreateAssignment(A.category_uid, A.uid, C.faction_uid)
			SetAssignment(A.category_uid, A.uid, C.faction_uid, A)

//=========================
// Assignments Categories
//=========================
/datum/db_records/Faction/proc/GetAssignmentCategories_ByFaction(var/faction_uid)
	return GetAssignmentCategories("faction_uid = [SQL_HELPER.Quote(faction_uid)]")
/datum/db_records/Faction/proc/GetAssignmentCategories_ByUID(var/uid)
	return GetAssignmentCategories("uid = [SQL_HELPER.Quote(uid)]")
/datum/db_records/Faction/proc/GetAssignmentCategories(var/condition)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT * FROM [FACTION_ASSIGNMENT_CATEGORY_TABLE] WHERE [condition];")
	dbq.Execute()
	var/list/datum/assignment_category/results = list()
	while(dbq.NextRow())
		var/datum/assignment_category/C = new()
		C.parse_row(dbq.GetRowData())
		results += C
	return results

/datum/db_records/Faction/proc/DoesAssignmentCategoryExists(var/faction_uid, var/category_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT uid FROM [FACTION_ASSIGNMENT_CATEGORY_TABLE] WHERE faction_uid = [SQL_HELPER.Quote(faction_uid)] AND uid = [SQL_HELPER.Quote(category_uid)];")
	dbq.Execute()
	return dbq.RowCount() > 0

/datum/db_records/Faction/proc/SetAssignmentCategory(var/faction_uid, var/category_uid, var/datum/assignment_category/cat)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("UPDATE [FACTION_ASSIGNMENT_CATEGORY_TABLE] SET [cat.to_sql()] WHERE faction_uid = [SQL_HELPER.Quote(faction_uid)] AND uid = [SQL_HELPER.Quote(category_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/CreateAssignmentCategory(var/faction_uid, var/category_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("INSERT INTO [FACTION_ASSIGNMENT_CATEGORY_TABLE] VALUES (uid = [SQL_HELPER.Quote(category_uid)], name = 'TEMPORARY', faction_uid = [SQL_HELPER.Quote(faction_uid)]);")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/DeleteAssignmentCategory(var/faction_uid, var/category_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("DELETE FROM [FACTION_ASSIGNMENT_CATEGORY_TABLE] WHERE faction_uid = [SQL_HELPER.Quote(faction_uid)] AND uid = [SQL_HELPER.Quote(category_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

//=========================
// Assignments
//=========================
/datum/db_records/Faction/proc/DoesAssignmentExists(var/assignment_uid, var/faction_uid, var/category_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT uid FROM [FACTION_ASSIGNMENT_TABLE] WHERE faction_uid = [SQL_HELPER.Quote(faction_uid)] AND category_uid = [SQL_HELPER.Quote(category_uid)] AND uid = [SQL_HELPER.Quote(assignment_uid)];")
	dbq.Execute()
	return dbq.RowCount() > 0

/datum/db_records/Faction/proc/GetAssignment_ByUID(var/uid, var/faction_uid)
	return GetAssignment("uid = [SQL_HELPER.Quote(uid)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)]")
/datum/db_records/Faction/proc/GetAssignment_ByCategory(var/category, var/faction_uid)
	return GetAssignment("category_uid = [SQL_HELPER.Quote(category)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)]")
/datum/db_records/Faction/proc/GetAssignment_ByFaction(var/faction_uid)
	return GetAssignment("faction_uid = [SQL_HELPER.Quote(faction_uid)]")
/datum/db_records/Faction/proc/GetAssignment(var/condition)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("SELECT * FROM [FACTION_ASSIGNMENT_TABLE] WHERE [condition];")
	dbq.Execute()
	var/list/datum/assignment/results = list()
	while(dbq.NextRow())
		var/datum/assignment/CR = new()
		CR.parse_row(dbq.GetRowData())
		results += CR
	return results

/datum/db_records/Faction/proc/SetAssignment(var/category_uid, var/assignment_uid, var/faction_uid, var/datum/assignment/ass)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("UPDATE [FACTION_ASSIGNMENT_TABLE] SET [ass.to_sql()] WHERE category_uid = [SQL_HELPER.Quote(category_uid)] AND uid = [SQL_HELPER.Quote(assignment_uid)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/CreateAssignment(var/category_uid, var/assignment_uid, var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("INSERT INTO [FACTION_ASSIGNMENT_TABLE] VALUES (uid = [SQL_HELPER.Quote(assignment_uid)], name = 'TEMPORARY', category_uid = [SQL_HELPER.Quote(category_uid)], faction_uid = [SQL_HELPER.Quote(faction_uid)]);")
	dbq.Execute()
	return dbq.RowsAffected() > 0

/datum/db_records/Faction/proc/DeleteAssignment(var/category_uid, var/assignment_uid, var/faction_uid)
	if(!PSDB.check_connection()) return
	var/DBQuery/dbq = PSDB.psdbcon.NewQuery("DELETE FROM [FACTION_ASSIGNMENT_TABLE] WHERE category_uid = [SQL_HELPER.Quote(category_uid)] AND uid = [SQL_HELPER.Quote(assignment_uid)] AND faction_uid = [SQL_HELPER.Quote(faction_uid)];")
	dbq.Execute()
	return dbq.RowsAffected() > 0

//=========================
// Assignments Parsing
//=========================
/datum/assignment/proc/parse_row(var/list/row)
	name 			= row["name"]
	uid 			= row["uid"]
	category_uid 	= row["category_uid"]
	base_pay 		= row["base_pay"]
	payscale 		= text2num(row["payscale"])
	task			= row["task"]
	flags			= text2num(row["flags"])
	expense_limit	= text2num(row["expense_limit"])
	allowed_access	= savedtext2list(row["allowed_access"])
	rank			= text2num(row["rank"])
	faction_uid 	= row["faction_uid"]

/datum/assignment/proc/to_sql()
	. =  "name           = [SQL_HELPER.Quote(name)],"
	. += "uid            = [SQL_HELPER.Quote(uid)],"
	. += "category_uid   = [SQL_HELPER.Quote(category_uid)],"
	. += "base_pay       = [base_pay],"
	. += "task           = [SQL_HELPER.Quote(task)],"
	. += "flags          = [flags],"
	. += "expense_limit  = [expense_limit]"
	. += "allowed_access = '[list2savedtext(allowed_access)]'"
	. += "rank           = [rank]"
	. += "faction_uid    = [SQL_HELPER.Quote(faction_uid)]"

//================================
// Assignments Category Parsing
//================================
/datum/assignment_category/proc/parse_row(var/list/row)
	name 				= row["name"]
	uid					= row["uid"]
	head_position_uid	= row["head_position_uid"]
	faction_uid			= row["faction_uid"]

/datum/assignment_category/proc/to_sql()
	. =  "name               = [SQL_HELPER.Quote(name)],"
	. += "uid                = [SQL_HELPER.Quote(uid)],"
	. += "head_position_uid  = [SQL_HELPER.Quote(head_position_uid)],"
	. += "faction_uid        = [SQL_HELPER.Quote(faction_uid)]"