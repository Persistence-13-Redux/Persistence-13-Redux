
/datum/assignment_category
	var/name
	var/uid
	var/list/assignments = list()
	var/head_position_uid
	// var/datum/world_faction/parent
	var/faction_uid
	var/tmp/datum/world_faction/_faction_ref
	//Demotion/Promotion caches
	var/list/_assignments_by_rank = list() //(index = assignment uid)
	//var/command_faction = FALSE
	//var/member_faction = TRUE
	//var/account_status = FALSE
// 	var/datum/money_account/account
	var/overall_rank = 0 //Rank of the assignments. 0 is higher, and 1+ is lower

// /datum/assignment_category/proc/create_account()
// 	account = create_account(name, 0)

/datum/assignment_category/New(var/uid, var/title, var/faction_uid)
	. = ..()
	src.uid = uid
	src.name = title
	src.faction_uid = faction_uid
	src._faction_ref = null

/datum/assignment_category/Destroy()
	QDEL_NULL_LIST(assignments)
	return ..()

/datum/assignment_category/proc/get_faction()
	if(!faction_uid)
		return null
	if(!_faction_ref)
		_faction_ref = FindFaction(faction_uid)
	return _faction_ref

/datum/assignment_category/proc/add_assignment(var/datum/assignment/ass, var/ass_rank = -1)
	if(!ass)
		log_error(" /datum/assignment_category/proc/add_assignment(): Got null assignment!")
		return FALSE
	if(ass_rank == -1 || !isnum(ass_rank))
		ass_rank = ass.rank
	if(_assignments_by_rank[ass_rank])
		var/datum/assignment/old_ass = (_assignments_by_rank[ass_rank])? assignments[_assignments_by_rank[ass_rank]] : null
		log_warning(" /datum/assignment_category/proc/add_assignment(): Tried to add assignment '[ass.uid]'-'[ass.name]' with same rank([ass.rank]) as '[old_ass?.uid]'-'[old_ass?.name]' with rank [old_ass.rank]!")
		return FALSE
	ass.category_uid = src.uid
	ass.faction_uid  = src.faction_uid
	ass.rank = ass_rank
	assignments[ass.uid] = ass
	_assignments_by_rank[ass_rank] = ass.uid
	return TRUE

/datum/assignment_category/proc/rem_assignment(var/uid)
	if(assignments[uid])
		var/datum/assignment/ass = assignments[uid]
		_assignments_by_rank -= ass.uid
		ass.category_uid = null
		ass.faction_uid  = null
		assignments[uid] = null
		return TRUE
	return FALSE

/datum/assignment_category/proc/set_head_position_uid(var/uid)
	if(assignments[uid])
		src.head_position_uid = uid
		// src.overall_rank = 0 //Highest rank
		return TRUE
	return FALSE

/datum/assignment_category/proc/get_promotion_assignment(var/current_assignment_uid)
	var/datum/assignment/current_assignment = assignments[current_assignment_uid]
	if(!current_assignment || !_assignments_by_rank[current_assignment.rank])
		return null 
	var/next_assignment_rank = current_assignment.rank + 1
	if(next_assignment_rank > length(_assignments_by_rank))
		return null
	return assignments[_assignments_by_rank[next_assignment_rank]]

//Return either the assignment lower than this one by one, or more
/datum/assignment_category/proc/get_demotion_assignment(var/current_assignment_uid)
	var/datum/assignment/current_assignment = assignments[current_assignment_uid]
	if(!current_assignment || !_assignments_by_rank[current_assignment.rank])
		return null 
	var/prev_assignment_rank = current_assignment.rank - 1
	if(prev_assignment_rank < 1)
		return null
	return assignments[_assignments_by_rank[prev_assignment_rank]]

//Promotion stuff
/datum/assignment_category/proc/try_promotion(var/employe_name)
	if(!employe_name || !can_promote(employe_name))
		return
	var/datum/world_faction/F = src.get_faction()
	if(!F)
		log_error(" /datum/assignment_category/proc/try_promotion(): Non-existent faction '[faction_uid]'!")
		return
	var/assignment_uid = F.get_member_assignment_uid(employe_name)
	var/datum/assignment/target_assignment = get_promotion_assignment(assignment_uid)
	if(!target_assignment)
		return
	F.set_member_assignment(employe_name, target_assignment.uid)
	return target_assignment.uid

/datum/assignment_category/proc/try_demotion(var/employe_name)
	if(!employe_name || !can_demote(employe_name))
		return FALSE
	var/datum/world_faction/F = src.get_faction()
	if(!F)
		log_error(" /datum/assignment_category/proc/try_demotion(): Non-existent faction '[faction_uid]'!")
		return
	var/assignment_uid = F.get_member_assignment_uid(employe_name)
	var/datum/assignment/target_assignment = get_demotion_assignment(assignment_uid)
	if(!target_assignment)
		return
	F.set_member_assignment(employe_name, target_assignment.uid)
	return target_assignment.uid

/datum/assignment_category/proc/can_promote(var/employe_name)
	if(!employe_name)
		log_warning(" /datum/assignment_category/proc/can_promote() : Got null employe name!")
		return FALSE
	var/datum/world_faction/F = src.get_faction()
	if(F)
		log_error(" /datum/assignment_category/proc/can_promote(): Non-existent faction '[faction_uid]'!")
		return FALSE
	var/assignment_uid = F.get_member_assignment_uid(employe_name)
	return !isnull(get_promotion_assignment(assignment_uid))

/datum/assignment_category/proc/can_demote(var/employe_name)
	if(!employe_name)
		log_warning(" /datum/assignment_category/proc/can_demote() : Got null employe name!")
		return FALSE
	var/datum/world_faction/F = src.get_faction()
	if(F)
		log_error(" /datum/assignment_category/proc/can_demote(): Non-existent faction '[faction_uid]'!")
		return FALSE
	var/assignment_uid = F.get_member_assignment_uid(employe_name)
	return !isnull(get_demotion_assignment(assignment_uid))

//
//
//
var/const/ASSIGNMENT_FLAG_CAN_CLOCK_IN 			= 1
var/const/ASSIGNMENT_FLAG_ALLOW_REASSIGNMENT 	= 2
var/const/ASSIGNMENT_FLAG_EDIT_AUTHORITY 		= 4
var/const/ASSIGNMENT_FLAG_AUTHORITY_RESTRICTION = 8

/datum/assignment
	var/name
	var/uid
	//var/list/accesses = list()
	// var/datum/assignment_category/parent
	var/faction_uid
	var/category_uid
	var/base_pay
	var/payscale = 1.0
	//var/list/ranks = list() // format-- list("Apprentice Engineer (2)" = "1.1", "Journeyman Engineer (3)" = "1.2")
	//var/duty_able = TRUE
	//var/cryo_net = "default"
	//var/any_assign = FALSE // this makes it so that the assignment can be assigned by anyone with the reassignment access,
	var/task
	// var/edit_authority = TRUE
	// var/authority_restriction = TRUE
	var/flags = ASSIGNMENT_FLAG_CAN_CLOCK_IN | ASSIGNMENT_FLAG_EDIT_AUTHORITY | ASSIGNMENT_FLAG_AUTHORITY_RESTRICTION
	var/expense_limit = 0
	var/list/allowed_access = list()
	var/rank = 1 //Rank of the assignment in the current category. Promotions will increase to the next assignment with a higher rank in the same category

/datum/assignment/New(var/uid, var/title, var/datum/assignment_category/parent = null)
	. = ..()
	src.uid = uid
	src.name = title
	src.category_uid = parent?.uid
	parent?.add_assignment(src)
	// if(title && pay)
	// 	var/datum/accesses/access = new()
	// 	access.name = title
	// 	access.pay = pay
	// 	accesses |= access

/datum/assignment/proc/can_clock_in()
	return flags & ASSIGNMENT_FLAG_CAN_CLOCK_IN
/datum/assignment/proc/can_be_reassigned()
	return flags & ASSIGNMENT_FLAG_ALLOW_REASSIGNMENT
/datum/assignment/proc/has_edit_authority()
	return flags & ASSIGNMENT_FLAG_EDIT_AUTHORITY
/datum/assignment/proc/has_authority_restriction()
	return flags & ASSIGNMENT_FLAG_AUTHORITY_RESTRICTION

/datum/assignment/proc/get_title()
	return name
/datum/assignment/proc/get_pay()
	return base_pay * payscale

/datum/assignment/proc/add_allowed_access(var/access)
	allowed_access |= access
/datum/assignment/proc/rem_allowed_access(var/access)
	allowed_access -= access
/datum/assignment/proc/get_access()
	return allowed_access