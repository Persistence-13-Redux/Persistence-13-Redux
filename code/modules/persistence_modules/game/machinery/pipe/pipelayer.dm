/obj/machinery/pipelayer
	max_metal = 100
	metal = 0

/obj/machinery/pipelayer/New()
	..()
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(a_dis)
	ADD_SAVED_VAR(P_type)
	ADD_SAVED_VAR(P_type_t)
	ADD_SAVED_VAR(metal)