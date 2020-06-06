#define DUCTTAPE_NEEDED_SUITFIX 10
#define SURFACE_BREACHES 1
#define STRUCTURE_BREACHES 2

/obj/item/clothing/suit/space/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/stack/tape_roll))
		var/datum/breach/target_breach		//Target the largest unpatched breach.
		for(var/datum/breach/B in breaches)
			if(B.patched)
				continue
			if(!target_breach || (B.class > target_breach.class))
				target_breach = B

		var/obj/item/stack/tape_roll/thetape = W
		if(!target_breach)
			to_chat(user, "There are no open breaches to seal with \the [W].")
		else if(user != loc)		//Doing this in your own inventory is awkward.
			if(!thetape.can_use(DUCTTAPE_NEEDED_SUITFIX))
				user.visible_message("<span class='warning'>You need [DUCTTAPE_NEEDED_SUITFIX] strips of tape to seal \the [target_breach] on \the [src].</span>")
				return
			if(!do_after(user, 30, src))
				return
		if(!thetape.use(DUCTTAPE_NEEDED_SUITFIX))
			user.visible_message("<span class='warning'>You need [DUCTTAPE_NEEDED_SUITFIX] strips of tape to seal \the [target_breach] on \the [src].</span>")
			return
		playsound(src, 'sound/effects/tape.ogg',25)
		user.visible_message("<b>[user]</b> uses \the [W] to seal \the [target_breach] on \the [src].")
		target_breach.patched = TRUE
		target_breach.update_descriptor()
		calc_breach_damage()
		return

#undef SURFACE_BREACHES
#undef STRUCTURE_BREACHES
#undef DUCTTAPE_NEEDED_SUITFIX
