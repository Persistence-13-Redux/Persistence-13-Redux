/obj/machinery/reagentgrinder/New()
	bag_whitelist += /obj/item/weapon/storage/plants
	bag_whitelist += /obj/item/weapon/storage/ore
	bag_whitelist += /obj/item/weapon/storage/bag/trash
	bag_whitelist += /obj/item/weapon/storage/bag/plasticbag
	bag_whitelist += /obj/item/weapon/storage/chewables
	bag_whitelist += /obj/item/weapon/storage/fancy/crayons
	bag_whitelist += /obj/item/weapon/storage/fancy/egg_box
	bag_whitelist += /obj/item/weapon/storage/fancy/crackers
	. = ..()
	ADD_SAVED_VAR(beaker)
	ADD_SAVED_VAR(holdingitems)
	ADD_SKIP_EMPTY(holdingitems)

/obj/machinery/reagentgrinder/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if (istype(O,/obj/item/weapon/reagent_containers/chem_disp_cartridge))
		if (beaker)
			return 1
		else
			if(!user.unEquip(O, src))
				return
			src.beaker =  O
			update_icon()
			src.updateUsrDialog()
			return 0

	if(istype(O,/obj/item/stack/material) || istype(O, /obj/item/stack/ore) || istype(O, /obj/item/stack/ore/ices))
		var/material/material
		if(istype(O, /obj/item/stack/ore))
			var/obj/item/stack/ore/stack = O
			material = stack.material
		else if(istype(O,/obj/item/stack/material))
			var/obj/item/stack/material/stack = O
			material = stack.material
		if(istype(O, /obj/item/stack/ore/ices))
			var/obj/item/stack/ore/ices/stack  = O
			material = stack.material
		if(!length(material.chem_products))
			to_chat(user, SPAN_NOTICE("\The [material.name] is unable to produce any usable reagents."))
			return 1
	return ..()

/obj/machinery/reagentgrinder/grind(mob/user)
	power_change()
	if(stat & (NOPOWER|BROKEN))
		return

	// Sanity check.
	if (!beaker || (beaker && beaker.reagents.total_volume >= beaker.reagents.maximum_volume))
		return

	attempt_skill_effect(user)
	playsound(src.loc, grind_sound, 75, 1)
	inuse = 1
	update_icon()

	// Reset the machine.
	spawn(60)
		inuse = 0
		interact(user)

	var/skill_factor = CLAMP01(1 + 0.3*(user.get_skill_value(skill_to_check) - SKILL_EXPERT)/(SKILL_EXPERT - SKILL_MIN))
	// Process.
	for (var/obj/item/O in holdingitems)

		var/remaining_volume = beaker.reagents.maximum_volume - beaker.reagents.total_volume
		if(remaining_volume <= 0)
			break

		if(istype(O, /obj/item/stack/material) || istype(O, /obj/item/stack/ore) || istype(O, /obj/item/stack/ore/ices))
			var/material/material
			var/obj/item/stack/ST = O

			if(istype(O, /obj/item/stack/material))
				var/obj/item/stack/material/stack = O
				material = stack.material
			if(istype(O, /obj/item/stack/ore))
				var/obj/item/stack/ore/stack = O
				material = stack.material
			if(istype(O, /obj/item/stack/ore/ices))
				var/obj/item/stack/ore/stack = O
				material = stack.material
			if(!material || (material && !LAZYLEN(material.chem_products) ) )
				break

			var/list/chem_products = material.chem_products
			var/sheet_volume = 0
			for(var/chem in chem_products)
				sheet_volume += chem_products[chem]

			var/amount_to_take = max(0,min(ST.amount,round(remaining_volume/sheet_volume)))
			if(amount_to_take)
				ST.use(amount_to_take)
				if(QDELETED(ST))
					holdingitems -= ST
				for(var/chem in chem_products)
					beaker.reagents.add_reagent(chem, (amount_to_take*chem_products[chem]*skill_factor))
				continue

		if(O.reagents)
			O.reagents.trans_to(beaker, O.reagents.total_volume, skill_factor)
			if(O.reagents.total_volume == 0)
				holdingitems -= O
				qdel(O)
			if (beaker.reagents.total_volume >= beaker.reagents.maximum_volume)
				break