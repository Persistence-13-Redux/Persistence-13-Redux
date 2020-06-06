/datum/game_mode/persistent
	name = "Persistent"
	config_tag = "persistent"
	required_players = 0
	round_description = "Just have fun and role-play!"
	extended_round_description = "There are no antagonists during extended, unless an admin decides to be cheeky. Just play your character, mess around with your job, and have fun."
	addantag_allowed = ADDANTAG_ADMIN // No add antag vote allowed on extended, except when manually called by admins.
	end_on_antag_death = FALSE
	ert_disabled = TRUE
	deny_respawn = TRUE
	waittime_l = 0
	waittime_h = 0

/datum/game_mode/persistent/pre_setup()
	. = ..()
	SSticker.start_ASAP = TRUE

/datum/game_mode/check_win() //Truth is, the game was rigged from the start
	return FALSE

