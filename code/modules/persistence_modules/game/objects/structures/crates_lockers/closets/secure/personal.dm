/obj/structure/closet/secure_closet/personal/cabinet/empty/WillContain()
	return

/obj/structure/closet/secure_closet/personal/set_owner(var/registered_name, var/faction = null)
	if (registered_name)
		if(faction)
			src.req_access_faction = faction
	else
		src.req_access_faction = initial(req_access_faction)
	return ..(registered_name)