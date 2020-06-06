// GENERIC PRINTER - DO NOT USE THIS OBJECT.
// Flesh and robot printers are defined below this object.

/obj/machinery/organ_printer
	uncreated_component_parts = list(
		/obj/item/weapon/stock_parts/power/apc,
	)
	var/tick_printing = 0


/obj/machinery/organ_printer/New()
	..()
	ADD_SAVED_VAR(stored_matter)
	ADD_SAVED_VAR(printing)
	ADD_SAVED_VAR(tick_printing)
	ADD_SAVED_VAR(matter_in_use)

/obj/machinery/organ_printer/before_save()
	. = ..()
	//Make sure we only save the time difference from the start of the printing process
	//time_print_end -= world.time

/obj/machinery/organ_printer/after_load()
	. = ..()
	//Add the current time to the time difference we just saved
	//tick_printingtime_print_end += world.time

/obj/machinery/organ_printer/proc/printer_status()
	return 	{"Matter levels: [round(stored_matter,1)]/[max_stored_matter] units<BR>
Time left: [tick_printing != 0? tick_printing SECONDS : "N/A"] second(s)<BR>"}

/obj/machinery/organ_printer/interface_interact(mob/user)
	if(!panel_open)
		var/list/dat = list()
		dat += "[src.name]: "
		dat += printer_status()
		dat += "<BR><BR>"
		
		dat += "Print options: <br /><div>"
		for(var/key in products)
			var/list/P = products[key]
			if(P && P.len)
				dat += "<div class='item'>[key] - [P[2]]u <a href='?src=\ref[src];print=[key]'>Print</a></div>"
		dat += "</div>"
		dat += "<SPAN><A HREF='?src=\ref[src];cancel=1'>Cancel</A></SPAN>"
		user.set_machine(src)
		var/datum/browser/popup = new(usr, "organ_printer", "[src.name] menu")
		popup.set_content(jointext(dat, null))
		popup.open()
		return TRUE

/obj/machinery/organ_printer/OnTopic(mob/user, href_list, datum/topic_state/state)
	. = ..()
	if(href_list["print"] && !printing)
		var/prod = sanitize(href_list["print"])
		if(can_print(prod))
			printing = prod
			tick_printing = print_delay
			update_use_power(POWER_USE_ACTIVE)
			update_icon()
			updateUsrDialog()
		else
			state("Not enough matter for completing the task!")
		return TOPIC_HANDLED
	if(href_list["cancel"] && printing)
		printing = null
		tick_printing = 0
		update_use_power(POWER_USE_IDLE)
		update_icon()
		updateUsrDialog()
		return TOPIC_REFRESH

/obj/machinery/organ_printer/Process()
	if(inoperable())
		return
	tick_printing = max(tick_printing - 1, 0)
	if(printing && tick_printing <= 0 )
		tick_printing = 0
		stored_matter -= products[printing][2]
		print_organ(printing)
		printing = null
		update_use_power(POWER_USE_IDLE)
		queue_icon_update()
	updateUsrDialog()

// ROBOT ORGAN PRINTER
/obj/machinery/organ_printer/robot/print_organ(var/choice)
	var/obj/item/organ/O = ..()
	O.robotize()
	O.status |= ORGAN_CUT_AWAY  // robotize() resets status to 0
	visible_message("<span class='info'>\The [src] churns for a moment, then spits out \a [O].</span>")
	return O

/obj/machinery/organ_printer/robot/attackby(var/obj/item/weapon/W, var/mob/user)
	. = ..()
	if(istype(W, /obj/item/stack/material))
		updateUsrDialog()
	
// END ROBOT ORGAN PRINTER

// FLESH ORGAN PRINTER
/obj/machinery/organ_printer/flesh/New()
	..()
	ADD_SAVED_VAR(loaded_dna_datum)
	ADD_SAVED_VAR(loaded_species)

/obj/machinery/organ_printer/flesh/print_organ(var/choice)
	. = ..()
	updateUsrDialog()

/obj/machinery/organ_printer/flesh/physical_attack_hand(mob/user)
	return //Doesn't work like the base version

/obj/machinery/organ_printer/flesh/printer_status()
	return {"[..()]Loaded dna: [loaded_dna_datum? loaded_dna_datum.unique_enzymes : "<span class='bad'>N/A</span>"] <BR>
Loaded specie: [loaded_species? loaded_species.name : "<span class='bad'>N/A</span>"]<BR>"}

/obj/machinery/organ_printer/flesh/can_print(var/choice)
	. = ..()
	if(!loaded_dna_datum || !loaded_dna_datum["donor"])
		visible_message("<span class='info'>\The [src] displays a warning: 'No DNA saved. Insert a blood sample.'</span>")
		return 0

/obj/machinery/organ_printer/flesh/can_print(choice)
	if(!loaded_dna_datum || !loaded_species)
		return FALSE
	. = ..()

/obj/machinery/organ_printer/flesh/attackby(obj/item/weapon/W, mob/user)
	. = ..()
	updateUsrDialog()

