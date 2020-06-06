/datum/follow_holder/stack
	sort_order = 14
	followed_type = /obj/item/organ/internal/stack

/datum/follow_holder/stack/show_entry()
	var/obj/item/organ/internal/stack/S = followed_instance
	return ..() && !S.owner