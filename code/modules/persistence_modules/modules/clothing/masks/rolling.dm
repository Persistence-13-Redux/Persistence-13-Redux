/////////// //Ported Straight from TG. I am not sorry. - BloodyMan
//ROLLING//
///////////
/obj/item/paper/cig
	name = "rolling paper"
	desc = "A thin piece of paper used to make smokeables."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cig_paper"
	w_class = ITEM_SIZE_TINY

/obj/item/paper/cig/fancy
	name = "\improper Trident rolling paper"
	desc = "A thin piece of trident branded paper used to make fine smokeables."
	icon_state = "cig_paperf"

/obj/item/paper/cig/filter
	name = "cigarette filter"
	desc = "A small nub like filter for cigarettes."
	icon_state = "cig_filter"
	w_class = ITEM_SIZE_TINY

//tobacco sold seperately if you're too snobby to grow it yourself.
/obj/item/weapon/reagent_containers/terrbacco
	name = "tobacco"
	desc = "A wad of carefully cured and dried tobacco. Ground into a mess."
	icon = 'icons/obj/clothing/obj_mask.dmi'
	icon_state = "chew"
	w_class = ITEM_SIZE_TINY
	volume = 15
	var/dry = 1
	var/list/filling = list(/datum/reagent/tobacco = 5)

/obj/item/weapon/reagent_containers/terrbacco/New()
	..()
	ADD_SAVED_VAR(dry)

/obj/item/weapon/reagent_containers/terrbacco/Initialize()
	. = ..()
	if(!map_storage_loaded)
		for(var/R in filling)
			reagents.add_reagent(R, filling[R])

/obj/item/weapon/reagent_containers/terrbacco/bad
	desc = "A wad of carefully cured and dried tobacco. Ground into a coarse mess."
	filling = list(/datum/reagent/tobacco/bad = 5)

/obj/item/weapon/reagent_containers/terrbacco/fine
	desc = "A wad of carefully cured and dried tobacco. Ground into a fine mess."
	filling = list(/datum/reagent/tobacco/fine = 5)

//cig paper interaction ported straight from TG with some adjustments for our derelict code
/obj/item/paper/cig/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/item/weapon/reagent_containers/food/snacks/grown))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/G = target
		if(G.dry)
			var/obj/item/clothing/mask/smokable/cigarette/rolled/R = new(user.loc)
			R.chem_volume = target.reagents.total_volume
			target.reagents.trans_to_holder(R.reagents, R.chem_volume)
			qdel(target)
			qdel(src)
			user.put_in_active_hand(R)
			to_chat(user, "<span class='notice'>You roll the [target.name] into a rolling paper.</span>")
			R.desc = "A [target.name] rolled up in a thin piece of paper."
		else
			to_chat(user, "<span class='warning'>You need to dry this first!</span>")
	else
		..()

//and if you are a savage you can just use a sheet of ordinary paper.
/obj/item/weapon/paper/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/item/weapon/reagent_containers/food/snacks/grown))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/G = target
		if(G.dry)
			var/obj/item/clothing/mask/smokable/cigarette/rolled/R = new(user.loc)
			R.chem_volume = target.reagents.total_volume
			target.reagents.trans_to_holder(R.reagents, R.chem_volume)
			qdel(target)
			qdel(src)
			user.put_in_active_hand(R)
			to_chat(user, "<span class='notice'>You roll the [target.name] into a regular sheet of paper. How bold.</span>")
			R.desc = "A [target.name] rolled up in a piece of office paper. How bold."
		else
			to_chat(user, "<span class='warning'>You need to dry this first!</span>")
	else
		..()

//and finally a use for those magic scrolls that are left over from wizard antags.
/obj/item/weapon/teleportation_scroll/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/item/weapon/reagent_containers/food/snacks/grown))
		var/obj/item/weapon/reagent_containers/food/snacks/grown/G = target
		if(G.dry)
			var/obj/item/clothing/mask/smokable/cigarette/rolled/R = new(user.loc)
			R.chem_volume = target.reagents.total_volume
			target.reagents.trans_to_holder(R.reagents, R.chem_volume)
			qdel(target)
			qdel(src)
			user.put_in_active_hand(R)
			to_chat(user, "<span class='notice'>You roll the [target.name] into the wizard's teleportation scroll. Not like he'll be needing it anymore.</span>")
			R.desc = "A [target.name] rolled up in a piece of arcane parchment. Magical!"
		else
			to_chat(user, "<span class='warning'>You need to dry this first!</span>")
	else
		..()

//Repeating this for tobacco-wad objects
/obj/item/paper/cig/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/item/weapon/reagent_containers/terrbacco))
		var/obj/item/weapon/reagent_containers/terrbacco/Z = target
		if(Z.dry)
			var/obj/item/clothing/mask/smokable/cigarette/rolled/R = new(user.loc)
			R.chem_volume = target.reagents.total_volume
			target.reagents.trans_to_holder(R.reagents, R.chem_volume)
			qdel(target)
			qdel(src)
			user.put_in_active_hand(R)
			to_chat(user, "<span class='notice'>You roll the [target.name] into a rolling paper.</span>")
			R.desc = "A [target.name] rolled up in a thin piece of paper."
		else
			to_chat(user, "<span class='warning'>You need to dry this first!</span>")
	else
		..()

/obj/item/weapon/paper/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/item/weapon/reagent_containers/terrbacco))
		var/obj/item/weapon/reagent_containers/terrbacco/Z = target
		if(Z.dry)
			var/obj/item/clothing/mask/smokable/cigarette/rolled/R = new(user.loc)
			R.chem_volume = target.reagents.total_volume
			target.reagents.trans_to_holder(R.reagents, R.chem_volume)
			qdel(target)
			qdel(src)
			user.put_in_active_hand(R)
			to_chat(user, "<span class='notice'>You roll the [target.name] into a regular sheet of paper. How bold.</span>")
			R.desc = "A [target.name] rolled up in a piece of office paper. How bold."
		else
			to_chat(user, "<span class='warning'>You need to dry this first!</span>")
	else
		..()

/obj/item/weapon/teleportation_scroll/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/item/weapon/reagent_containers/terrbacco))
		var/obj/item/weapon/reagent_containers/terrbacco/Z = target
		if(Z.dry)
			var/obj/item/clothing/mask/smokable/cigarette/rolled/R = new(user.loc)
			R.chem_volume = target.reagents.total_volume
			target.reagents.trans_to_holder(R.reagents, R.chem_volume)
			qdel(target)
			qdel(src)
			user.put_in_active_hand(R)
			to_chat(user, "<span class='notice'>You roll the [target.name] into the wizard's teleportation scroll. Not like he'll be needing it anymore.</span>")
			R.desc = "A [target.name] rolled up in a piece of arcane parchment. Magical!"
		else
			to_chat(user, "<span class='warning'>You need to dry this first!</span>")
	else
		..()

//crafting a filter into the existing rollie
/obj/item/paper/cig/filter/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return
	if(istype(target, /obj/item/clothing/mask/smokable/cigarette/rolled))
		var/obj/item/clothing/mask/smokable/cigarette/rolled/filtered/R = new(user.loc)
		R.chem_volume = target.reagents.total_volume
		target.reagents.trans_to_holder(R.reagents, R.chem_volume)
		qdel(target)
		qdel(src)
		user.put_in_active_hand(R)
		to_chat(user, "<span class='notice'>You roll the filter into the rolled cigarette.</span>")
		R.desc = "A [target.name] with a filter."
	else
		..()

// Rollies.

/obj/item/clothing/mask/smokable/cigarette/rolled
	name = "rolled cigarette"
	desc = "A hand rolled cigarette using dried plant matter."
	icon_state = "cigroll"
	item_state = "cigoff"
	type_butt = /obj/item/trash/cigbutt/rollbutt
	chem_volume = 50
	brand = "handrolled"
	filling = list()

/obj/item/clothing/mask/smokable/cigarette/rolled/office
	brand = "handrolled from regular office paper. How bold."

/obj/item/clothing/mask/smokable/cigarette/rolled/arcane
	brand = "handrolled from a magic scroll"


/obj/item/clothing/mask/smokable/cigarette/rolled/filtered
	name = "filtered rolled cigarette"
	desc = "A hand rolled cigarette using dried plant matter. Capped off one end with a filter."
	icon_state = "cigoff"
	brand = "handrolled with a filter"

/obj/item/trash/cigbutt/rollbutt
	name = "cigarette butt"
	desc = "A cigarette butt."
	icon_state = "rollbutt"
