//======================================================
//	CEO Access
//======================================================
/datum/world_faction/business/proc/get_ceo()
	return get_commander()

/datum/world_faction/business/proc/get_ceo_assignment_category()
	return get_commander_assignment_category()

/datum/world_faction/business/proc/get_ceo_wage()
	return get_commander_wage()

/datum/world_faction/business/proc/set_ceo(var/real_name)
	return set_commander(real_name)

//======================================================
//	CEO setup
//======================================================
/datum/world_faction/business/proc/setup_ceo(var/real_name)
	var/datum/assignment_category/ceo_cat = create_assignment_category(COMMANDER_ASSIGNMENT_UID)
	ceo_cat.name = "CEO"
	var/datum/assignment/ceoass = create_assignment(COMMANDER_ASSIGNMENT_UID, ceo_cat)
	ceoass.name = "CEO"
	set_member_assignment(real_name, COMMANDER_ASSIGNMENT_UID)
	return ceoass