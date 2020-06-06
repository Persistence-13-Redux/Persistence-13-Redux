//Used to generate a id_tag that would be unique to the machine at that specific coordinate
/obj/machinery/proc/make_loc_string_id(var/prefix)
	return "[prefix]([x]:[y]:[z])"

/obj/machinery/dnaforensics/New()
	..()
	ADD_SAVED_VAR(bloodsamp)
	ADD_SAVED_VAR(closed)
	ADD_SAVED_VAR(scanning)
	ADD_SAVED_VAR(scanner_progress)
	ADD_SAVED_VAR(report_num)

/obj/machinery/microscope/New()
	..()
	ADD_SAVED_VAR(sample)
	ADD_SAVED_VAR(report_num)

/obj/structure/iv_drip/New()
	. = ..()
	ADD_SAVED_VAR(mode)
	ADD_SAVED_VAR(beaker)
	ADD_SAVED_VAR(transfer_amount)
