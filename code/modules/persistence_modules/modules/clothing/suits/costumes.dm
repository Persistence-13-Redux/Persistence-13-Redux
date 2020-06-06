/obj/item/clothing/suit/skeleton
	name = "skeleton costume"
	desc = "A body-tight costume with the human skeleton lined out on it."
	icon_state = "skelecost"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS|FEET|HANDS|EYES|HEAD|FACE
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDEGLOVES
	item_state_slots = list(slot_r_hand_str = "judge", slot_l_hand_str = "judge")

/obj/item/clothing/suit/engicost
	name = "sexy engineering voidsuit costume"
	desc = "It's supposed to look like an engineering voidsuit... It doesn't look like it could protect from much radiation."
	icon_state = "engicost"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|FEET
	flags_inv = HIDEJUMPSUIT|HIDESHOES
	item_state_slots = list(slot_r_hand_str = "eng_voidsuit", slot_l_hand_str = "eng_voidsuit")

/obj/item/clothing/suit/maxman
	name = "doctor maxman costume"
	desc = "A costume made to look like Dr. Maxman, the famous male-enhancement salesman. Complete with red do-rag and sleeveless labcoat."
	icon_state = "maxman"
	body_parts_covered = LOWER_TORSO|FEET|LEGS|HEAD
	flags_inv = HIDEJUMPSUIT|HIDESHOES
	item_state_slots = list(slot_r_hand_str = "leather_jacket", slot_l_hand_str = "leather_jacket")

/obj/item/clothing/suit/iasexy
	name = "sexy internal affairs suit"
	desc = "Now where's your pen?~"
	icon_state = "iacost"
	body_parts_covered = UPPER_TORSO|FEET|LOWER_TORSO|EYES
	flags_inv = HIDEJUMPSUIT|HIDESHOES
	item_state_slots = list(slot_r_hand_str = "suit_black", slot_l_hand_str = "suit_black")

/obj/item/clothing/suit/sexyminer
	name = "sexy miner costume"
	desc = "For when you need to get your rocks off."
	icon_state = "sexyminer"
	body_parts_covered = FEET|LOWER_TORSO|HEAD
	flags_inv = HIDEJUMPSUIT|HIDESHOES
	item_state_slots = list(slot_r_hand_str = "miner", slot_l_hand_str = "miner")

/obj/item/clothing/suit/sumo
	name = "inflatable sumo wrestler costume"
	desc = "An inflated sumo wrestler costume. It's quite hot."
	icon_state = "sumo"
	body_parts_covered = FEET|LOWER_TORSO|UPPER_TORSO|LEGS|ARMS
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	item_state_slots = list(slot_r_hand_str = "classicponcho", slot_l_hand_str = "classicponcho")
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/suit/hackercost
	name = "classic hacker costume"
	desc = "You would feel insanely cool wearing this."
	icon_state = "hackercost"
	body_parts_covered = FEET|LOWER_TORSO|UPPER_TORSO|LEGS|ARMS|EYES
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	item_state_slots = list(slot_r_hand_str = "leather_coat", slot_l_hand_str = "leather_coat")

/obj/item/clothing/suit/lumber
	name = "sexy lumberjack costume"
	desc = "Smells of dusky pine. Includes chest hair and beard."
	icon_state = "sexylumber"
	body_parts_covered = FEET|LOWER_TORSO|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	item_state_slots = list(slot_r_hand_str = "red_labcoat", slot_l_hand_str = "red_labcoat")

/obj/item/clothing/suit/eccentricjudge
	name = "eccentric judge robe"
	desc = "For when you need to establish law and order, and on the side run a galactic empire."
	icon_state = "eccentricjudge"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS|FEET
	flags_inv = HIDEJUMPSUIT|HIDESHOES
	item_state_slots = list(slot_r_hand_str = "judge", slot_l_hand_str = "judge")

/obj/item/clothing/head/wizard/magus/fake
	siemens_coefficient = 1.0

/obj/item/clothing/suit/wizrobe/magusblue/fake
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor  = list()
	siemens_coefficient = 1.0

/obj/item/clothing/suit/wizrobe/magusred/fake
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor  = list()
	siemens_coefficient = 1.0

/obj/item/clothing/head/wizard/amp/fake
	siemens_coefficient = 1.0

/obj/item/clothing/suit/wizrobe/psypurple/fake
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor  = list()
	siemens_coefficient = 1.0

/obj/item/clothing/head/wizard/cap/fake
	siemens_coefficient = 1.0

/obj/item/clothing/suit/wizrobe/gentlecoat/fake
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor  = list()
	siemens_coefficient = 1.0

/obj/item/clothing/head/wizard/red/fake
	siemens_coefficient = 1.0

/obj/item/clothing/suit/wizrobe/red/fake
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor  = list()
	siemens_coefficient = 1.0

//Cosmetic wizard wear below
/obj/item/clothing/head/wizard/fake
	siemens_coefficient = 1.0

/obj/item/clothing/suit/wizrobe/old/fake
	name = "wizard robe"
	desc = "A rather dull, blue robe meant to mimick real wizard robes."
	icon_state = "wizard"
	item_state = "wizrobe"
	gas_transfer_coefficient = 1
	permeability_coefficient = 1
	armor  = list()
	siemens_coefficient = 1.0