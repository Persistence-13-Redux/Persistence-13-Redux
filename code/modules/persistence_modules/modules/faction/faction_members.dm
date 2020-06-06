/*
	Procs to handle faction members
*/

/datum/world_faction/proc/get_leadername()
	return owner_name

//===============================
//	Memeber Records
//===============================
/datum/world_faction/proc/add_member(var/real_name, var/assignment_uid = null)
	if(isnull(real_name))
		return
	var/datum/computer_file/report/crew_record/faction/CR = new()
	CR.load_from_global(real_name)
	if(assignment_uid)
		CR.set_assignment_uid(assignment_uid)
	PSDB.factions.CreateFactionCrewRecord(CR, src.uid)
	records_byname[real_name] = CR
	return CR

/datum/world_faction/proc/remove_member(var/real_name)
	if(isnull(real_name))
		return
	records_byname[real_name] = null
	PSDB.factions.RemoveFactionCrewRecord(real_name, src.uid)

/datum/world_faction/proc/get_record(var/real_name)
	if(isnull(real_name))
		return
	if(records_byname[real_name])
		return records_byname[real_name]
	var/datum/computer_file/report/crew_record/faction/FR = PSDB.factions.GetFactionCrewRecord(real_name, src.uid)
	if(!FR)
		return null
	records_byname[real_name] = FR
	return FR

/datum/world_faction/proc/get_members_names()
	return PSDB.factions.GetFactionEmployees_Names(src.uid)

/datum/world_faction/proc/get_members_records()
	var/list/datum/computer_file/report/crew_record/faction/Records = list()
	var/list/members_names = get_members_names()
	for(var/employe in members_names)
		Records[employe] = get_record(employe)
	return Records

