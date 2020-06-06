/obj/item/weapon/gun/projectile/New()
	..()
	ADD_SAVED_VAR(chambered)
	ADD_SAVED_VAR(ammo_magazine)
	ADD_SAVED_VAR(is_jammed)

	ADD_SKIP_EMPTY(chambered)
	ADD_SKIP_EMPTY(ammo_magazine)
