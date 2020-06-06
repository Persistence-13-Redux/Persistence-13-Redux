GLOBAL_LIST_EMPTY(pending_clonings) //Keep tracks globally of the clonings going on. So contracts can refer to them if needed
/datum/cloning_detail
	var/patient_name
	var/list/debited_accounts = list() //format: "account_number" = sum
	var/cleared_funds = 0
	var/total_required_funds
	var/datum/dna/patient_dna
	var/contract_id

/datum/cloning_detail/after_load()
	. = ..()
	if(patient_name)
		GLOB.pending_clonings[patient_name] = src

/datum/computer_file/program/clone_manager
	filename = "clonermanager"
	filedesc = "Cloning Pod Management"
	nanomodule_path = /datum/nano_module/program/clone_manager
	program_icon_state = "crew"
	program_menu_icon = "heart"
	extended_desc = "This program connects to nearby cloning pods, and uses dna scanning hardware to collect DNA and transmit it to the pods."
	required_access = core_access_medical_programs
	requires_ntnet = FALSE
	network_destination = "cloner management"
	size = 20
	var/tmp/obj/machinery/clonepod/pod
	
// /datum/computer_file/program/clone_manager/after_load()
// 	. = ..()
// 	if(pending_cloning && pending_cloning.patient_name)
// 		PendingCloning[pending_cloning.patient_name] = pending_cloning //Add to the global list of clonings 

/datum/computer_file/program/clone_manager/Destroy()
	pod = null
	. = ..()

//Handle clone pods being disconnected while running
// /datum/computer_file/program/clone_manager/event_clonepod_removed(var/obj/machinery/clonepod/pod)
// 	var/obj/item/weapon/stock_parts/computer/scanner/medical/mdscan = computer.get_component(PART_SCANNER)
// 	if(istype(mdscan) && mdscan.connected_pods)
// 		mdscan.connected_pods -= pod
// 	if(src.pod == pod )
// 		src.pod = null

//MODULE
/datum/nano_module/program/clone_manager
	name = "Cloning Pod Management"
	var/tmp/menu = 1
	var/datum/cloning_detail/pending_cloning

/datum/nano_module/program/clone_manager/New(host, topic_manager, program)
	. = ..()
	
/datum/nano_module/program/clone_manager/Destroy()
	if(pending_cloning)
		clear_pending()
	// cancel_contracts()
	return ..()	
	
//Send the message to the contracts linked to the current cloning in progress
/datum/nano_module/program/clone_manager/proc/cancel_contracts()
	if(pending_cloning)
		GLOB.contract_cancelled_event.raise_event(src, pending_cloning.contract_id)

//Called when the contract is cancelled from the contract side of things
/datum/nano_module/program/clone_manager/proc/on_contract_cancelled(var/atom/source, var/contract_id)
	var/obj/item/weapon/paper/contract/C = GLOB.pending_contracts[contract_id]
	if(!C)
		log_error("\The [src] \ref[src] received a completed cloning contract event, but the contract instance couldn't be found!")
		return
	if(pending_cloning && pending_cloning.contract_id == contract_id)
		clear_pending()

//Called when the contract is completed, and we get the event for it
/datum/nano_module/program/clone_manager/proc/on_contract_completed(var/atom/source, var/contract_id)
	var/obj/item/weapon/paper/contract/C = GLOB.pending_contracts[contract_id]
	if(!C)
		log_error("\The [src] \ref[src] received a completed cloning contract event, but the contract instance couldn't be found!")
		return
	if(!pending_cloning)
		log_error("\The [src] \ref[src] received a completed cloning contract event, but we have no cloning in progress!")
		return
	if(pending_cloning.contract_id == contract_id)
		clear_pending()

/datum/nano_module/program/clone_manager/proc/make_contract(var/patient_name, var/datum/dna/patient_dna, var/issuer, var/creator)
	if(pending_cloning)
		clear_pending() //Make sure anything pending is flushed

	var/content = {"
	<font face='Verdana' color=blue><table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'><center></td><tr><td><H1>Investment Contract</td>
	<tr><td><br><b>For:</b>clone [patient_name]<br>
	<b>Cost:</b> [GLOB.using_map.local_currency_name_short] [config.cloning_cost] <br><br>
	<tr><td><h3>Status</H3>*Unsigned*<br></td></tr></table><br><table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>
	<td><font size='4'><b>Swipe ID to sign contract.</b></font></center></font>
	"}
	var/obj/item/weapon/paper/contract/C = MakeCloningContract(
		get_turf(host),
		content,
		"Cloning Contract for [patient_name], on the [stationtime2text()]",
		"Payment for cloning [patient_name], [config.cloning_cost]",
		issuer,
		null,
		creator,
		config.cloning_cost
	)
	pending_cloning = new()
	pending_cloning.patient_name = patient_name
	pending_cloning.total_required_funds = config.cloning_cost
	pending_cloning.cleared_funds = 0
	pending_cloning.contract_id = C.contract_id()
	pending_cloning.patient_dna = patient_dna
	//Add to pending cloning data
	GLOB.pending_clonings[patient_name] = pending_cloning
	register_contract(C)
	return C

/datum/nano_module/program/clone_manager/proc/clear_pending()
	if(pending_cloning && pending_cloning.patient_name)
		GLOB.pending_clonings -= pending_cloning.patient_name
		unregister_contract(pending_cloning.contract_id)
	QDEL_NULL(pending_cloning)

/datum/nano_module/program/clone_manager/proc/register_contract(var/obj/item/weapon/paper/contract/C)
	GLOB.contract_completed_event.register(C, src, /datum/nano_module/program/clone_manager/proc/on_contract_completed)
	GLOB.contract_cancelled_event.register(C, src, /datum/nano_module/program/clone_manager/proc/on_contract_cancelled)

/datum/nano_module/program/clone_manager/proc/unregister_contract(var/contract_id)
	if(GLOB.pending_contracts[contract_id])
		GLOB.contract_completed_event.unregister(GLOB.pending_contracts[contract_id], src, /datum/nano_module/program/clone_manager/proc/on_contract_completed)
		GLOB.contract_cancelled_event.unregister(GLOB.pending_contracts[contract_id], src, /datum/nano_module/program/clone_manager/proc/on_contract_cancelled)

/datum/nano_module/program/clone_manager/proc/get_contributed()
	if(pending_cloning)
		return pending_cloning.cleared_funds
	return 0

/datum/nano_module/program/clone_manager/proc/format_pods()
	var/list/formatted = list()
	if(!can_get_dna())
		to_chat(usr, "The computer must have a medical scanner installed to correctly function.")
		return 0
	var/list/obj/machinery/clonepod/pods = get_pods()
	for(var/obj/machinery/clonepod/pod in pods)
		var/can_select = 1
		if(pod.panel_open || pod.attempting || pod.occupant || pod.biomass < config.cloning_biomass_cost || pod.inoperable())
			can_select = 0
		formatted.Add(list(list(
			"name" = pod.name,
			"attempting" = !isnull(pod.occupant),
			"biomass" = pod.biomass,
			"status" = pod.stat + pod.panel_open,
			"can_select" = can_select,
			"pod_ref" = "\ref[pod]")))
	return formatted

//Since this is a nano module, we wanna abstract this. Since it might not always comes from a modular computer
/datum/nano_module/program/clone_manager/proc/get_dna()
	var/obj/item/weapon/stock_parts/computer/scanner/medical/mdscan = get_scanner()
	if(!mdscan || !istype(mdscan))
		return null
	return mdscan.stored_dna

/datum/nano_module/program/clone_manager/proc/clear_dna()
	var/obj/item/weapon/stock_parts/computer/scanner/medical/mdscan = get_scanner()
	if(!mdscan || !istype(mdscan))
		return null
	mdscan.clear_dna()

//Since this is a nano module, we wanna abstract this. Since it might not always comes from a modular computer
/datum/nano_module/program/clone_manager/proc/can_get_dna()
	return program.computer.has_component(PART_SCANNER_MEDICAL)

//
/datum/nano_module/program/clone_manager/proc/get_scanner()
	return program.computer.get_component(PART_SCANNER_MEDICAL)

//Returns the pod currently selected
/datum/nano_module/program/clone_manager/proc/get_current_pod()
	var/datum/computer_file/program/clone_manager/CM = program
	if(!CM || !istype(CM))
		return
	return CM.pod
	
//
/datum/nano_module/program/clone_manager/proc/get_pods()
	var/obj/item/weapon/stock_parts/computer/scanner/medical/mdscan = get_scanner()
	if(!mdscan)
		return 
	return mdscan.connected_pods

//
/datum/nano_module/program/clone_manager/proc/connect_pods()
	var/obj/item/weapon/stock_parts/computer/scanner/medical/mdscan = get_scanner()
	if(!mdscan)
		return 
	mdscan.search_for_pods()

//
/datum/nano_module/program/clone_manager/proc/select_pod(var/obj/machinery/clonepod/CP)
	var/datum/computer_file/program/clone_manager/CM = program
	if(!CM || !istype(CM))
		return
	CM.pod = CP
	return TRUE

//
/datum/nano_module/program/clone_manager/proc/disconnect_pod()
	var/datum/computer_file/program/clone_manager/CM = program
	if(!CM || !istype(CM))
		return
	CM.pod = null
	return TRUE

//
/datum/nano_module/program/clone_manager/proc/get_cleared_funds()
	return pending_cloning?.cleared_funds

//
/datum/nano_module/program/clone_manager/proc/begin_cloning()
	var/obj/machinery/clonepod/CP = get_current_pod()
	if(!CP)
		to_chat(usr, SPAN_WARNING("Couldn't reach the cloning pod.. Please, re-select the cloning pod from the list, and try again!"))
		return FALSE
	if(CP.growclone(get_dna()))
		CP.state(SPAN_NOTICE("Cloning procedure beginning.."))
		clear_dna()
		cancel_contracts()
	else
		CP.state(SPAN_WARNING("Error. Couldn't start the cloning process.."))
		return FALSE
	return TRUE

/datum/nano_module/program/clone_manager/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = host.initial_data()
	data["has_scanner"] = can_get_dna()

	var/datum/dna/DNA = get_dna()
	if(DNA)
		data["has_dna"] = 1
		data["dna"] = DNA.unique_enzymes
	else
		data["has_dna"] = 0
		data["message"] = "Couldn't acquire a DNA sample."

	data["clone_biomass"] = config.cloning_biomass_cost
	data["connected_pods"] = format_pods()
	data["menu"] = menu
	var/commitment = get_contributed()
	data["commitment"] = commitment
	data["finishable"] = commitment >= config.cloning_cost

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "cloning_management.tmpl", "Cloning Management", 400, 450, state = state)
		ui.set_initial_data(data)
		if(host.update_layout()) // This is necessary to ensure the status bar remains updated along with rest of the UI.
			ui.auto_update_layout = 1
		ui.open()
		ui.set_auto_update(1)

/datum/nano_module/program/clone_manager/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["connect"])
		connect_pods()
		return 
	
	if(href_list["select_pod"])
		if(!href_list["target"]) 
			return
		select_pod(locate(href_list["target"]))
		menu = 2
		return 

	if(href_list["finish"])
		if(!pending_cloning)
			return
		if(get_contributed() < config.cloning_cost)
			to_chat(usr, SPAN_WARNING("Only [GLOB.using_map.local_currency_name_short] [get_cleared_funds()] out of the neccessary [pending_cloning.total_required_funds] are currently cleared!"))
			return
		if(!get_dna())
			to_chat(usr, SPAN_WARNING("Couldn't obtain the DNA sample from the scanner.. Please try again!"))
			cancel_contracts()
			menu = 1
			return
		begin_cloning()
		menu = 2
		return
	
	if(href_list["back"])
		var/choice = input(usr,"This will cancel all current contracts and return to the prior menu.") in list("Confirm", "Cancel")
		if(choice == "Confirm")
			cancel_contracts()
			menu = 1
		return 
	
	if(href_list["disconnect_pod"])
		disconnect_pod()
		return 

	if(href_list["contract"])
		var/datum/dna/DNA = get_dna()
		if(!DNA)
			cancel_contracts()
			menu = 1
			return
		var/cost = round(input("How much [GLOB.using_map.local_currency_name] should be the funding contract be for?", "Funding", config.cloning_cost - get_contributed()) as null|num)
		if(cost > config.cloning_cost - get_contributed())
			cost = config.cloning_cost - get_contributed()
		if(!cost || cost < 0)
			return 0
		var/choice = input(usr,"This will create a funding contract for [cost] [GLOB.using_map.local_currency_name].") in list("Confirm", "Cancel")
		if(choice == "Confirm")
			var/obj/item/weapon/paper/contract/contract = make_contract(DNA.real_name, DNA, usr.real_name, usr.real_name)
			usr.put_in_any_hand_if_possible(contract)
			playsound(get_turf(program?.computer?.get_physical_host()), pick('sound/items/polaroid1.ogg', 'sound/items/polaroid2.ogg'), 75, 1, -3)
		return