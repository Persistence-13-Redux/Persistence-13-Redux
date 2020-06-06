// //Override default ore noise
// /datum/random_map/noise/ore/apply_to_turf(var/x,var/y)

// 	var/tx = ((origin_x-1)+x)*chunk_size
// 	var/ty = ((origin_y-1)+y)*chunk_size

// 	for(var/i=0,i<chunk_size,i++)
// 		for(var/j=0,j<chunk_size,j++)
// 			var/turf/simulated/T = locate(tx+j, ty+i, origin_z)
// 			if(!istype(T) || !T.has_resources)
// 				continue
// 			if(!priority_process)
// 				CHECK_TICK
// 			T.resources = list()
// 			T.resources[MATERIAL_SAND] = rand(3,5)
// 			T.resources[MATERIAL_GRAPHITE] = rand(3,5)

// 			var/tmp_cell
// 			TRANSLATE_AND_VERIFY_COORD(x, y)

// 			if(tmp_cell < rare_val)      // Surface metals.
// 				T.resources[MATERIAL_HEMATITE] =			rand(RESOURCE_HIGH_MIN,	RESOURCE_HIGH_MAX)
// 				T.resources[MATERIAL_GRAPHITE] =			rand(RESOURCE_MID_MIN,  RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_CASSITERITE] =			rand(RESOURCE_MID_MIN,  RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_TETRAHEDRITE] =		rand(RESOURCE_MID_MIN,  RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_ROCK_SALT] =			rand(RESOURCE_LOW_MIN,	RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_PYRITE] =				rand(RESOURCE_LOW_MIN,	RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_CINNABAR] =			rand(RESOURCE_LOW_MIN,	RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_PHOSPHORITE] =			rand(RESOURCE_LOW_MIN,	RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_POTASH] =				rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_QUARTZ] =				rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_SPODUMENE] =			rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_FREIBERGITE] =			rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_BOHMEITE] =			0
// 				T.resources[MATERIAL_SPHALERITE] =			0
// 				T.resources[MATERIAL_BORON] =				0
// 				T.resources[MATERIAL_GALENA] =				0
// 				T.resources[MATERIAL_SILVER] =				0
// 				T.resources[MATERIAL_GOLD] =				0
// 				T.resources[MATERIAL_BAUXITE] =   			0
// 				T.resources[MATERIAL_PITCHBLENDE] =			0
// 				T.resources[MATERIAL_ILMENITE] = 			0
// 				T.resources[MATERIAL_DIAMOND] =  			0
// 				T.resources[MATERIAL_PHORON] =   			0
// 				T.resources[MATERIAL_PLATINUM] = 			0
// 				T.resources[MATERIAL_TUNGSTEN] = 			0
// 				T.resources[MATERIAL_HYDROGEN] = 			0
// 				T.resources[MATERIAL_BSPACE_CRYSTAL] = 		0
// 				T.resources[MATERIAL_TITANIUM] =			0
// 				T.resources[MATERIAL_DEUTERIUM] =			0
// 				T.resources[MATERIAL_TRITIUM] =				0
// 				T.resources[MATERIAL_ICES_ACETONE] =		0
// 				T.resources[MATERIAL_ICES_AMONIA] =			0
// 				T.resources[MATERIAL_ICES_CARBON_DIOXIDE] = 0
// 				T.resources[MATERIAL_ICES_HYDROGEN] = 		0
// 				T.resources[MATERIAL_ICES_METHANE] =		0
// 				T.resources[MATERIAL_ICES_NITROGEN] =		0
// 				T.resources[MATERIAL_ICES_SULFUR_DIOXIDE] = 0
// 				T.resources[MATERIAL_ICES_WATER] =			0
// 			else if(tmp_cell < deep_val) // Rare metals.
// 				T.resources[MATERIAL_HEMATITE] =			rand(RESOURCE_MID_MIN,	RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_GRAPHITE] =			rand(RESOURCE_MID_MIN,  RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_CASSITERITE] =			rand(RESOURCE_HIGH_MIN, RESOURCE_HIGH_MAX)
// 				T.resources[MATERIAL_TETRAHEDRITE] =		rand(RESOURCE_HIGH_MIN, RESOURCE_HIGH_MAX)
// 				T.resources[MATERIAL_ROCK_SALT] =			rand(RESOURCE_MID_MIN,	RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_PYRITE] =				rand(RESOURCE_MID_MIN,	RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_CINNABAR] =			rand(RESOURCE_MID_MIN,	RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_PHOSPHORITE] =			rand(RESOURCE_LOW_MIN,	RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_POTASH] =				rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_QUARTZ] =				rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_SPODUMENE] =			rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_FREIBERGITE] =			rand(RESOURCE_MID_MIN,  RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_BOHMEITE] =			0
// 				T.resources[MATERIAL_SPHALERITE] =			0
// 				T.resources[MATERIAL_GALENA] =				0
// 				T.resources[MATERIAL_SILVER] =				0
// 				T.resources[MATERIAL_GOLD] =				0
// 				T.resources[MATERIAL_BAUXITE] =   			0
// 				T.resources[MATERIAL_PITCHBLENDE] =			0
// 				T.resources[MATERIAL_ILMENITE] = 			0
// 				T.resources[MATERIAL_DIAMOND] =  			0
// 				T.resources[MATERIAL_PHORON] =   			0
// 				T.resources[MATERIAL_PLATINUM] = 			0
// 				T.resources[MATERIAL_TUNGSTEN] = 			0
// 				T.resources[MATERIAL_HYDROGEN] = 			0
// 				T.resources[MATERIAL_BSPACE_CRYSTAL] = 		0
// 				T.resources[MATERIAL_TITANIUM] =			0
// 				T.resources[MATERIAL_DEUTERIUM] =			0
// 				T.resources[MATERIAL_TRITIUM] =				0
// 				T.resources[MATERIAL_BORON] =				0
// 				T.resources[MATERIAL_ICES_ACETONE] =		0
// 				T.resources[MATERIAL_ICES_AMONIA] =			0
// 				T.resources[MATERIAL_ICES_CARBON_DIOXIDE] = 0
// 				T.resources[MATERIAL_ICES_HYDROGEN] = 		0
// 				T.resources[MATERIAL_ICES_METHANE] =		0
// 				T.resources[MATERIAL_ICES_NITROGEN] =		0
// 				T.resources[MATERIAL_ICES_SULFUR_DIOXIDE] = 0
// 				T.resources[MATERIAL_ICES_WATER] =			0
// 			else                             // Deep metals.
// 				T.resources[MATERIAL_HEMATITE] =			rand(RESOURCE_HIGH_MIN,	RESOURCE_HIGH_MAX)
// 				T.resources[MATERIAL_GRAPHITE] =			rand(RESOURCE_HIGH_MIN, RESOURCE_HIGH_MAX)
// 				T.resources[MATERIAL_CASSITERITE] =			rand(RESOURCE_MID_MIN,  RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_TETRAHEDRITE] =		rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_ROCK_SALT] =			rand(RESOURCE_LOW_MIN,	RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_PYRITE] =				rand(RESOURCE_LOW_MIN,	RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_CINNABAR] =			rand(RESOURCE_LOW_MIN,	RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_PHOSPHORITE] =			rand(RESOURCE_MID_MIN,	RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_POTASH] =				rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_QUARTZ] =				rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_SPODUMENE] =			rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_FREIBERGITE] =			rand(RESOURCE_MID_MIN,  RESOURCE_MID_MAX)
// 				T.resources[MATERIAL_SILVER] =				rand(RESOURCE_LOW_MIN,  RESOURCE_LOW_MAX)
// 				T.resources[MATERIAL_BOHMEITE] =			0
// 				T.resources[MATERIAL_SPHALERITE] =			0
// 				T.resources[MATERIAL_BORON] =				0
// 				T.resources[MATERIAL_GALENA] =				0
// 				T.resources[MATERIAL_GOLD] =				0
// 				T.resources[MATERIAL_BAUXITE] =   			0
// 				T.resources[MATERIAL_PITCHBLENDE] =			0
// 				T.resources[MATERIAL_ILMENITE] = 			0
// 				T.resources[MATERIAL_DIAMOND] =  			0
// 				T.resources[MATERIAL_PHORON] =   			0
// 				T.resources[MATERIAL_PLATINUM] = 			0
// 				T.resources[MATERIAL_TUNGSTEN] = 			0
// 				T.resources[MATERIAL_HYDROGEN] = 			0
// 				T.resources[MATERIAL_BSPACE_CRYSTAL] = 		0
// 				T.resources[MATERIAL_TITANIUM] =			0
// 				T.resources[MATERIAL_DEUTERIUM] =			0
// 				T.resources[MATERIAL_TRITIUM] =				0
// 				T.resources[MATERIAL_ICES_ACETONE] =		0
// 				T.resources[MATERIAL_ICES_AMONIA] =			0
// 				T.resources[MATERIAL_ICES_CARBON_DIOXIDE] = 0
// 				T.resources[MATERIAL_ICES_HYDROGEN] = 		0
// 				T.resources[MATERIAL_ICES_METHANE] =		0
// 				T.resources[MATERIAL_ICES_NITROGEN] =		0
// 				T.resources[MATERIAL_ICES_SULFUR_DIOXIDE] = 0
// 				T.resources[MATERIAL_ICES_WATER] =			0
