//#TODO: Armor values

//Icon paths for the suits
#define SOFTSUIT_ITEM_HEAD_PATH 'code/modules/persistence_modules/icons/obj/clothing/head/softsuits.dmi'
#define SOFTSUIT_ITEM_SUIT_PATH 'code/modules/persistence_modules/icons/obj/clothing/suit/softsuits.dmi'
#define SOFTSUIT_ONMOB_HEAD_PATH 'code/modules/persistence_modules/icons/mob/onmob/head/softsuits.dmi'
#define SOFTSUIT_ONMOB_SUIT_PATH 'code/modules/persistence_modules/icons/mob/onmob/suit/softsuits.dmi'

//Base softsuits
/obj/item/clothing/head/helmet/space/softsuit
	icon = SOFTSUIT_ITEM_HEAD_PATH
	icon_state = "civ_softhelm"
	item_icons = list(
		slot_head_str = SOFTSUIT_ONMOB_HEAD_PATH,
		)

/obj/item/clothing/suit/space/softsuit
	icon = SOFTSUIT_ITEM_SUIT_PATH
	item_icons = list(
		slot_wear_suit_str = SOFTSUIT_ONMOB_SUIT_PATH,
		)
	icon_state = "civ_softsuit"
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)

//Definitions
/obj/item/clothing/head/helmet/space/softsuit/civilian
	name = "EVA softsuit helmet"
	icon_state = "civ_softhelm"
	desc = "A flimsy helmet designed for work in a hazardous, low-pressure environment."
	permeability_coefficient = 0

/obj/item/clothing/suit/space/softsuit/civilian
	name = "EVA softsuit"
	desc = "Your average general use softsuit. Though lacking in protection that modern voidsuits give, its cheap cost and portable size makes it perfect for those still getting used to life on the frontier."
	icon_state = "civ_softsuit"
	item_state_slots = list(
		slot_l_hand_str = "s_suit",
		slot_r_hand_str = "s_suit",
	)


//Engineering softsuit
/obj/item/clothing/head/helmet/space/softsuit/engineering
	name = "engineering softsuit helmet"
	icon_state = "eng_softhelm"
	desc = "A flimsy helmet with basic radiation shielding. Its visor protects the user from bright UV lights."
	item_state_slots = list(
		slot_l_hand_str = "eng_helm",
		slot_r_hand_str = "eng_helm",
		)


/obj/item/clothing/suit/space/softsuit/engineering
	name = "engineering softsuit"
	icon_state = "eng_softsuit"
	desc = "A general use softsuit. The cloth fibers on this suit can protect the user from minor amounts of radiation."
	item_state_slots = list(
		slot_l_hand_str = "eng_voidsuit",
		slot_r_hand_str = "eng_voidsuit",
	)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank/emergency,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/toolbox,/obj/item/weapon/storage/briefcase/inflatable,/obj/item/device/t_scanner)

//Security softsuit
/obj/item/clothing/head/helmet/space/softsuit/security
	name = "security softsuit helmet"
	icon_state = "sec_softhelm"
	desc = "A flimsy helmet equipped with heat-resistent fabric."
	item_state_slots = list(
		slot_l_hand_str = "sec_helm",
		slot_r_hand_str = "sec_helm",
		)
	siemens_coefficient = 0.8 //barely stronger than average softsuits, slightly weaker than sec voidsuits


/obj/item/clothing/suit/space/softsuit/security
	name = "security softsuit"
	icon_state = "sec_softsuit"
	desc = "A general use softsuit equipped with heat-resistent fabric."
	item_state_slots = list(
		slot_l_hand_str = "sec_voidsuit",
		slot_r_hand_str = "sec_voidsuit",
	)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank/emergency,/obj/item/device/suit_cooling_unit,/obj/item/weapon/melee/baton) //maybe allow small weapons to fit in the suit slot
	siemens_coefficient = 0.8 //barely stronger than average softsuits, slightly weaker than sec voidsuits


//Medical softsuit
/obj/item/clothing/head/helmet/space/softsuit/medical
	name = "medical softsuit helmet"
	icon_state = "med_softhelm"
	desc = "A flimsy helmet that protects the user just enough to be considered spaceworthy."
	item_state_slots = list(
		slot_l_hand_str = "medical_helm",
		slot_r_hand_str = "medical_helm",
		)


/obj/item/clothing/suit/space/softsuit/medical
	name = "medical softsuit"
	icon_state = "med_softsuit"
	desc = "A general use softsuit that sacrafices some (presumably) non-essential systems in turn for enhanced mobility."
	item_state_slots = list(
		slot_l_hand_str = "medical_voidsuit",
		slot_r_hand_str = "medical_voidsuit",
	)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank/emergency,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/firstaid,/obj/item/device/scanner/health,/obj/item/stack/medical)


/obj/item/clothing/suit/space/softsuit/void/medical/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 0.5

//Mining softsuit
/obj/item/clothing/head/helmet/space/softsuit/mining
	name = "mining softsuit helmet"
	icon_state = "miner_softhelm"
	desc = "A flimsy helmet with extra thick fabric, you still aren't sure if it'll be enough to protect you."
	item_state_slots = list(
		slot_l_hand_str = "mining_helm",
		slot_r_hand_str = "mining_helm",
		)


/obj/item/clothing/suit/space/softsuit/mining
	name = "mining softsuit"
	icon_state = "miner_softsuit"
	desc = "A general use softsuit with extra thick fabric. Something tells you its not thick enough."
	item_state_slots = list(
		slot_l_hand_str = "mining_voidsuit",
		slot_r_hand_str = "mining_voidsuit",
	)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank/emergency,/obj/item/stack/flag,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/ore,/obj/item/weapon/pickaxe)


//Science softsuit, we don't have xenoarch but that's the only thing i can base its stats off of
/obj/item/clothing/head/helmet/space/softsuit/science
	name = "scientist softsuit helmet"
	icon_state = "sci_softhelm"
	desc = "A flimsy helmet that provides basic protection from radiation."


/obj/item/clothing/suit/space/softsuit/science
	name = "scientist softsuit"
	icon_state = "sci_softsuit"
	desc = "A general use softsuit retrofitted with basic radiation shielding."

	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank/emergency,/obj/item/device/suit_cooling_unit,/obj/item/stack/flag,/obj/item/weapon/storage/excavation,/obj/item/weapon/pickaxe,/obj/item/device/scanner/health,/obj/item/device/measuring_tape,/obj/item/device/ano_scanner,/obj/item/device/depth_scanner,/obj/item/device/core_sampler,/obj/item/device/gps,/obj/item/weapon/pinpointer/radio,/obj/item/device/radio/beacon,/obj/item/weapon/pickaxe/xeno/hand,/obj/item/weapon/storage/bag/fossils)

//Emergency softsuit
/obj/item/clothing/head/helmet/space/softsuit/emergency/alt
	name = "emergency softsuit"
	icon_state = "crisis_softhelm"
	desc = "A simple helmet with a built in light, smells like mothballs."
	flash_protection = FLASH_PROTECTION_NONE

/obj/item/clothing/suit/space/softsuit/emergency/alt
	name = "emergency softsuit"
	icon_state = "crisis_softsuit"
	desc = "A thin, ungainly softsuit colored in blaze orange for rescuers to easily locate, looks pretty fragile."

	allowed = list(/obj/item/weapon/tank/emergency)

/obj/item/clothing/suit/space/softsuit/emergency/alt/New()
	..()
	slowdown_per_slot[slot_wear_suit] = 4

#undef SOFTSUIT_ITEM_HEAD_PATH
#undef SOFTSUIT_ITEM_SUIT_PATH
#undef SOFTSUIT_ONMOB_HEAD_PATH
#undef SOFTSUIT_ONMOB_SUIT_PATH