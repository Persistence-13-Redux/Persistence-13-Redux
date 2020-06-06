//	Observer Pattern Implementation: Faction Pay
//		Registration type: /datum/world_faction
//
//		Raised when: A faction has dispensed pay to an employe.
//
//		Arguments that the called proc should expect:
//			/atom/sender: the faction that sent the event
//			/employe_name : the name of the employe that earned their pay.
//			/earnings : The amount earned.
//			/work_time : The time worked in minutes.
//
GLOBAL_DATUM_INIT(faction_pay_event, /decl/observ/faction_pay, new)

/decl/observ/faction_pay
	name = "Faction Pay"
	expected_type = /datum/world_faction

//
//
//

//Make listeners listen to events from this faction
/datum/world_faction/proc/RegisterListener_OnPay(var/datum/listener, var/callback)
	GLOB.faction_pay_event.register(src, listener, callback)

//Make listeners listen to events from this faction
/datum/world_faction/proc/UnregisterListener_OnPay(var/datum/listener, var/callback)
	if(GLOB.faction_pay_event.is_listening(src, listener, callback))
		GLOB.faction_pay_event.unregister(src, listener, callback)