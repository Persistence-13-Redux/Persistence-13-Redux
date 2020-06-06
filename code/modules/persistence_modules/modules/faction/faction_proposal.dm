/datum/world_faction/proc/proposal_approved(var/datum/proposal/proposal)
	return 0
/datum/world_faction/proc/proposal_denied(var/datum/proposal/proposal)
	return 0

// PROPOSALS
/datum/proposal
	var/name = "Unnamed proposal"
	var/started_by = ""
	var/required = 51
	var/support = 0
	var/denyrequired = 49
	var/deny = 0
	var/connected_uid = ""
	var/connected_type = 1 // 1 = faction, 2 = business
	var/list/supporters = list() //format = list(real_name = "10")
	var/list/deniers = list()
	var/func = 1
	var/change = ""

/datum/proposal/proc/calculate_support()
	var/new_support = 0
	for(var/x in supporters)
		new_support += text2num(supporters[x])
	support = new_support
	if(support >= required)
		approved()
		return support
	var/new_deny = 0
	for(var/x in deniers)
		new_deny += text2num(deniers[x])
	deny = deny
	if(deny >= denyrequired)
		denied()
		return deny

/datum/proposal/proc/get_support()
	var/new_support = 0
	for(var/x in supporters)
		new_support += text2num(supporters[x])
	support = new_support
	return new_support
/datum/proposal/proc/get_deny()
	var/new_support = 0
	for(var/x in deniers)
		new_support += text2num(deniers[x])
	deny = new_support
	return new_support

/datum/proposal/proc/add_support(var/name, var/support)
	if(!name || !support) return
	supporters[name] = support
	deniers -= name
	calculate_support()
/datum/proposal/proc/remove_support(var/name)
	supporters -= name
	calculate_support()
/datum/proposal/proc/add_denial(var/name, var/support)
	if(!name || !support) return
	deniers[name] = support
	supporters -= name
	calculate_support()

/datum/proposal/proc/remove_denial(var/name)
	deniers -= name
	calculate_support()

/datum/proposal/proc/approved()
	if(connected_type == 1)
		var/datum/world_faction/connected_faction = FindFaction(connected_uid)
		connected_faction.proposal_approved(src)

/datum/proposal/proc/denied()
	if(connected_type == 1)
		var/datum/world_faction/connected_faction = FindFaction(connected_uid)
		connected_faction.proposal_denied(src)