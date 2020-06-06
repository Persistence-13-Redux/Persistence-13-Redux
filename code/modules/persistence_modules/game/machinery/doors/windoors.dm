/obj/machinery/door/window/Initialize(mapload, obj/structure/windoor_assembly/assembly)
	. = ..()
	if(assembly && assembly.electronics && !assembly.electronics.autoset)
		req_access_faction = electronics.req_access_faction
		req_access_personal = electronics.req_access_personal

/obj/machinery/door/window/brigdoor
	req_access = list(core_access_security_programs)
