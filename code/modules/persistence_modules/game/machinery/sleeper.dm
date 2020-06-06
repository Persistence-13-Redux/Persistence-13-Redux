#define SLEEPER_MAX_CARTRIDGES 32

#define SLEEPER_LOWEST_STASIS	1
#define SLEEPER_LOW_STASIS		5
#define SLEEPER_MID_STASIS		10
#define SLEEPER_MAX_STASIS		25

#define SLEEPER_MAX_CHEM_UNITS  30 //maximum quantity of a chem we can inject in a single person at a time

/obj/machinery/sleeper
	name = "sleeper"
	desc = "A fancy bed with built-in injectors, a dialysis machine, and a limited health scanner. Uses reagent cartridges. Alt + click to remove a cartridge."
	stasis_settings = list(SLEEPER_LOWEST_STASIS,SLEEPER_LOW_STASIS, SLEEPER_MID_STASIS, SLEEPER_MAX_STASIS)
	stasis = SLEEPER_LOW_STASIS
	var/efficiency
	var/initial_bin_rating = 1
	var/min_treatable_health = 25
	//For chems handling
	var/list/cartridges = list()
	var/amount_injected = 5
	var/list/amount_injectable = list(0.5, 1, 5, 10, 15)

/obj/machinery/sleeper/New()
	..()
	ADD_SAVED_VAR(cartridges)
	ADD_SAVED_VAR(filtering)
	ADD_SAVED_VAR(pump)
	ADD_SAVED_VAR(stasis)
	ADD_SAVED_VAR(occupant)
	ADD_SAVED_VAR(beaker)

/obj/machinery/sleeper/examine(mob/user, distance)
	. = ..()
	if (distance <= 1)
		to_chat(user, "It has [cartridges.len] cartridges installed, and has space for [SLEEPER_MAX_CARTRIDGES - cartridges.len] more.")

/obj/machinery/sleeper/Process()
	if(inoperable())
		return

	active_power_usage = 1 KILOWATTS
	if(filtering > 0)
		if(beaker)
			if(beaker.reagents.total_volume < beaker.reagents.maximum_volume)
				var/pumped = 0
				for(var/datum/reagent/x in occupant.reagents.reagent_list)
					occupant.reagents.trans_to_obj(beaker, pump_speed)
					pumped++
				if(ishuman(occupant))
					occupant.vessel.trans_to_obj(beaker, pumped + 1)
				active_power_usage += 500
		else
			toggle_filter()
	if(pump > 0)
		if(beaker && istype(occupant))
			if(beaker.reagents.total_volume < beaker.reagents.maximum_volume)
				var/datum/reagents/ingested = occupant.get_ingested_reagents()
				if(ingested)
					for(var/datum/reagent/x in ingested.reagent_list)
						ingested.trans_to_obj(beaker, pump_speed)
				active_power_usage += 800
		else
			toggle_pump()

	if(iscarbon(occupant))
		occupant.SetStasis(stasis)
		active_power_usage += stasis * 10

/obj/machinery/sleeper/ui_interact(var/mob/user, var/ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.outside_state)
	var/list/data = list()

	data["power"] = inoperable() ? 0 : 1

	var chemicals[0]
	for(var/label in cartridges)
		var/obj/item/weapon/reagent_containers/chem_disp_cartridge/cart = cartridges[label]
		var/list/cartdata = list("name" = label, "amount" = cart.reagents.total_volume )
		if(occupant && occupant.reagents)
			cartdata["contained"] = occupant.reagents.get_reagent_amount(cart.reagents.get_master_reagent_type())
		chemicals[++chemicals.len] = cartdata
	data["chemicals"] = chemicals

	if(occupant)
		var/scan = user.skill_check(SKILL_MEDICAL, SKILL_ADEPT) ? medical_scan_results(occupant) : "<span class='white'><b>Contains: \the [occupant]</b></span>"
		scan = replacetext(scan,"'scan_notice'","'white'")
		scan = replacetext(scan,"'scan_warning'","'average'")
		scan = replacetext(scan,"'scan_danger'","'bad'")
		data["occupant"] =scan
	else
		data["occupant"] = 0
	if(beaker)
		data["beaker"] = beaker.reagents.get_free_space()
	else
		data["beaker"] = -1
	data["filtering"] = filtering
	data["pump"] = pump
	data["stasis"] = stasis
	data["skill_check"] = user.skill_check(SKILL_MEDICAL, SKILL_BASIC)
	data["stasis_modes"] = stasis_settings.Copy()
	data["amount_injectable"] = amount_injectable
	data["amount_injected"] = amount_injected

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "sleeper.tmpl", "Sleeper UI", 600, 800, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/sleeper/OnTopic(user, href_list)
	if(href_list["eject"])
		go_out()
		return TOPIC_REFRESH
	if(href_list["beaker"])
		remove_beaker()
		return TOPIC_REFRESH
	if(href_list["filter"])
		var/filterstate = text2num(href_list["filter"])
		if(filtering != filterstate)
			set_filter(filterstate)
			return TOPIC_REFRESH
	if(href_list["pump"])
		var/pumpstate = text2num(href_list["pump"])
		if(pump != pumpstate)
			set_pump(pumpstate)
			return TOPIC_REFRESH
	if(href_list["quantity_index"])
		var/quantity_index = text2num(href_list["quantity_index"]) + 1
		if(quantity_index <= amount_injectable.len && quantity_index > 0)
			amount_injected = amount_injectable[quantity_index]
			return TOPIC_REFRESH
	if(href_list["inject"])
		if(occupant)
			if(href_list["inject"] in cartridges) // Your hacks are bad and you should feel bad
				inject_chemical(usr, href_list["inject"], amount_injected)
				return TOPIC_REFRESH
	if(href_list["stasis_index"])
		var/stasis_index = text2num(href_list["stasis_index"]) + 1 //nano ui indices begin at 0 for some reasons
		if(stasis_index <= stasis_settings.len && stasis_index > 0)
			stasis = stasis_settings[stasis_index]
			change_power_consumption(initial(active_power_usage) + 5 KILOWATTS * (stasis_index-1), POWER_USE_ACTIVE)
			return TOPIC_REFRESH

/obj/machinery/sleeper/emp_act(var/severity)
	if(filtering)
		toggle_filter()

	if(inoperable())
		..(severity)
		return

	if(occupant)
		go_out()

	..(severity)

/obj/machinery/sleeper/toggle_filter()
	set_filter(!filtering)

/obj/machinery/sleeper/proc/set_filter(var/state)
	if(!occupant || !beaker)
		filtering = FALSE
		return
	to_chat(occupant, "<span class='warning'>You feel like your blood is being sucked away.</span>")
	filtering = state

/obj/machinery/sleeper/toggle_pump()
	set_pump(!pump)

/obj/machinery/sleeper/proc/set_pump(var/state)
	if(!occupant || !beaker)
		pump = FALSE
		return
	to_chat(occupant, "<span class='warning'>You feel a tube jammed down your throat.</span>")
	pump = state

/obj/machinery/sleeper/go_in(var/mob/M, var/mob/user)
	if(!M)
		return FALSE
	if(inoperable())
		return FALSE
	if(occupant)
		to_chat(user, "<span class='warning'>\The [src] is already occupied.</span>")
		return FALSE

	if(M == user)
		visible_message("\The [user] starts climbing into \the [src].")
	else
		visible_message("\The [user] starts putting [M] into \the [src].")

	if(do_after(user, 20, src))
		if(occupant)
			to_chat(user, "<span class='warning'>\The [src] is already occupied.</span>")
			return FALSE
		set_occupant(M)
		return TRUE
	return FALSE

/obj/machinery/sleeper/go_out()
	if(!occupant)
		return
	if(occupant.client)
		occupant.client.eye = occupant.client.mob
		occupant.client.perspective = MOB_PERSPECTIVE
	occupant.dropInto(loc)
	set_occupant(null)
	var/list/ejectable_content = InsertedContents()
	for(var/key in cartridges)
		ejectable_content -= cartridges[key]
	for(var/obj/O in ejectable_content) // In case an object was dropped inside or something. Excludes the beaker and component parts.
		if(O == beaker)
			continue
		O.dropInto(loc)
	update_use_power(1)
	update_icon()
	toggle_filter()

/obj/machinery/sleeper/inject_chemical(var/mob/living/user, var/chemical_name, var/amount)
	if(inoperable())
		return

	var/obj/item/weapon/reagent_containers/chem_disp_cartridge/cart = cartridges[chemical_name]
	if(!cart)
		return //Someone has an outdated UI display
	var/chemical_type = cart.reagents.get_master_reagent_type()

	if(occupant && occupant.reagents)
		if(occupant.reagents.get_reagent_amount(chemical_type) + amount <= SLEEPER_MAX_CHEM_UNITS)
			cart.reagents.trans_to_mob(occupant, amount,CHEM_BLOOD)
			to_chat(user, "<span class='notice'>Occupant now has [occupant.reagents.get_reagent_amount(chemical_type)] unit\s of [chemical_name] in their bloodstream.</span>")
		else
			to_chat(user, "<span class='warning'>The subject has too much of that chemical in their bloodstream.</span>")
	else
		to_chat(user, "<span class='warning'>There's no suitable occupant in \the [src].</span>")

/obj/machinery/sleeper/attackby(var/obj/item/O, var/mob/user)
	if(istype(O, /obj/item/grab/normal))
		var/obj/item/grab/normal/G = O
		if(ismob(G.affecting) && go_in(G.affecting, user))
			qdel(G)
		return
	else if(istype(O, /obj/item/weapon/reagent_containers/chem_disp_cartridge))
		add_cartridge(O, user)
		return
	else if(istype(O, /obj/item/weapon/reagent_containers/glass) || istype(O, /obj/item/weapon/reagent_containers/food))
		if(beaker)
			to_chat(user, "<span class='warning'>There is already \a [beaker] on \the [src]!</span>")
			return

		var/obj/item/weapon/reagent_containers/RC = O

		if(istype(RC,/obj/item/weapon/reagent_containers/food))
			to_chat(user, "<span class='warning'>This machine only accepts beakers!</span>")
			return

		if(!RC.is_open_container())
			to_chat(user, "<span class='warning'>There's no opening for \the [src] to pour into \the [RC].</span>")
			return

		beaker =  RC
		user.drop_from_inventory(RC)
		RC.loc = src
		update_icon()
		to_chat(user, "<span class='notice'>You set \the [RC] on \the [src].</span>")
		SSnano.update_uis(src) // update all UIs attached to src
		return TRUE
	else
		return ..()

/obj/machinery/sleeper/AltClick(var/mob/user)
	var/label = input(user, "Which cartridge would you like to remove?", "Chemical Dispenser") as null|anything in cartridges
	if(!label) return
	var/obj/item/weapon/reagent_containers/chem_disp_cartridge/C = remove_cartridge(label)
	if(C)
		to_chat(user, "<span class='notice'>You remove \the [C] from \the [src].</span>")
		C.loc = loc
	..()

/obj/machinery/sleeper/proc/add_cartridge(obj/item/weapon/reagent_containers/chem_disp_cartridge/C, mob/user)
	if(!istype(C))
		if(user)
			to_chat(user, "<span class='warning'>\The [C] will not fit in \the [src]!</span>")
		return
	if(cartridges.len >= SLEEPER_MAX_CARTRIDGES)
		if(user)
			to_chat(user, "<span class='warning'>\The [src] does not have any slots open for \the [C] to fit into!</span>")
		return

	if(!C.get_first_label())
		if(user)
			to_chat(user, "<span class='warning'>\The [C] does not have a label!</span>")
		return

	if(cartridges[C.get_first_label()])
		if(user)
			to_chat(user, "<span class='warning'>\The [src] already contains a cartridge with that label!</span>")
		return

	if(user)
		user.drop_from_inventory(C)
		to_chat(user, "<span class='notice'>You add \the [C] to \the [src].</span>")

	C.loc = src
	cartridges[C.get_first_label()] = C
	cartridges = sortAssoc(cartridges)
	SSnano.update_uis(src)

/obj/machinery/sleeper/proc/remove_cartridge(label)
	. = cartridges[label]
	cartridges -= label
	SSnano.update_uis(src)

#undef SLEEPER_MAX_CARTRIDGES
#undef SLEEPER_MAX_CHEM_UNITS
#undef SLEEPER_LOWEST_STASIS
#undef SLEEPER_LOW_STASIS
#undef SLEEPER_MID_STASIS
#undef SLEEPER_MAX_STASIS
