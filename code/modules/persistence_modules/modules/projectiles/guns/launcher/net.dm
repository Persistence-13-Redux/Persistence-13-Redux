/obj/item/weapon/gun/launcher/net
	name = "XX-1 \"Varmint Catcher\" net gun"

/obj/item/weapon/gun/launcher/net/New()
	..()
	ADD_SAVED_VAR(chambered)
	ADD_SKIP_EMPTY(chambered)