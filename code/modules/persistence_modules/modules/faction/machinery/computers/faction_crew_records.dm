/datum/computer_file/report/crew_record/faction
	filetype = "FCDB"

/datum/computer_file/report/crew_record/faction/New()
	..()

/datum/computer_file/report/crew_record/faction/Destroy()
	QDEL_NULL_LIST(fields)
	if(holder)
		holder.remove_file(src)
	GLOB.destroyed_event && GLOB.destroyed_event.raise_event(src)
	cleanup_events(src)
	return QDEL_HINT_QUEUE

// Returns independent copy of this file.
/datum/computer_file/report/crew_record/faction/clone(var/rename = 0)
	var/datum/computer_file/report/crew_record/faction/temp = ..()
	return temp

//Used when completely changing work. Not used when promoting/demoting!!!
/datum/computer_file/report/crew_record/faction/proc/ChangeWork(var/new_work_uid)
	var/old_work = get_assignment_uid()
	try
		//Clear old work status
		set_work_status(WORK_STATUS_OFF_DUTY)
		set_employement_status(EMPLOYMENT_STATUS_UNEMPLOYED)
		set_last_clock_in(0)
		//Set new work
		set_assignment_uid(new_work_uid)
	catch
		set_assignment_uid(old_work)
	return TRUE

// /datum/computer_file/report/crew_record/faction/proc/try_duty()
// 	CRASH("UNIMPLEMENTED")
	// if(get_employement_status() != EMPLOYMENT_STATUS_EMPLOYED)
	// 	return 0
	// else
	// 	return get_assignment_uid()

// /datum/computer_file/report/crew_record/faction/proc/check_rank_change(var/datum/world_faction/faction)
// 	CRASH("UNIMPLEMENTED")
	// var/list/all_promotes = list()
	// var/list/three_promotes = list()
	// var/list/five_promotes = list()
	// var/list/all_demotes = list()
	// var/list/three_demotes = list()
	// var/list/five_demotes = list()
	// var/datum/assignment/curr_assignment = faction.get_assignment(assignment_uid, get_name())
	// if(!curr_assignment) return 0
	// for(var/name in promote_votes)
	// 	if(name == faction.get_leadername())
	// 		five_promotes |= name
	// 		three_promotes |= name
	// 		all_promotes |= name
	// 		continue
	// 	if(name == get_name()) continue
	// 	var/datum/computer_file/report/crew_record/record = faction.get_record(name)
	// 	if(record)
	// 		var/datum/assignment/assignment = faction.get_assignment(record.assignment_uid, record.get_name())
	// 		if(assignment)
	// 			if(assignment.parent)
	// 				var/promoter_command = (assignment.parent.command_faction)
	// 				var/promoter_head = (assignment.parent.head_position && assignment.parent.head_position.uid == assignment.uid)
	// 				var/curr_command = curr_assignment.parent.command_faction
	// 				var/curr_head = (curr_assignment.parent.head_position && curr_assignment.parent.head_position.uid == curr_assignment.uid)
	// 				var/same_dept = (assignment.parent.name == curr_assignment.parent.name)
	// 				if(promoter_command)
	// 					if(curr_command)
	// 						if(curr_head)
	// 							if(promoter_head)
	// 								if(record.rank <= rank)
	// 									continue
	// 							else
	// 								continue
	// 				else
	// 					if(curr_command) continue
	// 					if(curr_head && !promoter_head) continue
	// 					if(!same_dept) continue
	// 					if(promoter_head)
	// 						if(curr_head)
	// 							if(record.rank <= rank)
	// 								continue
	// 					else
	// 						if(record.rank <= rank)
	// 							continue

	// 	if(record.rank <= 5)
	// 		five_promotes |= record.get_name()
	// 	if(record.rank <= 3)
	// 		three_promotes |= record.get_name()
	// 	all_promotes |= record.get_name()


	// if(five_promotes.len >= faction.five_promote_req)
	// 	rank++
	// 	promote_votes.Cut()
	// 	demote_votes.Cut()
	// 	UpdateIds(get_name())
	// 	return
	// if(three_promotes.len >= faction.three_promote_req)
	// 	rank++
	// 	promote_votes.Cut()
	// 	demote_votes.Cut()
	// 	UpdateIds(get_name())
	// 	return
	// if(all_promotes.len >= faction.all_promote_req)
	// 	rank++
	// 	promote_votes.Cut()
	// 	demote_votes.Cut()
	// 	UpdateIds(get_name())
	// 	return
	// for(var/name in demote_votes)
	// 	if(name == faction.get_leadername())
	// 		five_demotes |= name
	// 		three_demotes |= name
	// 		all_demotes |= name
	// 		continue
	// 	if(name == get_name()) continue
	// 	var/datum/computer_file/report/crew_record/record = faction.get_record(name)
	// 	if(record)
	// 		var/datum/assignment/assignment = faction.get_assignment(record.assignment_uid, record.get_name())
	// 		if(assignment)
	// 			if(assignment.parent)
	// 				var/promoter_command = (assignment.parent.command_faction)
	// 				var/promoter_head = (assignment.parent.head_position && assignment.parent.head_position.uid == assignment.uid)
	// 				var/curr_command = curr_assignment.parent.command_faction
	// 				var/curr_head = (curr_assignment.parent.head_position && curr_assignment.parent.head_position.uid == curr_assignment.uid)
	// 				var/same_dept = (assignment.parent.name == curr_assignment.parent.name)
	// 				if(promoter_command)
	// 					if(curr_command)
	// 						if(curr_head)
	// 							if(promoter_head)
	// 								if(record.rank <= rank)
	// 									continue
	// 							else
	// 								continue
	// 				else
	// 					if(curr_command) continue
	// 					if(curr_head && !promoter_head) continue
	// 					if(!same_dept) continue
	// 					if(promoter_head)
	// 						if(curr_head)
	// 							if(record.rank <= rank)
	// 								continue
	// 					else
	// 						if(record.rank <= rank)
	// 							continue

	// 	if(record.rank <= 5)
	// 		five_demotes |= record.get_name()
	// 	if(record.rank <= 3)
	// 		three_demotes |= record.get_name()
	// 	all_demotes |= record.get_name()

	// if(five_demotes.len >= faction.five_promote_req)
	// 	rank--
	// 	promote_votes.Cut()
	// 	demote_votes.Cut()
	// 	UpdateIds(get_name())
	// 	return
	// if(three_demotes.len >= faction.three_promote_req)
	// 	rank--
	// 	promote_votes.Cut()
	// 	demote_votes.Cut()
	// 	UpdateIds(get_name())
	// 	return
	// if(all_demotes.len >= faction.all_promote_req)
	// 	rank--
	// 	promote_votes.Cut()
	// 	demote_votes.Cut()
	// 	UpdateIds(get_name())
	// 	return

/datum/computer_file/report/crew_record/faction/load_from_mob(var/mob/living/carbon/human/H)
	. = ..()
	if(!.)
		return .

	return TRUE

// /datum/computer_file/report/crew_record/faction/load_from_id(var/obj/item/weapon/card/id/card)
// 	. = ..()
// 	if(!.)
// 		return .

// 	return TRUE

/datum/computer_file/report/crew_record/faction/proc/load_from_global(var/real_name)
	var/datum/computer_file/report/crew_record/CR = GetGlobalCrewRecord(real_name)
	if(!CR)
		return FALSE
	//Copy them fields
	for(var/key in src.fields)
		if(CR.fields[key])
			src.fields[key].set_value(CR.fields[key].get_value())
	return TRUE


#define GETTER_SETTER(PATH, KEY) /datum/computer_file/report/crew_record/faction/proc/get_##KEY(){var/datum/report_field/F = locate(/datum/report_field/##PATH/##KEY) in fields; if(F) return F.get_value()} \
/datum/computer_file/report/crew_record/faction/proc/set_##KEY(given_value){var/datum/report_field/F = locate(/datum/report_field/##PATH/##KEY) in fields; if(F) F.set_value(given_value)}
#define SETUP_FIELD(NAME, KEY, PATH, ACCESS, ACCESS_EDIT) GETTER_SETTER(PATH, KEY); /datum/report_field/##PATH/##KEY;\
/datum/computer_file/report/crew_record/faction/generate_fields(){..(); var/datum/report_field/##KEY = add_field(/datum/report_field/##PATH/##KEY, ##NAME);\
KEY.set_access(ACCESS, ACCESS_EDIT || ACCESS || access_bridge)}

// Fear not the preprocessor, for it is a friend. To add a field, use one of these, depending on value type and if you need special access to see it.
// It will also create getter/setter procs for record datum, named like /get_[key here]() /set_[key_here](value) e.g. get_name() set_name(value)
// Use getter setters to avoid errors caused by typoing the string key.
#define FIELD_SHORT(NAME, KEY, ACCESS, ACCESS_EDIT) SETUP_FIELD(NAME, KEY, simple_text/crew_record, ACCESS, ACCESS_EDIT)
#define FIELD_LONG(NAME, KEY, ACCESS, ACCESS_EDIT) SETUP_FIELD(NAME, KEY, pencode_text/crew_record, ACCESS, ACCESS_EDIT)
#define FIELD_NUM(NAME, KEY, ACCESS, ACCESS_EDIT) SETUP_FIELD(NAME, KEY, number/crew_record, ACCESS, ACCESS_EDIT)
#define FIELD_LIST(NAME, KEY, OPTIONS, ACCESS, ACCESS_EDIT) FIELD_LIST_EDIT(NAME, KEY, OPTIONS, ACCESS, ACCESS_EDIT)
#define FIELD_LIST_EDIT(NAME, KEY, OPTIONS, ACCESS, ACCESS_EDIT) SETUP_FIELD(NAME, KEY, options/crew_record, ACCESS, ACCESS_EDIT);\
/datum/report_field/options/crew_record/##KEY/get_options(){return OPTIONS}

// === Employment stuff ===
FIELD_SHORT("Prefered Title", custom_title, null, access_change_ids)
FIELD_LIST_EDIT("Employment Status", employement_status, GLOB.employement_status, null, access_change_ids)
FIELD_SHORT("Assignment ID", assignment_uid, access_bridge, access_change_ids)
FIELD_LIST_EDIT("Work Status", work_status, GLOB.work_status, null, access_change_ids)
FIELD_SHORT("Last Clock In", last_clock_in, null, access_change_ids)
FIELD_SHORT("Last Pay", time_last_pay, null, access_change_ids)
//FIELD_SHORT("Faction UID", faction_uid, null, access_change_ids)

#undef GETTER_SETTER
#undef SETUP_FIELD
#undef FIELD_SHORT
#undef FIELD_LONG
#undef FIELD_NUM
#undef FIELD_LIST
#undef FIELD_LIST_EDIT