/*
	Helper for handling new player spawning
*/

/datum/world_faction/proc/isNewPlayerSpawningAllowed()
	return allow_new_player_spawn

/datum/world_faction/proc/SetNewPlayerSpawningAllowed(var/_allowed)
	allow_new_player_spawn = _allowed
	PSDB.factions.CommitFaction(src)