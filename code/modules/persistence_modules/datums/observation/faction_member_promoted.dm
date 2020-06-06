//	Observer Pattern Implementation: Faction Member Promoted
//		Registration type: /datum
//
//		Raised when: When a faction member is promoted this event is sent.
//
//		Arguments that the called proc should expect:
//			/atom/sender        : the atom that sent the event
//			/faction_uid        : the ID of the faction that did the promoting
//			/employe_name       : the name of the employe that was promoted
//			/old_assignment_uid : the UID of the old assignment of the member
//			/new_assignment_uid : the UID of the new assignment of the member
//
GLOBAL_DATUM_INIT(faction_member_promoted, /decl/observ/faction_member_promoted, new)

/decl/observ/faction_member_promoted
	name = "Faction Member Promoted"
	expected_type = /datum/world_faction

/***********************************
* Member Promoted Handling *
***********************************/
/datum/world_faction/proc/OnMemberPromote(var/employe_name, var/old_assignment_uid, var/new_assignment_uid)
	GLOB.faction_member_promoted.raise_event(src, src.uid, employe_name, old_assignment_uid, new_assignment_uid)