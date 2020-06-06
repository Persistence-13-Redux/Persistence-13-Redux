/obj/structure/pit/New()
	. = ..()
	ADD_SAVED_VAR(open)

/obj/structure/pit/Initialize()
	. = ..()
	if(!open)
		close()

/obj/structure/pit/Destroy()
	var/turf/T = get_turf(src)
	for(var/atom/movable/I in contents)
		I.forceMove(T)
	. = ..()
	
/obj/structure/pit/attackby(obj/item/W, mob/user)
	if(isShovel(W))
		var/whatdo = "dig"
		if(!open)
			whatdo = input(user, "Do you want to flatten out the pit, or dig it open?", "dig") as anything in list("dig", "flatten")
		if(whatdo == "dig")
			user.visible_message("<span class='notice'>\The [user] starts [open ? "filling" : "digging open"] \the [src]</span>")
			if( do_after(user, 5 SECONDS) )
				user.visible_message("<span class='notice'>\The [user] [open ? "fills" : "digs open"] \the [src]!</span>")
				if(open)
					close(user)
				else
					open()
			else
				to_chat(user, "<span class='notice'>You stop shoveling.</span>")
		else if("flatten")
			user.visible_message("<span class='notice'>\The [user] starts flattening \the [src] flat</span>")
			if( do_after(user, 5 SECONDS) )
				user.visible_message("<span class='notice'>\The [user] finish flattening \the [src]</span>")
				qdel(src)
		return
	else
		return ..()


/obj/structure/gravemarker
	parts = /obj/item/weapon/material/stick

/obj/structure/gravemarker/New()
	. = ..()
	ADD_SAVED_VAR(message)
