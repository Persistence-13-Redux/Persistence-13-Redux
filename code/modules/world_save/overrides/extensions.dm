/datum/extension/New(var/datum/holder)
	if(!istype(holder, expected_type) && !isnull(holder)) //Let null extensions be built, otherwise we get runtime spam on save load!!
		CRASH("Invalid holder type. Expected [expected_type], was [isnull(holder)? "null" : holder.type]")
	src.holder = holder
	ADD_SAVED_VAR(holder)
	ADD_SAVED_VAR(flags)

/datum/extension/proc/set_holder(var/newholder)
	holder = newholder

/datum/after_load()
	. = ..()
	if(extensions)
		for(var/key in extensions)
			var/list/extension = extensions[key]
			if(!islist(extension))
				var/datum/extension/ext = extension
				ext.set_holder(src) //Ensure the holder is set properly
			// else
			// 	log_debug(" /datum/after_load(): found a list extension \"[key]\".. Not setting holder.")
/datum/Destroy()
	if(extensions)
		for(var/expansion_key in extensions)
			var/list/extension = extensions[expansion_key]
			if(islist(extension))
				extension.Cut()
			else
				qdel(extension)
		extensions = null
	return ..()