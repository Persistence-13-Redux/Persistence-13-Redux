/material
	var/energy_combustion = 8    // MJ/kilo-unit Basically the heat energy given off for burning 1,000 units of said material(8 is given for generic trash on wikipedia)
	//var/stack_type = /obj/item/stack/material
	var/list/ore_matter = list() //material contained in the ore itself
	//Asteroid triggering
	var/asteroid_anger = 0 //amount of anger mining this material causes to the asteroid

//Returns the material content of the ore for this material if available
/material/proc/get_ore_matter()
	return ore_matter