//	Observer Pattern Implementation: Contract Completed
//		Registration type: /obj/item/weapon/paper/contract
//
//		Raised when: A contract is signed and completed
//
//		Arguments that the called proc should expect:
//			/obj/item/weapon/paper/contract/contract:  The contract that was completed
//			/contract_id: The id of the contract that was completed

GLOBAL_DATUM_INIT(contract_completed_event, /decl/observ/contract_completed, new)

/decl/observ/contract_completed
	name = "Contract Completed"
	expected_type = /obj/item/weapon/paper/contract

/***********************************
* Contract Completed Handling *
***********************************/
/obj/item/weapon/paper/contract/finalize()
	if(!(. = ..()))
		return
	GLOB.contract_completed_event.raise_event(src, uuid)
