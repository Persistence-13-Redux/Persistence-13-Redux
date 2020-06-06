// /obj/structure
// 	damthreshold_brute 	= 5
// 	damthreshold_burn 	= 5
// 	maxhealth 			= 100

/obj/structure/before_save()
	. = ..()
	if(istype(material))
		custom_saved_vars["material"] = material.name
	
/obj/structure/after_load()
	. = ..()
	var/material/mat = custom_saved_vars["material"]
	if(mat && istext(mat))
		material = SSmaterials.get_material_by_name(mat)
	else if(istype(mat, /material)) //Backward compatibility
		material = SSmaterials.get_material_by_name(mat.name)		

/obj/structure/update_connections()
	if(!anchored)
		return
	. = ..()

/obj/structure/proc/dismantle()
	if(parts)
		new parts(loc)
	else if(matter && matter.len)
		refund_matter()
	qdel(src)

/obj/structure/proc/default_deconstruction_screwdriver(var/obj/item/weapon/screwdriver/S, var/mob/living/user, var/deconstruct_time = null)
	if(!istype(S))
		return FALSE
	src.add_fingerprint(user)
	user.visible_message(SPAN_NOTICE("You begin to unscrew \the [src]."), SPAN_NOTICE("[user] begins to unscrew \the [src]."))
	if(do_mob(user, src, deconstruct_time? deconstruct_time : 6 SECONDS) && src)
		user.visible_message(SPAN_NOTICE("You finish unscrewing \the [src]."), SPAN_NOTICE("[user] finishes unscrewing \the [src]."))
		dismantle()
		return TRUE
	return FALSE

/obj/structure/proc/default_deconstruction_wrench(var/obj/item/weapon/wrench/W, var/mob/living/user, var/deconstruct_time = null)
	if(!istype(W))
		return FALSE
	src.add_fingerprint(user)
	user.visible_message(SPAN_NOTICE("You begin to dismantle \the [src]."), SPAN_NOTICE("[user] begins to dismantle \the [src]."))
	if(do_mob(user, src, deconstruct_time? deconstruct_time : 4 SECONDS) && src)
		user.visible_message(SPAN_NOTICE("You finish dismantling \the [src]."), SPAN_NOTICE("[user] finishes dismantling \the [src]."))
		dismantle()
		return TRUE
	return FALSE

/obj/structure/proc/default_deconstruction_welder(var/obj/item/weapon/weldingtool/W, var/mob/living/user, var/deconstruct_time = null)
	if(!istype(W) || !W.remove_fuel(0, user))
		return FALSE
	src.add_fingerprint(user)
	user.visible_message(SPAN_NOTICE("You begin to dismantle \the [src]."), SPAN_NOTICE("[user] begins to dismantle \the [src]."))
	if(do_mob(user, src, deconstruct_time? deconstruct_time : (2 * w_class) SECONDS) && W.isOn() && src)
		user.visible_message(SPAN_NOTICE("You finish dismantling \the [src]."), SPAN_NOTICE("[user] finishes dismantling \the [src]."))
		dismantle()
		return TRUE
	return FALSE