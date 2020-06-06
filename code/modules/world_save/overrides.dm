//Misc overrides for save stuff


// /weakref/after_load() {qdel(src)}//Weakref shouldn't be loaded

/decl/should_save = FALSE //Do not save decls. Otherwise we'll end up with weirdness

/datum/wires/should_save = FALSE

/zone/should_save = TRUE
/zone/var/list/turf_coords = list() // used for save/loading zones :V

/atom/movable/overlay/typing_indicator/should_save = FALSE

/obj/effect/decal/should_save = TRUE
/obj/effect/decal/cleanable/should_save = TRUE
/obj/effect/decal/cleanable/blood/should_save = TRUE

/obj/effect/effect/water/should_save = TRUE
