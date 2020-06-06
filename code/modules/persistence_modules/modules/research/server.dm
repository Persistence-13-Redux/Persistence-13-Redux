/obj/machinery/r_n_d/server/New()
	. = ..()
	ADD_SAVED_VAR(files)
	ADD_SAVED_VAR(id_with_upload_string)
	ADD_SAVED_VAR(id_with_download_string)

/obj/machinery/r_n_d/server/Destroy()
	griefProtection()
	return ..()

/obj/machinery/r_n_d/server/Process()
	. = ..()
	if(health <= 0)
		griefProtection() //I dont like putting this in process() but it's the best I can do without re-writing a chunk of rd servers.

/obj/machinery/r_n_d/server/emp_act(severity)
	griefProtection()
	. = ..()

/obj/machinery/r_n_d/server/ex_act(severity)
	griefProtection()
	. = ..()

//Backup files to centcomm to help admins recover data after greifer attacks
/obj/machinery/r_n_d/server/proc/griefProtection()
	for(var/obj/machinery/r_n_d/server/centcom/C in SSmachines.machinery)
		for(var/datum/tech/T in files.known_tech)
			C.files.AddTech2Known(T)
		for(var/datum/design/D in files.known_designs)
			C.files.AddDesign2Known(D)
		C.files.RefreshResearch()
