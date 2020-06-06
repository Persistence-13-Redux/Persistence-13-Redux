#define MAX_FINGERPRINTS_SAVED 10
#define MAX_SUIT_FIBERS_SAVED 5
#define MAX_GUNSHOT_RESIDUES_SAVED 5
#define MAX_DNA_TRACES_SAVED 10
/*
	Various checks to run on save to prune useless data
	from various entities.
*/

//Keep track of the lifetime of each objects for maintenance purpose
/atom
	var/created_time

/atom/Initialize(mapload, ...)
	. = ..()
	if(!created_time)
		created_time = REALTIMEOFDAY


//============================================================
//	Pruning Procs
//============================================================

//Proc to override for atoms to clean up old entries to avoid clogging saves
//Cleans things like fingerprints
/atom/proc/prune_data()

/atom/before_save()
	. = ..()
	prune_data()

//Clear forensic stuff, and etc so it stays somewhat sane..
/obj/prune_data()
	..()
	if(LAZYLEN(fingerprints) > MAX_FINGERPRINTS_SAVED)
		var/end = fingerprints.len - MAX_FINGERPRINTS_SAVED
		fingerprints.Cut(0, end) //Remove the oldest

	if(LAZYLEN(fingerprintshidden) > MAX_FINGERPRINTS_SAVED)
		var/end = fingerprintshidden.len - MAX_FINGERPRINTS_SAVED
		fingerprintshidden.Cut(0, end) //Remove the oldest

	if(LAZYLEN(suit_fibers) > MAX_SUIT_FIBERS_SAVED)
		var/end = suit_fibers.len - MAX_SUIT_FIBERS_SAVED
		suit_fibers.Cut(0, end) //Remove the oldest
	
	if(LAZYLEN(gunshot_residue) > MAX_GUNSHOT_RESIDUES_SAVED)
		var/end = gunshot_residue.len - MAX_GUNSHOT_RESIDUES_SAVED
		gunshot_residue.Cut(0, end) //Remove the oldest
	
	if(LAZYLEN(blood_DNA) > MAX_DNA_TRACES_SAVED)
		var/end = blood_DNA.len - MAX_DNA_TRACES_SAVED
		blood_DNA.Cut(0, end) //Remove the oldest

/obj/item/prune_data()
	. = ..()
	if(LAZYLEN(trace_DNA) > MAX_DNA_TRACES_SAVED)
		var/end = trace_DNA.len - MAX_DNA_TRACES_SAVED
		trace_DNA.Cut(0, end) //Remove the oldest

//Save only a single cleanable per turf
// /turf/prune_data()
// 	..()
// 	var/count = 0
// 	for(var/obj/effect/cleanable/C in src)
// 		count++
// 		if(count > 1)
// 			qdel(C)

#undef MAX_FINGERPRINTS_SAVED
#undef MAX_SUIT_FIBERS_SAVED
#undef MAX_GUNSHOT_RESIDUES_SAVED
#undef MAX_DNA_TRACES_SAVED