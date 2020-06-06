//TODO
/*
	Store the rank in the crew record. Store the category uid in the records, so we can just pick the correct assignment by their rank in the category
*/


/*
	Helper for editing custom faction assignments.
*/
var/const/COMMANDER_ASSIGNMENT_UID = "COMMANDER" //Used for both the category and actual assignment

//======================================================
//	Helper
//======================================================
//Load assignemnts from DB
/datum/world_faction/proc/load_assignments()
	if(!uid)
		return
	var/list/datum/assignment_category/loaded = PSDB.factions.LoadAssignmentCategories(src.uid)
	if(!LAZYLEN(loaded))
		return 
	//Organize the table properly
	src.assignments = list()
	for(var/list/datum/assignment_category/cur in loaded)
		src.assignments[cur.uid] = cur

//Ideally, don't use this for saving things to the DB. Ideally, we want each removal and addition be a single transaction with the DB, 
//	otherwise, things can get messy with orphanned records and etc..
/datum/world_faction/proc/commit_assignments()
	if(!uid)
		return
	var/list/datum/assignment_category/indexed = list()
	for(var/key in assignments)
		if(!assignments[key])
			continue
		indexed += assignments[key]
	PSDB.factions.CommitAssignmentCategories(src.uid, indexed)
	
//======================================================
//	Commander stuff
//======================================================
/datum/world_faction/proc/get_commander()
	return owner_name

/datum/world_faction/proc/get_commander_assignment_category()
	return assignments[COMMANDER_ASSIGNMENT_UID]

/datum/world_faction/proc/get_commander_assignment()
	var/datum/assignment_category/AC = get_commander_assignment_category()
	if(!AC || !LAZYLEN(AC?.assignments))
		return null
	return AC.assignments[COMMANDER_ASSIGNMENT_UID]

/datum/world_faction/proc/get_commander_wage()
	var/datum/assignment/A = get_commander_assignment() //Get the actual assignment
	return A.base_pay * A.payscale

/datum/world_faction/proc/set_commander(var/real_name)
	if(!real_name || owner_name == real_name)
		return FALSE

	//Get rid of the old
	var/old_commander = owner_name
	var/datum/computer_file/report/crew_record/faction/OldComRec = get_record(old_commander)
	if(OldComRec)
		OldComRec.ChangeWork(null)
		owner_name = null
	
	//Set the new one
	var/datum/assignment/CommanderAssignment = get_commander_assignment()
	var/datum/computer_file/report/crew_record/faction/NewComRec = get_record(real_name)
	if(isnull(NewComRec))
		. = add_member(real_name, CommanderAssignment.uid) //Try creating a record for the new one
	else
		. = NewComRec.ChangeWork(CommanderAssignment.uid)
	if(.)
		owner_name = real_name

//======================================================
//	Set/Get Assignments
//======================================================
/datum/world_faction/proc/get_assignment(var/uid)
	if(!uid) 
		return null
	for(var/key in assignments)
		if(!assignments[key])
			continue
		var/datum/assignment_category/cat = assignments[key]
		if(cat.assignments[uid])
			return cat.assignments[uid]
	return null

//Returns the category with the specified uid
/datum/world_faction/proc/get_assignment_category(var/uid)
	if(!uid) 
		return null
	return assignments[uid]

//Returns the assignment category an assignment is in
/datum/world_faction/proc/get_assignment_category_for_assignment(var/assignment_uid)
	if(!assignment_uid) 
		return null
	for(var/key in assignments)
		if(!assignments[key])
			continue
		var/datum/assignment_category/cat = assignments[key]
		if(cat.assignments[assignment_uid])
			return cat
	return null

/datum/world_faction/proc/get_assignment_categories()
	return assignments

/datum/world_faction/proc/get_all_assignments()
	var/list/datum/assignment/all_assignments = list()
	for(var/key in assignments)
		var/datum/assignment_category/cat = assignments[key]
		all_assignments.Insert(length(all_assignments), cat.assignments)
	return all_assignments

//===============================
//	Member Assignment
//===============================
/datum/world_faction/proc/get_member_assignement_rank(var/real_name)
	var/datum/assignment/A = get_member_assignment(real_name)
	return A?.rank

/datum/world_faction/proc/get_member_assignment(var/employe_name)
	var/uid = get_member_assignment_uid(employe_name)
	if(!uid)
		return
	return get_assignment(uid)

/datum/world_faction/proc/get_member_assignment_uid(var/employe_name)
	var/datum/computer_file/report/crew_record/faction/CR = src.get_record(employe_name)
	if(!CR)
		return
	return CR.get_assignment_uid()

/datum/world_faction/proc/get_member_assignment_category_uid(var/employe_name)
	var/datum/computer_file/report/crew_record/faction/CR = src.get_record(employe_name)
	if(!CR)
		return
	var/assignment_uid = CR.get_assignment_uid()
	if(!assignment_uid)
		return
	var/datum/assignment_category/C = get_assignment_category_for_assignment(assignment_uid)
	return C?.uid

/*
	Find the assignment category that a given employe's assignment is in.
*/
/datum/world_faction/proc/get_member_assignment_category(var/employe_name)
	var/datum/computer_file/report/crew_record/faction/CR = src.get_record(employe_name)
	if(!CR)
		return
	var/assignment_uid = CR.get_assignment_uid()
	if(!assignment_uid)
		return
	return get_assignment_category_for_assignment(assignment_uid)

/*
	Set and commit a member's assignment
*/
/datum/world_faction/proc/set_member_assignment(var/employe_name, var/assignment_uid)
	var/datum/computer_file/report/crew_record/faction/CR = src.get_record(employe_name)
	if(!CR)
		return FALSE
	CR.set_assignment_uid(assignment_uid)
	PSDB.factions.CommitFactionCrewRecord(CR, uid)

//===============================
// 	Member Promotion
//===============================

/*
	Handle properly promoting an employe of the faction. Emit the neccessary events.
*/
/datum/world_faction/proc/promote_member(var/employe_name)
	if(!employe_name)
		return FALSE
	var/old_assignment_uid = get_member_assignment_uid(employe_name)
	var/datum/assignment_category/C = get_member_assignment_category(employe_name)
	. = C?.try_promotion(employe_name)
	//Send the event
	if(.)
		OnMemberPromote(employe_name, old_assignment_uid, .)

/*
	Handle properly demoting an employe of the faction. Emit the neccessary events.
*/
/datum/world_faction/proc/demote_member(var/employe_name)
	if(!employe_name)
		return FALSE
	var/old_assignment_uid = get_member_assignment_uid(employe_name)
	var/datum/assignment_category/C = get_member_assignment_category(employe_name)
	. = C?.try_demotion(employe_name)
	//Send the event
	if(.)
		OnMemberDemote(employe_name, old_assignment_uid, .)

/*
	Check whether an employe can be promoted, depending on its assignment category and whether anything special might prevent it.
*/
/datum/world_faction/proc/can_promote_member(var/employe_name)
	if(!employe_name)
		return FALSE
	var/datum/assignment/A = get_member_assignment(employe_name)
	var/datum/assignment_category/C = get_assignment_category_for_assignment(A?.uid)
	return C?.can_promote(A?.uid)

/*
	Check whether an employe can be demoted, depending on its assignment category and whether anything special might prevent it.
*/
/datum/world_faction/proc/can_demote_member(var/employe_name)
	if(!employe_name)
		return FALSE
	var/datum/assignment/A = get_member_assignment(employe_name)
	var/datum/assignment_category/C = get_assignment_category_for_assignment(A?.uid)
	return C?.can_demote(A?.uid)

//======================================================
//	Assignment Creations
//======================================================

/*
	Creates a brand new, empty, assignment category, and returns it.
*/
/datum/world_faction/proc/create_assignment_category(var/cat_uid, var/cat_title)
	if(assignments[cat_uid])
		return assignments[cat_uid] //If it already exists, just return it
	var/datum/assignment_category/new_cat = new(cat_uid, cat_title, src.uid)
	assignment_categories[cat_uid] = new_cat

	PSDB.factions.CreateAssignmentCategory(src.uid, cat_uid)
	PSDB.factions.SetAssignmentCategory(src.uid, cat_uid, new_cat)
	return new_cat

/*
	Creates a brand new assignment into the given assignment category, and returns it.
*/
/datum/world_faction/proc/create_assignment(var/ass_uid, var/ass_title, var/datum/assignment_category/parent)
	if(isnull(parent))
		parent = create_assignment_category(ass_uid, ass_title) //If no parents, create one with the same uid
	var/datum/assignment/new_ass = new(ass_uid, ass_title, parent)
	parent.add_assignment(new_ass)

	PSDB.factions.CreateAssignment(parent.uid, ass_uid, src.uid)
	PSDB.factions.SetAssignment(parent.uid, ass_uid, src.uid, new_ass)
	return new_ass

//======================================================
//	Assignment Removal
//======================================================
/datum/world_faction/proc/delete_assignment(var/ass_uid, var/category_uid)
	var/datum/assignment_category/cat = assignments[category_uid]
	if(!cat)
		return FALSE
	var/datum/assignment/ass = cat.assignments[ass_uid]
	if(!ass)
		return FALSE
	if(!PSDB.factions.DeleteAssignment(cat.uid, ass.uid))
		log_error("Error when deleting assignment uid = '[ass.uid]', category uid = '[cat.uid]', for faction uid = '[src.uid]'!")
	cat.rem_assignment(ass.uid)
	//#TODO: maybe revoke assigments?
	return TRUE

/datum/world_faction/proc/delete_assignment_category(var/cat_uid)
	var/datum/assignment_category/cat = assignments[cat_uid]
	if(!cat)
		return FALSE
	//#TODO: Maybe revoke assignments?
	if(!PSDB.factions.DeleteAssignmentCategory(cat.faction_uid, cat.uid))
		log_error("Error when deleting assignment category uid = '[cat.uid]', for faction uid = '[src.uid]'!")
	QDEL_NULL(assignments[cat.uid])
	return TRUE

//======================================================
//	Assignment Setup
//======================================================

/*
	Properly assign a commander for the faction, by character name. Then returns the assignment.
*/
/datum/world_faction/proc/setup_commander(var/real_name)
	var/datum/assignment_category/commander_cat = get_assignment_category(COMMANDER_ASSIGNMENT_UID)
	var/datum/assignment/commanderass = get_assignment(COMMANDER_ASSIGNMENT_UID)
	//If the category and assignment don't exist already, create them
	if(!commander_cat)
		commander_cat = create_assignment_category(COMMANDER_ASSIGNMENT_UID)
		commander_cat.name = "Commander"
	if(!commanderass)
		commanderass = create_assignment(COMMANDER_ASSIGNMENT_UID, commander_cat)
		commanderass.name = "Commander"
	//Then assign the new commander
	set_member_assignment(real_name, COMMANDER_ASSIGNMENT_UID)
	return commanderass
