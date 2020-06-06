//Refreshes the icon and sets the luminosity
/obj/machinery/portable_atmospherics/hydroponics/on_update_icon()
	. = ..()
	if(mechanical)
		if(seed && closed_system)
			set_light(tray_light / 10.0, tray_light / 2.0, 10, 1.2, COLOR_RESEARCH)
		else
			set_light(0)
	else
		// Update bioluminescence. //Should do this a better way imo
		if(seed && seed.get_trait(TRAIT_BIOLUM))
			set_light(0.5, 0.1, 3, l_color = seed.get_trait(TRAIT_BIOLUM_COLOUR))
		else
			set_light(0)

