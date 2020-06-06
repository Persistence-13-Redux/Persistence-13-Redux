/datum/computer_file/program/New(var/obj/item/modular_computer/comp = null)
	..(null)
	if(comp && istype(comp))
		computer = comp
	ADD_SAVED_VAR(program_state)
	ADD_SAVED_VAR(computer)

/datum/computer_file/program/after_load()
	. = ..()
	update_computer_icon()