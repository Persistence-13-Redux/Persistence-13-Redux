//Convenience proc to clear labels, and properly clear the atom_holder's name
/datum/extension/labels/proc/RemoveAllLabels(var/mob/user)
	if(!LAZYLEN(labels))
		return
	for(var/lbl in labels)
		RemoveLabel(user, lbl)