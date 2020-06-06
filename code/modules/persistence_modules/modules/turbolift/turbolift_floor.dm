/datum/turbolift_floor
	var/list/area_contents = list()
	var/list/extra_turfs = list()

/datum/turbolift_floor/Write(savefile/f)
	var/area/A = locate(area_ref)
	if(!A)
		message_admins("turbolift floor saved without areacontents")
		return 0
	area_contents = list()
	extra_turfs = list()
	for(var/turf/T in A.contents)
		area_contents |= T
	for(var/obj/ob in doors)
		extra_turfs |= ob.loc
	if(ext_panel)
		extra_turfs |= ext_panel.loc
	..()

/datum/turbolift_floor/after_load()
	var/area/turbolift/A = new
	A.contents.Add(area_contents)
	A.lift_floor_label = label
	A.lift_floor_name = name
	A.name = name
	A.lift_announce_str = announce_str
	A.arrival_sound = arrival_sound
	area_ref = "\ref[A]"