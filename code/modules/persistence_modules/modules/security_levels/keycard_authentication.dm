/obj/machinery/keycard_auth/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(default_wrench_floor_bolts(user, 2 SECONDS))
		return 
	return ..()

/proc/make_maint_all_access()
	maint_all_access = 1
	to_world("<font size=4 color='red'>Attention!</font>")
	to_world("<font color='red'>The maintenance access requirement has been revoked on all airlocks.</font>")

/proc/revoke_maint_all_access()
	maint_all_access = 0
	to_world("<font size=4 color='red'>Attention!</font>")
	to_world("<font color='red'>The maintenance access requirement has been readded on all maintenance airlocks.</font>")

/obj/machinery/door/airlock/allowed(mob/M)
	if(maint_all_access && src.check_access_list(list(access_maint_tunnels)))
		return 1
	return ..(M)