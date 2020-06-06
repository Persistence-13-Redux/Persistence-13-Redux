/obj/structure/morgue
	mass = 20

/obj/structure/morgue/on_update_icon()
	. = ..()
	if (connected)
		icon_state = "morgue0"
	else if (contents.len)
		icon_state = "morgue2"
	else
		icon_state = "morgue1"

/obj/structure/morgue/attackby(var/obj/item/P, mob/user as mob)
	if(isWrench(P))
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		to_chat(user, "You begin dismantling \the [src]..")
		if(do_after(user, 5 SECONDS, src))
			to_chat(user, "You dismantled \the [src]!")
			dismantle()
	else
		return ..()

/obj/structure/m_tray
	should_save = FALSE //Don't save trays

/obj/structure/m_tray/after_load()
	qdel(src)
