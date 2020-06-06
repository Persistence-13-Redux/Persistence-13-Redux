/obj/item/weapon/paper/export
	name = "export manifest"
	icon_state = "paper_words"
	var/is_copy = 1
	var/export_id = 0
	var/business_name = 0

/obj/item/weapon/paper/export/business
	name = "export manifest"
	business_name = null

/obj/item/weapon/paper/export/business/show_content(mob/user, forceshow)
	var/can_read = (istype(user, /mob/living/carbon/human) || isghost(user) || istype(user, /mob/living/silicon)) || forceshow
	if(!forceshow && istype(user,/mob/living/silicon/ai))
		var/mob/living/silicon/ai/AI = user
		can_read = get_dist(src, AI.camera) < 2
	var/info2 = info
	info2 += "LINKED BUSINESS: [business_name]<br>"
	if(src.Adjacent(user))
		info2 += "<br>Swipe business name-tag <A href='?src=\ref[src];connect=1'>or enter full business name here.</A>"
	else
		info2 += "<br>Swipe business name-tag or enter full business name here."
	user << browse("<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY bgcolor='[color]'>[can_read ? info2 : stars(info)][stamps]</BODY></HTML>", "window=[name]")
	onclose(user, "[name]")

/obj/item/weapon/paper/export/business/attackby(obj/item/weapon/P as obj, mob/user as mob)
	if(istype(P, /obj/item/weapon/pen))
		return
	var/obj/item/weapon/card/id/id = P.GetIdCard()
	if(id)
		var/datum/world_faction/business = id.get_faction()
		if(business)
			business_name = business.name
			to_chat(user, "Business linked to export.")
		return
	return ..()

/obj/item/weapon/paper/export/business/Topic(href, href_list)
	. = ..()
	if(!usr || (usr.stat || usr.restrained()))
		return
	if(href_list["connect"])
		var/select_name =  sanitize(input(usr,"Enter the full name of the business.","Connect Business", "") as null|text)
		var/datum/world_faction/viewing = FindFaction(select_name)
		if(viewing && src.Adjacent(usr))
			business_name = viewing.name
			to_chat(usr, "Business linked to export.")
