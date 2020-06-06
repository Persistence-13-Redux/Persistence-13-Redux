/datum/degradation_effect
	var/decay_factor = 1.0 //Wear damage is multiplied by this value before being applied
	var/decay_threshold = 1.0 //Wear damage below this value will be ignored
	
	var/decay_temp = 0 //The item will degrade when its temperature is above this value
	var/decay_temp_rate = 0 //The rate at which the item will degrade when the temperature is above the threshold

	var/wear_overlay
	var/wear_overlay_blending

	var/breaks_down //whether the decay can actually get the object under 0 health and destroy it. Otherwise won't go under 1
	var/decay_delay //time in ticks when to apply some decay on the object
	var/decay_while_stored //Doesn't decay if inside something
	var/decay_when_stomped //Decays a bit when a mob steps on it, mainly for trash
	var/decay_when_wet //Decays a when exposed to fluids


/datum/degradation_effect/food_items
	decay_factor = 1.0
	decay_threshold = 0
	breaks_down = TRUE
	decay_when_stomped = TRUE
	decay_while_stored = TRUE
	decay_when_wet = TRUE

/datum/degradation_effect/flimsy_junk
	decay_factor = 0.8
	decay_threshold = 0
	breaks_down = TRUE
	decay_when_stomped = TRUE
	decay_while_stored = FALSE
	decay_when_wet = TRUE

/datum/degradation_effect/everyday_items
	decay_factor = 0.5
	decay_threshold = 0.1
	breaks_down = FALSE
	decay_when_stomped = TRUE
	decay_while_stored = FALSE
	decay_when_wet = TRUE

/datum/degradation_effect/rugged_items
	decay_factor = 0.5
	decay_threshold = 0.5
	breaks_down = FALSE
	decay_when_stomped = TRUE
	decay_while_stored = FALSE
	decay_when_wet = FALSE

/datum/degradation_effect/armored_item
	decay_factor = 0.25
	decay_threshold = 1.0
	breaks_down = FALSE
	decay_when_stomped = FALSE
	decay_while_stored = FALSE
	decay_when_wet = FALSE


/obj
	var/datum/degradation_effect/wear	//Contains info on how the wear affects the object
	var/wear_damage = 0 				//used for calculating the wear overlay intensity
	var/time_last_decay = 0 			//Keep track of the last time recurring wear was applied to this object

//Damage some things when stepping on them
/obj/Crossed(var/atom/movable/O)
	. = ..()
	if(wear && wear.decay_when_stomped && ismob(O))
		wear_down(O.get_mass()/2)

//Apply some wear on some actions
/obj/proc/wear_down(var/intensity = 1)
	// if(!wear)
	// 	return
	// var/decay_damage = wear.wear_factor * intensity
	// //If we don't want wear to destroy the item, we don't decay anymore
	// if((health - decay_damage < 1) && !wear.breaks_down)
	// 	set_health(1, DAM_WEAR)
	// 	return
	// rem_health(wear.wear_factor * intensity, DAM_WEAR)

// //update wear when wear damage is applied
// /obj/set_health(newhealth, dtype)
// 	var/hbef = health
// 	. = ..()
// 	if(ISDAMTYPE(dtype, DAM_WEAR))
// 		wear_damage = between(0, wear_damage + (hbef - newhealth), max_health)
// 		if(wear && wear.wear_overlay) //if we have a wear overlay, update it
// 			update_icon()

