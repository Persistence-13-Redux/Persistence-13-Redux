//========================================
//	Helpers
//========================================
/proc/CreateNewFaction(var/_uid, var/_name, var/_abbreviation, var/_short_tag, var/_desc, var/_network_id, var/_network_password)
	var/datum/world_faction/F = new(_uid, _name, _abbreviation, _short_tag, _desc)
	F.network_uid = _network_id
	F.password = _network_password
	F.InitialSetup()
	return F

/proc/FindFaction(var/name, var/password)
	if(password)
		var/datum/world_faction/found_faction
		for(var/datum/world_faction/fac in GLOB.all_world_factions)
			if(fac && fac.uid == name)
				found_faction = fac
				break
		if(!found_faction) return
		if(found_faction.password != password) return
		return found_faction
	var/datum/world_faction/found_faction
	for(var/datum/world_faction/fac in GLOB.all_world_factions)
		if(fac && fac.uid == name)
			found_faction = fac
			break
	return found_faction

/proc/get_faction_tag(var/name)
	var/datum/world_faction/fac = FindFaction(name)
	if(fac)
		return fac.short_tag
	else
		return "BROKE"

//Return a list of factions that have records for the given character
/proc/get_associated_factions(var/real_name)
	var/list/datum/world_faction/FL = list()
	for(var/datum/world_faction/F in GLOB.all_world_factions)
		if(F.get_record(real_name))
			FL += F
	return FL

/proc/DevalidateIDs(var/real_name)
	var/datum/character_records/CR = GetCharacterRecord(real_name)
	if(!CR)
		message_admins("no record found for [real_name]")
		return
	
	for(var/obj/item/weapon/card/id/I in GLOB.all_id_cards)
		if(I.registered_name == real_name)
			I.devalidate()

/proc/UpdateIds(var/real_name)
	for(var/obj/item/weapon/card/id/I in GLOB.all_id_cards)
		if(I.registered_name == real_name && I.get_faction_uid())
			var/datum/world_faction/F = FindFaction(I.get_faction_uid())
			var/datum/computer_file/report/crew_record/faction/CR = F?.get_record(I.registered_name)
			if(!CR || !F)
				I.selected_faction = null
				continue
			I.sync_from_record(CR)