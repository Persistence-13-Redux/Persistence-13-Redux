//Replace the default bay tape roll with the new one
/obj/item/weapon/tape_roll/New(var/loc)
	new /obj/item/stack/tape_roll(loc)

/obj/item/weapon/tape_roll/Initialize()
	return INITIALIZE_HINT_QDEL