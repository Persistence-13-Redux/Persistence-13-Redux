//	Observer Pattern Implementation: Contract Cancelled
//		Registration type: /obj/item/weapon/paper/contract
//
//		Raised when: A contract is cancelled
//
//		Arguments that the called proc should expect:
//			/atom/sender: the atom that sent the cancellation
//			/contract_id : the ID of the contract that was cancelled
//
//		The event can be sent both ways. So a contract can send it to the issuer, or the issuer of the contract can send it to the contract


GLOBAL_DATUM_INIT(contract_cancelled_event, /decl/observ/contract_cancelled, new)

/decl/observ/contract_cancelled
	name = "Contract Cancelled"
	expected_type = /obj/item/weapon/paper/contract

/***********************************
* Contract Cancelled Handling *
***********************************/
/obj/item/weapon/paper/contract/Initialize()
	. = ..()
	GLOB.contract_cancelled_event.register(src, src, /obj/item/weapon/paper/contract/proc/on_remote_cancel)

/obj/item/weapon/paper/contract/Destroy()
	GLOB.contract_cancelled_event.unregister(src, src, /obj/item/weapon/paper/contract/proc/on_remote_cancel)
	return ..()
	
/obj/item/weapon/paper/contract/cancel(var/send_event = TRUE)
	if(!(. = ..()))
		return .
	if(send_event)
		GLOB.contract_cancelled_event.raise_event(src, uuid)

/obj/item/weapon/paper/contract/proc/on_remote_cancel(var/atom/sender, var/contract_id)
	//Called when we receive the cancel event
	if(sender == src) //Don't care if we issued the cancel
		return
	if(contract_id != src.uuid)
		log_debug(" /obj/item/weapon/paper/contract/proc/remote_cancel(): Received a remote_cancel request for another contract!! ID: [contract_id], from: \ref[sender] [sender]")
		return
	cancel(send_event = FALSE) //Don't re-send the event

//Other things may write their own things to emit this event