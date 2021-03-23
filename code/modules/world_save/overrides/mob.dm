//Ckey is special
/mob/Write(var/savefile/F, var/list/neversave = null)
	. = ..(F, neversave)
	F.dir.Remove("key")
	return .
