// Base
/atom/movable/Destroy()
	if(LAZYLEN(movement_handlers) && !ispath(movement_handlers[1]))
		QDEL_NULL_LIST(movement_handlers)
	. = ..()
