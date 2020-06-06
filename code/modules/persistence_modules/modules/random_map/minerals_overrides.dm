
/hook/global_init/proc/override_minerals_caves()

	//Sparse
	GLOB.weighted_minerals_sparse[MATERIAL_TUNGSTEN] 			= 8
	GLOB.weighted_minerals_sparse[MATERIAL_TETRAHEDRITE] 		= 10
	GLOB.weighted_minerals_sparse[MATERIAL_FREIBERGITE] 		= 10
	GLOB.weighted_minerals_sparse[MATERIAL_ILMENITE] 			= 3
	GLOB.weighted_minerals_sparse[MATERIAL_CASSITERITE] 		= 3
	GLOB.weighted_minerals_sparse[MATERIAL_SPHALERITE] 			= 3
	GLOB.weighted_minerals_sparse[MATERIAL_BORON] 				= 4
	GLOB.weighted_minerals_sparse[MATERIAL_ICES_ACETONE] 		= 10
	GLOB.weighted_minerals_sparse[MATERIAL_ICES_AMONIA] 		= 5
	GLOB.weighted_minerals_sparse[MATERIAL_ICES_CARBON_DIOXIDE] = 5
	GLOB.weighted_minerals_sparse[MATERIAL_ICES_HYDROGEN] 		= 10
	GLOB.weighted_minerals_sparse[MATERIAL_ICES_METHANE] 		= 5
	GLOB.weighted_minerals_sparse[MATERIAL_ICES_NITROGEN] 		= 10
	GLOB.weighted_minerals_sparse[MATERIAL_ICES_SULFUR_DIOXIDE] = 5
	GLOB.weighted_minerals_sparse[MATERIAL_ICES_WATER] 			= 10

	//Rich
	GLOB.weighted_minerals_rich[MATERIAL_TUNGSTEN] 				= 10
	GLOB.weighted_minerals_rich[MATERIAL_TETRAHEDRITE] 			= 2
	GLOB.weighted_minerals_rich[MATERIAL_FREIBERGITE] 			= 2
	GLOB.weighted_minerals_rich[MATERIAL_ILMENITE] 				= 10
	GLOB.weighted_minerals_rich[MATERIAL_CASSITERITE] 			= 10
	GLOB.weighted_minerals_rich[MATERIAL_SPHALERITE] 			= 10
	GLOB.weighted_minerals_rich[MATERIAL_BORON] 				= 10
	GLOB.weighted_minerals_rich[MATERIAL_ICES_ACETONE] 			= 1
	GLOB.weighted_minerals_rich[MATERIAL_ICES_AMONIA] 			= 5
	GLOB.weighted_minerals_rich[MATERIAL_ICES_CARBON_DIOXIDE] 	= 5
	GLOB.weighted_minerals_rich[MATERIAL_ICES_HYDROGEN] 		= 5
	GLOB.weighted_minerals_rich[MATERIAL_ICES_METHANE] 			= 5
	GLOB.weighted_minerals_rich[MATERIAL_ICES_NITROGEN] 		= 5
	GLOB.weighted_minerals_rich[MATERIAL_ICES_SULFUR_DIOXIDE] 	= 5
	GLOB.weighted_minerals_rich[MATERIAL_ICES_WATER] 			= 1
	return TRUE