#define ORE_STACK_MAX_OVERLAYS 10 //The maximum amount of ores overlay we'll ever have on the ore stack icon
#define SVAR_MINERAL "mineral"

//######### This should be used instead of the default bay ores. Otherwise the ore clutter gets insane #########
//-----------------------------------------
// Stackable Ore
//-----------------------------------------
/obj/item/stack/ore
	name = "ore"
	icon_state = "lump"
	icon = 'icons/obj/materials/ore.dmi'
	randpixel = 8
	w_class = ITEM_SIZE_SMALL
	amount = 1
	max_amount = 250

	var/tmp/material/material
	var/datum/geosample/geologic_data
	stacktype = /obj/item/stack/ore

/obj/item/stack/ore/New(var/newloc, var/amount, var/_mat)
	if(_mat)
		set_material_data_byname(_mat)
	..(newloc, amount)
	ADD_SAVED_VAR(geologic_data)

/obj/item/stack/ore/after_load()
	. = ..()
	var/_mineral = custom_saved_vars[SVAR_MINERAL]
	if(_mineral)
		set_material_data_byname(_mineral)
	if(!material)
		log_error("Loaded [src]\ref[src] [loc] ([x], [y], [z]) with null material!")

/obj/item/stack/ore/before_save()
	. = ..()
	if(istype(material))
		custom_saved_vars[SVAR_MINERAL] = material.name

// /obj/item/stack/ore/Initialize()
// 	. = ..()
// 	queue_icon_update()

/obj/item/stack/ore/get_storage_cost()
	return ceil(BASE_STORAGE_COST(w_class) * amount / 50)

/obj/item/stack/ore/proc/set_material_data_byname(var/material_name)
	set_material_data(SSmaterials.get_material_by_name(material_name))

/obj/item/stack/ore/proc/set_material_data(var/material/M)
	if(M && istype(M))
		name = M.ore_name
		desc = M.ore_desc ? M.ore_desc : "A lump of ore."
		material = M
		color = M.icon_colour
		icon_state = M.ore_icon_overlay
		materials_per_unit = M.get_ore_matter()
		update_material_value() //Calculates the total matter value for the stack
		if(M.ore_desc)
			desc = M.ore_desc
		if(icon_state == "dust")
			slot_flags = SLOT_HOLSTER

/obj/item/stack/ore/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/device/core_sampler))
		var/obj/item/device/core_sampler/C = W
		C.sample_item(src, user)
	else
		return ..()

/obj/item/stack/ore/get_material()
	return material

/obj/item/stack/ore/on_update_icon()
	var/icstate = "lump"
	var/iccolor = src.color
	if(material)
		icstate = material.ore_icon_overlay
		iccolor = material.icon_colour
	var/nboverlays = min(ORE_STACK_MAX_OVERLAYS, round(amount/ORE_STACK_MAX_OVERLAYS))

	//Skip when we have the max nb of overlays or if the number doesn't change
	if(overlays.len >= ORE_STACK_MAX_OVERLAYS || overlays.len == nboverlays )
		return
	overlays.Cut()
	for(var/i=1, i < nboverlays, ++i)
		var/image/oreoverlay = image('icons/obj/materials/ore.dmi', icstate)
		oreoverlay.color = iccolor
		var/matrix/M = matrix()
		M.Translate(rand(-7, 7), rand(-8, 8))
		M.Turn(pick(-58, -45, -27.-5, 0, 0, 0, 0, 0, 27.5, 45, 58))
		oreoverlay.transform = M
		src.overlays += oreoverlay
	//TODO: Possibly make sprites for largers amounts leading up to the max, would look better really

/obj/item/stack/ore/stacks_can_merge(var/obj/item/stack/other)
	if(!istype(other, stacktype))
		return FALSE
	if(src.get_amount() < src.get_max_amount() && other.get_amount() < other.get_max_amount())
		var/obj/item/stack/ore/otherstack = other
		if(src.material && otherstack.get_material() && otherstack.get_material().name == src.material.name)
			return TRUE //Make sure we merge only with similar materials!!!
	return FALSE

//Called by parent stack class when spliting or creating a new stack of the same type as this one.
/obj/item/stack/ore/create_new(var/location, var/newamount)
	if(newamount < 1)
		return null
	return new /obj/item/stack/ore(location, newamount, material.name)

// POCKET SAND!
/obj/item/stack/ore/throw_impact(atom/hit_atom)
	. = ..()
	if(icon_state == "dust")
		var/mob/living/carbon/human/H = hit_atom
		if(istype(H) && H.has_eyes() && prob(85))
			H << "<span class='danger'>Some of \the [src] gets in your eyes!</span>"
			H.eye_blind += 5
			H.eye_blurry += 10
			QDEL_IN(src, 1)

//-----------------------------------------
// Subtypes
//-----------------------------------------
/obj/item/stack/ore/uranium/New(var/newloc)
	..(newloc, 1, MATERIAL_PITCHBLENDE)
/obj/item/stack/ore/iron/New(var/newloc)
	..(newloc, 1, MATERIAL_HEMATITE)
/obj/item/stack/ore/graphite/New(var/newloc)
	..(newloc, 1, MATERIAL_GRAPHITE)
/obj/item/stack/ore/glass/New(var/newloc)
	..(newloc, 1, MATERIAL_SAND)
/obj/item/stack/ore/silver/New(var/newloc)
	..(newloc, 1, MATERIAL_SILVER)
/obj/item/stack/ore/gold/New(var/newloc)
	..(newloc, 1, MATERIAL_GOLD)
/obj/item/stack/ore/diamond/New(var/newloc)
	..(newloc, 1, MATERIAL_DIAMOND)
/obj/item/stack/ore/osmium/New(var/newloc)
	..(newloc, 1, MATERIAL_PLATINUM)
/obj/item/stack/ore/hydrogen/New(var/newloc)
	..(newloc, 1, MATERIAL_HYDROGEN)
/obj/item/stack/ore/slag/New(var/newloc)
	..(newloc, 1, MATERIAL_SLAG)
/obj/item/stack/ore/phoron/New(var/newloc)
	..(newloc, 1, MATERIAL_PHORON)
/obj/item/stack/ore/aluminium/New(var/newloc)
	..(newloc, 1, MATERIAL_BAUXITE)
/obj/item/stack/ore/rutile/New(var/newloc)
	..(newloc, 1, MATERIAL_RUTILE)
/obj/item/stack/ore/aluminium/New(var/newloc)
	..(newloc, 1, MATERIAL_BAUXITE)
/obj/item/stack/ore/copper/New(var/newloc)
	..(newloc, 1, MATERIAL_TETRAHEDRITE)

//-----------------------------------------
// Phoron-specific
//-----------------------------------------
/obj/item/stack/ore/phoron/New(var/newloc)
	..(newloc, 1, MATERIAL_PHORON)

// Phoron ore is just as engaging!
/obj/item/stack/ore/phoron/pickup(mob/user)
	var/mob/living/carbon/human/H = user
	var/prot = 0
	if(istype(H))
		if(H.gloves)
			var/obj/item/clothing/gloves/G = H.gloves
			if(G.permeability_coefficient)
				if(G.permeability_coefficient < 0.2)
					prot = 1
	else
		prot = 1

	if(prot > 0)
		return
	else
		to_chat(user, "<span class='warning'>The phoron ore stings your hands as you pick it up.</span>")
		return

#undef ORE_STACK_MAX_OVERLAYS
#undef SVAR_MINERAL 