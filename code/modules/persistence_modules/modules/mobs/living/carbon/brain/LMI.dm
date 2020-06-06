//============================================
// Lace Maching Interface
//============================================
/obj/item/device/mmi/lmi
	name = "lace-machine interface"
	desc = "A complex machine interface that connects an active neural lace. It contains an internal speaker the lace can use to communicate."
	icon = 'code/modules/persistence_modules/icons/obj/items/lmi.dmi'
	icon_state = "lmi_empty"
	w_class = ITEM_SIZE_NORMAL
	origin_tech = list(TECH_BIO = 3)
	req_access = list()
	brainobj = null
	var/obj/item/organ/internal/stack/laceobj = null	//The lace, replaces the brainobj in the mmi

/obj/item/device/mmi/lmi/New()
	. = ..()
	ADD_SAVED_VAR(laceobj)

/obj/item/device/mmi/lmi/Destroy()
	if(isrobot(loc))
		var/mob/living/silicon/robot/borg = loc
		borg.mmi = null
	if(brainmob)
		brainmob.loc = laceobj
	if(laceobj)
		laceobj.loc = get_turf(src)
		laceobj = null
		brainmob.container = laceobj
	else
		QDEL_NULL(brainmob)
	return ..()

/obj/item/device/mmi/lmi/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(istype(O,/obj/item/organ/internal/brain))
		return 1 //Keep base class from accepting brains
	
	if(istype(O,/obj/item/organ/internal/stack) && !brainmob) //Time to stick a brain in it --NEO

		var/obj/item/organ/internal/stack/B = O
		if(!B.brainmob)
			to_chat(user, SPAN_NOTICE("This lace is completely useless to you."))
			return
		if(istype(O, /obj/item/organ/internal/stack/vat))
			to_chat(user, SPAN_WARNING("[O] does not fit into [src], and you get the horrifying feeling that it was not meant to."))
			return

		user.visible_message(SPAN_NOTICE("\The [user] sticks \a [O] into \the [src]."))

		brainmob = B.brainmob
		B.brainmob = null
		brainmob.forceMove(src)
		brainmob.container = src
		brainmob.set_stat(CONSCIOUS)
		brainmob.switch_from_dead_to_living_mob_list() //Update dem lists

		laceobj = O
		brainobj = O //For compatibility's sake

		SetName("[initial(name)]: ([brainmob.real_name])")
		update_icon()
		locked = 1

		SSstatistics.add_field("cyborg_mmis_filled",1)

		return
	return ..()

/obj/item/device/mmi/lmi/attack_self(mob/user as mob)
	if(!brainmob)
		to_chat(user, "<span class='warning'>Theirs nothing plugged into the LMI.</span>")
	else if(locked)
		to_chat(user, "<span class='warning'>You try to unplug the lace, but it is clamped into place.</span>")
	else
		to_chat(user, "<span class='notice'>You yank out the lace.</span>")
		var/obj/item/organ/internal/stack/stack
		if (laceobj)	//Pull brain organ out of MMI.
			laceobj.forceMove(user.loc)
			stack = laceobj
			laceobj = null
			brainobj = null
		else	//Or make a new one if empty.
			stack = new(user.loc)
		brainmob.container = null//Reset brainmob mmi var.
		brainmob.forceMove(stack)//Throw mob into brain.
		brainmob.remove_from_living_mob_list() //Get outta here
		stack.brainmob = brainmob//Set the brain to use the brainmob
		brainmob = null//Set mmi brainmob var to null

		update_icon()
		SetName(initial(name))

/obj/item/device/mmi/lmi/transfer_identity(mob/living/carbon/human/H)
	. = ..()
	brainmob.add_lace_action()

/obj/item/device/mmi/lmi/on_update_icon()
	if(laceobj)
		icon_state = "lmi_full"
	else
		icon_state = "lmi_empty"

//============================================
// LMI Radio-Enabled
//============================================
/obj/item/device/mmi/lmi/radio_enabled
	name = "radio-enabled lace-machine interface"
	desc = "A complex machine interface that connects an active neural lace. It contains an internal speaker the lace can use to communicate. This one comes with a built-in radio."
	origin_tech = list(TECH_BIO = 4)
	var/obj/item/device/radio/radio = null//Let's give it a radio.

/obj/item/device/mmi/lmi/radio_enabled/Initialize()
	. = ..()
	radio = new(src)//Spawns a radio inside the MMI.
	radio.broadcasting = TRUE//So it's broadcasting from the start.

/obj/item/device/mmi/lmi/radio_enabled/verb/Toggle_Broadcasting()//Allows the brain to toggle the radio functions.
	set name = "Toggle Broadcasting"
	set desc = "Toggle broadcasting channel on or off."
	set category = "LMI"
	set src = usr.loc//In user location, or in MMI in this case.
	set popup_menu = 0//Will not appear when right clicking.

	if(brainmob.stat)//Only the brainmob will trigger these so no further check is necessary.
		to_chat(brainmob, "Can't do that while incapacitated or dead.")

	radio.broadcasting = !radio.broadcasting
	to_chat(brainmob, "<span class='notice'>Radio is [radio.broadcasting? "now" : "no longer"] broadcasting.</span>")

/obj/item/device/mmi/lmi/radio_enabled/verb/Toggle_Listening()
	set name = "Toggle Listening"
	set desc = "Toggle listening channel on or off."
	set category = "LMI"
	set src = usr.loc
	set popup_menu = 0

	if(brainmob.stat)
		to_chat(brainmob, "Can't do that while incapacitated or dead.")

	radio.listening = !radio.listening
	to_chat(brainmob, "<span class='notice'>Radio is [radio.listening? "now" : "no longer"] receiving broadcast.</span>")

/obj/item/device/mmi/lmi/emp_act(severity)
	if(!brainmob)
		return
	else
		switch(severity)
			if(1)
				brainmob.emp_damage += rand(20,30)
			if(2)
				brainmob.emp_damage += rand(10,20)
			if(3)
				brainmob.emp_damage += rand(0,10)
	return ..()

/obj/item/device/mmi/lmi/get_mob()
	return ismob(loc)? loc : null