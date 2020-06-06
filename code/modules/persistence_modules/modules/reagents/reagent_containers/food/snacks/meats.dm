/obj/item/weapon/reagent_containers/food/snacks/meat/xenomeat
	name = "meat"
	desc = "A slab of green meat. Smells like acid."
	icon_state = "xenomeat"
	filling_color = "#43de18"
	center_of_mass = "x=16;y=10"
	bitesize = 6
/obj/item/weapon/reagent_containers/food/snacks/meat/xenomeat/New()
	. = ..()
	reagents.add_reagent(/datum/reagent/nutriment/protein, 6)
	reagents.add_reagent(/datum/reagent/acid/polyacid, 6)
	src.bitesize = 6

/obj/item/weapon/reagent_containers/food/snacks/meat/bearmeat
	name = "bear meat"
	desc = "A very manly slab of meat."
	icon_state = "bearmeat"
	filling_color = "#db0000"
	center_of_mass = "x=16;y=10"
	bitesize = 3
/obj/item/weapon/reagent_containers/food/snacks/meat/bearmeat/New()
	. = ..()
	reagents.add_reagent(/datum/reagent/nutriment/protein, 12)
	reagents.add_reagent(/datum/reagent/hyperzine, 5)
	src.bitesize = 3