//Override for skipping blacklisted vars
/datum/Write(var/savefile/F, var/list/neversave = null)
	before_save(F)
	var/list/savetmp = null
	if(neversave && islist(neversave) && neversave.len)
		savetmp = list() //Holds the changed value of variables
		for(var/v in neversave)
			//If not saveable, pass
			if(!issaved(src.vars[v]))
				continue
			//If not default value, save cur value and set it to default, so it won't be saved by the default proc
			var/init = initial(src.vars[v])
			if(src.vars[v] != init)
				savetmp[v] = src.vars[v]
				src.vars[v] = init
	
	//Do base saving proc
	. = ..(F)
	
	//If we got any variables we changed the value of, we restore them
	if(savetmp)
		for(var/v in savetmp)
			src.vars[v] = savetmp[v]
	after_save(F)
