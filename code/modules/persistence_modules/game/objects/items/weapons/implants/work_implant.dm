/datum/extension/faction_state_listener/work_implant/OnFactionOpened()
	if(!(. = ..()))
		return .
	var/obj/item/weapon/implant/work/I = holder
	if(!holder)
		return
	I.OnFactionOpened()
	
/datum/extension/faction_state_listener/work_implant/OnFactionClosed()
	if(!(. = ..()))
		return .
	var/obj/item/weapon/implant/work/I = holder
	if(!holder)
		return
	I.OnFactionClosed()

/datum/action/work_implant
	name = "Access Work Interface"
	action_type = AB_ITEM

/obj/item/weapon/implanter/work
	name = "implanter-work"
	imp = /obj/item/weapon/implant/work

/obj/item/weapon/implantcase/work
	name = "glass case - 'work'"
	imp = /obj/item/weapon/implant/work

/obj/item/weapon/implant/work
	name = "work implant"
	desc = "Allows to track and report your work status."
	origin_tech = list(TECH_MATERIAL = 1, TECH_BIO = 2)
	hidden = 1
	var/tmp/datum/world_faction/faction
	var/faction_uid
	var/last_shift_duration

/obj/item/weapon/implant/work/New()
	. = ..()
	ADD_SAVED_VAR(faction_uid)
	ADD_SAVED_VAR(last_shift_duration)
	set_extension(src, /datum/extension/faction_state_listener/work_implant)

/obj/item/weapon/implant/work/Initialize()
	. = ..()
	if(imp_in && faction_uid)
		register_events()

/obj/item/weapon/implant/work/Destroy()
	unregister_events()
	return ..()

/obj/item/weapon/implant/work/implanted(mob/source)
	. = ..()
	if(.)
		register_events()

/obj/item/weapon/implant/work/removed()
	. = ..()
	unregister_events()

/obj/item/weapon/implant/work/get_faction_uid()
	return faction_uid
/obj/item/weapon/implant/work/get_faction()
	return faction? faction : (faction = FindFaction(faction_uid))

/obj/item/weapon/implant/work/proc/set_faction_uid(var/uid)
	unregister_events()
	action_clock_out() //clock out from old faction
	src.faction_uid = uid
	src.faction = null
	register_events()

//Make sure we get events from the faction
/obj/item/weapon/implant/work/proc/register_events()
	var/datum/world_faction/F = get_faction()
	if(!F)
		return
	F.RegisterListener_OnPay(src, /obj/item/weapon/implant/work/proc/OnPaid)

//Clear events from the faction
/obj/item/weapon/implant/work/proc/unregister_events()
	var/datum/world_faction/F = get_faction()
	if(!F)
		return
	F.UnregisterListener_OnPay(src, /obj/item/weapon/implant/work/proc/OnPaid)

/obj/item/weapon/implant/work/get_data()
	return {"
	<b>Implant Specifications:</b><BR>
	<b>Name:</b> Cybersun Industries Work Implant<BR>
	<b>Life:</b> Five years.<BR>
	<b>Important Notes:</b> <font color='red'>May render the host sterile.</font><BR>
	<HR>
	<b>Implant Details:</b> Subjects injected with implant can access their work interface remotely.<BR>
	<b>Function:</b> A simple internal transmitter meant to communicate with a work network.<BR>
	<b>Special Features:</b> Mint scented.<BR>
	<b>Integrity:</b> Guaranteed to outlast its host, or money back guaranteed."}

	//This implant doesn't work that way
/obj/item/weapon/implant/work/trigger(emote, mob/source)
/obj/item/weapon/implant/work/activate()

/obj/item/weapon/implant/work/ui_action_click()
	ui_interact(loc)

/obj/item/weapon/implant/work/ui_interact(mob/user, ui_key, datum/nanoui/ui, force_open, datum/nano_ui/master_ui, datum/topic_state/state)
	var/list/data[0]
	var/datum/world_faction/F = get_faction()
	data["selected_faction"] = F? faction.name : "UNSET"
	data["clocked_in"] = F?.get_on_duty(user.real_name)
	data["shift_time"] = last_shift_duration? "[(last_shift_duration / (1 MINUTE))] minutes": "--- minutes"
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "work_interface.tmpl", "Work UI", 550, 450, state = state)
		ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()
	
/obj/item/weapon/implant/work/OnTopic(mob/user, href_list, datum/topic_state/state)
	. = ..()
	switch(href_list["action"])
		if("set_active_faction")
			var/list/available = list()
			for(var/datum/world_faction/F in GLOB.all_world_factions)
				if(F.is_employe(user.real_name))
					available += F
			var/datum/world_faction/choice = input(user, "Choose an organization to connect to.","Business Select",null) as null|anything in available
			if(choice && choice != get_faction())
				set_faction_uid(choice.uid)
			return TOPIC_REFRESH
		if("deactivate")
			set_faction_uid(null)
			return TOPIC_REFRESH
		if("clock_in")
			action_clock_in()
			return TOPIC_REFRESH
		if("clock_out")
			action_clock_out()
			return TOPIC_REFRESH

/obj/item/weapon/implant/work/proc/action_clock_in()
	var/datum/world_faction/F = get_faction()
	var/mob/M = get_mob()
	if(!F || !M)
		return
	last_shift_duration = F.clock_out(M.real_name)

/obj/item/weapon/implant/work/proc/action_clock_out()
	var/datum/world_faction/F = get_faction()
	var/mob/M = get_mob()
	if(!F || !M)
		return
	last_shift_duration = null
	F.clock_in(M.real_name)

/obj/item/weapon/implant/work/implanted(mob/source)
	source.StoreMemory("This implant is activated via ability icon.", /decl/memory_options/system)
	to_chat(source, "The implanted work implant can be activated via the action icon.")
	source.update_action_buttons()
	return TRUE

/obj/item/weapon/implant/work/proc/OnFactionClosed()
	action_clock_out()

/obj/item/weapon/implant/work/proc/OnFactionOpened()
	//Maybe do some stuff here

/obj/item/weapon/implant/work/proc/OnPaid(var/employe_name, var/earnings, var/work_time)
	var/mob/M = get_mob()
	if(!(M?.mind))
		return
	if(employe_name != M.real_name)
		return
	//Notice the owner
	to_chat(M, SPAN_NOTICE("Your [src] buzzes letting you know you've earned [earnings] [CURRENCY_NAME_SHORT] for the the last [work_time] minutes."))

//Get the actual owner mob of the implant
// /obj/item/weapon/implant/work/get_mob()
// 	return part?.owner