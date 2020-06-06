//Various helper procs to make things more readable/shorter 

/proc/GetGlobalCrewRecord(var/name)
	return PSDB.crew_records.GetGlobalCrewRecord(name)

/proc/GetPlayerMaxSaveSlots(var/ckey)
	return PSDB.player.GetPlayerMaxSaveSlots(ckey)
