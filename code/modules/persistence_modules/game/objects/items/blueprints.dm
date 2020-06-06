/obj/item/blueprints
	var/const/MaxArea = 3000 //Max nb of tiles an area may be

/obj/item/blueprints/OnTopic(user, href_list)
	if ((usr.restrained() || usr.stat || usr.get_active_hand() != src))
		return TOPIC_NOACTION
	if (!href_list["action"])
		return TOPIC_NOACTION
	switch(href_list["action"])
		if("merge_area")
			merge_area()
		if("add_to_area")
			add_to_area()
	. = ..()

/obj/item/blueprints/interact()
	var/area/A = get_area(src)
	var/list/dat =  list(get_header())

	switch (get_area_type(A))
		if (AREA_SPACE)
			dat += "According \the [src], you are now <b>outside the facility</b>."
			dat += "<a href='?src=\ref[src];action=create_area'>Mark this place as new area.</a>"
		else
			dat += "According \the [src], you are now in <b>\"[A.name]\"</b>."
			dat += "<a href='?src=\ref[src];action=edit_area'>Edit Area</a>"
			if (A.apc)
				dat += "You can't touch this area, because it has an APC."
			else
				dat += "<a href='?src=\ref[src];action=delete_area'>Delete Area</a>"
				if(getAdjacentAreas())
					dat += "<a href='?src=\ref[src];action=add_to_area'>Add to Area</a>"
				else
					dat += "You can't add this location to an area!"
				if(getAdjacentAreas(1))
					dat += "<a href='?src=\ref[src];action=merge_area'>Merge Areas</a>"
				else
					dat += "You can't merge this location to an area!"
	dat += "</p>"
	var/datum/browser/popup = new(usr, "blueprints", name, 290, 300)
	popup.set_content(jointext(dat, "<br>"))
	popup.open()

obj/item/blueprints/get_area_type(var/area/A = get_area(src))
	var/list/SPECIALS = list(
		/area/shuttle,
		/area/turbolift,
	)

	if(is_type_in_list(A, SPECIALS))
		return AREA_SPECIAL
	return ..()

/obj/item/blueprints/proc/merge_area()
	var/area/A = get_area(usr)
	var/list/areas = getAdjacentAreas()
	if(areas)
		var/area/oldArea = input("Choose area to merge into [A.name]", "Area") as null|anything in areas
		if(!oldArea)
			interact()
			return
		for(var/turf/T in oldArea.contents)
			ChangeArea(T, A)
		to_chat(usr, "<span class='notice'>You merge [oldArea.name] into [A.name]</span>")
		qdel(oldArea)
	else
		to_chat(usr, "<span class='notice'>No valid areas could be found. Make sure they don't have an APC.</span>")
	interact()
	return

/obj/item/blueprints/proc/add_to_area()
	var/area/A = get_area(usr)
	var/list/turfs = list()
	for(var/dir in GLOB.cardinal)
		var/turf/T = get_step(usr, dir)
		var/area/area = get_area(T)
		if(area && !area.apc && area != A && !istype(area, /area/turbolift))
			turfs["[dir2text(dir)]"] = T
	var/turf/T = turfs[input("Choose turf to merge into [A.name]", "Area") as null|anything in turfs]
	if(!T)
		interact()
		return
	var/area/ar = T.loc
	ChangeArea(T, A)
	if(!ar.contents.len)
		qdel(ar)
	interact()
	return

/obj/item/blueprints/proc/getAdjacentAreas(var/n = 0)
	var/area/A = get_area(usr)
	var/list/areas = list()
	for(var/dir in GLOB.cardinal)
		var/turf/T = get_step(usr, dir)
		var/area/area = get_area(T)
		if(area && !area.apc && area != A && !istype(area, /area/turbolift))
			if(n || !isspace(area))
				areas.Add(area)
	if(!areas.len)
		return 0
	else
		return areas

/obj/item/blueprints/delete_area()
	var/area/A = get_area(src)
	if (get_area_type(A) == AREA_SPACE || A.apc) //let's just check this one last time, just in case
		to_chat(usr, SPAN_WARNING("You can't delete [A.name]!"))
		interact()
		return
	to_chat(usr, "<span class='notice'>You scrub [A.name] off the blueprint.</span>")
	log_and_message_admins("deleted area [A.name] via station blueprints.")
	qdel(A)
	interact()

//Re-defined to use the new MaxArea constant
/obj/item/blueprints/detect_room(var/turf/first)
	var/list/turf/found = new
	var/list/turf/pending = list(first)
	while(pending.len)
		if (found.len+pending.len > MaxArea)
			return ROOM_ERR_TOOLARGE
		var/turf/T = pending[1] //why byond havent list::pop()?
		pending -= T
		for (var/dir in GLOB.cardinal)
			var/skip = 0
			for (var/obj/structure/window/W in T)
				if(dir == W.dir || (W.dir in list(NORTHEAST,SOUTHEAST,NORTHWEST,SOUTHWEST)))
					skip = 1; break
			if (skip) continue
			for(var/obj/machinery/door/window/D in T)
				if(dir == D.dir)
					skip = 1; break
			if (skip) continue

			var/turf/NT = get_step(T,dir)
			if (!isturf(NT) || (NT in found) || (NT in pending))
				continue

			switch(check_tile_is_border(NT,dir))
				if(BORDER_NONE)
					pending+=NT
				if(BORDER_BETWEEN)
					//do nothing, may be later i'll add 'rejected' list as optimization
				if(BORDER_2NDTILE)
					found+=NT //tile included to new area, but we dont seek more
				if(BORDER_SPACE)
					return ROOM_ERR_SPACE
		found+=T
	return found
