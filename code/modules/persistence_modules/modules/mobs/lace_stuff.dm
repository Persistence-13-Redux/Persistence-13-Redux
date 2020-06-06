/mob/proc/get_stack()
	return 0
/mob/proc/get_id_name(var/if_no_id = "Unknown")
	return if_no_id
/mob/proc/sync_organ_dna()
	return
/mob/proc/redraw_inv()
	return TRUE

/mob/living/carbon/human/gib()
	//Drop the lace out
	var/obj/item/organ/internal/stack/ST = get_stack()
	if(ST)
		ST.removed(usr)
		ST.dropInto(get_turf(src))
	. = ..()

/mob/living/carbon/human/dust()
	//Drop the lace out
	var/obj/item/organ/internal/stack/ST = get_stack()
	if(ST)
		ST.removed(usr)
		ST.dropInto(get_turf(src))
	. = ..()

/mob/living/carbon/human/death(gibbed,deathmessage="seizes up and falls limp...", show_dead_message = "You have died.")
	if(stat == DEAD) return
	//backs up lace if available.
	var/obj/item/organ/internal/stack/s = get_stack()
	s?.do_backup()
	. = ..()
	s?.transfer_identity(src)

/mob/living/carbon/human/get_stack()
	return internal_organs_by_name[BP_STACK]

