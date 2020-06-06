/obj/structure/safe
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_CLIMBABLE

/obj/structure/safe/Initialize()
	var/old_t1p = tumbler_1_pos
	var/old_t1o = tumbler_1_open
	var/old_t2p = tumbler_2_pos
	var/old_t2o = tumbler_2_open
	. = ..()
	if(map_storage_loaded)	//Restore tumblers states, since base class changes them on init
		tumbler_1_pos = old_t1p
		tumbler_1_open = old_t1o
		tumbler_2_pos = old_t2p
		tumbler_2_open = old_t2o