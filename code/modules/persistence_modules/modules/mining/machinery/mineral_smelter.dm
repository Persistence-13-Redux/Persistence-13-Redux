
/obj/item/weapon/stock_parts/circuitboard/smelter
	name = T_BOARD("smelter")
	build_path = /obj/machinery/mineral/smelter
	board_type = "machine"
	origin_tech = list(TECH_ENGINEERING = 2, TECH_MATERIAL = 3)
	req_components = list(
		/obj/item/weapon/stock_parts/manipulator = 1,
		/obj/item/weapon/stock_parts/micro_laser = 4,
		/obj/item/weapon/stock_parts/matter_bin = 2)
	additional_spawn_components = list(
		/obj/item/weapon/stock_parts/console_screen = 1,
		/obj/item/weapon/stock_parts/keyboard = 1,
		/obj/item/weapon/stock_parts/power/apc/buildable = 1
	)

/**
	A machine to handle smelting materials.
	Made to replace the buggy ore processor.
*/
/obj/machinery/mineral/smelter
	var/const/SMELTER_SMELT = 0
	var/const/SMELTER_ALLOY = 1

	name = "Smelter"
	icon_state = "furnace"
	input_turf =  NORTH
	output_turf = SOUTH
	//Operation mode
	var/operation_mode = SMELTER_SMELT

	//Items waiting to be smelted
	var/list/obj/item/processing_queue = list()
	//merged list of matter being smelted
	var/list/smelting_matter = list()

	//
	var/time_next_processing = 0

	//
	var/time_paused = 0

	//
	var/max_items = 50
	
	//Whether something is being smelted or not
	var/smelting = FALSE

/obj/machinery/mineral/smelter/New()
	. = ..()
	ADD_SAVED_VAR(processing_queue)
	ADD_SAVED_VAR(target_temp)

/obj/machinery/mineral/smelter/Initialize()
	. = ..()
	START_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)

/obj/machinery/mineral/smelter/Destroy()
	STOP_PROCESSING_MACHINE(src, MACHINERY_PROCESS_ALL)
	return ..()

/obj/machinery/mineral/smelter/proc/is_smeltable(var/obj/item/I)
	return I.matter && length(I.matter)

/obj/machinery/mineral/smelter/proc/is_full()
	return length(processing_queue) >= max_items

/obj/machinery/mineral/smelter/CanPass(var/obj/item/I, var/turf/target, height, air_group)
	if(!istype(I))
		return ..()
	if(!is_smeltable(I) || is_full())
		return FALSE

/obj/machinery/mineral/smelter/Cross(var/obj/item/I)
	if(!istype(I))
		return ..()
	accept_item(I)

/obj/machinery/mineral/smelter/proc/reject_item(var/obj/item/I)
	var/turf/_turfout = get_step(src, output_turf)
	I.dropInto(_turfout)
	playsound(src, 'sound/machines/buzz-sigh.ogg', 25, TRUE, 0, 3)
	time_paused = 2 SECONDS
	time_next_processing = 1/2 SECOND
	update_icon()

/obj/machinery/mineral/smelter/proc/accept_item(var/obj/item/I)
	processing_queue += I
	I.forceMove(src)
	time_next_processing = 1/2 SECOND
	update_icon()

/obj/machinery/mineral/smelter/on_update_icon()
	. = ..()
	
/obj/machinery/mineral/smelter/Process()
	time_paused = max(--time_paused, 0)
	time_next_processing = max(--time_next_processing, 0)
	if(time_paused)
		return
	if(!length(processing_queue) && !smelting)
		return PROCESS_KILL
	smelt()
	return ..()

/obj/machinery/mineral/smelter/proc/smelt(var/list/smelted_matter)
	update_use_power(POWER_USE_ACTIVE)
	turn_items_to_matter()
	smelting = TRUE
	switch(operation_mode)
		if(SMELTER_SMELT)
			make_ingots()
		if(SMELTER_ALLOY)
			make_alloys(find_alloyables())
	smelting = FALSE
	time_paused = 1/2 SECOND

/obj/machinery/mineral/smelter/proc/make_ingots()
	for(var/key in smelting_matter)
		if(smelting_matter[key] <= 0)
			continue
		var/material/M = SSmaterials.get_material_by_name(key)
		if(!M)
			continue
		var/turf/_turfout = get_step(src, output_turf)
		var/result_amount = round(smelting_matter[key] / M.units_per_sheet)
		if(result_amount <= 0)
			continue
		smelting_matter[key] = max(smelting_matter[key] - (result_amount * M.units_per_sheet), 0)
		M.place_sheet(_turfout, result_amount)

/obj/machinery/mineral/smelter/proc/make_alloys(var/list/material/alloys)
	var/maximum_possible = -1
	for(var/material/M in alloys)
		//Verify if we can even smelt one of this material
		for(var/key in M.alloy_materials)
			if(M.alloy_materials[key] > 0)
				maximum_possible = maximum_possible == -1? \
					round(smelting_matter[key] / M.alloy_materials[key]) : \
					min(round(smelting_matter[key] / M.alloy_materials[key]), maximum_possible) //Get the lesser value, since we can't produce more than what's possible for all the components
		//Can't, skip
		if(maximum_possible == -1)
			continue
		var/turf/_turfout = get_step(src, output_turf)
		//Substract material units
		for(var/key in M.alloy_materials)
			if(smelting_matter[key])
				smelting_matter[key] -= (maximum_possible * M.alloy_materials[key]) //Remove the amount of mats we're using for the amount of alloys we're producing
		M.place_sheet(_turfout, maximum_possible)

//Make a list of alloyables we can currently make
/obj/machinery/mineral/smelter/proc/find_alloyables()
	var/list/material/alloyables = list()

	for(var/key in SSmaterials.alloy_products)
		var/material/M = SSmaterials.get_material_by_name(key)
		var/can_produce = TRUE
		var/result_amount = 0
		for(var/reqmat in M.alloy_materials)
			if(!smelting_matter[reqmat])
				can_produce = FALSE
				break
			if(smelting_matter[reqmat] < M.alloy_materials[reqmat])
				can_produce = FALSE
				break
		if(can_produce)
			alloyables += M

	return alloyables

//Destroy items and turn them to materials
/obj/machinery/mineral/smelter/proc/turn_items_to_matter()
	for(var/obj/item/I in processing_queue)
		var/efficiency_factor = 0.25 //Make sure you can't replace the recycler with this things, and get poor efficiency with things that aren't ores/material sheets
		if(istype(I, /obj/item/stack/ore) || istype(I, /obj/item/stack/material))
			efficiency_factor = 1.0

		for(var/key in I.matter)
			if(!smelting_matter[key]) 
				smelting_matter[key] = 0 //Make sure it implicitely creates a number and not a list..
			smelting_matter[key] += round(I.matter[key] * efficiency_factor)
		qdel(I)

/obj/machinery/mineral/smelter/update_use_power(new_use_power)
	. = ..()
	if(use_power != POWER_USE_OFF)
		START_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)
	else
		STOP_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)