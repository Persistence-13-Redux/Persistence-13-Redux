/obj/item/weapon/syringe_cartridge
	mass = 0.1
/obj/item/weapon/syringe_cartridge/New()
	..()
	ADD_SAVED_VAR(syringe)
	ADD_SKIP_EMPTY(syringe)

/obj/item/weapon/gun/launcher/syringe
	mass = 1.8

/obj/item/weapon/gun/launcher/syringe/New()
	..()
	ADD_SAVED_VAR(next)
	ADD_SAVED_VAR(darts)

	ADD_SKIP_EMPTY(next)
	ADD_SKIP_EMPTY(darts)

/obj/item/weapon/gun/launcher/syringe/rapid
	mass = 2.3
