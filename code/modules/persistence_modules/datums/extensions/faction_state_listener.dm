/*
	This extension is for handling faction related events.
	Just add it to anything that should receive signals from the faction and that's it.
*/
/datum/extension/faction_state_listener
	expected_type = /obj


////////////////////////////////////////////////////
// Business State
////////////////////////////////////////////////////

//Called when the faction is closed for business (Aka no paying employes/processing business activities)
/datum/extension/faction_state_listener/proc/OnFactionClosed(var/faction_uid)
	//Override me
	var/obj/O = src.holder
	return (O?.get_faction_uid()) == faction_uid

//Called when the faction is opened for business (Aka paying employes/processing business activities)
/datum/extension/faction_state_listener/proc/OnFactionOpened(var/faction_uid)
	//Override me
	var/obj/O = src.holder
	return (O?.get_faction_uid()) == faction_uid

////////////////////////////////////////////////////
// Activation State
////////////////////////////////////////////////////

//Called when a faction's state is changed to active 
/datum/extension/faction_state_listener/proc/OnFactionActivated(var/faction_uid)
	//Override me
	var/obj/O = src.holder
	return (O?.get_faction_uid()) == faction_uid

//Called when a faction's state is changed to deactivated 
/datum/extension/faction_state_listener/proc/OnFactionDeactivated(var/faction_uid)
	//Override me
	var/obj/O = src.holder
	return (O?.get_faction_uid()) == faction_uid

////////////////////////////////////////////////////
// Termination
////////////////////////////////////////////////////

//Called when the state of the faction is changed to "terminated" and the faction stops all operations
/datum/extension/faction_state_listener/proc/OnFactionTerminated(var/faction_uid)
	//Override me
	var/obj/O = src.holder
	return (O?.get_faction_uid()) == faction_uid

//Called when the state of the faction is un-"terminated" and the faction resumes all operations
/datum/extension/faction_state_listener/proc/OnFactionUnterminated(var/faction_uid)
	//Override me
	var/obj/O = src.holder
	return (O?.get_faction_uid()) == faction_uid

////////////////////////////////////////////////////
// Deletion
////////////////////////////////////////////////////

//Called when the faction is forcibly deleted from the database. Should happen very rarely, but has a hook here anyways.
/datum/extension/faction_state_listener/proc/OnFactionDeleted(var/faction_uid)
	//Override me
	var/obj/O = src.holder
	return (O?.get_faction_uid()) == faction_uid


//
//Override for the objects that receive the signals
//
