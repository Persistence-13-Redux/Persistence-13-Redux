/datum/sprite_accessory/facial_hair/shaved/New()
	species_allowed += SPECIES_RESOMI
	. = ..()

/obj/item/weapon/card/id
	sprite_sheets = list(SPECIES_RESOMI = 'icons/mob/species/resomi/id.dmi')

/obj/item/weapon/handcuffs
	sprite_sheets = list(SPECIES_RESOMI = 'icons/mob/species/resomi/handcuffs.dmi')

/obj/item/weapon/storage/backpack
	sprite_sheets = list(SPECIES_RESOMI = 'icons/mob/species/resomi/back.dmi')

/obj/item/weapon/storage/belt
	sprite_sheets = list(SPECIES_RESOMI = 'icons/mob/species/resomi/belt.dmi')

/obj/item/clothing/ears
	sprite_sheets = list(SPECIES_RESOMI = 'icons/mob/species/resomi/ears.dmi')

/obj/item/clothing/gloves/New()
	species_restricted += SPECIES_RESOMI
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/gloves.dmi'
	..()

/obj/item/clothing/glasses/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/eyes.dmi'
	..()
	
/obj/item/clothing/head/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/head.dmi'
	..()

/obj/item/clothing/mask/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/masks.dmi'
	..()

/obj/item/clothing/shoes/New()
	species_restricted += SPECIES_RESOMI
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/shoes.dmi'
	..()

/obj/item/clothing/suit/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/suit.dmi'
	..()

/obj/item/clothing/under/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/uniform.dmi'
	..()

/obj/item/weapon/tank/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/back.dmi'
	..()

/obj/item/clothing/head/collectable/petehat/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/head.dmi'
	..()

/obj/item/clothing/head/helmet/space/rig/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/head.dmi'
	..()
/obj/item/clothing/suit/space/rig/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/suit.dmi'
	..()

/obj/item/clothing/head/helmet/space/void/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/head.dmi' //Drax is lazy and they were already all packed in here. Yell at him if this is unacceptable
	sprite_sheets_obj[SPECIES_RESOMI] = 'icons/obj/clothing/species/resomi/hats.dmi'
	..()
/obj/item/clothing/suit/space/void/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/suit.dmi' //Drax is lazy and they were already all packed in here. Yell at him if this is unacceptable
	sprite_sheets_obj[SPECIES_RESOMI] = 'icons/obj/clothing/species/resomi/suits.dmi'
	..()
	
/obj/item/clothing/accessory/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/ties.dmi'
	..()
	
/obj/item/device/radio/headset
	sprite_sheets = list(SPECIES_RESOMI = 'icons/mob/species/resomi/ears.dmi')
