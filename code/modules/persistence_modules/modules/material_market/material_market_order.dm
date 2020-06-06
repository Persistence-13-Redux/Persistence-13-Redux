/datum/material_order
	var/faction_uid
	var/price = 0
	var/volume = 0
	var/filled = 0
	var/admin_order = 0 // if this order is non-factional and should spawn materials.

/datum/material_order/proc/get_remaining_volume()
	return (volume - filled)

/datum/material_order/proc/get_total_value()
	var/left = volume - filled
	return (price * left)