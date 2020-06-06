/turf/New()
	..()
	ADD_SAVED_VAR(holy)
	ADD_SAVED_VAR(blessed)
	ADD_SAVED_VAR(flooded)

//Not sure if this actually does anything..
// /turf/Initialize(mapload, ...)
// 	. = ..()
// 	for(var/atom/movable/AM as mob|obj in src)
// 		spawn( 0 )
// 			src.Entered(AM)
// 			return

// /turf/Entered(var/atom/A, var/atom/old_loc)
// 	..()
// 	if(ismob(A))
// 		var/mob/M = A
// 		if (isliving(M) && M.stat != DEAD)
// 			SSmazemap.map_data["[M.z]"]?.set_active()

