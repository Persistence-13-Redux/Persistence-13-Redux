/datum/computer_file/report
	var/faction_uid_access          //faction uid required to access
	var/faction_uid_edit            //faction uid required to edit

/datum/computer_file/report/New()
	..()
	ADD_SAVED_VAR(title)
	ADD_SAVED_VAR(form_name)
	ADD_SAVED_VAR(creator)
	ADD_SAVED_VAR(file_time)
	ADD_SAVED_VAR(access_edit)
	ADD_SAVED_VAR(access)
	ADD_SAVED_VAR(fields)
	ADD_SAVED_VAR(logo)
	ADD_SAVED_VAR(faction_uid_access)
	ADD_SAVED_VAR(faction_uid_edit)

/datum/computer_file/report/after_load()
	. = ..()
	//make sure all our references are up to date
	for(var/datum/report_field/field in fields)
		field.owner = src

/datum/computer_file/report/set_access(access, access_edit, recursive = 1, override = 1, var/faction_uid_access = null, var/faction_uid_edit = null)
	if(access)
		if(!islist(access))
			access = list(access)
		override ? (src.access = list(access)) : (src.access += list(access))  //Note that this is a list of lists.
	if(access_edit)
		if(!islist(access_edit))
			access_edit = list(access_edit)
		override ? (src.access_edit = list(access_edit)) : (src.access_edit += list(access_edit))
	if(recursive)
		for(var/datum/report_field/field in fields)
			field.set_access(access, access_edit, override, faction_uid_access, faction_uid_edit)

	src.faction_uid_access = faction_uid_access
	src.faction_uid_edit = faction_uid_edit

/datum/computer_file/report/verify_access(given_access, faction_uid)
	if(faction_uid_access && faction_uid_access != faction_uid)
		return FALSE
	return has_access_pattern(access, given_access)

/datum/computer_file/report/verify_access_edit(given_access, faction_uid)
	if(!verify_access(given_access, faction_uid))
		return //Need access for access_edit
	if(faction_uid_edit && faction_uid_edit != faction_uid)
		return FALSE
	return has_access_pattern(access_edit, given_access)

/datum/computer_file/report/clone()
	var/datum/computer_file/report/temp = ..()
	temp.faction_uid_access = faction_uid_access
	temp.faction_uid_edit = faction_uid_edit
	return temp

/datum/computer_file/report/generate_nano_data(list/given_access, var/datum/world_faction/faction)
	. = list()
	.["name"] = display_name()
	.["uid"] = uid
	.["creator"] = creator
	.["file_time"] = file_time
	.["fields"] = list()
	if(given_access)
		.["access"] = verify_access(given_access, faction.uid)
		.["access_edit"] = verify_access_edit(given_access, faction.uid)
	for(var/datum/report_field/field in fields)
		.["fields"] += list(field.generate_nano_data(given_access, faction))
