/*
	Basically, peasents with no papers.
*/
/datum/job/spawnonly/foreigner
	title = "Visitor"
	department = "Civilian"
	department_flag = CIV
	availablity_chance = 100
	total_positions = -1
	spawn_positions = -1
	supervisors = "the invisible hand of the market"
	ideal_character_age = 30
	minimal_player_age = 0
	create_record = 0
	announced = FALSE
	latejoin_at_spawnpoints = TRUE
	outfit_type = /decl/hierarchy/outfit/job/fringe/visitor
	// allowed_branches = list(
	// 	/datum/mil_branch/civilian,
	// 	/datum/mil_branch/alien
	// )
	// allowed_ranks = list(
	// 	/datum/mil_rank/civ/civ,
	// 	/datum/mil_rank/alien
	// )
	skill_points = 20
	required_language = null
	give_psionic_implant_on_join = FALSE