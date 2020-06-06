//Add extra tools exceptions to the global
/hook/global_init/proc/add_virus2_surgery_tool()
	GLOB.surgery_tool_exceptions += /obj/item/device/antibody_scanner
	return 1