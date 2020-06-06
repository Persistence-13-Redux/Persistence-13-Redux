//Scissor helper
#define isScissors(A) (A && A.isscissors())
/atom/proc/isscissors()
	return FALSE
/obj/item/weapon/scissors/isscissors()
	return TRUE

//Shovel helper
#define isShovel(A)    (A && A.isshovel())
/atom/proc/isshovel()
	return FALSE
/obj/item/weapon/shovel/isshovel()
	return TRUE
/obj/item/weapon/shovel/spade/isshovel()