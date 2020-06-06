/obj/item/organ/external/on_update_icon(var/regenerate = 0)
	if(QDELING(src) || QDELETED(src))
		return
	if(isnull(species))
		CRASH("[src] \ref[src] has null specie! Loc is [loc]")
	return ..()
