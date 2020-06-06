/proc/html_crew_manifest_faction(var/monochrome, var/OOC, var/datum/world_faction/connected_faction, var/setting = 1) // setting 1 = online members, setting 2 = all members
	CRASH("IMPLEMENT ME")
	// if(!connected_faction) return
	// var/list/dept_data[0]
	// for(var/datum/assignment_category/category in connected_faction.assignment_categories)
	// 	dept_data += "0"
	// 	dept_data[dept_data.len] = list("names" = list(), "header" = category.name, "flag" = category.name)
	// dept_data += "0"
	// dept_data[dept_data.len] = list("names" = list(), "header" = "Elected/Appointed", "flag" = "Special Assignments")
	// dept_data += "0"
	// dept_data[dept_data.len] = list("names" = list(), "header" = "Off duty", "flag" = "Off duty")
	// var/list/misc //Special departments for easier access
	// for(var/list/department in dept_data)
	// 	if(department["flag"] == MSC)
	// 		misc = department["names"]

	// var/list/isactive = new()
	// var/list/mil_ranks = list() // HTML to prepend to name
	// var/dat = {"
	// <head><style>
	// 	.manifest {border-collapse:collapse;}
	// 	.manifest td, th {border:1px solid [monochrome?"black":"[OOC?"black; background-color:#272727; color:white":"#DEF; background-color:white; color:black"]"]; padding:.25em}
	// 	.manifest th {height: 2em; [monochrome?"border-top-width: 3px":"background-color: [OOC?"#40628a":"#48c"]; color:white"]}
	// 	.manifest tr.head th { [monochrome?"border-top-width: 1px":"background-color: [OOC?"#013D3B;":"#488;"]"] }
	// 	.manifest td:first-child {text-align:right}
	// 	.manifest tr.alt td {[monochrome?"border-top-width: 2px":"background-color: [OOC?"#373737; color:white":"#DEF"]"]}
	// </style></head>
	// <table class="manifest" width='350px'>
	// <tr class='head'><th>Name</th><th>Position</th><th>Activity</th></tr>
	// "}
	// // sort mobs
	// var/list/records = list()
	// var/list/offduty = list()
	// if(setting == 1)
	// 	for(var/obj/item/organ/internal/stack/stack in connected_faction.connected_laces)
	// 		var/datum/computer_file/report/crew_record/record = connected_faction.get_record(stack.get_owner_name())
	// 		if(!record)
	// 			continue
	// 		if(stack.duty_status)
	// 			records |= record
	// 		else
	// 			offduty |= record
	// else
	// 	for(var/datum/computer_file/report/crew_record/faction/R in connected_faction.records.faction_records)
	// 		records |= R

	// for(var/datum/computer_file/report/crew_record/faction/CR in records)
	// 	var/name = CR.get_name()
	// 	var/datum/assignment/assignment = connected_faction.get_assignment(CR.get_assignment_uid(), name)
	// 	var/rank
	// 	if(CR.get_custom_title())
	// 		rank = CR.get_custom_title()
	// 	if(assignment)
	// 		if(!rank)
	// 			rank = assignment.get_title(CR.get_rank())
	// 		var/found_place = 0
	// 		var/datum/assignment_category/category = assignment.parent
	// 		if(category)
	// 			for(var/list/department in dept_data)
	// 				var/list/names = department["names"]
	// 				if(category.name == department["flag"])
	// 					names[name] = rank
	// 					found_place = 1
	// 		if(!found_place)
	// 			var/list/names = misc["names"]
	// 			names[name] = rank
	// 	else
	// 		if(!rank) rank = "Unset"
	// 		var/list/names = misc["names"]
	// 		names[name] = rank
	// 	mil_ranks[name] = ""

	// 	if(GLOB.using_map.flags & MAP_HAS_RANK)
	// 		var/datum/mil_branch/branch_obj = mil_branches.get_branch(CR.get_branch())
	// 		var/datum/mil_rank/rank_obj = mil_branches.get_rank(CR.get_branch(), CR.get_rank())

	// 		if(branch_obj && rank_obj)
	// 			mil_ranks[name] = "<abbr title=\"[rank_obj.name], [branch_obj.name]\">[rank_obj.name_short]</abbr> "

	// 	var/active = 0
	// 	for(var/mob/M in GLOB.player_list)
	// 		if(M.real_name == name && M.client && M.client.inactivity <= 10 * 60 * 10)
	// 			active = 1
	// 			break
	// 	isactive[name] = active ? "Active" : "Inactive"
	// for(var/datum/computer_file/report/crew_record/faction/CR in offduty)
	// 	var/name = CR.get_name()
	// 	var/datum/assignment/assignment = connected_faction.get_assignment(CR.get_assignment_uid(),name)
	// 	var/rank
	// 	if(CR.get_custom_title())
	// 		rank = CR.get_custom_title()
	// 	if(assignment)
	// 		if(!rank)
	// 			rank = assignment.get_title(CR.get_rank())
	// 	if(!rank) rank = "Unset"
	// 	for(var/list/department in dept_data)
	// 		var/list/names = department["names"]
	// 		if(department["flag"] == "Off duty")
	// 			names[name] = rank
	// 	mil_ranks[name] = ""

	// 	if(GLOB.using_map.flags & MAP_HAS_RANK)
	// 		var/datum/mil_branch/branch_obj = mil_branches.get_branch(CR.get_branch())
	// 		var/datum/mil_rank/rank_obj = mil_branches.get_rank(CR.get_branch(), CR.get_rank())

	// 		if(branch_obj && rank_obj)
	// 			mil_ranks[name] = "<abbr title=\"[rank_obj.name], [branch_obj.name]\">[rank_obj.name_short]</abbr> "

	// 	var/active = 0
	// 	for(var/mob/M in GLOB.player_list)
	// 		if(M.real_name == name && M.client && M.client.inactivity <= 10 * 60 * 10)
	// 			active = 1
	// 			break
	// 	isactive[name] = active ? "Active" : "Inactive"
	// for(var/list/department in dept_data)
	// 	var/list/names = department["names"]
	// 	if(names.len > 0)
	// 		dat += "<tr><th colspan=3>[department["header"]]</th></tr>"
	// 		for(var/name in names)
	// 			if(isactive[name] != "Inactive")
	// 				dat += "<tr class='candystripe'><td>[mil_ranks[name]][name]</td><td>[names[name]]</td><td>[isactive[name]]</td></tr>"

	// dat += "</table>"
	// dat = replacetext(dat, "\n", "") // so it can be placed on paper correctly
	// dat = replacetext(dat, "\t", "")
	// return dat

