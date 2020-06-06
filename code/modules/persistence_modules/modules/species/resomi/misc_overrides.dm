/obj/item/weapon/holder/New()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/head.dmi'
	. = ..()

/mob/living/carbon/human/resomi/New(var/new_loc)
	h_style = "Resomi Plumage"
	..(new_loc, SPECIES_RESOMI)

/obj/item/modular_computer/pda/New()
	. = ..()
	sprite_sheets[SPECIES_RESOMI] = 'icons/mob/species/resomi/id.dmi'

