// Called after turf replaces old one
/turf/post_change()
	..()
	var/turf/simulated/open/T = GetAbove(src)
	if(istype(T))
		T.update_icon()


/turf/simulated/wall/transport_properties_from(turf/simulated/wall/other)
	if(!..())
		return 0
	damage = other.damage
	stripe_color = other.stripe_color
	material = other.material
	reinf_material = other.reinf_material
	construction_stage = other.construction_stage
	can_open = other.can_open
	blocks_air = other.blocks_air
	last_state = other.last_state
	return 1

/turf/simulated/floor/transport_properties_from(turf/simulated/floor/other)
	. = ..()
	prior_floortype = other.prior_floortype
	prior_resources = other.prior_resources
	resources = other.resources
