/obj/structure/bed
	mass = 50
	// maxhealth = 200
	// damthreshold_brute 	= 5
	matter = list()

/obj/structure/bed/New(newloc, new_material = DEFAULT_FURNITURE_MATERIAL, new_padding_material)
	..()
	ADD_SAVED_VAR(padding_material)

/obj/structure/bed/Initialize(mapload, new_material = DEFAULT_FURNITURE_MATERIAL, new_padding_material)
	. = ..()
	if(!map_storage_loaded)
		color = null
		material = SSmaterials.get_material_by_name(new_material)
	if(!istype(material))
		log_warning("obj/structure/bed/Initialize(): [src]\ref[src] has a bad material type. Deleting!")
		qdel(src)
		return
	if(new_padding_material && !map_storage_loaded)
		padding_material = SSmaterials.get_material_by_name(new_padding_material)
	
	update_material()
	queue_icon_update()

/obj/structure/bed/proc/update_material()
	//Setup matter values so refunds works properly
	matter = list()
	matter[material.name] = 2 SHEETS
	if(padding_material)
		matter[padding_material.name] = 1 SHEET

/obj/structure/bed/remove_padding()
	. = ..()
	update_material()
	update_icon()

/obj/structure/bed/add_padding(var/padding_type)
	. = ..()
	update_material()
	update_icon()

/obj/structure/bed/roller/New(newloc, new_material, new_padding_material)
	. = ..()
	ADD_SAVED_VAR(beaker)
	ADD_SAVED_VAR(iv_attached)
	ADD_SAVED_VAR(iv_stand)

