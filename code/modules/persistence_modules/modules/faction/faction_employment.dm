/*
	Helpers to deal with employment in the faction
*/

//===============================
//	Duty control
//===============================
/datum/world_faction/proc/open_business(var/send_event = TRUE)
	if(is_business_opened())
		return
	status |= FACTION_STATUS_FLAG_ACTIVE
	if(send_event)
		GLOB.faction_opened_event.raise_event(src, uid)

/datum/world_faction/proc/close_business(var/send_event = TRUE)
	if(!is_business_opened())
		return
	status &= ~FACTION_STATUS_FLAG_ACTIVE
	if(send_event)
		GLOB.faction_closed_event.raise_event(src, uid)

/datum/world_faction/proc/is_business_opened()
	return status & FACTION_STATUS_FLAG_ACTIVE

//===============================
//	Member Duty status
//===============================

//Returns whether the employe is on duty or not
/datum/world_faction/proc/get_on_duty(var/employe_name)
	var/datum/computer_file/report/crew_record/faction/CR = get_record(employe_name)
	if(!CR)
		return FALSE
	return CR.get_work_status_as_num() > 0

//Set the OnDuty state for the given employe name
/datum/world_faction/proc/set_on_duty(var/employe_name, var/isonduty)
	var/datum/computer_file/report/crew_record/faction/CR = get_record(employe_name)
	if(!CR)
		return FALSE
	if(isonduty == CR.get_work_status_as_num())
		return
	var/datum/assignment/A = get_assignment(CR.get_assignment_uid())
	if(!A?.can_clock_in())
		return
	var/clock_time = REALTIMEOFDAY
	CR.set_work_status_as_num(isonduty)
	CR.set_last_clock_in(clock_time)
	PSDB.factions.CommitFactionCrewRecord(CR, src.uid)
	return clock_time

/datum/world_faction/proc/clock_in(var/mob/employee)
	if(!employee || get_on_duty(employee.real_name))
		return
	log_employe("At [stationdate2text()] [stationtime2text()] [employee.real_name] clocked in.")
	set_on_duty(employee.real_name, TRUE)
	//connected_laces += employee
	//worker_shifts[employee.real_name] = new/datum/work_shift(employee.real_name, employee, REALTIMEOFDAY)

/datum/world_faction/proc/clock_out(var/mob/employee)
	if(!employee || !get_on_duty(employee.real_name))
		return
	var/datum/computer_file/report/crew_record/faction/CR = src.get_record(employee.real_name)
	if(!CR)
		return FALSE
	log_employe("At [stationdate2text()] [stationtime2text()] [employee.real_name] clocked out.")
	set_on_duty(employee.real_name, FALSE)
	// connected_laces -= employee
	// var/datum/work_shift/S = worker_shifts[employee.real_name]
	// worker_shifts[employee.real_name] = null
	if(CR.get_last_clock_in() <= 0)
		return 0
	return REALTIMEOFDAY - CR.get_last_clock_in()

//===============================
// 	Member Expenses
//===============================
/datum/world_faction/proc/add_to_member_expenses(var/employe_name, var/value)
	expenses[employe_name] = max(expenses[employe_name] + value, 0)
	return TRUE

/datum/world_faction/proc/remove_from_member_expenses(var/employe_name, var/value)
	expenses[employe_name] = max(expenses[employe_name] - value, 0)
	return TRUE

/datum/world_faction/proc/clear_member_expenses(var/employe_name)
	expenses[employe_name] = 0
	return TRUE

//Returns the amount of funds someone used via an expense card on behalf of the faction
/datum/world_faction/proc/get_member_expenses_limit(var/real_name)
	var/datum/computer_file/report/crew_record/faction/R = src.get_record(real_name)
	if(!R)
		return 0
	var/datum/assignment/assignment = get_assignment(R.get_assignment_uid(), real_name)
	if(!assignment)
		return 0
	return assignment.expense_limit

/datum/world_faction/proc/get_member_available_expenses(var/real_name)
	return get_member_expenses_limit(real_name) - get_member_expenses(real_name)

/datum/world_faction/proc/get_member_expenses(var/real_name)
	return expenses[real_name]

//===============================
//	Hiring
//===============================
/datum/world_faction/proc/get_hiring_allowed()
	return hiring

/datum/world_faction/proc/set_hiring_allowed(var/allowed)
	hiring = allowed

//===============================
//	Logging
//===============================
/datum/world_faction/proc/log_employe(var/message)
	CRASH("IMPLEMENT ME")
	// if(employe_log.len > 100)
	// 	employe_log.Cut(1,2)
	// employe_log += message

//===============================
//	Employes
//===============================

/*
	Check if the character specified has a job under the current faction.
*/
/datum/world_faction/proc/is_employe(var/employe_name)
	var/datum/computer_file/report/crew_record/faction/CR = src.get_record(employe_name)
	if(!CR)
		return FALSE
	var/employmentstatus = CR.get_employement_status()
	if(employmentstatus != EMPLOYMENT_STATUS_EMPLOYED || employmentstatus != EMPLOYMENT_STATUS_SUSPENDED)
		return FALSE
	return src.get_member_assignment_uid(employe_name)

/*
	Get the crew records of only the employes in a given faction
*/
/datum/world_faction/proc/get_employes()
	return PSDB.factions.GetFactionCrewRecords_Employes(uid)

/*
	Handle handing out employe wages to all employees of the faction.
*/
/datum/world_faction/proc/pay_employes(var/time_elapsed)
	var/list/datum/computer_file/report/crew_record/faction/LCR = PSDB.factions.GetFactionCrewRecords_EmployesToPay(src.uid, time_elapsed)
	for(var/datum/computer_file/report/crew_record/faction/R in LCR)
		var/ename = R.get_name()
		var/earnings = 0
		var/worktime = 0
		var/datum/assignment/A = get_member_assignment(ename)
		if(!A)
			continue //Not employed, skip
		//#TODO: check if employe is suspended?

		earnings = A.get_pay() //#TODO: There's probably other modifiers that comes into this
		GLOB.faction_pay_event.raise_event(src, ename, earnings, worktime)
	// 	// 	for(var/datum/world_faction/faction in GLOB.all_world_factions)
// 	// 		for(var/employee in faction.unpaid)
// 	// 			var/amount = faction.unpaid[employee]
// 	// 			var/datum/computer_file/report/crew_record/faction/record = faction.get_record(employee)
// 	// 			var/rank = 1
// 	// 			var/assignment_uid = "* ! *"
// 	// 			if(!record)
// 	// 				if(faction.get_leadername() != employee)
// 	// 					message_admins("no record found for [employee] during payday")
// 	// 					continue
// 	// 			else
// 	// 				rank = record.get_rank()
// 	// 				assignment_uid = record.get_assignment_uid()
// 	// 			var/datum/assignment/job = faction.get_assignment(assignment_uid, employee)
// 	// 			var/payment
// 	// 			if(job)
// 	// 				payment = job.get_pay(rank) * amount / 6
// 	// 			else
// 	// 				payment = 0
// 	// 			if(payment && !faction.central_account.transfer(employee, payment, "Payroll ([faction.name])"))
// 	// 				faction.debts["[employee]"] += payment
// 	// 			else
// 	// 				if(istype(faction, /datum/world_faction/business))
// 	// 					var/datum/world_faction/business/business_faction = faction
// 	// 					business_faction.employee_objectives(employee)
// 	// 				if(payment)
// 	// 					if(paydata[employee])
// 	// 						paydata[employee] += payment
// 	// 					else
// 	// 						paydata[employee] = payment

// 	// 		faction.unpaid = list()
// 	// 		faction.pay_debt()
