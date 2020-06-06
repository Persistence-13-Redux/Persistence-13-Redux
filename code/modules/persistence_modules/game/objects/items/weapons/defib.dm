/obj/item/weapon/defibrillator
	mass = 1.5 KILOGRAMS

/obj/item/weapon/defibrillator/Destroy()
	if(paddles && !ispath(paddles))
		QDEL_NULL(paddles)
	if(bcell && !ispath(bcell))
		QDEL_NULL(bcell)
	paddles = null
	bcell = null
	return 	..()

/obj/item/weapon/defibrillator/get_cell()
	if(!ispath(bcell))
		return bcell
	return null