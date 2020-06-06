/mob/living/carbon/human/redraw_inv()
	var/obj/item/W
	if(back)
		W = back
		W.hud_layerise()
	if(wear_mask)
		W = wear_mask
		W.hud_layerise()
	if(handcuffed)
		W = handcuffed
		W.hud_layerise()
	if(l_hand)
		W = l_hand
		W.hud_layerise()
		W.screen_loc = ui_lhand
	if(r_hand)
		W = r_hand
		W.hud_layerise()
		W.screen_loc = ui_rhand


	if(belt)
		W = belt
		W.hud_layerise()
	if(wear_id)
		W = wear_id
		W.hud_layerise()
	if(l_ear)
		W = l_ear
		W.hud_layerise()
	if(r_ear)
		W = r_ear
		W.hud_layerise()
	if(glasses)
		W = glasses
		W.hud_layerise()
	if(gloves)
		W = gloves
		W.hud_layerise()
	if(head)
		W = head
		W.hud_layerise()
	if(shoes)
		W = shoes
		W.hud_layerise()
	if(wear_suit)
		W = wear_suit
		W.hud_layerise()
	if(w_uniform)
		W = w_uniform
		W.hud_layerise()
	if(l_store)
		W = l_store
		W.hud_layerise()
	if(r_store)
		W = r_store
		W.hud_layerise()
	if(s_store)
		W = s_store
		W.hud_layerise()
	if(hud_used)
		hud_used.persistant_inventory_update()
		//hud_used.hands_inventory_update()

/mob/living/carbon/human/proc/has_item_equipped(var/itemtype)
	var/list/equipped = get_equipped_items()
	for(var/obj/item/E in equipped)
		if(istype(E, itemtype))
			return E
	return null