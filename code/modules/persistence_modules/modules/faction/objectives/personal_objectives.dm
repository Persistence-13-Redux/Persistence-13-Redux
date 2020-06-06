/datum/personal_objective
	var/name = "Objective name"
	var/payout = 0 // how much to pay upon completion

	var/filled = 0 // how much has been provided of whatever is required
	var/required = 10 // How much of whatever is required to fill the objective

	var/completed = 0 // is the objective completed

	var/required_type // make this a typepath

	var/list/unique_characters = list() // a list of unique characters for objective tracking
	var/list/unique_factions = list() // a list of unique factions for objective tracking

	var/datum/computer_file/report/crew_record/parent


/datum/personal_objective/delicous_food

/datum/personal_objective/fancy_drink

/datum/personal_objective/visit_beacon

/datum/personal_objective/chat_friends

/datum/personal_objective/chat_many

/datum/personal_objective/chat_group

/datum/personal_objective/view_article