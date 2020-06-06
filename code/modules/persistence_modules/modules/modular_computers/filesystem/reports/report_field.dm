/datum/report_field
	var/faction_uid_access          //faction uid required to access
	var/faction_uid_edit            //faction uid required to edit

/datum/report_field/New(datum/computer_file/report/report)
	..()
	ADD_SAVED_VAR(name)
	ADD_SAVED_VAR(value)
	ADD_SAVED_VAR(access_edit)
	ADD_SAVED_VAR(access)
	ADD_SAVED_VAR(faction_uid_access)
	ADD_SAVED_VAR(faction_uid_edit)

/datum/report_field/set_access(access, access_edit, override = 1, var/faction_uid_access, var/faction_uid_edit)
	if(access)
		if(!islist(access))
			access = list(access)
		override ? (src.access = list(access)) : (src.access += list(access))
	if(access_edit)
		if(!islist(access_edit))
			access_edit = list(access_edit)
		override ? (src.access_edit = list(access_edit)) : (src.access_edit += list(access_edit))

	src.faction_uid_access = faction_uid_access
	src.faction_uid_edit = faction_uid_edit

/datum/report_field/verify_access(given_access, faction_uid)
	if(faction_uid_access && faction_uid_access != faction_uid)
		return FALSE
	return has_access_pattern(access, given_access)

/datum/report_field/verify_access_edit(given_access, faction_uid)
	if(!verify_access(given_access, faction_uid))
		return
	if(faction_uid_edit && faction_uid_edit != faction_uid)
		return FALSE
	return has_access_pattern(access_edit, given_access)

/datum/report_field/generate_nano_data(list/given_access, var/datum/world_faction/faction)
	var/dat = list()
	if(given_access)
		dat["access"] = verify_access(given_access, faction?.uid)
		dat["access_edit"] = verify_access_edit(given_access, faction?.uid)
	dat["name"] = display_name()
	dat["value"] = get_value()
	dat["can_edit"] = can_edit
	dat["needs_big_box"] = needs_big_box
	dat["ignore_value"] = ignore_value
	dat["ID"] = ID
	return dat
