/obj/structure/closet/LateInitialize(mapload, ...)
	if(!map_storage_loaded)
		var/list/will_contain = WillContain()
		if(will_contain)
			create_objects_in_loc(get_turf(src), will_contain)

		if(!opened && mapload) // if closed and it's the map loading phase, relevant items at the crate's loc are put in the contents
			store_contents()

/obj/structure/closet/attackby(obj/item/W as obj, mob/user as mob)
	if(isMultitool(W))
		if(locked)
			to_chat(user, "You cannot reprogram a locked container.")
			return
		user.visible_message("<span class='notice'>\The [user] begins reprogramming \the [src].</span>", "<span class='notice'>You begin reprogramming \the [src].</span>")
		if(do_after(usr, 40, src))
			ui_interact(user)
	else
		return ..()

/obj/structure/closet/slice_into_parts(var/obj/item/weapon/weldingtool/WT, mob/user)
	if(!WT.isOn() || !WT.remove_fuel(0, user))
		return
	if(do_mob(user, src, 5 SECONDS) && WT.isOn())
		user.visible_message("<span class='notice'>\The [src] has been cut apart by [user] with \the [WT].</span>", \
			"<span class='notice'>You have cut \the [src] apart with \the [WT].</span>", \
			"You hear welding.")
		dismantle()
		return TRUE
	return FALSE

/obj/structure/closet/CanToggleLock(var/mob/user, var/obj/item/weapon/card/id/id_card)
	return allowed(user) || (istype(id_card) && check_access_list(id_card.GetAccess(req_access_faction)))

/*
/obj/structure/closet/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = list()
	data["name"] = name
	if(locked)
		return (SSnano && SSnano.close_uis(src))
	if(req_access_faction && req_access_faction != "")
		var/datum/world_faction/faction = FindFaction(req_access_faction)
		data["connected_faction"] = faction.name
		var/datum/access_category/core/core = new()
		var/list/all_categories = list()
		all_categories |= core
		all_categories |= faction.access_categories
		var/list/access_categories[0]
		for(var/datum/access_category/category in all_categories)
			access_categories[++access_categories.len] = list("name" = category.name, "accesses" = list(), "ref" = "\ref[category]")
			for(var/x in category.accesses)
				var/name = category.accesses[x]
				if(!name) continue
				access_categories[access_categories.len]["accesses"] += list(list(
				"name" = sanitize("([x]) [name]"),
				"access" = x,
				"selected" = (text2num(x) in req_access)
				))
		data["access_categories"] = access_categories
	var/list/personal_access[0]
	for(var/x in req_access_personal_list)
		personal_access[++personal_access.len] = list("name" = x)
	data["personal_access"] = personal_access
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "closet.tmpl", "Container Programming", 800, 500, state = state)
		ui.set_initial_data(data)
		ui.open()


/obj/structure/closet/Topic(href, href_list)
	if(..())
		return 1
	. = SSnano.update_uis(src)
	if(locked)
		to_chat(usr, "The container is locked.")
		return
	switch(href_list["action"])
		if("change_name")
			var/chose_name = sanitize(input("Enter a new name for the container.", "Container Name", name), MAX_NAME_LEN)
			if(chose_name && usr.Adjacent(src) && !locked)
				name = chose_name
		if("add_name")
			var/chose_name = sanitize(input("Enter a new name to have personal access.", "Personal Access"), MAX_NAME_LEN)
			if(chose_name && usr.Adjacent(src) && !locked)
				req_access_personal_list |= chose_name
		if("remove_name")
			if(usr.Adjacent(src))
				var/chose_name = href_list["target"]
				req_access_personal_list -= chose_name
		if("remove_faction")
			if(usr.Adjacent(src))
				req_access_faction = ""
				req_access = list()
		if("pick_access")
			if(usr.Adjacent(src))
				if(text2num(href_list["selected_access"]) in req_access)
					req_access -= text2num(href_list["selected_access"])
				else
					req_access |= text2num(href_list["selected_access"])
		if("select_faction")
			var/obj/item/weapon/card/id/id_card = usr.GetIdCard()
			if(id_card)
				req_access_faction = id_card.get_faction_uid()
*/