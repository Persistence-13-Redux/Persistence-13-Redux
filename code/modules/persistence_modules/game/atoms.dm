/atom/New()
	. = ..()
	ADD_SAVED_VAR(reagents)
	ADD_SAVED_VAR(blood_DNA)
	ADD_SAVED_VAR(was_bloodied)
	ADD_SAVED_VAR(blood_color)
	ADD_SAVED_VAR(germ_level)
	ADD_SKIP_EMPTY(reagents)


//This is used to set the initial reagents for an atom. Its called only on an atom that wasn't loaded from save
/atom/proc/SetupReagents()
	return

/atom/update_icon()
	if(QDELETED(src)) //Handy little thing
		return
	on_update_icon(arglist(args))

/atom/Initialize(mapload, ...)
	if(QDELETED(src) || QDELING(src))
		return INITIALIZE_HINT_QDEL //Happens because of map loading shennanigans
	if(!map_storage_loaded)
		OneTimeInit()
	. = ..()

/atom/proc/OneTimeInit()
	SetupReagents()