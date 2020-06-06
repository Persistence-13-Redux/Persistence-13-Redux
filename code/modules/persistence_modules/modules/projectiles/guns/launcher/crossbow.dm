/obj/item/weapon/arrow
	mass = 0.150
/obj/item/weapon/spike
	mass = 0.750
/obj/item/weapon/arrow/quill
	mass = 0.050

/obj/item/weapon/arrow/rod
	mass = 0.200
	icon = 'icons/obj/weapons.dmi'

/obj/item/weapon/gun/launcher/crossbow
	mass = 2.26

/obj/item/weapon/gun/launcher/crossbow/New()
	..()
	ADD_SAVED_VAR(bolt)
	ADD_SAVED_VAR(cell)

	ADD_SKIP_EMPTY(bolt)
	ADD_SKIP_EMPTY(cell)