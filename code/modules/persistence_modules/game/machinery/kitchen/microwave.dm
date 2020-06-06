/obj/machinery/microwave/New()
	..()
	ADD_SAVED_VAR(dirty)
	ADD_SAVED_VAR(broken)
	ADD_SAVED_VAR(atom_flags) //Since we change those based on the state of the thing we have to save them
