/*
	Basic peasents
*/
/*******
Civilian
*******/
/datum/job/spawnonly/citizen
	title = "Citizen"
	department = "Civilian"
	department_flag = CIV
	availablity_chance = 100
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Executive Director"
	economic_power = 1
	announced = FALSE
	alt_titles = list(
		"Journalist" = /decl/hierarchy/outfit/job/fringe/citizen/journalist,
		"Investor" = /decl/hierarchy/outfit/job/fringe/citizen/investor,
		"Psychologist" = /decl/hierarchy/outfit/job/fringe/citizen/psychologist,
		"Entertainer" = /decl/hierarchy/outfit/job/fringe/citizen/entertainer,
		"Politician",
		"Scholar",
		"Refugee" = /decl/hierarchy/outfit/job/fringe/citizen/refuge,
		"Contractor" = /decl/hierarchy/outfit/job/fringe/citizen/contractor,
		"Security Contractor" = /decl/hierarchy/outfit/job/fringe/citizen/security_contractor,
		"Pilot" = /decl/hierarchy/outfit/job/fringe/citizen/pilot,
		"Miner" = /decl/hierarchy/outfit/job/fringe/citizen/miner,
		"Scientist" = /decl/hierarchy/outfit/job/fringe/citizen/scientist,
		"Chef" = /decl/hierarchy/outfit/job/fringe/citizen/chef,
		"Doctor"= /decl/hierarchy/outfit/job/fringe/citizen/doctor,
		)
	outfit_type = /decl/hierarchy/outfit/job/fringe/citizen
	// allowed_branches = list(/datum/mil_branch/civilian)
	// allowed_ranks = list(
	// 	/datum/mil_rank/civ/civ,
	// 	/datum/mil_rank/civ/contractor
	// )

/datum/job/spawnonly/citizen/get_access()
	if(config.assistant_maint)
		return list(access_maint_tunnels)
	else
		return list()