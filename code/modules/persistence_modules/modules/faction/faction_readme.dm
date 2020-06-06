/*
****************************************
	Faction system overview
****************************************

/datum/world_faction : The actual faction instance for a given faction. Is either created by a faction spawner or by players in-game using modular computer programs.
When making a new faction, a new bank account, nt network, and set of crew records unique to that faction are created and stored in the DB.

*/