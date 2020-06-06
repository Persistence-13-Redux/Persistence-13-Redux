/obj/item/weapon/disk/botany/New()
	. = ..()
	ADD_SAVED_VAR(genes)
	ADD_SAVED_VAR(genesource)

/obj/machinery/botany/New()
	. = ..()
	ADD_SAVED_VAR(seed)
	ADD_SAVED_VAR(loaded_disk)
	ADD_SAVED_VAR(open)
	ADD_SAVED_VAR(active)
	ADD_SAVED_VAR(action_time)
	ADD_SAVED_VAR(last_action)
	ADD_SAVED_VAR(failed_task)
	ADD_SAVED_VAR(disk_needs_genes)

	ADD_SKIP_EMPTY(seed)
	ADD_SKIP_EMPTY(loaded_disk)

//Save the time until finished as absolute time
/obj/machinery/botany/before_save()
	. = ..()
	if(active)
		last_action -= world.time
/obj/machinery/botany/after_save()
	. = ..()
	if(active)
		last_action += world.time

/obj/machinery/botany/extractor
	name = "lysis-isolation centrifuge"
	icon_state = "traitcopier"

/obj/machinery/botany/extractor/New()
	..()
	ADD_SAVED_VAR(genetics)
	ADD_SAVED_VAR(degradation)
