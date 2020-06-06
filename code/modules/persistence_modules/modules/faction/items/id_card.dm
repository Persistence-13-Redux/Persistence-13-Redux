/obj/item/weapon/card/id
	var/species = "\[UNSET\]"
	var/selected_faction_uid //the "active" faction UID for the card. When set things that query the card for a single faction, will get this faction
	var/tmp/datum/world_faction/selected_faction
	//Contains a list of all the factions that endorsed the id, with the access details for each
	// Its better to cache the access details in the card and update them remotely when needed than always
	// query the faction database for access each times we try to get a linked faction's granted accesses
	// Format is (FACTION_UID = ACCESS_LIST)
	var/list/faction_access = list()

/obj/item/weapon/card/id/Initialize()
	GLOB.all_id_cards |= src
	. = ..()

/obj/item/weapon/card/id/Destroy()
	GLOB.all_id_cards -= src
	return ..()

/obj/item/weapon/card/id/after_load()
	. = ..()

/obj/item/weapon/card/id/proc/devalidate()
	name = "unreadable id card"
	desc = "A card used to provide ID and determine access. This one got remotely wiped apparently.."
	access = list()
	registered_name = "Devalidated" // The name registered_name on the card
	associated_account_number = 0
	associated_email_login = list("login" = "", "password" = "")
	age = "\[UNSET\]"
	blood_type = "\[UNSET\]"
	dna_hash = "\[UNSET\]"
	fingerprint_hash = "\[UNSET\]"
	sex = "\[UNSET\]"
	front = null
	side = null
	assignment = null
	rank = null
	dorm = 0
	job_access_type = null
	military_branch = null
	military_rank = null
	formal_name_prefix = ""
	formal_name_suffix = ""
	selected_faction_uid = null
	faction_access.Cut()
	update_name()

/obj/item/weapon/card/id/proc/sync_from_record(var/datum/computer_file/report/crew_record/record)
	age = record.get_age()
	blood_type = record.get_bloodtype()
	dna_hash = record.get_dna()
	fingerprint_hash = record.get_fingerprint()
	sex = record.get_sex()
	species = record.get_species()
	front = record.photo_front
	side = record.photo_side
	var/datum/computer_file/report/crew_record/faction/FR = record
	if(istype(FR))
		if(FR.get_employement_status() == EMPLOYMENT_STATUS_FIRED) 
			assignment = "Terminated"
			rank = 0
		if(FR.get_custom_title())
			assignment = FR.get_custom_title()	//can be alt title or the actual job
		else
			var/datum/world_faction/faction = FindFaction(selected_faction_uid)
			if(!faction) return
			var/datum/assignment/job = faction.get_assignment(FR.get_assignment_uid(), FR.get_name())
			if(!job)
				assignment = "Unassigned"
				rank = 0
				name = text("[registered_name]'s ID Card [get_faction_tag(selected_faction_uid)]-([assignment])")
				return
			assignment = job.get_title(FR.get_rank())
	rank = record.get_rank()	//actual job
	name = text("[registered_name]'s ID Card [get_faction_tag(selected_faction_uid)]-([assignment])")

/obj/item/weapon/card/id/proc/update_name()
	name = "[registered_name]'s ID Card"
	if(military_rank && military_rank.name_short)
		name = military_rank.name_short + " " + name
	if(assignment)
		name = name + " ([assignment])"

/mob/set_id_info(var/obj/item/weapon/card/id/id_card)
	. = ..()
	id_card.update_name()

/obj/item/weapon/card/id/dat()
	var/list/dat = list("<table><tr><td>")
	dat += text("Name: []</A><BR>", "[formal_name_prefix][registered_name][formal_name_suffix]")
	dat += text("Sex: []</A><BR>\n", sex)
	dat += text("Age: []</A><BR>\n", age)

	if(GLOB.using_map.flags & MAP_HAS_BRANCH)
		dat += text("Branch: []</A><BR>\n", military_branch ? military_branch.name : "\[UNSET\]")
	if(GLOB.using_map.flags & MAP_HAS_RANK)
		dat += text("Rank: []</A><BR>\n", military_rank ? military_rank.name : "\[UNSET\]")
	var/datum/world_faction/faction = FindFaction(selected_faction_uid)
	if(faction)
		dat += text("Connected Organization: []</A><BR>\n", faction.name)
		if(length(faction_access))
			dat  += "<A href='byond://?src=\ref[src];changeorg=1'>Connect to different organization.</A><BR>"
	dat += text("Assignment: []</A><BR>\n", assignment)
	dat += text("Fingerprint: []</A><BR>\n", fingerprint_hash)
	dat += text("Blood Type: []<BR>\n", blood_type)
	dat += text("DNA Hash: []<BR><BR>\n", dna_hash)
	if(front && side)
		dat +="<td align = center valign = top>Photo:<br><img src=front.png height=80 width=80 border=4><img src=side.png height=80 width=80 border=4></td>"
	dat += "</tr></table>"
	return jointext(dat,null)

/obj/item/weapon/card/id/OnTopic(mob/user, list/href_list)
	if(href_list["changeorg"])
		var/list/datum/world_faction/associated_factions = get_associated_factions(registered_name)
		var/datum/world_faction/F = input(usr, "Choose an organization to connect to.", "Active faction select", null) as null|anything in associated_factions
		if(!F)
			return TOPIC_NOACTION
		selected_faction_uid = F.uid
		var/datum/browser/popup = new(usr, "idcard", name, 600, 250)
		popup.set_content(dat())
		popup.set_title_image(usr.browse_rsc_icon(src.icon, src.icon_state))
		popup.open()
	return ..()

/obj/item/weapon/card/id/attack_self(mob/user as mob)
	user.visible_message("\The [user] shows you: \icon[src] [src.name]. The assignment on the card: <font color=navy>[get_faction_tag(get_faction_uid())]</font>-([src.assignment])",\
		"You flash your ID card: \icon[src] [src.name]. The assignment on the card: <font color=navy>[get_faction_tag(get_faction_uid())]</font>-([src.assignment])")

/obj/item/weapon/card/id/get_faction()
	. = selected_faction? selected_faction : FindFaction(selected_faction_uid)
	selected_faction = .

/obj/item/weapon/card/id/get_faction_uid()
	return selected_faction_uid

//Check the specified faction and copy over access values
/obj/item/weapon/card/id/proc/update_cached_access(var/faction_uid)
	var/datum/world_faction/faction = FindFaction(faction_uid)
	if(!faction)
		return FALSE
	src.access = list()
	var/datum/computer_file/report/crew_record/faction/record = faction.get_record(registered_name)
	if(!record)
		return TRUE //No records, so we don't have any rights
	var/datum/assignment/ass = faction.get_assignment(record.get_assignment_uid(), registered_name)
	if(!ass)
		return TRUE //No assignments, so we have only public rights

	//Get the permissions for the current assignment
	var/list/AL = ass.get_access()
	if(!length(AL))
		return TRUE //No assignments, so we have only public rights
	src.access.Insert(length(src.access), AL)
	return TRUE

/obj/item/weapon/card/id/GetAccess(var/faction_uid)
	if(!faction_uid || faction_uid == "")
		faction_uid = get_faction()
	update_cached_access(faction_uid)
	return src.access

//==============================
// Synthethic id card
//==============================
/obj/item/weapon/card/id/synthetic/New()
	. = ..()
	access = access_synth //Synths don't get all access

/obj/item/weapon/card/id/synthetic/devalidate()
	return //Don't devalidate those, it would be kinda bad..

/obj/item/weapon/card/id/synthetic/GetAccess(var/faction_uid)
	. = access
	if(faction_uid && faction_access[faction_uid])
		. |= faction_access[faction_uid]
	return .

