
//Overriden to disallow people from modifying characters that already exists. 
// Since the preferences wouldn't actually affect the in-game characters anyways.
/datum/preferences/ShowChoices(mob/user)
	if(!SScharacter_setup.initialized)
		return
	if(!user || !user.client)
		return

	if(!get_mob_by_key(client_ckey))
		to_chat(user, "<span class='danger'>No mob exists for the given client!</span>")
		close_load_dialog(user)
		return

	var/datum/character_records/CR = GetCharacterRecordsForCKEYAndSaveSlot(client.ckey, default_slot)
	var/can_edit = !(CR && CR.get_status() != CHARACTER_RECORD_STATUS_NEW)
	var/dat = "<html><body><center>"

	if(path)
		dat += "Slot #[default_slot] - "
		dat += "<a href='?src=\ref[src];load=1'>Load slot</a> - "
		if(can_edit) 
			dat += "<a href='?src=\ref[src];save=1'>Save slot</a> - "
		dat += "<a href='?src=\ref[src];resetslot=1'>Reset slot</a> - "
		dat += "<a href='?src=\ref[src];reload=1'>Reload slot</a>"

	else
		dat += "Please create an account to save your preferences."

	//If the character already exists in-game, don't allow editing and show the character preview instead
	if(!can_edit)
		dat += "<br><br><HR></center>"
		dat += make_existing_character_preview(CR, user)
	//Otherwise, show the default stuff
	else
		dat += "<br>"
		dat += player_setup.header()
		dat += "<br><HR></center>"
		dat += player_setup.content(user)

	dat += "</html></body>"
	var/datum/browser/popup = new(user, "Character Setup","Character Setup", 1200, 800, src)
	popup.set_content(dat)
	popup.open()

/datum/preferences/proc/make_existing_character_preview(var/datum/character_records/CR, var/user)
	var/icon/front_icon = CR.get_front_picture()
	var/icon/side_icon = CR.get_side_picture()
	send_rsc(user, CR.get_front_picture(), "previewicon_front.png")
	send_rsc(user, CR.get_side_picture(), "previewicon_side.png")
	. = {"
	<b>Name:</b><b>[CR.get_real_name()]</b><br>
	<b>Status:</b><b>[CharacterRecordStatusNumToString(CR.get_status())]</b><br>
	<b>DNA Hash:</b><b>[CR.get_dna()]</b><br>
	<b>Fingerprint Hash:</b><b>[CR.get_fingerprint()]</b><br>
	<b>Preview</b><br>
	<div class='statusDisplay'><center><img src=previewicon_front.png width=[front_icon.Width()] height=[front_icon.Height()]></center></div><br>
	<div class='statusDisplay'><center><img src=previewicon_side.png width=[side_icon.Width()] height=[side_icon.Height()]></center></div><br>
	"}

/datum/preferences/Topic(href, list/href_list)
	. = ..()
	if(href_list["resetslot"] && .) //Only go ahead if they accepted
		var/datum/character_records/CR = GetCharacterRecordsForCKEYAndSaveSlot(client.ckey, default_slot)
		if(!CR)
			return 0
		DeleteCharacterRecord(CR.real_name)