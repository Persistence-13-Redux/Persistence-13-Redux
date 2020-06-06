/obj/machinery/computer/rdconsole/CallMaterialName(var/ID)
	. = ..()
	switch(ID)
		if(MATERIAL_PLASTEEL)
			. = "Plasteel"

/obj/machinery/computer/rdconsole/proc/griefProtection() //Have it automatically push research to the centcomm server so wild griffins can't fuck up R&D's work
	for(var/obj/machinery/r_n_d/server/centcom/C in SSmachines.machinery)
		for(var/datum/tech/T in files.known_tech)
			C.files.AddTech2Known(T)
		for(var/datum/design/D in files.known_designs)
			C.files.AddDesign2Known(D)
		C.files.RefreshResearch()

/obj/machinery/computer/rdconsole/OnTopic(user, href_list)
	if(href_list["updt_tech"]) //Update the research holder with information from the technology disk.
		. = TOPIC_REFRESH
		if(t_disk)
			griefProtection() //Update centcomm too
	else if(href_list["updt_design"]) //Updates the research holder with design data from the design disk.
		. = TOPIC_REFRESH
		if(d_disk)
			griefProtection() //Update centcomm too
	else if(href_list["sync"]) //Sync the research holder with all the R&D consoles in the game that aren't sync protected.
		if(sync)
			griefProtection() //Putting this here because I dont trust the sync process
	else if(href_list["reset"]) //Reset the R&D console's database.
		griefProtection()
	. = ..()