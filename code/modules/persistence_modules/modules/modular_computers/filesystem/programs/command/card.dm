/datum/computer_file/program/card_mod
	extended_desc = "Program for programming employee assignments and rank, and syncing ID cards."
	required_access = core_access_reassignment
	requires_ntnet = TRUE
	usage_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP | PROGRAM_TELESCREEN

/datum/computer_file/program/card_mod/can_run(var/mob/living/user, var/loud = 0, var/access_to_check, var/alt_computer)
	// Defaults to required_access
	if(!access_to_check)
		access_to_check = required_access
	if(!access_to_check) // No required_access, allow it.
		return 1
	var/list/accesses_to_check = list()
	accesses_to_check |= access_to_check
	// Admin override - allows operation of any computer as aghosted admin, as if you had any required access.
	if(isghost(user) && check_rights(R_ADMIN, 0, user))
		return 1

	if(!istype(user))
		return 0

	var/obj/item/weapon/card/id/I = user.GetIdCard()
	if(!I)
		if(loud)
			to_chat(user, "<span class='notice'>\The [computer] flashes an \"RFID Error - Unable to scan ID\" warning.</span>")
		return 0
	
	if(computer.has_component(PART_NETWORK))
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

/datum/nano_module/program/card_mod
	var/show_record = 0
	var/datum/computer_file/report/crew_record/faction/record
	var/manifest_setting = 1
	var/submode = 0

/datum/nano_module/program/card_mod/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = host.initial_data()
	var/obj/item/weapon/stock_parts/computer/card_slot/card_slot = program.computer.get_component(PART_CARD)

	data["src"] = "\ref[src]"
	data["station_name"] = station_name()
	data["manifest"] = html_crew_manifest()
	data["assignments"] = show_assignments
	data["have_id_slot"] = !!card_slot
	data["have_printer"] = program.computer.has_component(PART_PRINTER)
	data["authenticated"] = program.can_run(user)
	if(!data["have_id_slot"] || !data["have_printer"])
		mod_mode = 0 //We can't modify IDs when there is no card reader
	var/datum/world_faction/connected_faction = program?.get_network_faction()
	if(connected_faction)
		data["found_faction"] = 1
		data["faction_name"] = connected_faction.name
		data["manifest"] = html_crew_manifest_faction(null, null, connected_faction, manifest_setting)

	if(!(program && program.computer))
		data["have_id_slot"] = 0
		data["have_printer"] = 0
		data["authenticated"] = 0
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
		// if(record.terminated)
		// 	data["duty_status"] = "Terminated"
		// 	data["terminated"] = 1
		// else if(record.suspended > world.realtime)
		// 	data["duty_status"] = "Suspended"
		// 	data["suspended"] = 1
		// else
		switch(connected_faction.get_on_duty(record.get_name()))
			if(0)
				data["duty_status"] = "Off network"
			if(1)
				data["duty_status"] = "On network, Off duty"
			if(2)
				data["duty_status"] = "On duty"
		var/datum/assignment/assignment = connected_faction.get_assignment(record.get_assignment_uid(), record.get_name())
		if(assignment)
			data["assignment_uid"] = assignment.uid
			data["current_rank"] = assignment.rank
			var/promote_button = 0
			var/demote_button = 0
			// var/max_rank = assignment.accesses.len + 1
			var/obj/item/weapon/card/id/user_id_card = user.GetIdCard()
			// if(user_id_card)
			// 	for(var/name in record.promote_votes)
			// 		if(name == user_id_card.registered_name)
			// 			promote_button = 2
			// 			break
			// 	for(var/name in record.demote_votes)
			// 		if(name == user_id_card.registered_name)
			// 			demote_button = 2
			// 			break
			// 	if(!promote_button)
			// 		for(var/name in record.demote_votes)
			// 			if(name == user_id_card.registered_name)
			// 				demote_button = 2
			// 				break
			// 	if(!promote_button)
			// 		if(record.get_rank() < max_rank)
			// 			promote_button = 1
			// 	if(!demote_button)
			// 		if(record.get_rank() != 1)
			// 			demote_button = 1
			data["promote_button"] = promote_button
			data["demote_button"] = demote_button
			// var/expense_limit = 0
			// var/use_rank = 1
			// if(!record.get_rank() || record.get_rank() > assignment.accesses.len)
			// 	use_rank = assignment.accesses.len
			// if(!use_rank)
			// 	message_admins("Broken assignment [assignment.uid] held by [record.get_name()]")
			// var/datum/accesses/expenses = assignment.accesses[use_rank]
			// if(expenses)
			// 	expense_limit = expenses.expense_limit
			data["expense_limit"] = connected_faction.get_member_expenses_limit(record.get_name())
			data["expenses"] = connected_faction.get_member_expenses(record.get_name())
			data["title"] = assignment.get_title(record.get_rank())
			if(record.get_custom_title())
				data["custom_title"] = record.get_custom_title()
			else
				data["custom_title"] = "None"
		else
			data["assignment_uid"] = "None"
			data["current_rank"] = "None"
			data["promote_button"] = 0
			data["demote_button"] = 0
			data["title"] = "None"
			data["custom_title"] = "None"
		var/list/assignment_categories[0]
		var/none_select = 1
		for(var/datum/assignment_category/category in connected_faction.assignment_categories)
			assignment_categories[++assignment_categories.len] = list("name" = category.name, "assignments" = list())
			for(var/datum/assignment/assignmentz in category.assignments)
				var/selected = 0
				var/x = text2num(connected_faction.get_member_assignement_rank(record.get_name(), assignmentz.uid))
				var/title = ""
				title = assignmentz.get_title(x)
				if(assignment && assignment.uid == assignmentz.uid)
					selected = 1
					none_select = 0
				assignment_categories[assignment_categories.len]["assignments"] += list(list(
				"name" = title,
				"ref" = "\ref[assignmentz]",
				"selected" = selected
				))
		data["none_select"] = none_select
		data["assignment_categories"] = assignment_categories
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

/datum/computer_file/program/card_mod/Topic(href, href_list)
	if(..())
		return 1
	var/isleader = 0
	var/mob/user = usr
	var/obj/item/weapon/card/id/user_id_card = user.GetIdCard()
	var/obj/item/weapon/card/id/id_card = computer.get_inserted_id()
	if(!user_id_card)
		return 0
	var/datum/computer_file/report/crew_record/user_record
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
	var/datum/nano_module/program/card_mod/module = NM
	switch(href_list["action"])
		if("scan_id")
			if(!id_card)
				return
			module.record = null
			var/datum/computer_file/report/crew_record/faction/record = connected_faction.get_record(id_card.registered_name)
			if(!record && id_card.registered_name)
				if(!user_id_card) return
				if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
					to_chat(usr, "No record is on file for [id_card.registered_name]. Insufficent access to add new members.")
					return 0
				if(!connected_faction.get_hiring_allowed())
					if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.in_command(user_id_card.registered_name))
						to_chat(usr, "No record is on file for [id_card.registered_name]. Only members of Command categories can add new names to the records.")
						return 0
				var/choice = input(usr,"No record is on file for [id_card.registered_name]. Would you like to create a new record for [id_card.registered_name] based on information found in public records?") in list("Create", "Cancel")
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
			var/select_name = input(usr,"Enter the name of the record to search for.","Record Search", "") as null|text
			if(select_name)
				var/datum/computer_file/report/crew_record/faction/record = connected_faction.get_record(select_name)
				if(!record)
					if(!user_id_card) return
					if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
						to_chat(usr, "No record is on file for [select_name]. Insufficent access to add new members.")
						return 0
					if(!connected_faction.get_hiring_allowed())
						if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.in_command(user_id_card.registered_name))
							to_chat(usr, "No record is on file for [select_name]. Only members of Command categories can add new names to the records.")
							return 0
					var/choice = input(usr,"No record is on file for [select_name]. Would you like to create a new record for [select_name] based on information found in public records?") in list("Create", "Cancel")
					if(choice == "Cancel") return 1
					if(!connected_faction.get_record(select_name) && module)
						// record = new()
						// if(!record.load_from_global(select_name))
						// 	to_chat(user, "No public records have been found for [select_name]. Record creation aborted.")
						// 	return 0
						// connected_faction.records.faction_records |= record
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
				to_chat(usr, "<span class='warning'>Access denied.</span>")
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
							to_chat(usr, "<span class='notice'>Hardware error: Printer was unable to print the file. It may be out of paper.</span>")
							return
				else
					var/contents = {"<h4>Crew Manifest</h4>
									<br>
									[html_crew_manifest_faction(null, null, connected_faction, module.manifest_setting)]
									"}
					if(!computer.print_paper(contents, "crew manifest ([stationtime2text()])"))
						to_chat(usr, "<span class='notice'>Hardware error: Printer was unable to print the file. It may be out of paper.</span>")
						return
		if("eject")
			var/obj/item/weapon/stock_parts/computer/card_slot/card_slot = computer.get_component(PART_CARD)
			if(computer.get_inserted_id())
				card_slot.eject_id(user)
			else
				card_slot.insert_id(user.get_active_hand(), user)
		if("terminate")
			if(!authorized(user_id_card))
				to_chat(usr, "<span class='warning'>Access denied.</span>")
				return
			if(computer && can_run(user, 1))
				id_card.assignment = "Terminated"
				remove_nt_access(id_card)
				callHook("terminate_employee", list(id_card))
		if("edit")
			if(!authorized(user_id_card))
				to_chat(usr, "<span class='warning'>Access denied.</span>")
				return
			if(computer && can_run(user, 1))
				if(href_list["name"])
					var/temp_name = sanitizeName(input("Enter name.", "Name", id_card.registered_name),allow_numbers=TRUE)
					if(temp_name)
						id_card.registered_name = temp_name
						id_card.formal_name_suffix = initial(id_card.formal_name_suffix)
						id_card.formal_name_prefix = initial(id_card.formal_name_prefix)
					else
						computer.show_error(usr, "Invalid name entered!")
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
					to_chat(usr, "Access Denied.")
					return 0
				connected_faction.clear_member_expenses(id_card.registered_name)
		if("assign")
			if(!authorized(user_id_card))
				to_chat(usr, "<span class='warning'>Access denied.</span>")
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
							to_chat(usr, "<span class='warning'>No log exists for this job: [t1]</span>")
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
				to_chat(usr, "Access Denied.")
				return 0
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.outranks(user_id_card.registered_name, module.record.get_name()))
				to_chat(usr, "Insufficent Rank.")
				return 0
			//module.record.promote_votes |= user_id_card.registered_name
			connected_faction.promote_member(id_card.registered_name)
			// module.record.check_rank_change(connected_faction)
			UpdateIds(id_card.registered_name)
		if("demote")
			if(!user_id_card) return
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !(core_access_reassignment in user_accesses))
				to_chat(usr, "Access Denied.")
				return 0
			if(!(isghost(user) && check_rights(R_ADMIN, 0, user)) && !isleader && !connected_faction.outranks(user_id_card.registered_name, module.record.get_name()))
				to_chat(usr, "Insufficent Rank.")
				return 0
			//module.record.demote_votes |= user_id_card.registered_name
			connected_faction.demote_member(id_card.registered_name)
			// module.record.check_rank_change(connected_faction)
			UpdateIds(id_card.registered_name)
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
			to_chat(user, "Card successfully resynced to [connected_faction.name]")
			UpdateIds(id_card.registered_name)
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
