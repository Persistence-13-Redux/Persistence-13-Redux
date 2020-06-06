/datum/extension/labels/New()
	..()
	atom_holder = holder
	ADD_SAVED_VAR(atom_holder)
	ADD_SAVED_VAR(labels)
	ADD_SKIP_EMPTY(labels)

/datum/extension/labels/Destroy()
	atom_holder = null
	LAZYCLEARLIST(labels)
	QDEL_NULL(labels)
	RemoveAllLabels()
	return ..()