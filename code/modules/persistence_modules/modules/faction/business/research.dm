/datum/faction_research
	var/points = 0
	var/list/unlocked = list()
	map_storage_saved_vars = "points;unlocked"

/datum/world_faction
	var/datum/faction_research/research

/datum/world_faction/New()
	..()
	research = new()

/datum/world_faction/proc/get_tech_points()
	return research.points

/datum/world_faction/proc/take_tech_points(var/amount)
	research.points -= amount


/datum/world_faction/proc/unlock_tech(var/uid)
	research.unlocked |= uid

/datum/world_faction/proc/is_tech_unlocked(var/uid)
	if(uid in research.unlocked)
		return 1

/datum/world_faction/proc/meets_prereqs()//(var/datum/tech_entry/tech)
	// for(var/x in tech.prereqs)
	// 	if(!(x in research.unlocked))
	// 		return 0
	// return 1
	return 0