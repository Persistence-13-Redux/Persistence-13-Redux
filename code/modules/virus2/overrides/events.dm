//Adds virology events
/datum/event/prison_break/virology
	eventDept = "Medical"
	areaName = list("Virology")
	areaType = list(/area/medical/virology, /area/medical/virologyaccess)

/datum/event/prison_break/station
	eventDept = "Local"
	areaName = list("Brig","Virology")
	areaType = list(/area/security/prison, /area/security/brig, /area/medical/virology, /area/medical/virologyaccess)

/datum/event_container/moderate/New()
	. = ..()
	available_events += new /datum/event_meta(EVENT_LEVEL_MODERATE, "Virology Breach", /datum/event/prison_break/virology, 0, list(ASSIGNMENT_MEDICAL = 100))

/datum/event_container/major/New()
	. = ..()
	available_events += new /datum/event_meta(EVENT_LEVEL_MAJOR, "Containment Breach", /datum/event/prison_break/station, 0, list(ASSIGNMENT_ANY = 5))
