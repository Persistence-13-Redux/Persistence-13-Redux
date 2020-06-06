/datum/admins/Topic(href, href_list)
	..()
	if(usr.client != src.owner || !check_rights(0))
		log_admin("[key_name(usr)] tried to use the admin panel without authorization.")
		message_admins("[usr.key] has attempted to override the admin panel!")
		return

	if(SSticker.mode && SSticker.mode.check_antagonists_topic(href, href_list))
		check_antagonists()
		return
	
	if(href_list["increaseslots"])
		var/ckey = sanitizeName(href_list["increaseslots"])
		var/slots = CharacterSaves.GetMaxSaveSlots(ckey)
		slots = min(100, slots + 1) //Just some sanity value check so someone doesn't break anything
		usr.client.holder.bonus_panel_refresh(usr, usr.client.ckey)
		CharacterSaves.SetMaxSaveSlots(ckey, slots)

	else if(href_list["decreaseslots"])
		var/ckey = sanitizeName(href_list["decreaseslots"])
		var/slots = CharacterSaves.GetMaxSaveSlots(ckey)
		slots = max(0, slots - 1)
		usr.client.holder.bonus_panel_refresh(usr, usr.client.ckey)
		CharacterSaves.SetMaxSaveSlots(ckey, slots)

	else if(href_list["editnotes"])
		var/ckey = sanitizeName(href_list["editnotes"])
		var/notes = CharacterSaves.GetBonusNotes(ckey)
		notes = sanitize(input(usr,"Edit Bonus Notes","bonus notes", notes) as text|null)
		CharacterSaves.SetBonusNotes(ckey, notes)
		usr.client.holder.bonus_panel_refresh(usr, usr.client.ckey)

	// else if(href_list["subtlemessage"])
	// 	if(!check_rights(R_MOD,0) && !check_rights(R_ADMIN))  return

	// 	var/mob/M = locate(href_list["subtlemessage"])
	// 	usr.client.cmd_admin_subtle_message(M)
