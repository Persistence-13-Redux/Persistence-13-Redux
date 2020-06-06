#define SVAR_FLOORING "flooring.name"

/turf/simulated/floor
	var/prior_floortype = /turf/space
	var/prior_resources = list()

/turf/simulated/floor/New(var/newloc, var/floortype)
	..()
	ADD_SAVED_VAR(broken)
	ADD_SAVED_VAR(burnt)
	//ADD_SAVED_VAR(flooring)
	ADD_SAVED_VAR(mineral)

/turf/simulated/floor/should_never_save(list/L)
	L.Add("flooring") //Don't save Decl
	return ..(L)

/turf/simulated/floor/before_save()
	. = ..()
	if(istype(flooring))
		custom_saved_vars[SVAR_FLOORING] = flooring.name

/turf/simulated/floor/after_load()
	. = ..()
	var/_flooring = custom_saved_vars[SVAR_FLOORING]
	if(length(_flooring))
		set_flooring(decls_repository.get_decl(_flooring))

/turf/simulated/floor/ReplaceWithLattice()
	var/resources = prior_resources
	var/floortype = prior_floortype
	src.ChangeTurf(prior_floortype)
	spawn()
		var/turf/simulated/T = locate(src.x, src.y, src.z)
		if(ispath(floortype, /turf/simulated))
			T.resources = resources
		new /obj/structure/lattice(T)

#undef SVAR_FLOORING