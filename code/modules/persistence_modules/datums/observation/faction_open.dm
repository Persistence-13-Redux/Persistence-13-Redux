//	Observer Pattern Implementation: Faction Opened
//		Registration type: /obj
//
//		Raised when: A faction's state change to open, and allow employees to work
//
//		Arguments that the called proc should expect:
//			/atom/sender: the atom that sent the event
//			/faction_uid : the ID of the faction that is open
//
GLOBAL_DATUM_INIT(faction_opened_event, /decl/observ/faction_opened, new)

/decl/observ/faction_opened
	name = "Faction Opened"
	expected_type = /datum/extension/faction_state_listener

/***********************************
* Faction Closed Handling *
***********************************/
/datum/extension/faction_state_listener/New(datum/holder)
	. = ..()
	GLOB.faction_opened_event.register(src, src, /datum/extension/faction_state_listener/proc/OnFactionOpened)

/datum/extension/faction_state_listener/Destroy()
	GLOB.faction_opened_event.unregister(src, src, /datum/extension/faction_state_listener/proc/OnFactionOpened)
	return ..()

//Event trigger
/datum/world_faction/open_business(var/send_event = TRUE)
	. = ..()
	if(send_event)
		GLOB.faction_opened_event.raise_event(src, uid)