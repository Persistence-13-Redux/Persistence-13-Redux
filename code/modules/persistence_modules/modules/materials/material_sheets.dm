//------------------------------------
//	Material stacks
//------------------------------------
/obj/item/stack/material
	stacktype = /obj/item/stack/material

/obj/item/stack/material/New(loc, amount)
	. = ..()
	ADD_SAVED_VAR(default_type)
	ADD_SAVED_VAR(default_reinf_type)

/obj/item/stack/material/before_save()
	. = ..()
	//Make sure the default_type and default_reinf_type vars match the current material type names
	if(istype(material))
		default_type = material.name
	if(istype(reinf_material))
		default_reinf_type = reinf_material.name
	else
		default_reinf_type = null

/obj/item/stack/material/list_recipes(mob/user, recipes_sublist)
	if(!reinf_material)
		return
	. = ..()

/obj/item/stack/material/update_strings()
	if(!material)
		CRASH("[src]\ref[src] tried to run update_strings() with null material! (default_type: [default_type], default_reinf_type: [default_reinf_type])")
	. = ..()

/obj/item/stack/material/on_update_icon()
	if(!istype(material))
		log_error("[src] has invalid/null material '[material]'!")
		return
	. = ..()

/obj/item/stack/material/is_same(obj/item/stack/material/M)
	if((stacktype != M.stacktype))
		return FALSE
	. = ..()

//--------------------------------
//	Generic
//--------------------------------
/obj/item/stack/material/generic/Initialize()
	. = ..()
	if(istype(material)) color = material.icon_colour
	//This should make any existing stacks of generic material on the save turn into regular old material stacks
	if(material && loc)
		material.place_sheet(get_turf(src), amount)
	return INITIALIZE_HINT_QDEL


//--------------------------------
//	Iron
//--------------------------------
/obj/item/stack/material/iron
	name = MATERIAL_IRON
	icon_state = "ingot"
	plural_icon_state = "ingot-mult"
	max_icon_state = "ingot-max"
	default_type = MATERIAL_IRON

/obj/item/stack/material/iron/ten
	amount = 10

/obj/item/stack/material/iron/fifty
	amount = 50

//--------------------------------
//	Stone
//--------------------------------
/obj/item/stack/material/sandstone/ten
	amount = 10

/obj/item/stack/material/sandstone/fifty
	amount = 50

//--------------------------------
//	Diamond
//--------------------------------
/obj/item/stack/material/diamond/fifty
	amount = 50

//--------------------------------
//	Uranium
//--------------------------------
/obj/item/stack/material/uranium
	name = MATERIAL_URANIUM

/obj/item/stack/material/uranium/fifty
	amount = 50


//--------------------------------
//	Gold
//--------------------------------
/obj/item/stack/material/gold/fifty
	amount = 50

//--------------------------------
//	Silver
//--------------------------------
/obj/item/stack/material/silver/fifty
	amount = 50

//--------------------------------
//	Platinum
//--------------------------------
/obj/item/stack/material/platinum/fifty
	amount = 50

//--------------------------------
//	Metallic Hydrogen
//--------------------------------
/obj/item/stack/material/mhydrogen/fifty
	amount = 50

//--------------------------------
//	Osmium
//--------------------------------
/obj/item/stack/material/osmium/fifty
	amount = 50

//--------------------------------
//	Deuterium
//--------------------------------
/obj/item/stack/material/deuterium/ten
	amount = 10

//--------------------------------
//	Titanium
//--------------------------------
/obj/item/stack/material/titanium
	item_state = "sheet-metal"

//--------------------------------
//	Cloth
//--------------------------------
/obj/item/stack/material/cloth/ten
	amount = 10

/obj/item/stack/material/cloth/fifty
	amount = 50

//--------------------------------
//	Leather
//--------------------------------
/obj/item/stack/material/leather/ten
	amount = 10

/obj/item/stack/material/leather/fifty
	amount = 50

//--------------------------------
//	Borosilicate Glass
//--------------------------------
/obj/item/stack/material/glass/phoronglass/ten
	amount = 10

/obj/item/stack/material/glass/phoronglass/fifty
	amount = 50

//--------------------------------
//	Reinforced Borosilicate Glass
//--------------------------------
/obj/item/stack/material/glass/phoronrglass/fifty
	amount = 50

//--------------------------------
//	Skins
//--------------------------------
/obj/item/stack/material/generic/skin/ten
	amount = 10
/obj/item/stack/material/generic/skin/fifty
	amount = 50

//--------------------------------
//	Bones
//--------------------------------
/obj/item/stack/material/generic/bone/ten
	amount = 10
/obj/item/stack/material/generic/bone/fifty
	amount = 50

//--------------------------------
//	Bricks
//--------------------------------
/obj/item/stack/material/generic/brick/ten
	amount = 10
/obj/item/stack/material/generic/brick/fifty
	amount = 50

//===============================================================================
// New material stacks
//===============================================================================
//--------------------------------
//	Beeswax
//--------------------------------
/obj/item/stack/material/edible/beeswax
	name = MATERIAL_BEESWAX
	desc = "Soft substance produced by bees. Used to make candles mainly."
	singular_name = "piece"
	icon = 'icons/obj/beekeeping.dmi'
	icon_state = "Wax"
	default_type = MATERIAL_BEESWAX
/obj/item/stack/material/edible/beeswax/ten
	amount = 10
/obj/item/stack/material/edible/beeswax/fifty
	amount = 50

//--------------------------------
//	Edible
//--------------------------------
//Edible materials!
/obj/item/stack/material/edible
	name = "edible"
	icon_state = "sheet-leather"
	default_type = "pinkgoo"

//--------------------------------
//	Pink Goo
//--------------------------------
/obj/item/stack/material/edible/pink_goo_slab
	name = MATERIAL_PINK_GOO
	desc = "A mix of meats, from various origins and species, grinded finely and pressed into thick meaty slabs.."
	singular_name = "pink goo slab"
	icon_state = "sheet-leather"
	default_type = MATERIAL_PINK_GOO
/obj/item/stack/material/edible/pink_goo_slab/ten
	amount = 10
/obj/item/stack/material/edible/pink_goo_slab/fifty
	amount = 50

//--------------------------------
//	Fiberglass
//--------------------------------
/obj/item/stack/material/glass/fiberglass
	name = "fiberglass"
	default_type = MATERIAL_FIBERGLASS
/obj/item/stack/material/glass/fiberglass/ten
	amount = 10
/obj/item/stack/material/glass/fiberglass/fifty
	amount = 50

//--------------------------------
//	Quartz
//--------------------------------
/obj/item/stack/material/glass/quartz
	name = MATERIAL_QUARTZ
	default_type = MATERIAL_QUARTZ
/obj/item/stack/material/glass/quartz/ten
	amount = 10
/obj/item/stack/material/glass/quartz/fifty
	amount = 50

//--------------------------------
//	Sulfur
//--------------------------------
/obj/item/stack/material/sulfur
	name = MATERIAL_SULFUR
	icon_state = "brick"
	plural_icon_state = "brick-mult"
	max_icon_state = "brick-max"
	default_type = MATERIAL_SULFUR
/obj/item/stack/material/sulfur/ten
	amount = 10
/obj/item/stack/material/sulfur/fifty
	amount = 50

//--------------------------------
//	Salt
//--------------------------------
/obj/item/stack/material/salt
	name = "salt brick"
	icon_state = "brick"
	plural_icon_state = "brick-mult"
	max_icon_state = "brick-max"
	default_type = MATERIAL_ROCK_SALT
/obj/item/stack/material/salt/ten
	amount = 10
/obj/item/stack/material/salt/fifty
	amount = 50

//--------------------------------
//	Carbon
//--------------------------------
/obj/item/stack/material/carbon
	name = "graphite brick"
	icon_state = "brick"
	plural_icon_state = "brick-mult"
	max_icon_state = "brick-max"
	default_type = MATERIAL_GRAPHITE
/obj/item/stack/material/carbon/ten
	amount = 10
/obj/item/stack/material/carbon/fifty
	amount = 50

//--------------------------------
//	Copper
//--------------------------------
/obj/item/stack/material/copper
	name = MATERIAL_COPPER
	icon_state = "sheet"
	plural_icon_state = "sheet-mult"
	max_icon_state = "sheet-max"
	default_type = MATERIAL_COPPER
/obj/item/stack/material/copper/ten
	amount = 10
/obj/item/stack/material/copper/fifty
	amount = 50

//--------------------------------
//	Bronze
//--------------------------------
/obj/item/stack/material/bronze
	name = MATERIAL_BRONZE
	icon_state = "sheet"
	plural_icon_state = "sheet-mult"
	max_icon_state = "sheet-max"
	default_type = MATERIAL_BRONZE
/obj/item/stack/material/bronze/ten
	amount = 10
/obj/item/stack/material/bronze/fifty
	amount = 50

//--------------------------------
//	Brass
//--------------------------------
/obj/item/stack/material/brass
	name = MATERIAL_BRASS
	icon_state = "sheet"
	plural_icon_state = "sheet-mult"
	max_icon_state = "sheet-max"
	default_type = MATERIAL_BRASS
/obj/item/stack/material/brass/ten
	amount = 10
/obj/item/stack/material/brass/fifty
	amount = 50

//--------------------------------
//	Tin
//--------------------------------
/obj/item/stack/material/tin
	name = MATERIAL_TIN
	icon_state = "ingot"
	plural_icon_state = "ingot-mult"
	max_icon_state = "ingot-max"
	default_type = MATERIAL_TIN
/obj/item/stack/material/tin/ten
	amount = 10
/obj/item/stack/material/tin/fifty
	amount = 50

//--------------------------------
//	Zinc
//--------------------------------
/obj/item/stack/material/zinc
	name = MATERIAL_ZINC
	icon_state = "ingot"
	plural_icon_state = "ingot-mult"
	max_icon_state = "ingot-max"
	default_type = MATERIAL_ZINC
/obj/item/stack/material/zinc/ten
	amount = 10
/obj/item/stack/material/zinc/fifty
	amount = 50

//--------------------------------
//	Tungsten
//--------------------------------
/obj/item/stack/material/tungsten
	name = MATERIAL_TUNGSTEN
	icon_state = "ingot"
	plural_icon_state = "ingot-mult"
	max_icon_state = "ingot-max"
	default_type = MATERIAL_TUNGSTEN
/obj/item/stack/material/tungsten/ten
	amount = 10
/obj/item/stack/material/tungsten/fifty
	amount = 50

//--------------------------------
//	Lead
//--------------------------------
/obj/item/stack/material/lead
	name = MATERIAL_LEAD
	icon_state = "ingot"
	plural_icon_state = "ingot-mult"
	max_icon_state = "ingot-max"
	default_type = MATERIAL_LEAD
/obj/item/stack/material/lead/ten
	amount = 10
/obj/item/stack/material/lead/fifty
	amount = 50