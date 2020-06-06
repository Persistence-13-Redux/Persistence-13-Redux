#define CONFIG_TYPE_CONFIG "config"
#define CONFIG_TYPE_GAME_OPTION "game_options"
// #define DEFINE_CONFIGURATION_ENTRY(NAME, TYPE, DEFAULT, CONFIGTYPE, CODE) /datum/configuration/var/##TYPE##NAME = DEFAULT;\ 
// /datum/configuration/load_value(list/lines, t, pos, name, value, type){\
// 	if(type == CONFIGTYPE && name == NAME){ CODE }\
// 	.=..();}

// DEFINE_CONFIGURATION_ENTRY(autosave_initial, , 3 HOUR, CONFIG_TYPE_CONFIG, config.autosave_initial = text2num(value))
// DEFINE_CONFIGURATION_ENTRY(autosave_interval, , 3 HOUR, CONFIG_TYPE_CONFIG, config.autosave_interval = text2num(value))
// DEFINE_CONFIGURATION_ENTRY(discordurl, , NULL, CONFIG_TYPE_CONFIG, config.discordurl = value)
// DEFINE_CONFIGURATION_ENTRY(donationsurl, , NULL, CONFIG_TYPE_CONFIG, config.donationsurl = value)
// DEFINE_CONFIGURATION_ENTRY(year_skip, , 420, CONFIG_TYPE_CONFIG, config.year_skip = text2num(value))
// DEFINE_CONFIGURATION_ENTRY(time_zone, , -5, CONFIG_TYPE_CONFIG, config.time_zone = text2num(value))
// DEFINE_CONFIGURATION_ENTRY(addiction, , TRUE, CONFIG_TYPE_CONFIG, config.addiction = text2num(value))

/datum/configuration
	var/autosave_initial =  3 HOUR	//Length of time before the first autoSave
	var/autosave_interval = 3 HOUR  //Length of time before next sequential autosave
	var/discordurl
	var/donationsurl
	var/year_skip = 420 // How many years we are in the future IC. A multiple of 28 (e.g. 392 or 420) will always give you a calendar that exactly matches the current year.
	var/time_zone = -5 // The IC time-zone in relation to GMT. EST by default.
	var/addiction = TRUE //Whether addiction and withdrawal effects will tick. Toggling this off will NOT remove already present addictions, but will prevent them from having any effect.

	var/cloning_cost = 1000 //The cost of cloning a person. If set to 0, the entirety of the payment/contract process is skipped
	var/cloning_biomass_cost = 1000 //The amount of biomass required to do a cloning

	var/persistent_mode = TRUE

/datum/configuration/proc/load_value(var/list/lines, var/t, var/pos, var/name, var/value, var/type = "config")
	if(type == "config")
		switch(name)
			if("autosave_initial")
				config.autosave_initial = text2num(value)
			if("autosave_interval")
				config.autosave_interval = text2num(value)
			if("discordurl")
				config.discordurl = value
			if("donationsurl")
				config.donationsurl = value
			if("year_skip")
				config.year_skip = text2num(value)
			if("time_zone")
				config.time_zone = text2num(value)
			if("addiction")
				config.addiction = text2num(value)
			if("cloning_cost")
				config.cloning_cost = text2num(value)
			if("cloning_biomass_cost")
				config.cloning_biomass_cost = text2num(value)
			if ("donationsurl")
				config.donationsurl = value
			if ("discordurl")
				config.discordurl = value
			if("year_skip")
				config.year_skip = text2num(value)
			if("time_zone")
				config.time_zone = text2num(value)
			if("persistent_mode")
				config.persistent_mode = text2num(value)

//Add handling for the new configs
/datum/configuration/load(filename, type = "config") //the type can also be game_options, in which case it uses a different switch. not making it separate to not copypaste code - Urist
	var/list/Lines = file2list(filename)

	for(var/t in Lines)
		if(!t)	continue

		t = trim(t)
		if (length(t) == 0)
			continue
		else if (copytext(t, 1, 2) == "#")
			continue

		var/pos = findtext(t, " ")
		var/name = null
		var/value = null

		if (pos)
			name = lowertext(copytext(t, 1, pos))
			value = copytext(t, pos + 1)
		else
			name = lowertext(t)

		if (!name)
			continue

		load_value(Lines, t, pos, name, value, type)
	
	. = ..()
