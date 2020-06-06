/mob/living/carbon/brain/lace/Life()
	update_action_buttons()

/datum/action/lace
	name = "Access Lace UI"

//The lace action should be cleared when it no longer has any owner and lacemob!
// Otherwise it just sticks around in people's action bar
/datum/action/lace/CheckRemoval()
	var/obj/item/organ/internal/stack/ST = target
	if(!istype(ST))
		return TRUE //Remove plz
	if(ST.can_delete_stack_action())
		return TRUE
	return FALSE

/datum/action/lace_storage
	name = "Access Lace Storage UI"
	action_type = AB_GENERIC
	button_icon = 'code/modules/persistence_modules/icons/obj/action_buttons/lace.dmi'
	button_icon_state = "lace"
	procname = "lace_ui_interact"