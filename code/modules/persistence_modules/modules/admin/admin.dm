
/hook/global_init/proc/AddExtraVerbs()
	admin_verbs_admin += /datum/admins/proc/discord_broadcast
	admin_verbs_admin += /datum/admins/proc/savenow	//persistent edit, savenow saves the station,
	admin_verbs_admin += /client/proc/bonus_panel

	admin_verbs_debug += /datum/designer_system/proc/delete_designs
	return TRUE

/datum/admins/proc/bonus_panel()
	if(!check_rights(R_ADMIN))
		return
	var/ckey = lowertext(input(usr, "Enter the ckey of the person you want to edit", "Bonus Panel", "") as text|null)
	if(!ckey) return

	var/bonus_slots = CharacterSaves.GetMaxSaveSlots(ckey)
	var/bonus_notes = CharacterSaves.GetBonusNotes(ckey)

	var/dat = ""
	dat += "<h2>Bonus Panel</h2>"
	dat += "Currently viewing [ckey]<br><br>"
	dat += "Bonus Slots: [bonus_slots] <a href='?src=\ref[src];increaseslots=[ckey]'>Increase Slots</a>    <a href='?src=\ref[src];decreaseslots=[ckey]'>Decrease Slots</a><br><br>"
	dat += "Bonus Notes: [bonus_notes] <br><a href='?src=\ref[src];editnotes=[ckey]'>Edit Bonus Notes</a><br><br>"


	var/datum/browser/popup = new(usr, "bonus", "Bonus", 300, 400)
	popup.set_content(dat)
	popup.open()
	return

/datum/admins/proc/bonus_panel_refresh(var/mob/user, var/ckey)
	if(!check_rights(R_ADMIN))
		return
	var/bonus_slots = CharacterSaves.GetMaxSaveSlots(ckey)
	var/bonus_notes = CharacterSaves.GetBonusNotes(ckey)

	var/dat = ""
	dat += "<h2>Bonus Panel</h2>"
	dat += "Currently viewing [ckey]<br><br>"
	dat += "Bonus Slots: [bonus_slots] <a href='?src=\ref[src];increaseslots=[ckey]'>Increase Slots</a>    <a href='?src=\ref[src];decreaseslots=[ckey]'>Decrease Slots</a><br><br>"
	dat += "Bonus Notes: [bonus_notes] <br><a href='?src=\ref[src];editnotes=[ckey]'>Edit Bonus Notes</a><br><br>"
	var/datum/browser/popup = new(user, "bonus", "Bonus", 300, 400)
	popup.set_content(dat)
	popup.open()
	return

/client/proc/bonus_panel()
	set category = "Server"
	set desc="Open Host Panel"
	set name="Host Panel"
	if(!check_rights(R_ADMIN))
		return
	if(holder)
		holder.bonus_panel()
