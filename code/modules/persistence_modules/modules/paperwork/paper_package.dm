/*
 * Paper packages (not to be confused with bundled paper)
 */
/obj/item/weapon/paper_package
	name = "package of paper"
	gender = NEUTER
	icon = 'code/modules/persistence_modules/icons/obj/items/paper.dmi'
	icon_state = "paperpackage"
	item_state = "paperpackage"
	randpixel = 8
	throwforce = 0
	w_class = ITEM_SIZE_SMALL
	throw_range = 2
	throw_speed = 1
	layer = ABOVE_OBJ_LAYER
	attack_verb = list("bureaucratized")
	var/amount = 50 //How much paper is stored
