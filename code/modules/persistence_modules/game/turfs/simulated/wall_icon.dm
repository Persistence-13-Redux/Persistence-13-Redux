/turf/simulated/wall/update_material(var/integrity)
	. = ..()
	if(material && integrity)
		src.damage = 0

/turf/simulated/wall/on_update_icon()
	LAZYINITLIST(damage_overlays)
	..()

/turf/simulated/wall/proc/update_full(var/propagate, var/integrity)
	update_material(integrity)
	update_connections(propagate)
	queue_icon_update()
