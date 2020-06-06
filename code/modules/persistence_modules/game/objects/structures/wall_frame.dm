

/obj/structure/wall_frame/New(var/new_loc, var/materialtype)
	..()
	ADD_SAVED_VAR(paint_color)
	ADD_SAVED_VAR(stripe_color)

/obj/structure/wall_frame/Initialize()
	if(!material)
		material = DEFAULT_WALL_MATERIAL
	if(istext(material))
		material = SSmaterials.get_material_by_name(material)
	//maxhealth = material.integrity
	update_connections(TRUE)
	queue_icon_update()
	. = ..()
