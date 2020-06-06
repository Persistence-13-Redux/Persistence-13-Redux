//-----------------------------------------
// Stackable Ices
//-----------------------------------------
/obj/item/stack/ore/ices
	name = "ice"
	stacktype = /obj/item/stack/ore/ices
	atom_flags = 0 //Wanna have those react
	temperature = 5 //k so all ices shouldn't melt immediately
	var/tmp/time_next_melt = 0 //Time at which one nugget might melt

/obj/item/stack/ore/ices/melt(user)
	//#TODO leave something behind
	return ..() 

//Handles melting ices - Disabled for now
// /obj/item/stack/ore/ices/ProcessAtomTemperature()
// 	if(..() == PROCESS_KILL || !material || amount <= 0)
// 		return PROCESS_KILL
	
// 	if(!time_next_melt && src.temperature > src.material.melting_point)
// 		time_next_melt = world.time + 5 SECONDS
// 	else if(src.temperature < src.material.melting_point)
// 		time_next_melt = 0
	
// 	if(world.time > time_next_melt && amount > 0)
// 		time_next_melt = 0
// 		use(1)
// 		if(!amount)
// 			spawn(1)
// 				src.melt()
// 			return PROCESS_KILL

//-----------------------------------------
// Subtypes
//-----------------------------------------
/obj/item/stack/ore/ices/water/New(var/newloc)
	..(newloc, MATERIAL_ICES_WATER)
/obj/item/stack/ore/ices/nitrogen/New(var/newloc)
	..(newloc, MATERIAL_ICES_NITROGEN)
/obj/item/stack/ore/ices/amonia/New(var/newloc)
	..(newloc, MATERIAL_ICES_AMONIA)
/obj/item/stack/ore/ices/hydrogen/New(var/newloc)
	..(newloc, MATERIAL_ICES_HYDROGEN)
/obj/item/stack/ore/ices/sulfur_dioxide/New(var/newloc)
	..(newloc, MATERIAL_ICES_SULFUR_DIOXIDE)
/obj/item/stack/ore/ices/carbon_dioxide/New(var/newloc)
	..(newloc, MATERIAL_ICES_CARBON_DIOXIDE)
/obj/item/stack/ore/ices/methane/New(var/newloc)
	..(newloc, MATERIAL_ICES_METHANE)
/obj/item/stack/ore/ices/acetone/New(var/newloc)
	..(newloc, MATERIAL_ICES_ACETONE)