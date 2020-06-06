/*
	Mostly identical to citizen, except starts as a crew member on the buffalo.
*/
/datum/job/spawnonly/crewmember
	title = "Crewmember"
	department = "Civilian"
	department_flag = CIV
	availablity_chance = 100
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Executive Director"
	economic_power = 1
	announced = FALSE
	outfit_type = /decl/hierarchy/outfit/job/fringe/crew
	alt_titles = list(
		"Janitor" = /decl/hierarchy/outfit/job/fringe/crew/janitor,
		"Technician" = /decl/hierarchy/outfit/job/fringe/crew/technician,
		"Worker" = /decl/hierarchy/outfit/job/fringe/crew/worker,
		"Clerk" = /decl/hierarchy/outfit/job/fringe/crew/clerk,
		"Staff" = /decl/hierarchy/outfit/job/fringe/crew/staff,
		)