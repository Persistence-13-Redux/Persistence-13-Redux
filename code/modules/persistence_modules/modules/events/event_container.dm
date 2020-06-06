/datum/event_container/mundane/New()
	. = ..()
	available_events += new /datum/event_meta(EVENT_LEVEL_MUNDANE, "Space Cold Outbreak",			/datum/event/space_cold,			100,	list(ASSIGNMENT_MEDICAL = 20))
