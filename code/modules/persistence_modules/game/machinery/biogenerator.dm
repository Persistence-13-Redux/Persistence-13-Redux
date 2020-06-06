/obj/machinery/biogenerator/New()
	..()
	ADD_SAVED_VAR(beaker)
	ADD_SAVED_VAR(points)

/obj/machinery/biogenerator/SetupReagents()
	. = ..()
	create_reagents(1000)

/obj/machinery/biogenerator/on_reagent_change()			//When the reagents change, change the icon as well.
	. = ..()
	queue_icon_update()