/obj/machinery/mineral/stacking_machine
	stacks = null

/obj/machinery/mineral/stacking_machine/New()
	..()
	ADD_SAVED_VAR(stack_amt)
	ADD_SAVED_VAR(stacks)

/obj/machinery/mineral/stacking_machine/Initialize()
	. = ..()
	if(!stacks)
		stacks = list()

