//	Observer Pattern Implementation: Faction Terminated
//		Registration type: /datum
//
//		Raised when: A faction's state is changed to "terminated".
//
//		Arguments that the called proc should expect:
//			/atom/sender: the atom that sent the event
//			/faction_uid : the ID of the faction that was terminated
//
GLOBAL_DATUM_INIT(faction_terminated_event, /decl/observ/faction_terminated, new)

/decl/observ/faction_terminated
	name = "Faction Terminated"
	expected_type = /datum/extension/faction_state_listener

////////////////////////////////////////////////
// Handling 
////////////////////////////////////////////////
/datum/extension/faction_state_listener/New(datum/holder)
	. = ..()
	GLOB.faction_terminated_event.register(src, src, /datum/extension/faction_state_listener/proc/OnFactionTerminated)

/datum/extension/faction_state_listener/Destroy()
	GLOB.faction_terminated_event.unregister(src, src, /datum/extension/faction_state_listener/proc/OnFactionTerminated)
	return ..()
