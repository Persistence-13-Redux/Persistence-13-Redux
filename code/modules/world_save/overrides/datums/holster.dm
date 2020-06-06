/datum/extension/holster/New(holder, storage, sound_in, sound_out, can_holster)
	..()
	if(!holder)
		log_debug("[src] has null holder!!")
	atom_holder = holder
	if(!storage)
		src.storage = storage
	else
		log_error("extension/holster/New(): Created a [src]\ref[src] without a proper storage pocket linked!")
	ADD_SAVED_VAR(holstered)
	ADD_SAVED_VAR(atom_holder)
	ADD_SAVED_VAR(storage)

/datum/extension/holster/after_load()
	. = ..()
	atom_holder.verbs |= /atom/proc/holster_verb

/datum/extension/holster/Destroy()
	storage = null
	holstered = null
	atom_holder.verbs -= /atom/proc/holster_verb
	. = ..()