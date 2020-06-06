//	Observer Pattern Implementation: Faction Unterminated
//		Registration type: /datum
//
//		Raised when: A faction's state is changed to "unterminated".
//
//		Arguments that the called proc should expect:
//			/atom/sender: the atom that sent the event
//			/faction_uid : the ID of the faction
//
GLOBAL_DATUM_INIT(faction_unterminated_event, /decl/observ/faction_unterminated, new)

/decl/observ/faction_unterminated
	name = "Faction Unterminated"
	expected_type = /datum/extension/faction_state_listener

////////////////////////////////////////////////
// Handling 
////////////////////////////////////////////////
/datum/extension/faction_state_listener/New(datum/holder)
	. = ..()
	GLOB.faction_unterminated_event.register(src, src, /datum/extension/faction_state_listener/proc/OnFactionUnterminated)

/datum/extension/faction_state_listener/Destroy()
	GLOB.faction_unterminated_event.unregister(src, src, /datum/extension/faction_state_listener/proc/OnFactionUnterminated)
	return ..()
