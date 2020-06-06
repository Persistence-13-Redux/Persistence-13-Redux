/obj/item/weapon/airlock_brace/update_access()
	if(!electronics)
		return
	. = ..()
	req_access_faction = electronics.req_access_faction