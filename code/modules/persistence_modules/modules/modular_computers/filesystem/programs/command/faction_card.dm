/datum/computer_file/program/faction_card_mod
	filename = "cardmod"
	filedesc = "ID card modification program"
	nanomodule_path = /datum/nano_module/program/faction_card_mod
	program_icon_state = "id"
	program_key_state = "id_key"
	program_menu_icon = "key"
	extended_desc = "Program for programming factionalised employee assignments and rank, and syncing ID cards."
	required_access = core_access_reassignment
	requires_ntnet = TRUE
	size = 8
	category = PROG_COMMAND
	usage_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP | PROGRAM_TELESCREEN
	
/datum/computer_file/program/faction_card_mod/can_run(var/mob/living/user, var/loud = 0, var/access_to_check, var/alt_computer)
	// Defaults to required_access
	if(!access_to_check)
		access_to_check = required_access
	if(!access_to_check) // No required_access, allow it.
		return TRUE
	var/list/accesses_to_check = list()
	accesses_to_check |= access_to_check
	// Admin override - allows operation of any computer as aghosted admin, as if you had any required access.
	if(isghost(user) && check_rights(R_ADMIN, 0, user))
		return TRUE
	if(!istype(user) || !computer.has_component(PART_NETWORK))
		return FALSE

	var/obj/item/weapon/card/id/I = user.GetIdCard()
	if(!I)
		if(loud)
			to_chat(user, SPAN_NOTICE("\The [computer] flashes an \"RFID Error - Unable to scan ID\" warning."))
		return FALSE
	
	var/faction_uid = get_network_faction_uid()
	if(faction_uid)
		for(var/access in accesses_to_check)
			if(access in I.GetAccess(faction_uid))
				return TRUE
		if(loud)
			to_chat(user, "<span class='notice'>\The [computer] flashes an \"Access Denied\" warning.</span>")
	else
		if(loud)
			to_chat(user, SPAN_WARNING("\The [computer] flashes an \"No faction network access\" warning."))
	return TRUE

/datum/nano_module/program/faction_card_mod
	name = "ID card modification program"
	var/mod_mode = 1
	var/is_centcom = 0
	var/show_assignments = 0
	var/show_record = 0
	var/datum/computer_file/report/crew_record/faction/record
	var/manifest_setting = 1
	var/submode = 0

/datum/nano_module/program/faction_card_mod/proc/fill_employment_state(var/list/data)
	var/datum/world_faction/connected_faction = program.get_network_faction()
	data["employment_status"] = record.get_employement_status()
	data["terminated"] = record.get_employement_status() == EMPLOYMENT_STATUS_FIRED
	data["suspended"] = record.get_employement_status() == EMPLOYMENT_STATUS_SUSPENDED
	switch(connected_faction.get_on_duty(record.get_name()))
		if(WORK_STATUS_OFF_DUTY)
			data["duty_status"] = "Off duty"
		if(WORK_STATUS_ON_DUTY)
			data["duty_status"] = "On duty"
	return data

/datum/nano_module/program/faction_card_mod/proc/fill_assignment_data(var/list/data)
	var/current_name = record.get_name()
	var/datum/world_faction/connected_faction = program.get_network_faction()
	var/datum/assignment/A = connected_faction.get_assignment(record.get_assignment_uid(), current_name)
	
	data["assignment_uid"] = A? A.uid : "None"
	data["current_rank"]   = A? A.rank : "None"
	data["promote_button"] = A? connected_faction.can_promote_member(current_name) : FALSE
	data["demote_button"]  = A? connected_faction.can_demote_member(current_name) : FALSE
	data["title"]          = A? A.get_title() : "None"
	data["custom_title"]  = record.get_custom_title()
	data["expense_limit"] = connected_faction.get_member_expenses_limit(current_name)
	data["expenses"]      = connected_faction.get_member_expenses(current_name)
	return data

/datum/nano_module/program/faction_card_mod/proc/fill_assignment_list(var/list/data)
	var/datum/world_faction/connected_faction = program.get_network_faction()
	var/datum/assignment/current_assignment = connected_faction.get_assignment(record.get_assignment_uid())
	var/list/assignment_categories = list()
	var/selected_match = FALSE

	for(var/datum/assignment_category/C in connected_faction.get_assignment_categories())
		assignment_categories[++assignment_categories.len] = list("name" = C.name, "assignments" = list())
		for(var/datum/assignment/A in C.assignments)
			if(current_assignment && current_assignment.uid == A.uid)
				selected_match = TRUE
			assignment_categories[assignment_categories.len]["assignments"] += list(list(
			"name" = A? A.get_title() : "",
			"ref" = "\ref[A]",
			"selected" = selected_match,
			))
	data["none_select"] = !selected_match
	data["assignment_categories"] = assignment_categories
	return data

/datum/nano_module/program/faction_card_mod/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = host.initial_data()
	var/obj/item/weapon/stock_parts/computer/card_slot/card_slot = program.computer.get_component(PART_CARD)

	data["src"] = "\ref[src]"
	data["station_name"] = station_name()
	data["manifest"] = html_crew_manifest()
	data["assignments"] = show_assignments
	data["have_id_slot"] = !isnull(card_slot)
	data["have_printer"] = program.computer.has_component(PART_PRINTER)
	data["authenticated"] = program.can_run(user)
	if(!data["have_id_slot"] || !data["have_printer"])
		mod_mode = 0 //We can't modify IDs when there is no card reader
	var/datum/world_faction/connected_faction = program?.get_network_faction()
	if(connected_faction)
		data["found_faction"] = TRUE
		data["faction_name"] = connected_faction.name
		data["manifest"] = html_crew_manifest_faction(null, null, connected_faction, manifest_setting)

	if(!(program && program.computer))
		data["have_id_slot"] = FALSE
		data["have_printer"] = FALSE
		data["authenticated"] = FALSE
	data["submode"] = submode
	if(!mod_mode && !submode)
		data["manifest_button"] = 1

	if(card_slot)
		var/obj/item/weapon/card/id/id_card = card_slot.stored_card
		data["has_id"] = !!id_card
		data["id_account_number"] = id_card ? id_card.associated_account_number : null
		data["id_email_login"] = id_card ? id_card.associated_email_login["login"] : null
		data["id_email_password"] = id_card ? stars(id_card.associated_email_login["password"], 0) : null
		data["id_rank"] = id_card && id_card.assignment ? id_card.assignment : "Unassigned"
		data["id_owner"] = id_card && id_card.registered_name ? id_card.registered_name : "-----"
		data["id_name"] = id_card ? id_card.name : "-----"
	data["mmode"] = mod_mode
	data["centcom_access"] = is_centcom
	data["has_record"] = !isnull(record)
	data["record_name"] = record ? record.get_name() : "-Search by name-"
	if(record)
		data = fill_employment_state(data)
		data = fill_assignment_data(data)
		data = fill_assignment_list(data)
		data["record_val"] = pencode2html(record.get_emplRecord())
		data["record"] = show_record
	if(card_slot && card_slot.stored_card)
		var/obj/item/weapon/card/id/id_card = card_slot.stored_card
		if(is_centcom)
			var/list/all_centcom_access = list()
			for(var/access in get_all_centcom_access())
				all_centcom_access.Add(list(list(
					"desc" = replacetext(get_centcom_access_desc(access), " ", "&nbsp"),
					"ref" = access,
					"allowed" = (access in id_card.access) ? 1 : 0)))
			data["all_centcom_access"] = all_centcom_access
		else
			var/list/regions = list()
			for(var/i = 1; i <= 8; i++)
				var/list/accesses = list()
				for(var/access in get_region_accesses(i))
					if (get_access_desc(access))
						accesses.Add(list(list(
							"desc" = replacetext(get_access_desc(access), " ", "&nbsp"),
							"ref" = access,
							"allowed" = (access in id_card.access) ? 1 : 0)))

				regions.Add(list(list(
					"name" = get_region_accesses_name(i),
					"accesses" = accesses)))
			data["regions"] = regions

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "identification_computer.tmpl", name, 600, 700, state = state)
		ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()

/datum/nano_module/program/faction_card_mod/proc/format_jobs(list/jobs)
	var/obj/item/weapon/card/id/id_card = program.computer.get_inserted_id()
	var/list/formatted = list()
	for(var/job in jobs)
		formatted.Add(list(list(
			"display_name" = replacetext(job, " ", "&nbsp"),
			"target_rank" = id_card && id_card.assignment ? id_card.assignment : "Unassigned",
			"job" = job)))

	return formatted

/datum/nano_module/program/faction_card_mod/proc/get_accesses(var/is_centcom = 0)
	return null

/datum/computer_file/program/faction_card_mod/Topic(href, href_list)
	if(..())
		return 1
	var/isleader = 0
	var/mob/user = usr
	var/obj/item/weapon/card/id/user_id_card = user.GetIdCard()
	var/obj/item/weapon/card/id/id_card = computer.get_inserted_id()
	if(!user_id_card)
		return 0
	var/datum/computer_file/report/crew_record/faction/user_record
	var/list/user_accesses = list()
	var/datum/world_faction/connected_faction = computer?.get_network_faction()
	if(connected_faction)
		user_record = connected_faction.get_record(user_id_card.registered_name)
		if(user_record)
			user_accesses = user_id_card.GetAccess(connected_faction.uid)
		if(connected_faction.get_leadername() == user_id_card.registered_name)
			isleader = 1
	else
		return 0
	var/datum/nano_module/program/faction_card_mod/module = NM
	switch(href_list["action"])
		if("scan_id")
			if(!id_card)
				return
			module.record = null
			var/datum/computer_file/report/crew_record/faction/record = connected_faction.get_record(id_card.registered_name)
			if(!record && id_card.registered_name)
				if(!user_id_card) return
				if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
					to_chat(user, "No record is on file for [id_card.registered_name]. Insufficent access to add new members.")
					return 0
				if(!connected_faction.get_hiring_allowed())
					if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.in_command(user_id_card.registered_name))
						to_chat(user, "No record is on file for [id_card.registered_name]. Only members of Command categories can add new names to the records.")
						return 0
				var/choice = input(user,"No record is on file for [id_card.registered_name]. Would you like to create a new record for [id_card.registered_name] based on information found in public records?") in list("Create", "Cancel")
				if(choice == "Cancel") return 1
				if(!connected_faction.get_record(id_card.registered_name) && module)
					// record = new()
					// if(!record.load_from_global(id_card.registered_name))
					// 	to_chat(user, "No public records have been found for [id_card.registered_name]. Record creation aborted.")
					// 	return 0
					// connected_faction.records.faction_records |= record
					connected_faction.add_member(id_card.registered_name)
					module.record = record
			else
				module.record = record
		if("search_name")
			module.record = null
			var/select_name = input(user,"Enter the name of the record to search for.","Record Search", "") as null|text
			if(select_name)
				var/datum/computer_file/report/crew_record/faction/record = connected_faction.get_record(select_name)
				if(!record)
					if(!user_id_card) return
					if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
						to_chat(user, "No record is on file for [select_name]. Insufficent access to add new members.")
						return 0
					if(!connected_faction.get_hiring_allowed())
						if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.in_command(user_id_card.registered_name))
							to_chat(user, "No record is on file for [select_name]. Only members of Command categories can add new names to the records.")
							return 0
					var/choice = input(user,"No record is on file for [select_name]. Would you like to create a new record for [select_name] based on information found in public records?") in list("Create", "Cancel")
					if(choice == "Cancel") return 1
					if(!connected_faction.get_record(select_name) && module)
						record = connected_faction.add_member(select_name)
						module.record = record
				else
					module.record = record

		if("switchm")
			if(href_list["target"] == "mod")
				module.mod_mode = 1
				module.submode = 0
			else if (href_list["target"] == "manifest")
				module.mod_mode = 0
				module.submode = 0
			else if (href_list["target"] == "id")
				module.mod_mode = 0
				module.submode = 1
		if("togglea")
			if(module.show_assignments)
				module.show_assignments = 0
			else
				module.show_assignments = 1
				module.show_record = 0
		if("toggler")
			if(module.show_record)
				module.show_record = 0
			else
				module.show_assignments = 0
				module.show_record = 1
		if("print")
			if(!authorized(user_id_card))
				to_chat(user, SPAN_WARNING("Access Denied."))
				return
			if(computer.has_component(PART_PRINTER)) //This option should never be called if there is no printer
				if(module.mod_mode)
					if(can_run(user, 1))
						var/contents = {"<h4>Access Report</h4>
									<u>Prepared By:</u> [user_id_card.registered_name ? user_id_card.registered_name : "Unknown"]<br>
									<u>For:</u> [id_card.registered_name ? id_card.registered_name : "Unregistered"]<br>
									<hr>
									<u>Assignment:</u> [id_card.assignment]<br>
									<u>Account Number:</u> #[id_card.associated_account_number]<br>
									<u>Email account:</u> [id_card.associated_email_login["login"]]
									<u>Email password:</u> [stars(id_card.associated_email_login["password"], 0)]
									<u>Blood Type:</u> [id_card.blood_type]<br><br>
									<u>Access:</u><br>
								"}

						var/known_access_rights = get_access_ids(ACCESS_TYPE_STATION|ACCESS_TYPE_CENTCOM)
						for(var/A in id_card.access)
							if(A in known_access_rights)
								contents += "  [get_access_desc(A)]"

						if(!computer.print_paper(contents,"access report"))
							to_chat(user, "<span class='notice'>Hardware error: Printer was unable to print the file. It may be out of paper.</span>")
							return
				else
					var/contents = {"<h4>Crew Manifest</h4>
									<br>
									[html_crew_manifest_faction(null, null, connected_faction, module.manifest_setting)]
									"}
					if(!computer.print_paper(contents, "crew manifest ([stationtime2text()])"))
						to_chat(user, "<span class='notice'>Hardware error: Printer was unable to print the file. It may be out of paper.</span>")
						return
		if("eject")
			var/obj/item/weapon/stock_parts/computer/card_slot/card_slot = computer.get_component(PART_CARD)
			if(computer.get_inserted_id())
				card_slot.eject_id(user)
			else
				card_slot.insert_id(user.get_active_hand(), user)
		if("terminate")
			if(!authorized(user_id_card))
				to_chat(user, SPAN_WARNING("Access Denied."))
				return
			if(computer && can_run(user, 1))
				id_card.assignment = "Terminated"
				remove_nt_access(id_card)
				callHook("terminate_employee", list(id_card))
		if("edit")
			if(!authorized(user_id_card))
				to_chat(user, SPAN_WARNING("Access Denied."))
				return
			if(computer && can_run(user, 1))
				if(href_list["name"])
					var/temp_name = sanitizeName(input("Enter name.", "Name", id_card.registered_name),allow_numbers=TRUE)
					if(temp_name)
						id_card.registered_name = temp_name
						id_card.formal_name_suffix = initial(id_card.formal_name_suffix)
						id_card.formal_name_prefix = initial(id_card.formal_name_prefix)
					else
						computer.show_error(user, "Invalid name entered!")
				else if(href_list["account"])
					var/account_num = text2num(input("Enter account number.", "Account", id_card.associated_account_number))
					id_card.associated_account_number = account_num
				else if(href_list["elogin"])
					var/email_login = input("Enter email login.", "Email login", id_card.associated_email_login["login"])
					id_card.associated_email_login["login"] = email_login
				else if(href_list["epswd"])
					var/email_password = input("Enter email password.", "Email password")
					id_card.associated_email_login["password"] = email_password
		if("reset_expenses")
			if(computer && can_run(user, 1))
				if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
					to_chat(user, SPAN_WARNING("Access Denied."))
					return 0
				connected_faction.clear_member_expenses(id_card.registered_name)
		if("assign")
			if(!authorized(user_id_card))
				to_chat(user, SPAN_WARNING("Access Denied."))
				return
			if(computer && can_run(user, 1) && id_card)
				var/t1 = href_list["assign_target"]
				if(t1 == "Custom")
					var/temp_t = sanitize(input("Enter a custom job assignment.","Assignment", id_card.assignment), 45)
					//let custom jobs function as an impromptu alt title, mainly for sechuds
					if(temp_t)
						id_card.assignment = temp_t
				else
					var/list/access = list()
					if(module.is_centcom)
						access = get_centcom_access(t1)
					else
						var/datum/job/jobdatum = SSjobs.get_by_title(t1)
						if(!jobdatum)
							to_chat(user, "<span class='warning'>No log exists for this job: [t1]</span>")
							return

						access = jobdatum.get_access()

					remove_nt_access(id_card)
					apply_access(id_card, access)
					id_card.assignment = t1
					id_card.rank = t1

				callHook("reassign_employee", list(id_card))
		if("access")
			if(href_list["allowed"] && computer && can_run(user, 1) && id_card)
				var/access_type = href_list["access_target"]
				var/access_allowed = text2num(href_list["allowed"])
				if(access_type in get_access_ids(ACCESS_TYPE_STATION|ACCESS_TYPE_CENTCOM))
					for(var/access in user_id_card.access)
						var/region_type = get_access_region_by_id(access_type)
						if(access in GLOB.using_map.access_modify_region[region_type])
							id_card.access -= access_type
							if(!access_allowed)
								id_card.access += access_type
							break
		if("promote")
			if(!user_id_card) return
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
				to_chat(user, SPAN_WARNING("Access Denied."))
				return 0
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.outranks(user_id_card.registered_name, module.record.get_name()))
				to_chat(user, SPAN_WARNING("Insufficent Rank."))
				return 0
			if(connected_faction.promote_member(user_id_card.registered_name))
				to_chat(user, SPAN_WARNING("Couldn't promote member! Make sure there is a rank above the target user's assignment!"))
				return 1
			var/datum/assignment/new_ass = connected_faction.get_member_assignment(user_id_card.registered_name)
			to_chat(user, SPAN_NOTICE("'[user_id_card.registered_name]' was promoted to '[new_ass.name]'!"))
			//module.record.promote_votes |= user_id_card.registered_name
			//module.record.check_rank_change(connected_faction)
		if("demote")
			if(!user_id_card) return
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
				to_chat(user, SPAN_WARNING("Access Denied."))
				return 0
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.outranks(user_id_card.registered_name, module.record.get_name()))
				to_chat(user, SPAN_WARNING("Insufficent Rank."))
				return 0
			if(connected_faction.demote_member(user_id_card.registered_name))
				to_chat(user, SPAN_WARNING("Couldn't demote member! Make sure there is a rank under the target user's assignment!"))
				return 1
			var/datum/assignment/new_ass = connected_faction.get_member_assignment(user_id_card.registered_name)
			to_chat(user, SPAN_NOTICE("'[user_id_card.registered_name]' was demoted to '[new_ass.name]'!"))
			//module.record.demote_votes |= user_id_card.registered_name
			//module.record.check_rank_change(connected_faction)
		// if("promote_cancel")
		// 	if(!user_id_card) return
		// 	module.record.promote_votes -= user_id_card.registered_name
		// if("demote_cancel")
		// 	if(!user_id_card) return
		// 	module.record.promote_votes -= user_id_card.registered_name
		if("register_id")
			//id_card.approved_factions |= connected_faction.uid
			if(!connected_faction.get_record(id_card.registered_name))
				connected_faction.add_member(id_card.registered_name)
				to_chat(user, SPAN_NOTICE("User [id_card.registered_name] was successfully registered as a member of [connected_faction.name]!"))
			else
				to_chat(user, SPAN_WARNING("[id_card.registered_name] was already registered as a member."))
		if("resync_id")
			//id_card.approved_factions |= connected_faction.uid
			id_card.selected_faction_uid = connected_faction.uid
			UpdateIds(id_card.registered_name)
			to_chat(user, "Card successfully resynced to [connected_faction.name]")
			
		if("edit_record")
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
				to_chat(usr, "Access Denied.")
				return 0
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.outranks(user_id_card.registered_name, module.record.get_name()))
				to_chat(usr, "Insufficent Rank.")
				return 0
			var/newValue
			newValue = replacetext(input(usr, "Edit the employee record. You may use HTML paper formatting tags:", "Record edit", replacetext(html_decode(module.record.get_emplRecord()), "\[br\]", "\n")) as null|message, "\n", "\[br\]")
			if(newValue)
				module.record.set_emplRecord(newValue)
	if(id_card)
		id_card.SetName(text("[id_card.registered_name]'s ID Card ([id_card.assignment])"))

	SSnano.update_uis(NM)
	return 1

/datum/computer_file/program/faction_card_mod/proc/remove_nt_access(var/obj/item/weapon/card/id/id_card)
	id_card.access -= get_access_ids(ACCESS_TYPE_STATION|ACCESS_TYPE_CENTCOM)

/datum/computer_file/program/faction_card_mod/proc/apply_access(var/obj/item/weapon/card/id/id_card, var/list/accesses)
	id_card.access |= accesses

/datum/computer_file/program/faction_card_mod/proc/authorized(var/obj/item/weapon/card/id/id_card)
	return id_card && (access_change_ids in id_card.access)