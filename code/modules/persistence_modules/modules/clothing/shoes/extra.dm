
/obj/item/clothing/shoes/eod
	name = "bomb boots"
	desc = "A pair of boot reinforced to provide some explosion protection."
	icon_state = "swat"
	force = 2
	item_flags = ITEM_FLAG_NOSLIP
	siemens_coefficient = 0.6
	heat_protection = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	armor  = list(
		melee = ARMOR_MELEE_RESISTANT,
		bullet = ARMOR_BALLISTIC_MINOR,
		laser	= ARMOR_LASER_SMALL,
		energy = ARMOR_ENERGY_RESISTANT,
		bomb = ARMOR_BOMB_SHIELDED,
	)
