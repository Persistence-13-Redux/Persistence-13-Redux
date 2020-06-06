//	Observer Pattern Implementation: Faction Deleted
//		Registration type: /datum
//
//		Raised when: A faction was deleted from the database.
//
//		Arguments that the called proc should expect:
//			/atom/sender: the atom that sent the event
//			/faction_uid : the ID of the faction that was deleted
//
GLOBAL_DATUM_INIT(faction_deleted_event, /decl/observ/faction_deleted, new)

/decl/observ/faction_deleted
	name = "Faction Deleted"
	expected_type = /datum/extension/faction_state_listener

/***********************************
* Faction Deleted Handling *
***********************************/
/datum/extension/faction_state_listener/New(datum/holder)
	. = ..()
	GLOB.faction_closed_event.register(src, src, /datum/extension/faction_state_listener/proc/OnFactionDeleted)

/datum/extension/faction_state_listener/Destroy()
	GLOB.faction_closed_event.unregister(src, src, /datum/extension/faction_state_listener/proc/OnFactionDeleted)
	return ..()
