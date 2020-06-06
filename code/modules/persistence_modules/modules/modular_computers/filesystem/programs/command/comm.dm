#define STATE_DEFAULT	1
#define STATE_MESSAGELIST	2
#define STATE_VIEWMESSAGE	3
#define STATE_STATUSDISPLAY	4
#define STATE_ALERT_LEVEL	5

/datum/computer_file/program/comm
	usage_flags = PROGRAM_CONSOLE | PROGRAM_LAPTOP | PROGRAM_TELESCREEN

/datum/nano_module/program/comm/Topic(href, href_list)
	if(..())
		return 1
	var/mob/user = usr
	var/ntn_comm = program ? !!program.get_signal(NTNET_COMMUNICATION) : 1
	var/ntn_cont = program ? !!program.get_signal(NTNET_SYSTEMCONTROL) : 1
	var/datum/comm_message_listener/l = obtain_message_listener()
	var/datum/world_faction/connected_faction = program.get_network_faction()
	switch(href_list["action"])
		if("sw_menu")
			. = 1
			current_status = text2num(href_list["target"])
		if("announce")
			. = 1
			if(is_autenthicated(user) && !issilicon(usr) && ntn_comm)
				if(user)
					var/obj/item/weapon/card/id/id_card = user.GetIdCard()
					crew_announcement.announcer = GetNameAndAssignmentFromId(id_card)
				else
					crew_announcement.announcer = "Unknown"
				if(announcment_cooldown)
					to_chat(usr, "Please allow at least one minute to pass between announcements")
					return TRUE
				var/input = input(usr, "Please write a message to announce to the [station_name()].", "Priority Announcement") as null|message
				if(!input || !can_still_topic())
					return 1
				var/affected_zlevels = GetConnectedZlevels(get_host_z())
				var/atom/A = host
				if(istype(A))
					affected_zlevels = GetConnectedZlevels(A.z)
				crew_announcement.faction = connected_faction.name
				crew_announcement.sector = program.computer.get_physical_host().z+(program.computer.get_physical_host().z % 2)
				crew_announcement.Announce(input, zlevels = affected_zlevels)
				GLOB.discord_api.broadcast("(Announcement by [usr.real_name]) [input]")
				announcment_cooldown = 1
				spawn(600)//One minute cooldown
					announcment_cooldown = 0
		if("message")
			. = 1
			if(href_list["target"] == "emagged")
				if(program)
					if(is_autenthicated(user) && program.computer.emagged() && !issilicon(usr) && ntn_comm)
						if(centcomm_message_cooldown)
							to_chat(usr, "<span class='warning'>Arrays recycling. Please stand by.</span>")
							SSnano.update_uis(src)
							return
						var/input = sanitize(input(usr, "Please choose a message to transmit to \[ABNORMAL ROUTING CORDINATES\] via quantum entanglement.  Please be aware that this process is very expensive, and abuse will lead to... termination. Transmission does not guarantee a response. There is a 30 second delay before you may send another message, be clear, full and concise.", "To abort, send an empty message.", "") as null|text)
						if(!input || !can_still_topic())
							return 1
						Syndicate_announce(input, usr)
						to_chat(usr, "<span class='notice'>Message transmitted.</span>")
						log_say("[key_name(usr)] has made an illegal announcement: [input]")
						centcomm_message_cooldown = 1
						spawn(300)//30 second cooldown
							centcomm_message_cooldown = 0
			else if(href_list["target"] == "regular")
				if(is_autenthicated(user) && !issilicon(usr) && ntn_comm)
					if(centcomm_message_cooldown)
						to_chat(usr, "<span class='warning'>Arrays recycling. Please stand by.</span>")
						SSnano.update_uis(src)
						return
					if(!is_relay_online())//Contact Centcom has a check, Syndie doesn't to allow for Traitor funs.
						to_chat(usr, "<span class='warning'>No Emergency Bluespace Relay detected. Unable to transmit message.</span>")
						return 1
					var/input = sanitize(input("Please choose a message to transmit to [GLOB.using_map.boss_short] via quantum entanglement.  Please be aware that this process is very expensive, and abuse will lead to... termination.  Transmission does not guarantee a response. There is a 30 second delay before you may send another message, be clear, full and concise.", "To abort, send an empty message.", "") as null|text)
					if(!input || !can_still_topic())
						return 1
					Centcomm_announce(input, usr)
					to_chat(usr, "<span class='notice'>Message transmitted.</span>")
					log_say("[key_name(usr)] has made an IA [GLOB.using_map.boss_short] announcement: [input]")
					centcomm_message_cooldown = 1
					spawn(300) //30 second cooldown
						centcomm_message_cooldown = 0
		if("evac")
			. = 1
			if(is_autenthicated(user))
				var/datum/evacuation_option/selected_evac_option = evacuation_controller.evacuation_options[href_list["target"]]
				if (isnull(selected_evac_option) || !istype(selected_evac_option))
					return
				if (!selected_evac_option.silicon_allowed && issilicon(user))
					return
				if (selected_evac_option.needs_syscontrol && !ntn_cont)
					return
				var/confirm = alert("Are you sure you want to [selected_evac_option.option_desc]?", name, "No", "Yes")
				if (confirm == "Yes" && can_still_topic())
					evacuation_controller.handle_evac_option(selected_evac_option.option_target, user)
		if("setstatus")
			. = 1
			if(is_autenthicated(user) && ntn_cont)
				switch(href_list["target"])
					if("line1")
						var/linput = reject_bad_text(sanitize(input("Line 1", "Enter Message Text", msg_line1) as text|null, 40), 40)
						if(can_still_topic())
							msg_line1 = linput
					if("line2")
						var/linput = reject_bad_text(sanitize(input("Line 2", "Enter Message Text", msg_line2) as text|null, 40), 40)
						if(can_still_topic())
							msg_line2 = linput
					if("message")
						post_status("message", msg_line1, msg_line2)
					if("image")
						post_status("image", href_list["image"])
					else
						post_status(href_list["target"])
		if("setalert")
			. = 1
			if(is_autenthicated(user) && !issilicon(usr) && ntn_cont && ntn_comm)
				var/decl/security_state/security_state = decls_repository.get_decl(GLOB.using_map.security_state)
				var/decl/security_level/target_level = locate(href_list["target"]) in security_state.comm_console_security_levels
				if(target_level && security_state.can_switch_to(target_level))
					var/confirm = alert("Are you sure you want to change the alert level to [target_level.name]?", name, "No", "Yes")
					if(confirm == "Yes" && can_still_topic())
						if(security_state.set_security_level(target_level))
							SSstatistics.add_field(target_level.type,1)
			else
				to_chat(usr, "You press the button, but a red light flashes and nothing happens.") //This should never happen

			current_status = STATE_DEFAULT
		if("viewmessage")
			. = 1
			if(is_autenthicated(user) && ntn_comm)
				current_viewing_message_id = text2num(href_list["target"])
				for(var/list/m in l.messages)
					if(m["id"] == current_viewing_message_id)
						current_viewing_message = m
				current_status = STATE_VIEWMESSAGE
		if("delmessage")
			. = 1
			if(is_autenthicated(user) && ntn_comm && l != global_message_listener)
				l.Remove(current_viewing_message)
			current_status = STATE_MESSAGELIST
		if("printmessage")
			. = 1
			if(is_autenthicated(user) && ntn_comm)
				if(!program.computer.print_paper(current_viewing_message["contents"],current_viewing_message["title"]))
					to_chat(usr, "<span class='notice'>Hardware Error: Printer was unable to print the selected file.</span>")
		if("unbolt_doors")
			GLOB.using_map.unbolt_saferooms()
			to_chat(usr, "<span class='notice'>The console beeps, confirming the signal was sent to have the saferooms unbolted.</span>")
		if("bolt_doors")
			GLOB.using_map.bolt_saferooms()
			to_chat(usr, "<span class='notice'>The console beeps, confirming the signal was sent to have the saferooms bolted.</span>")

#undef STATE_DEFAULT
#undef STATE_MESSAGELIST
#undef STATE_VIEWMESSAGE
#undef STATE_STATUSDISPLAY
#undef STATE_ALERT_LEVEL
