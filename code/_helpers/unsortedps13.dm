/mob/dview
	invisibility 	= 101
	see_in_dark 	= 1e6
	density 		= FALSE
	anchored 		= TRUE
	simulated 		= FALSE
	virtual_mob 	= null
	should_save 	= FALSE
	var/destroy_ret = QDEL_HINT_LETMELIVE

/mob/dview/after_load()
	destroy_ret = null //Let me delete pointless saved instances
	qdel(src)

/mob/dview/Destroy()
	if(!destroy_ret)
		CRASH("Prevented attempt to delete dview mob: [log_info_line(src)]")
	else
		return ..()
	return destroy_ret // Prevents destruction

#define isPDA(A) istype(A,/obj/item/modular_computer/pda)