GLOBAL_RAW(/list/datum/world_faction/all_world_factions);GLOBAL_UNMANAGED(all_world_factions, null); //Don't init as empty list, because it happens too late during init

// //Status Flags for the faction
// var/const/FACTION_STATUS_FLAG_ACTIVE	= 1 //Whether the business/faction is Opened/Closed
// var/const/FACTION_STATUS_FLAG_PENDING 	= 2 //Whether the faction is awaiting finalization or not
// var/const/FACTION_STATUS_FLAG_TERMINATED= 4 //Whether the faction was terminated and shouldn't be considered an existing faction anymore

// /datum/records_holder
// 	var/use_standard = 1
// 	var/list/custom_records = list() // format-- list("")
// 	var/list/faction_records = list() // stores all employee record files, format-- list("[M.real_name]" = /datum/crew_record)

// FACTIONs
/datum/world_faction
	//var/name 					// can be safely changed
	//var/abbreviation			// can be safely changed
	//var/short_tag				// This can be safely changed as long as it doesn't conflict
	//var/purpose					// can be safely changed
	//var/uid						// THIS SHOULD NEVER BE CHANGED!
	//var/password				// this is used to access the faction, can be safely changed

	var/list/assignment_categories = list()
	var/list/access_categories = list()
	var/list/all_access = list() // format list("10", "11", "12", "13") used to determine which accesses are already given out.
	var/list/all_assignments

	//var/tmp/datum/records_holder/records
	//var/tmp/datum/ntnet/faction/network
	//var/newtork_uid								//uid of the faction network
	//var/network_flags 							//Settings saved for the associated network
	//var/tmp/datum/money_account/central_account		//Ref on the bank account
	//var/central_account_id						//Account number of the bank account 

	//var/tmp/list/connected_laces = list()
	var/tmp/list/worker_shifts = list()

	// var/all_promote_req = 3
	// var/three_promote_req = 2
	// var/five_promote_req = 1

	//var/payrate = 100
	
	//var/list/debts = list() // format list("Ro Laren" = "550") real_name = debt amount
	//var/list/unpaid = list()

	//var/list/cryo_networks = list() // "default" is always a cryo_network

	//var/hiring_policy = 0 // if hiring_policy, anyone with reassignment can add people to the network, else only people in command a command category with reassignment can add people
	var/tmp/last_expense_print = 0

	//var/status = FACTION_STATUS_FLAG_ACTIVE

	//var/list/employment_log = list()

	//var/tmp/decl/hierarchy/outfit/starter_outfit = /decl/hierarchy/outfit/job/assistant //Outfit members of this faction spawn with by default

	//var/tmp/list/people_to_notify = list()

	//var/list/assigned_ranks = list() //list(employee_name = list(assignment_uid=rank)) Keep track of all the assigned people, and their rank and assignment
	//var/list/expenses = list()	//list(employee_name = amount_expenses) Keep track of expenses for a given person's expense card

	//
	//var/taxer_uid
	//var/tmp/datum/world_faction/taxer_faction

	//var/allow_new_player_spawn = FALSE //Whether this faction should be considered as valid for spawning new players

// /datum/world_faction/proc/apc_alarm(var/obj/machinery/power/apc/apc)
// 	var/subject = "APC Alarm at [apc.area.name] ([apc.connected_faction.name])"
// 	var/body = "On [stationtime2text()] the APC at [apc.area.name] for [apc.connected_faction.name] went into alarm. If you want to unsubscribe to notifications like this use the personal modification program."
// 	for(var/name in people_to_notify)
// 		Send_Email(name, sender = src.name, subject, body)
// 	for(var/obj/item/organ/internal/stack/stack in connected_laces)
// 		if(stack.owner)
// 			to_chat(stack.owner, "Your neural lace buzzes letting you know that the APC at [apc.area.name] has gone into alarm.")

// /datum/world_faction/New(var/_uid, var/_name, var/_abbreviation, var/_short_tag, var/_purpose, var/_password, var/_owner_name, var/_create_accounts = TRUE)
// 	..()
// 	uid = _uid
// 	name = _name
// 	abbreviation = _abbreviation
// 	short_tag = _short_tag
// 	purpose = _purpose
// 	password = _password
// 	owner_name = _owner_name
// 	records = new()
// 	if(_create_accounts)
// 		create_faction_account()
// 		create_network()

// /datum/world_faction/after_load()
// 	if(!debts)
// 		debts = list()
// 	..()

// /datum/world_faction/proc/get_duty_status(var/real_name)
// 	for(var/obj/item/organ/internal/stack/stack in connected_laces)
// 		if(stack.get_owner_name() == real_name)
// 			return stack.duty_status + 1
// 	return 0

// /datum/world_faction/proc/get_debt()
// 	var/debt = 0
// 	for(var/x in debts)
// 		debt += text2num(debts[x])
// 	return debt

// /datum/world_faction/proc/pay_debt()
// 	for(var/x in debts)
// 		var/debt = text2num(debts[x])
// 		if(!central_account.transfer(x, debt, "Postpaid Payroll"))
// 			return 0
// 		debts -= x

// /datum/world_faction/proc/rebuild_all_access()
// 	all_access = list()
// 	var/datum/access_category/core/core = new()
// 	for(var/datum/access_category/access_category in access_categories+core)
// 		for(var/x in access_category.accesses)
// 			all_access |= x

// /datum/world_faction/proc/rebuild_all_assignments()
// 	all_assignments = list()
// 	for(var/datum/assignment_category/assignment_category in assignment_categories)
// 		for(var/x in assignment_category.assignments)
// 			all_assignments |= x

// /datum/world_faction/proc/get_assignment(var/assignment, var/real_name)
// 	if(!assignment) return null
// 	rebuild_all_assignments()
// 	for(var/datum/assignment/assignmentt in all_assignments)
// 		if(assignmentt.uid == assignment) return assignmentt

//Just a way to customize the starting money for new characters joining a specific faction on spawn
// Can be expanded to check the specie and origins and etc too
// /datum/world_faction/proc/get_new_character_money(var/mob/living/carbon/human/H)
// 	return DEFAULT_NEW_CHARACTER_MONEY //By default just throw the default amount at them

// /datum/world_faction/proc/get_records()
// 	PSDB.GetFactionCrewRecords()
// 	return records.faction_records

// /datum/world_faction/proc/get_record(var/real_name)
// 	for(var/datum/computer_file/report/crew_record/faction/R in records.faction_records)
// 		if(R.get_name() == real_name)
// 			return R
// 	var/datum/computer_file/report/crew_record/faction/FR = PSDB.faction.GetFactionCrewRecord(real_name, uid)
// 	records.faction_records += FR
// 	return FR

/datum/world_faction/proc/in_command(var/real_name)
	CRASH("IMPLEMENT ME!")
	// var/datum/computer_file/report/crew_record/faction/R = get_record(real_name)
	// if(R)
	// 	var/datum/assignment/assignment = get_assignment(R.get_assignment_uid(), R.get_name())
	// 	if(assignment)
	// 		if(assignment.parent)
	// 			return assignment.parent.command_faction
	// return 0

/datum/world_faction/proc/outranks(var/real_name, var/target)
	CRASH("IMPLEMENT ME!")
// 	if(real_name == get_leadername())
// 		return 1
// 	var/datum/computer_file/report/crew_record/faction/R = get_record(real_name)
// 	if(!R) return 0
// 	var/datum/computer_file/report/crew_record/faction/target_record = get_record(target)
// 	if(!target_record) return 1
// 	var/user_command = 0
// //	var/target_command = 0
// 	var/user_leader = 0
// 	var/target_leader = 0
// 	var/same_department = 0
// 	var/user_auth = 0
// 	var/target_auth = 0

// 	var/datum/assignment/assignment = get_assignment(R.get_assignment_uid(), R.get_name())
// 	if(assignment)
// 		user_auth = assignment.edit_authority
// 		if(assignment.parent)
// 			user_command = assignment.parent.command_faction
// 			if(assignment.parent.head_position && assignment.parent.head_position.name == assignment.name)
// 				user_leader = 1
// 	else
// 		return 0
// 	var/datum/assignment/target_assignment = get_assignment(target_record.get_assignment_uid(), target_record.get_name())
// 	if(target_assignment)
// 		target_auth = target_assignment.authority_restriction
// 		if(target_assignment.any_assign)
// 			same_department = 1
// 		if(target_assignment.parent)
// 	//		target_command = target_assignment.parent.command_faction
// 			if(target_assignment.parent.head_position && target_assignment.parent.head_position.name == target_assignment.name)
// 				target_leader = 1
// 			if(assignment.parent && target_assignment.parent.name == assignment.parent.name)
// 				same_department = 1
// 	else
// 		return 1
// 	if(user_command)
// 	//	if(!target_command) return 1
// 		if(user_leader)
// 			if(!target_leader) return 1
// 		else
// 			if(target_leader) return 0
// 	//	if(user_rank >= target_rank) return 1
// 		if(user_auth >= target_auth) return 1
// 		else return 0
// 	if(same_department)
// 		if(user_leader)
// 			if(!target_leader) return 1
// 		else
// 			if(target_leader) return 0
// 	//	if(user_rank >= target_rank) return 1
// 		if(user_auth >= target_auth) return 1
// 		else return 0
// 	return 0

// /datum/world_faction/proc/promote(var/member_name)

// /datum/world_faction/proc/demote(var/member_name)

// /datum/world_faction/proc/get_access_name(var/access)
// 	var/datum/access_category/core/core = new()
// 	for(var/datum/access_category/access_category in access_categories+core)
// 		if(access in access_category.accesses) return access_category.accesses[access]
// 	return 0

//Look at all the assignements we've handed out for the name and assignement specifieds
// /datum/world_faction/proc/get_assignement_rank(var/real_name, var/assignment_uid)
// 	var/list/L = assigned_ranks[real_name]
// 	if(L && L[assignment_uid])
// 		return L[assignment_uid]
// 	return null

// /datum/world_faction/proc/set_assignement_rank(var/real_name, var/assignment_uid, var/rank = 0)
// 	var/list/L = assigned_ranks[real_name]
// 	L[assignment_uid] = rank

// //Returns the amount of funds someone used via an expense card on behalf of the faction
// /datum/world_faction/proc/get_expenses_limit(var/real_name)
// 	var/datum/computer_file/report/crew_record/faction/record = get_record(real_name)
// 	if(!record)
// 		return 0
// 	var/datum/assignment/assignment = get_assignment(record.get_assignment_uid(), real_name)
// 	if(!assignment)
// 		return 0
// 	var/datum/accesses/copy = assignment.accesses[record.get_rank()]
// 	if(!copy)
// 		return 0
// 	return copy.expense_limit

// /datum/world_faction/proc/get_available_expenses(var/real_name)
// 	return get_expenses_limit(real_name) - get_expenses(real_name)

// /datum/world_faction/proc/get_access(var/real_name)
// 	var/datum/computer_file/report/crew_record/faction/record = get_record(real_name)
// 	if(!record)
// 		return 0
// 	var/datum/assignment/assignment = get_assignment(record.get_assignment_uid(), real_name)
// 	if(!assignment)
// 		return 0
// 	var/datum/accesses/access = assignment.accesses[record.get_rank()]
// 	if(!access)
// 		return 0
// 	return access.accesses

//Returns the amount of funds someone used via an expense card on behalf of the faction
// /datum/world_faction/proc/get_expenses(var/real_name)
// 	if(expenses[real_name])
// 		return expenses[real_name]
// 	return null

// /datum/world_faction/proc/add_to_expenses(var/real_name, var/amount)
// 	if(!expenses[real_name])
// 		return FALSE
// 	expenses[real_name]  = (expenses[real_name]) + amount
// 	return TRUE

// /datum/world_faction/proc/remove_from_expenses(var/real_name, var/amount)
// 	if(!expenses[real_name])
// 		return FALSE
// 	expenses[real_name]  = (expenses[real_name]) - amount
// 	return TRUE

// /datum/world_faction/proc/reset_expenses(var/real_name)
// 	if(!expenses[real_name])
// 		return FALSE
// 	expenses[real_name]  = 0
// 	return TRUE

// /datum/world_faction/proc/get_leadername()
// 	return owner_name

// /datum/world_faction/proc/register_member(var/real_name, var/assignment_uid = null)
// 	var/datum/computer_file/report/crew_record/faction/R = new(null, real_name)
// 	R.load_from_global(real_name)
// 	if(assignment_uid)
// 		R.set_assignment_uid(assignment_uid)
// 	network.records += R
// 	return R

// /datum/world_faction/proc/get_members()
// 	var/list/members = list()
// 	var/list/contracts = GLOB.contract_database.get_contracts(src.uid, CONTRACT_BUSINESS)
// 	for(var/datum/recurring_contract/contract in contracts)
// 		if(contract.payee_cancelled || contract.payee_completed|| contract.payer_cancelled || contract.payer_completed)
// 			continue
// 		if(contract.func == CONTRACT_SERVICE_MEMBERSHIP)
// 			members |= contract
// 	return members

// /datum/world_faction/proc/employee_health_alarm(var/mob/M)
// 	CRASH("IMPLEMENT ME")
	// for(var/datum/world_faction/faction in GLOB.all_world_factions)
	// 	if(faction == src) continue
	// 	if(M.real_name in faction.service_medical_personal) continue
	// 	if(uid in faction.service_medical_personal)
	// 		faction.health_alarm(M)

// /datum/world_faction/proc/health_alarm(var/mob/M)
// 	var/subject = "Critical Health Alarm for [M.real_name]"
// 	var/body = "On [stationtime2text()] [M.real_name] is in critical health status. If you want to unsubscribe to notifications like this use the personal modification program."
// 	for(var/name in people_to_notify)
// 		Send_Email(name, sender = src.name, subject, body)
// 	for(var/obj/item/organ/internal/stack/stack in connected_laces)
// 		if(stack.owner)
// 			to_chat(stack.owner, "Your neural lace buzzes letting you know that [M.real_name] is in critical health status.")

// /datum/world_faction/proc/get_central_account()
// 	if(!central_account)
// 		central_account = get_account(central_account_id)
// 	return central_account

// /datum/work_shift
// 	var/employee_name
// 	var/mob/employee_ref
// 	var/clock_in_time

// /datum/work_shift/New(var/_employee_name, var/mob/_employee_ref, var/_clock_in_time)
// 	employee_name = _employee_name
// 	employee_ref = _employee_ref
// 	clock_in_time = _clock_in_time

// /datum/world_faction/proc/is_clocked_in(var/mob/employee)
// 	if(!employee)
// 		return
// 	return worker_shifts[employee.real_name]? TRUE : FALSE

// /datum/world_faction/proc/clock_in(var/mob/employee)
// 	if(!employee || worker_shifts[employee.real_name])
// 		return
// 	if(employment_log.len > 100)
// 		employment_log.Cut(1,2)
// 	employment_log += "At [stationdate2text()] [stationtime2text()] [employee.real_name] clocked in."
// 	connected_laces += employee
// 	worker_shifts[employee.real_name] = new/datum/work_shift(employee.real_name, employee, REALTIMEOFDAY)

// /datum/world_faction/proc/clock_out(var/mob/employee)
// 	if(!employee || !worker_shifts[employee.real_name])
// 		return
// 	if(employment_log.len > 100)
// 		employment_log.Cut(1,2)
// 	employment_log += "At [stationdate2text()] [stationtime2text()] [employee.real_name] clocked out."
// 	connected_laces -= employee
// 	var/datum/work_shift/S = worker_shifts[employee.real_name]
// 	worker_shifts[employee.real_name] = null
// 	return REALTIMEOFDAY - S.clock_in_time

//Taxation functions ripped out of the small_business system, and modified to fit in here
// /datum/world_faction/proc/set_tax_collector(var/_taxer_uid)
// 	taxer_uid = _taxer_uid

// /datum/world_faction/proc/get_tax_collector_uid()
// 	return taxer_uid

// /datum/world_faction/proc/pay_tax(var/amount)
// 	if(!taxer_uid || taxer_uid == "") 
// 		return 0
// 	var/datum/world_faction/connected_faction = FindFaction(taxer_uid)
// 	if(!connected_faction) 
// 		return 0
// 	connected_faction.central_account.transfer(central_account, round(amount/100 * connected_faction.tax_rate), "Tax to [connected_faction.name]")

// /datum/world_faction/proc/pay_export_tax(var/amount)
// 	if(!taxer_uid || taxer_uid == "") 
// 		return 0
// 	var/datum/world_faction/connected_faction = FindFaction(taxer_uid)
// 	if(!connected_faction) 
// 		return 0
// 	connected_faction.central_account.transfer(central_account, round(amount/100 * connected_faction.export_profit), "Export tax to [connected_faction.name]")
// 	return (amount/100 * connected_faction.export_profit)

