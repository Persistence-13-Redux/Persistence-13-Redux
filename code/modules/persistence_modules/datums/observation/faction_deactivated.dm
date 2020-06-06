//	Observer Pattern Implementation: Faction Deactivated
//		Registration type: /datum
//
//		Raised when: A faction's state is changed to "inactive".
//
//		Arguments that the called proc should expect:
//			/atom/sender: the atom that sent the event
//			/faction_uid : the ID of the faction
//
GLOBAL_DATUM_INIT(faction_deactivated_event, /decl/observ/faction_deactivated, new)

/decl/observ/faction_deactivated
	name = "Faction Deactivated"
	expected_type = /datum/extension/faction_state_listener

///////////////////////////////////
// Handling
///////////////////////////////////
/datum/extension/faction_state_listener/New(datum/holder)
	. = ..()
	GLOB.faction_deactivated_event.register(src, src, /datum/extension/faction_state_listener/proc/OnFactionDeactivated)

/datum/extension/faction_state_listener/Destroy()
	GLOB.faction_deactivated_event.unregister(src, src, /datum/extension/faction_state_listener/proc/OnFactionDeactivated)
	return ..()
