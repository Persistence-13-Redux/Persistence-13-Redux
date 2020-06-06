/datum/Read(var/savefile/F, var/list/neversave = null)
	before_load()
	var/list/curvalues = null
	if(neversave && islist(neversave) && neversave.len)
		curvalues = list() //Current values of ignored variables
		for(var/v in neversave)
			if(!issaved(src.vars[v]))
				continue
			curvalues[v] = src.vars[v]
	
	//Run the base proc
	. = ..(F)

	//If we did keep the state of some variables, restore them
	if(curvalues)
        for(var/v in curvalues)
            src.vars[v] = curvalues[v]
	after_load()