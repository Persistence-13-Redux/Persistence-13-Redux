/*
	Helper for editing custom faction accesses.
*/
////////////////////////////
// Access Datum Override
////////////////////////////
//Represents a type of access
/datum/access/faction
	id = "" //ID is generated when the access is initialized
	region = ACCESS_REGION_NONE
	access_type = ACCESS_TYPE_FACTION //Set to faction, so base bay doesn't attempt to do weirdness with out things
	var/faction_uid = ""
	var/access_name = "" //The name of the access. Like say, "maintenance", or "hallway door" or something like that

//Generates the access id from the faction uid and access name
/datum/access/faction/proc/setup(var/_factionuid, var/_access_name)
	faction_uid = _factionuid
	access_name = _access_name
	id = "[_factionuid]_[_access_name]"

//Sort proc set to order by faction_uid then access type then description
/datum/access/faction/dd_SortValue()
	return "[access_type][faction_uid][desc]"

////////////////////////////
// Base Types Overrides
////////////////////////////
/area
	var/req_faction = "" 

/obj
	var/req_access_faction = ""
	var/list/req_access_personal = list()

////////////////////////////
// Faction Overrides
////////////////////////////
/datum/world_faction/proc/get_access(var/real_name)
	var/datum/computer_file/report/crew_record/faction/CR = src.get_record(real_name)
	if(!CR)
		return
	var/datum/assignment/A = get_assignment(CR.get_assignment_uid(), real_name)
	return A?.allowed_access

//Returns a named list of all the custom accesses defined for the faction
/datum/world_faction/proc/get_all_accesses()
	return accesses

//Returns a list of list with all the fields of the each access, mainly for displaying in a ui
/datum/world_faction/proc/get_all_accesses_for_ui()
	var/list/data = list()
	for(var/key in accesses)
		var/datum/access/A = accesses[key]
		if(isnull(A))
			continue
		data["id"] = A.id
		data["desc"] = A.desc
	return