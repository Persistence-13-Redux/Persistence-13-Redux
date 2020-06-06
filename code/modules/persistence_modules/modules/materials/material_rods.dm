// #define DUCTTAPE_NEEDED_SPLINT 8
// /obj/item/stack/material/rods/attackby(obj/item/W as obj, mob/user as mob)
// 	if (istype(W, /obj/item/stack/tape_roll))
// 		if(!can_use(1))
// 			user.visible_message("<span class='warning'>You need at least a [singular_name] to make a splint!</span>")
// 			return
// 		var/obj/item/stack/tape_roll/thetape = W
// 		if(!thetape.use(DUCTTAPE_NEEDED_SPLINT))
// 			user.visible_message("<span class='warning'>You need at least [DUCTTAPE_NEEDED_SPLINT] strips of tape to make a splint!</span>")
// 			return
// 		var/obj/item/stack/medical/splint/ghetto/new_splint = new(user.loc)
// 		new_splint.dropInto(loc)
// 		new_splint.add_fingerprint(user)

// 		user.visible_message("<span class='notice'>\The [user] constructs \a [new_splint] out of a [singular_name].</span>", \
// 				"<span class='notice'>You use make \a [new_splint] out of a [singular_name].</span>")
// 		src.use(1)
// 		return 1
// 	return ..()
// #undef DUCTTAPE_NEEDED_SPLINT