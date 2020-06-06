/obj/machinery/mining/drill
	var/base_power_usage = 10 KILOWATTS // Base power usage when the drill is running.
	var/actual_power_usage = 10 KILOWATTS // Actual power usage, with upgrades in mind.
	ore_types = list(
		MATERIAL_IRON     = /obj/item/stack/ore/iron,
		MATERIAL_URANIUM =  /obj/item/stack/ore/uranium,
		MATERIAL_GOLD =     /obj/item/stack/ore/gold,
		MATERIAL_SILVER =   /obj/item/stack/ore/silver,
		MATERIAL_DIAMOND =  /obj/item/stack/ore/diamond,
		MATERIAL_PHORON =   /obj/item/stack/ore/phoron,
		MATERIAL_OSMIUM =   /obj/item/stack/ore/osmium,
		MATERIAL_HYDROGEN = /obj/item/stack/ore/hydrogen,
		MATERIAL_SAND =     /obj/item/stack/ore/glass,
		MATERIAL_GRAPHITE = /obj/item/stack/ore/graphite,
		MATERIAL_ALUMINIUM = /obj/item/stack/ore/aluminium,
		MATERIAL_RUTILE = /obj/item/stack/ore/rutile
		)

/obj/machinery/mining/New()
	. = ..()
	ADD_SAVED_VAR(active)

/obj/machinery/mining/brace/after_load()
	. = ..()
	connect()

//Overriden for asteroid mob things
/obj/machinery/mining/drill/Process()
	if(need_player_check)
		return

	check_supports()

	if(!active) return

	if(!anchored)
		system_error("system configuration error")
		return

	if(stat & NOPOWER)
		system_error("insufficient charge")
		return

	if(need_update_field)
		get_resource_field()

	if(world.time % 10 == 0)
		update_icon()

	if(!active)
		return

	//Drill through the flooring, if any.
	if(istype(get_turf(src), /turf/simulated/floor/asteroid))
		var/turf/simulated/floor/asteroid/T = get_turf(src)
		if(!T.dug)
			T.gets_dug()
	else if(istype(get_turf(src), /turf/simulated/floor/exoplanet))
		var/turf/simulated/floor/exoplanet/T = get_turf(src)
		if(T.diggable)
			new /obj/structure/pit(T)
			T.diggable = 0
	else if(istype(get_turf(src), /turf/simulated/floor))
		var/turf/simulated/floor/T = get_turf(src)
		T.ex_act(2.0)

	//Dig out the tasty ores.
	if(resource_field.len)
		var/turf/simulated/harvesting = pick(resource_field)

		while(resource_field.len && !harvesting.resources)
			harvesting.has_resources = 0
			harvesting.resources = null
			resource_field -= harvesting
			if(resource_field.len)
				harvesting = pick(resource_field)

		if(!harvesting || !harvesting.resources)
			return

		var/total_harvest = harvest_speed //Ore harvest-per-tick.
		var/found_resource = 0 //If this doesn't get set, the area is depleted and the drill errors out.

		for(var/metal in ore_types)

			if(contents.len >= capacity)
				system_error("insufficient storage space")
				set_active(FALSE)
				need_player_check = 1
				update_icon()
				return

			if(contents.len + total_harvest >= capacity)
				total_harvest = capacity - contents.len

			if(total_harvest <= 0) break
			if(harvesting.resources[metal])

				found_resource  = 1

				var/create_ore = 0
				if(harvesting.resources[metal] >= total_harvest)
					harvesting.resources[metal] -= total_harvest
					create_ore = total_harvest
					total_harvest = 0
				else
					total_harvest -= harvesting.resources[metal]
					create_ore = harvesting.resources[metal]
					harvesting.resources[metal] = 0

				var/obj/item/stack/ore/st = new(src, create_ore, metal)
				SSasteroid.agitate(src, st.get_material()?.asteroid_anger * st.get_amount())

		if(!found_resource)
			harvesting.has_resources = 0
			harvesting.resources = null
			resource_field -= harvesting
	else
		set_active(FALSE)
		need_player_check = 1
		update_icon()

//Overriden the base proc to handle stachable ores
/obj/machinery/mining/drill/unload()
	if(usr.stat) return

	var/obj/structure/ore_box/B = locate() in orange(1)
	if(B)
		drop_contents(B)
		to_chat(usr, "<span class='notice'>You unload the drill's storage cache into the ore box.</span>")
	else
		to_chat(usr, "<span class='notice'>You must move an ore box up to the drill before you can unload it.</span>")

/obj/machinery/mining/drill/proc/drop_contents(var/atom/movable/target)
	for(var/obj/item/I in InsertedContents())
		I.dropInto(target)
