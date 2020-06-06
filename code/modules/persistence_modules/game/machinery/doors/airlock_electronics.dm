/obj/item/weapon/airlock_electronics/New()
	..()
	ADD_SAVED_VAR(conf_access)
	ADD_SAVED_VAR(one_access)
	ADD_SAVED_VAR(locked)

/obj/item/weapon/airlock_electronics/set_access(var/obj/object)
	if(!object.req_access || !object.req_access_faction || !object.req_access_personal)
		object.check_access()
	. = ..()
	if(object.req_access_faction)
		src.req_access_faction = object.req_access_faction
	if(object.req_access_personal)
		src.req_access_personal = object.req_access_personal
