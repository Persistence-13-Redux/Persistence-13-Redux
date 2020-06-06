#if !defined(using_map_DATUM)

#define using_map_DATUM /datum/map/fringe

//Common strings
#define FRINGE_ORG_NAME "Fringe Worlds Association" //Name of the governmental body ruling over the systems
#define FRINGE_ORG_NAME_SHORT "FWA" //Name of the governmental body ruling over the systems
#define FRINGE_STATION_NAME "Canis Major Fringe Waystation"
#define FRINGE_STATION_NAME_SHORT "CMF Waystation"
#define FRINGE_STATION_NAME_ABBR "CMFW"

#include "fringe_define.dm"
#include "fringe_overmap.dm"
#include "fringe_lobby.dm"
#include "fringe_network_presets.dm"
#include "fringe_jobs.dm"
#include "fringe_elevators.dm"
#include "fringe_areas.dm"
#include "fringe_map_templates.dm"

//Load the empty map
#include "empty.dmm"
// #include "fringe_3.dmm"
// #include "fringe_2.dmm"
// #include "fringe_1.dmm"

#elif !defined(MAP_OVERRIDE)
	#warn A map has already been included, ignoring Torch
#endif