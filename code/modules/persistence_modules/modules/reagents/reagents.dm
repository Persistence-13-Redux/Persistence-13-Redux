/datum/reagent
	var/gas_id // Override for reagents inwhich name != id of parent gas

/datum/reagent/New(var/datum/reagents/holder)
	//Have to comment this CRASH, because on mapload it breaks everything
	// if(!istype(holder))
	// 	CRASH("[src]: Invalid reagents holder: [log_info_line(holder)]")
	src.holder = holder

	//We only want to save what's actually neccessary, the rest will be initialized properly to its default values
	ADD_SAVED_VAR(volume)
	ADD_SAVED_VAR(data)
	ADD_SAVED_VAR(reagent_state)
	ADD_SAVED_VAR(holder)
	ADD_SAVED_VAR(severe_ticks)
