/obj/item/weapon/gun/launcher/grenade
	name = "pump-action grenade launcher"
/obj/item/weapon/gun/launcher/grenade/New()
	..()
	ADD_SAVED_VAR(chambered)
	ADD_SAVED_VAR(grenades)
	ADD_SKIP_EMPTY(chambered)
	ADD_SKIP_EMPTY(grenades)