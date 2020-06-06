/atom/movable/Destroy()
	if(virtual_mob && !ispath(virtual_mob))
		qdel(virtual_mob)
	virtual_mob = null
	return ..()
