//	Observer Pattern Implementation: Faction Closed
//		Registration type: /obj
//
//		Raised when: A faction's state change to close, and disallow employees from working
//
//		Arguments that the called proc should expect:
//			/atom/sender: the atom that sent the event
//			/faction_uid : the ID of the faction that was closed
//
GLOBAL_DATUM_INIT(faction_closed_event, /decl/observ/faction_closed, new)

/decl/observ/faction_closed
	name = "Faction CLosed"
	expected_type = /datum/extension/faction_state_listener

/***********************************
* Faction Closed Handling *
***********************************/
/datum/extension/faction_state_listener/New(datum/holder)
	. = ..()
	GLOB.faction_closed_event.register(src, src, /datum/extension/faction_state_listener/proc/OnFactionClosed)

/datum/extension/faction_state_listener/Destroy()
	GLOB.faction_closed_event.unregister(src, src, /datum/extension/faction_state_listener/proc/OnFactionClosed)
	return ..()
