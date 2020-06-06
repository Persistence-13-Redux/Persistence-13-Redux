/datum/contract_database
	var/list/all_contracts = list()

/datum/contract_database/after_load()
	if(!islist(all_contracts))
		all_contracts = list()
	. = ..()

/datum/contract_database/proc/process()
	for(var/datum/recurring_contract/contract in all_contracts)
		contract.process()

/datum/contract_database/proc/get_service_desc(var/service)
	switch(service)
		if(CONTRACT_SERVICE_NONE)
			return ""
		if(CONTRACT_SERVICE_MEDICAL)
			return "The signing party will be able to call in medical emergencies through a medical-response beacon. If its health drops into a critical state, a medical emergency will trigger. For organization contracts this applies to everyone clocked in to the signing organization."
		if(CONTRACT_SERVICE_SECURITY)
			return "Areas trespasser alarms from the signing party will be forwarded to the contracted organization. The signing party will be able to call security emergencies through a security-response beacon. For organization contracts this applies to everyone clocked in to the signing organization (but not areas those employees have leased)."
		if(CONTRACT_SERVICE_LEASE)
			return "As long as this contract is in place, this contracts APC and area it controls will be considered under the control of the signing party. The trespasser alarm will respond based on the settings of the signing party."
		if(CONTRACT_SERVICE_LOAN)
			return "The signing party agrees to automatic payment at the rate specified. Once the balance reaches zero, this contract will automatically complete in good standing. This type of contract can only be cancelled by the issuer."
		if(CONTRACT_SERVICE_MEMBERSHIP)
			return "The signing party agrees to become a voluntary member in the organization. You may recieve emails related to your membership, and it can be cancelled at any time by either party."
	return ""

/datum/contract_database/proc/add_contract(var/datum/recurring_contract/contract)
	var/datum/world_faction/business/faction = FindFaction(contract.payee)
	if(contract.auto_pay)
		if(contract.handle_payment())
			contract.add_services()
			all_contracts |= contract
			if(istype(faction))
				faction.contract_objectives(contract.payer, contract.payer_type)
	else
		contract.add_services()
		all_contracts |= contract
		if(istype(faction))
			faction.contract_objectives(contract.payer, contract.payer_type)

/datum/contract_database/proc/get_contracts(var/uid, var/typee)
	var/list/contracts = list()
	for(var/datum/recurring_contract/contract in all_contracts)
		if((contract.payee == uid && contract.payee_type == typee && !contract.payee_clear) || (contract.payer == uid && contract.payer_type == typee && !contract.payer_clear))
			contracts |= contract
	return contracts
