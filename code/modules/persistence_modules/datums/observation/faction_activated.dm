//	Observer Pattern Implementation: Faction Terminated
//		Registration type: /datum
//
//		Raised when: A faction's state is changed to "active".
//
//		Arguments that the called proc should expect:
//			/atom/sender: the atom that sent the event
//			/faction_uid : the ID of the faction that was terminated
//
GLOBAL_DATUM_INIT(faction_activated_event, /decl/observ/faction_activated, new)

/decl/observ/faction_activated
	name = "Faction Activated"
	expected_type = /datum/extension/faction_state_listener

/***********************************
* Faction Activated Handling *
***********************************/
/datum/extension/faction_state_listener/New(datum/holder)
	. = ..()
	GLOB.faction_activated_event.register(src, src, /datum/extension/faction_state_listener/proc/OnFactionActivated)

/datum/extension/faction_state_listener/Destroy()
	GLOB.faction_activated_event.unregister(src, src, /datum/extension/faction_state_listener/proc/OnFactionActivated)
	return ..()
