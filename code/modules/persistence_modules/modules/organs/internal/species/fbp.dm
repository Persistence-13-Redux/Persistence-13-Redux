/obj/item/organ/internal/cell/New()
	..()
	ADD_SAVED_VAR(open)
	ADD_SAVED_VAR(cell)

/obj/item/organ/internal/mmi_holder/New()
	..()
	ADD_SAVED_VAR(stored_mmi)
	ADD_SKIP_EMPTY(stored_mmi)

/obj/item/organ/internal/mmi_holder/after_load()
	. = ..()
	if(stored_mmi)
		update_from_mmi()

/obj/item/organ/internal/mmi_holder/update_from_mmi()

	if(!stored_mmi.brainmob)
		stored_mmi.brainmob = new(stored_mmi)
		stored_mmi.brainobj = new(stored_mmi)
		stored_mmi.brainmob.container = stored_mmi
		stored_mmi.brainmob.real_name = owner.real_name
		stored_mmi.brainmob.SetName(stored_mmi.brainmob.real_name)
		stored_mmi.SetName("[initial(stored_mmi.name)] ([owner.real_name])")

	if(!owner) return

	name = stored_mmi.name
	desc = stored_mmi.desc
	icon = stored_mmi.icon

	stored_mmi.icon_state = "mmi-full"
	icon_state = stored_mmi.icon_state

	if(owner && owner.stat == DEAD)
		owner.set_stat(CONSCIOUS)
		owner.switch_from_dead_to_living_mob_list()
		owner.visible_message("<span class='danger'>\The [owner] twitches visibly!</span>")

//Removed the ghost handling code
/obj/item/organ/internal/mmi_holder/transfer_and_delete()
	if(stored_mmi)
		. = stored_mmi
		stored_mmi.forceMove(src.loc)
		persistantMind.transfer_to(stored_mmi.brainmob)
	qdel(src)
