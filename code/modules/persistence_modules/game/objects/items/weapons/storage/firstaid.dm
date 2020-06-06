/obj/item/weapon/storage/firstaid/empty
	name = "first-aid kit"
	icon_state = "firstaid"

/obj/item/weapon/storage/firstaid/regular/empty
	startswith = null

/obj/item/weapon/storage/firstaid/trauma/empty
	startswith = null

/obj/item/weapon/storage/firstaid/fire/empty
	startswith = null

/obj/item/weapon/storage/firstaid/fire/empty
	startswith = null

/obj/item/weapon/storage/firstaid/toxin/empty
	startswith = null

/obj/item/weapon/storage/firstaid/o2/empty
	startswith = null

/obj/item/weapon/storage/firstaid/adv/empty
	startswith = null

/obj/item/weapon/storage/firstaid/combat/empty
	startswith = null

/obj/item/weapon/storage/firstaid/stab/empty
	startswith = null

/obj/item/weapon/storage/firstaid/surgery/empty
	startswith = null

/obj/item/weapon/storage/pill_bottle/New()
	. = ..()
	ADD_SAVED_VAR(wrapper_color)
	ADD_SAVED_VAR(label)
