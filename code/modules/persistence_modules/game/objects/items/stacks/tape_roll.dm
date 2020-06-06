/obj/item/stack/tape_roll
	name = "duct tape"
	desc = "A roll of sticky tape. Possibly for taping ducks... or was that ducts?"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "taperoll"
	max_icon_state = "taperoll"
	base_state = "taperoll"
	singular_name = "length of tape"
	plural_name = "lengths of tape"
	max_amount = 30
	w_class = ITEM_SIZE_SMALL

/obj/item/stack/tape_roll/attack(var/mob/living/carbon/human/H, var/mob/user)
	if(istype(H))
		if(user.zone_sel.selecting == BP_EYES)

			if(!H.organs_by_name[BP_HEAD])
				to_chat(user, "<span class='warning'>\The [H] doesn't have a head.</span>")
				return
			if(!H.has_eyes())
				to_chat(user, "<span class='warning'>\The [H] doesn't have any eyes.</span>")
				return
			if(H.glasses)
				to_chat(user, "<span class='warning'>\The [H] is already wearing somethign on their eyes.</span>")
				return
			if(H.head && (H.head.body_parts_covered & FACE))
				to_chat(user, "<span class='warning'>Remove their [H.head] first.</span>")
				return
			user.visible_message("<span class='danger'>\The [user] begins taping over \the [H]'s eyes!</span>")

			if(!can_use(2))
				to_chat(user, "<span class='warning'>You need 2 strips of tape to blindfold \the [H]!</span>")
				return
			if(!do_mob(user, H, 30))
				return

			// Repeat failure checks.
			if(!H || !src || !H.organs_by_name[BP_HEAD] || !H.has_eyes() || H.glasses || (H.head && (H.head.body_parts_covered & FACE)))
				return
			if(!use(2))
				to_chat(user, "<span class='warning'>You need 2 strips of tape to blindfold \the [H]!</span>")
				return
			playsound(src, 'sound/effects/tape.ogg',25)
			user.visible_message("<span class='danger'>\The [user] has taped up \the [H]'s eyes!</span>")
			H.equip_to_slot_or_del(new /obj/item/clothing/glasses/blindfold/tape(H), slot_glasses)

		else if(user.zone_sel.selecting == BP_MOUTH || user.zone_sel.selecting == BP_HEAD)
			if(!H.organs_by_name[BP_HEAD])
				to_chat(user, "<span class='warning'>\The [H] doesn't have a head.</span>")
				return
			if(!H.check_has_mouth())
				to_chat(user, "<span class='warning'>\The [H] doesn't have a mouth.</span>")
				return
			if(H.wear_mask)
				to_chat(user, "<span class='warning'>\The [H] is already wearing a mask.</span>")
				return
			if(H.head && (H.head.body_parts_covered & FACE))
				to_chat(user, "<span class='warning'>Remove their [H.head] first.</span>")
				return
			playsound(src, 'sound/effects/tape.ogg',25)
			user.visible_message("<span class='danger'>\The [user] begins taping up \the [H]'s mouth!</span>")

			if(!can_use(2))
				to_chat(user, "<span class='warning'>You need 2 strips of tape to gag \the [H]!</span>")
				return
			if(!do_mob(user, H, 30))
				return

			// Repeat failure checks.
			if(!H || !src || !H.organs_by_name[BP_HEAD] || !H.check_has_mouth() || H.wear_mask || (H.head && (H.head.body_parts_covered & FACE)))
				return
			playsound(src, 'sound/effects/tape.ogg',25)

			if(!use(2))
				to_chat(user, "<span class='warning'>You need 2 strips of tape to gag \the [H]!</span>")
				return

			user.visible_message("<span class='danger'>\The [user] has taped up \the [H]'s mouth!</span>")
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/muzzle/tape(H), slot_wear_mask)


		else if(user.zone_sel.selecting == BP_R_HAND || user.zone_sel.selecting == BP_L_HAND)
			playsound(src, 'sound/effects/tape.ogg',25)
			var/obj/item/weapon/handcuffs/cable/tape/T = new(user)
			if(!T.place_handcuffs(H, user))
				user.unEquip(T)
				qdel(T)
			if(!use(6))
				to_chat(user, "<span class='warning'>You need 6 strips of tape to cuff \the [H]'s hands!</span>")
				return

		else if(user.zone_sel.selecting == BP_CHEST)
			if(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/space))
				if(H == user || do_mob(user, H, 10))	//Skip the time-check if patching your own suit, that's handled in attackby()
					playsound(src, 'sound/effects/tape.ogg',25)
					H.wear_suit.attackby(src, user)
			else
				to_chat(user, "<span class='warning'>\The [H] isn't wearing a spacesuit for you to reseal.</span>")

		else
			return ..()
		return 1

/obj/item/stack/tape_roll/proc/stick(var/obj/item/weapon/W, mob/user)
	if(!istype(W, /obj/item/weapon/paper) || istype(W, /obj/item/weapon/paper/sticky) || !user.unEquip(W))
		return
	if(!use(1))
		return
	var/obj/item/weapon/ducttape/tape = new(get_turf(src))
	tape.attach(W)
	user.put_in_hands(tape)

