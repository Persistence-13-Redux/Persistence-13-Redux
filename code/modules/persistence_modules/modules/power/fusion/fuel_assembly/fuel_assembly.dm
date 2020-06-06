/obj/item/weapon/fuel_assembly/New(var/newloc, var/_material, var/_colour)
	..()
	ADD_SAVED_VAR(material_name)
	ADD_SAVED_VAR(percent_depleted)
	ADD_SAVED_VAR(rod_quantities)
	ADD_SAVED_VAR(fuel_type)
	ADD_SAVED_VAR(fuel_colour)
	ADD_SAVED_VAR(radioactivity)

/obj/item/weapon/fuel_assembly/Initialize()
	var/old_fuel_type = fuel_type
	var/old_fuel_colour = fuel_colour
	var/old_initial_amount = initial_amount
	var/old_name = name
	var/old_desc = desc
	var/old_radioactivity = radioactivity
	. = ..()
	if(map_storage_loaded)
		rod_quantities.Cut()
		fuel_type = old_fuel_type
		fuel_colour = old_fuel_colour
		initial_amount = old_initial_amount
		SetName(old_name)
		desc = old_desc
		radioactivity = old_radioactivity
		
		icon_state = "blank"
		var/image/I = image(icon, "fuel_assembly")
		I.color = fuel_colour
		overlays += list(I, image(icon, "fuel_assembly_bracket"))
		rod_quantities[fuel_type] = initial_amount
