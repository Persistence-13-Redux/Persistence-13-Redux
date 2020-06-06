/turf/simulated/floor/attackby(var/obj/item/C, var/mob/user)
	if(!C || !user)
		return 0
	if(isCrowbar(C))
		if(broken || burnt)
			var/turf/T = GetBelow(src)
			if(istype(T,/turf/simulated/wall) || istype(T,/turf/unsimulated/wall))
				to_chat(user, SPAN_WARNING("Remove the wall on the level below first!"))
				return
			playsound(src, 'sound/items/Crowbar.ogg', 80, 1)
			visible_message("<span class='notice'>[user] has begun prying off the damaged plating.</span>")
			if(T)
				T.visible_message("<span class='warning'>The ceiling above looks as if it's being pried off.</span>")
			if(do_after(user, 10 SECONDS))
				if(!broken && !burnt || !(is_plating()))return
				visible_message("<span class='warning'>[user] has pried off the damaged plating.</span>")
				new /obj/item/stack/tile/floor(src)
				src.ReplaceWithLattice()
				playsound(src, 'sound/items/Deconstruct.ogg', 80, 1)
				if(T)
					T.visible_message("<span class='danger'>The ceiling above has been pried off!</span>")
					playsound(T, 'sound/items/Deconstruct.ogg', 60, 1)
		else
			return
		return
	else if(isWelder(C))
		var/obj/item/weapon/weldingtool/welder = C
		if(welder.isOn() && (is_plating()))
			if(broken || burnt)
				if(welder.isOn())
					to_chat(user, "<span class='notice'>You fix some dents on the broken plating.</span>")
					playsound(src, 'sound/items/Welder.ogg', 80, 1)
					icon_state = "plating"
					burnt = null
					broken = null
				else
					to_chat(user, "<span class='warning'>You need more welding fuel to complete this task.</span>")
				return
			else
				if(welder.isOn())
					var/turf/T = GetBelow(src)
					var/datum/effect/effect/system/spark_spread/spark = null //Keep it in this scope so it stays alive until after do_after
					var/obj/effect/effect/smoke/illumination/sparklight = null
					if(T)
						T.visible_message("<span class='warning'>The ceiling above looks as if it's being cut with a welder!</span>")
						spark = new
						spark.set_up(10,0,T)
						spark.attach(T)
						spark.start()
						sparklight = new(T, 5 SECONDS, 8, 10, COLOR_MUZZLE_FLASH)
						playsound(T, 'sound/items/Welder.ogg', 40, 1)
					playsound(src, 'sound/items/Welder.ogg', 80, 1)
					visible_message("<span class='notice'>[user] has started melting the plating's reinforcements!</span>")
					if(do_after(user, 5 SECONDS) && welder.isOn() && welder_melt())
						visible_message("<span class='warning'>[user] has melted the plating's reinforcements! It should be possible to pry it off.</span>")
						playsound(src, 'sound/items/Welder.ogg', 80, 1)
						burnt = 1
						remove_decals()
						update_icon()
						qdel(sparklight)
						qdel(spark)
				else
					to_chat(user, "<span class='warning'>You need more welding fuel to complete this task.</span>")
				return
	else
		return ..()