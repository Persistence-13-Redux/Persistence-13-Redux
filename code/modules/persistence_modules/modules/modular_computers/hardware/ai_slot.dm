/obj/item/weapon/stock_parts/computer/ai_slot/New()
	..()
	ADD_SAVED_VAR(stored_card)

/obj/item/weapon/stock_parts/computer/ai_slot/attackby(obj/item/weapon/aicard/card, mob/living/user)
	if(!istype(card))
		return
	do_insert_ai(card, user)
	return TRUE