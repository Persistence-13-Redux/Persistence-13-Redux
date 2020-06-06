/obj/screen/movable/ability_master/proc/OnRemove()
	if(!my_mob)
		return
	my_mob.ability_master = null
	if(my_mob.client && my_mob.client.screen)
		my_mob.client.screen -= src
	my_mob = null

/obj/screen/movable/ability_master/Destroy()
	//Get rid of the ability objects.
	remove_all_abilities()
	ability_objects.Cut()
	// After that, remove ourselves from the mob seeing us, so we can qdel cleanly.
	OnRemove()
	. = ..() //run the base class destroy last

/obj/screen/movable/ability_master/add_ability(var/name_given)
	if(!name) return
	update_icon()

/mob/Destroy()
	QDEL_NULL(ability_master)
	. = ..()

/mob/living/var/last_hud_update = 0
/mob/living/Life()
	. = ..()
	if(last_hud_update > world.time)
		last_hud_update = world.time + 15 SECONDS
		update_action_buttons()