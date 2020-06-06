/obj/machinery/vending
	req_access_faction = list()
	mass  = 300 KILOGRAMS
	diona_spawn_chance = 0
	var/vermin_spawn_chance = 12 //%

	//Faction things
	var/locked = FALSE
	var/tmp/datum/money_account/vendor_account //reference on the money account where to put the accumulated money
	var/lacepay = TRUE //Whether lacepay(TM) is enabled. Basically automatically paying remotely via lace

	//Restocking
	var/list/allowed_products	//types that are accepted when refilling the machine!
	var/max_nb_products = 10 //At most 10 different products can be simultaneously inside
	var/max_single_product = 60 //At most of a single product can be inside
	var/max_size_class = ITEM_SIZE_TINY

/obj/machinery/vending/New()
	. = ..()
	wires = new(src)
	ADD_SAVED_VAR(name)
	ADD_SAVED_VAR(categories)
	ADD_SAVED_VAR(product_records)
	ADD_SAVED_VAR(ads_list)
	ADD_SAVED_VAR(slogan_list)
	ADD_SAVED_VAR(locked)
	ADD_SAVED_VAR(coin)
	ADD_SAVED_VAR(lacepay)
	ADD_SAVED_VAR(scan_id)
	ADD_SAVED_VAR(vend_reply)
	ADD_SAVED_VAR(shut_up)

	ADD_SKIP_EMPTY(slogan_list)
	ADD_SKIP_EMPTY(ads_list)
	ADD_SKIP_EMPTY(product_records)

/obj/machinery/vending/Initialize(mapload)
	. = ..()
	get_or_create_extension(src, /datum/extension/base_icon_state, icon_state)
	if(src.product_slogans)
		update_slogans()
	if(src.product_ads)
		update_ads()

	if(mapload)
		queue_icon_update()
	else
		update_icon()

/obj/machinery/vending/proc/update_slogans()
	if(product_slogans)
		slogan_list.Cut()
		slogan_list += splittext(product_slogans, ";")

		// So not all machines speak at the exact same time.
		// The first time this machine says something will be at slogantime + this random value,
		// so if slogantime is 10 minutes, it will say it at somewhere between 10 and 20 minutes after the machine is crated.
		last_slogan = world.time + rand(0, slogan_delay)

/obj/machinery/vending/build_inventory(populate_parts = FALSE)
	if(map_storage_loaded)
		return
	. = ..()

/obj/machinery/vending/proc/update_ads()
	if(product_ads)
		ads_list.Cut()
		ads_list += splittext(product_ads, ";")

/obj/machinery/vending/Destroy()
	vendor_account = null
	return ..()

/obj/machinery/vending/connect_faction()
	. = ..()
	if(. && faction)
		vendor_account = faction.central_account

/obj/machinery/vending/disconnect_faction()
	. = ..()
	if(.)
		vendor_account = null

/obj/machinery/vending/proc/handle_transactions(obj/item/weapon/W, mob/user)
	var/obj/item/weapon/card/id/I = W.GetIdCard()

	if (currently_vending && vendor_account && !vendor_account.suspended)
		var/paid = 0
		var/handled = 0

		if (I) //for IDs and PDAs and wallets with IDs
			paid = pay_with_card(I,W)
			handled = 1
		else if (istype(W, /obj/item/weapon/spacecash/ewallet))
			var/obj/item/weapon/spacecash/ewallet/C = W
			paid = pay_with_ewallet(C)
			handled = 1
		else if (istype(W, /obj/item/weapon/spacecash/bundle))
			var/obj/item/weapon/spacecash/bundle/C = W
			paid = pay_with_cash(C)
			handled = 1

		if(paid)
			src.vend(currently_vending, usr)
			return TRUE
		else if(handled)
			SSnano.update_uis(src)
			return TRUE// don't smack that machine with your 2 thalers

	if (I || istype(W, /obj/item/weapon/spacecash))
		attack_hand(user)
		return TRUE

	if(istype(W, /obj/item/weapon/material/coin) && premium.len > 0)
		if(!user.unEquip(W, src))
			return
		coin = W
		categories |= VENDINGM_CAT_COIN
		to_chat(user, "<span class='notice'>You insert \the [W] into \the [src].</span>")
		SSnano.update_uis(src)
		return TRUE
	return FALSE

/obj/machinery/vending/attackby(obj/item/weapon/W as obj, mob/user as mob)
	//Deconstruction
	if(isScrewdriver(W))
		if(!locked)
			to_chat(user, SPAN_WARNING("The maintenance panel is locked shut!"))	
			return TRUE	

	if((obj_flags & OBJ_FLAG_ANCHORABLE) && isWrench(W))
		if(!locked && wrench_floor_bolts(user, W))
			SSnano.update_uis(src)
			return TRUE
		else if(locked)
			to_chat(user, SPAN_WARNING("The floor bolts are covered!"))
			return TRUE

	if(isMultitool(W))
		if(src.panel_open)
			var/choice = input(user, "Do you really want to unlink \the [src] from [faction.name]?") in list("yes", "no")
			if(choice == "yes" && disconnect_faction())
				to_chat(user, SPAN_NOTICE("Faction disconnected!"))
				SSnano.update_uis(src)
			return TRUE
		else
			return FALSE //Handle multitool stuff in resolve attack
	
	//Faction linking
	if(!currently_vending && istype(W, /obj/item/weapon/card/id/))
		var/obj/item/weapon/card/id/I = W.GetIdCard()
		if(!faction_uid && I.get_faction_uid() && connect_faction(FindFaction(I.get_faction_uid()), user))
			to_chat(user, SPAN_NOTICE("\The [src] was linked to [faction.name], and will now deposit money to that account!"))
			SSnano.update_uis(src)
			return TRUE
		else if(!I.get_faction_uid())
			to_chat(user, SPAN_NOTICE("You don't have a faction selected on your ID card!"))
			return FALSE
		//Maintenance unlocking/locking
		if(faction_uid && check_access(I, faction))
			locked = !locked
			if(locked)
				panel_open = FALSE //Force the maintenance panel closed, because people are weird
			to_chat(user, SPAN_NOTICE("Maintenance access [locked? "locked" : "unlocked"]!"))
			SSnano.update_uis(src)
			update_icon()
			return TRUE
		else
			to_chat(user, SPAN_WARNING("Access denied!"))
			return FALSE

	//Transactions
	if(handle_transactions(W, user))
		return 

	//Stocking
	if(src.panel_open && istype(W)) 
		//If we get a bag that has stuff in it, just mass move it in
		if(istype(W, /obj/item/weapon/storage))
			var/obj/item/weapon/storage/bag = W
			for(var/obj/item/IT in bag)
				if(attempt_to_stock(IT, user))
					bag.remove_from_storage(IT, src, TRUE)
			bag.finish_bulk_removal()
		else
			attempt_to_stock(W, user)
		return FALSE
	return ..()

/obj/machinery/vending/MouseDrop_T(var/obj/item/I, var/mob/user)
	if(!CanMouseDrop(I, user) || (I.loc != user))
		return FALSE
	if(locked)
		to_chat(user, SPAN_WARNING("The maintenance panel is locked! You can't add anything to the machine."))
		return FALSE
	if(user)
		user.visible_message(SPAN_NOTICE("[user] inserts \the [I] in \the [src]."), SPAN_NOTICE("You insert \the [I] in \the [src]."))
	return attempt_to_stock(I, user)

//Whether this item can be added to the machine!
/obj/machinery/vending/proc/can_stock(var/obj/item/I)
	if(I.w_class > max_size_class)
		return FALSE
	var/datum/stored_items/vending_products/foundexisting = contains_product(I)
	if((!foundexisting && product_records.len < max_nb_products) || (foundexisting && foundexisting.get_amount() < max_single_product))
		return TRUE
	return FALSE

//Whether the machine already contains this product. Returns the entry if found!
/obj/machinery/vending/proc/contains_product(var/obj/item/I)
	for(var/datum/stored_items/vending_products/R in product_records)
		if(istype(I, R.item_path) && I.name == R.item_name)
			return R
	return FALSE

//Tries inserting the object into the product list
/obj/machinery/vending/attempt_to_stock(var/obj/item/I, var/mob/user)
	if(!can_stock(I))
		to_chat(user, SPAN_WARNING("\The [I] won't fit in \the [src]!"))
		return FALSE

	//if there wasn't an existing product
	var/datum/stored_items/vending_products/foundexisting = contains_product(I)
	//Add a new product to the list if we don't have that one already, and still got space
	if(!foundexisting && product_records.len < max_nb_products)
		var/datum/stored_items/vending_products/P = new(src, I.type, I.name)
		dd_insertObjectList(product_records, P)
		foundexisting = P
	return stock(I, foundexisting, user)

/obj/machinery/vending/proc/pay_with_lace(var/obj/item/organ/internal/stack/S)
	if(!currently_vending)
		return FALSE //Its possible it was cancelled
	if(!S)
		src.status_message = "Error: User has no neural lace!"
		src.status_error = 1
		return FALSE
	// if(!S.record)
	// 	//If no records, try to force load it..
	// 	//S.load_records()
	// 	if(!S.record)
	// 		src.status_message = "Error: User has no linked records!"
	// 		src.status_error = 1
	// 		return FALSE
	var/datum/money_account/customer_account = get_money_account_by_name(S.record.get_name())
	if (!customer_account)
		src.status_message = "Error: Unable to access account. Please contact technical support if problem persists."
		src.status_error = 1
		return FALSE
	
	if(customer_account.suspended)
		src.status_message = "Unable to access account: account suspended."
		src.status_error = 1
		return FALSE
	
	if(currently_vending.price > customer_account.get_balance())
		src.status_message = "Insufficient funds in account."
		src.status_error = 1
		return FALSE
	else
		customer_account.transfer(vendor_account, currently_vending.price, "Purchase of [currently_vending.item_name]")
		playsound(src, 'sound/items/timer.ogg', 20, TRUE)
		return TRUE

/**
 *  Display the NanoUI window for the vending machine.
 *
 *  See NanoUI documentation for details.
 */
/obj/machinery/vending/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	user.set_machine(src)

	var/list/data = list()
	if(currently_vending)
		data["mode"] = 1
		data["product"] = currently_vending.item_name
		data["price"] = currently_vending.price
		data["message_err"] = 0
		data["message"] = src.status_message
		data["message_err"] = src.status_error
	else
		data["mode"] = 0
		var/list/listed_products = list()

		for(var/key = 1 to src.product_records.len)
			var/datum/stored_items/vending_products/I = src.product_records[key]

			if(!(I.category & src.categories))
				continue

			listed_products.Add(list(list(
				"key" = key,
				"name" = I.item_name,
				"price" = I.price,
				"color" = I.display_color,
				"amount" = I.get_amount())))

		data["products"] = listed_products

	if(src.coin)
		data["coin"] = src.coin.name

	if(src.panel_open)
		data["panel"] = 1
		data["speaker"] = src.shut_up ? 0 : 1
	else
		data["panel"] = 0

	data["locked"] = src.locked
	data["faction_name"] = faction? faction.name : "NA"
	data["faction_UID"] = faction? faction.uid : "NA"
	data["max_single"] = max_single_product
	data["max_products"] = max_nb_products
	data["max_size"] = max_size_class
	data["can_change_icon"] = can_change_base_icon()

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "vending_machine.tmpl", src.name, 540, 600)
		ui.set_initial_data(data)
		ui.open()

/obj/machinery/vending/OnTopic(mob/user, href_list, datum/topic_state/state)
	if(href_list["remove_coin"] && !istype(user,/mob/living/silicon))
		if(!coin)
			to_chat(user, "There is no coin in this machine.")
			return TOPIC_HANDLED

		coin.forceMove(loc)
		if(!user.get_active_hand())
			user.put_in_hands(coin)
		to_chat(user, "<span class='notice'>You remove \the [coin] from \the [src]</span>")
		coin = null
		categories &= ~VENDINGM_CAT_COIN
		return TOPIC_HANDLED

	if(href_list["set_price"])
		var/key = text2num(href_list["set_price"])
		var/datum/stored_items/vending_products/R = product_records[key]
		var/newprice = text2num(input(user, "Set the product's price:", "", R.price) as num)
		if(newprice)
			R.price = newprice
		SSnano.update_uis(src)
		return TOPIC_REFRESH

	if(href_list["set_name"])
		var/key = text2num(href_list["set_name"])
		var/datum/stored_items/vending_products/R = product_records[key]
		var/new_name = sanitizeSafe(input(user, "Name the product:", "", R.item_name) as text)
		if(new_name)
			R.item_name = new_name
		SSnano.update_uis(src)
		return TOPIC_REFRESH

	if(href_list["flush_product"])
		var/key = text2num(href_list["flush_product"])
		var/datum/stored_items/vending_products/R = product_records[key]
		src.vend_ready = 0
		while(R.get_amount() > 0)
			R.get_product(get_turf(src))
		product_records.Remove(R) //remove the record
		SSnano.update_uis(src)
		src.vend_ready = 1
		return TOPIC_REFRESH

	if(href_list["edit_slogans"])
		var/new_slogans = sanitizeSafe(input(user, "Enter promotional slogans list (separated by semi-colons)", "Promotional Slogans", product_slogans) as text)
		if(new_slogans != product_slogans)
			product_slogans = new_slogans
			update_slogans()
		SSnano.update_uis(src)
		return TOPIC_REFRESH

	if(href_list["edit_ads"])
		var/new_ads = sanitizeSafe(input(user, "Enter promotional ads list (separated by semi-colons)", "Advertisement", product_ads) as text)
		if(new_ads != product_ads)
			product_ads = new_ads
			update_ads()
		SSnano.update_uis(src)
		return TOPIC_REFRESH
	
	if(href_list["edit_name"])
		var/new_name = sanitizeName(input(user, "Enter a new name for the machine", "Change name", name) as text)
		if(new_name)
			SetName(new_name)
		spawn(0)
			SSnano.update_uis(src)
		return TOPIC_REFRESH

	if ((usr.contents.Find(src) || (in_range(src, user) && istype(src.loc, /turf))))
		if ((href_list["vend"]) && (src.vend_ready) && (!currently_vending))
			if((!allowed(user)) && !emagged && scan_id)	//For SECURE VENDING MACHINES YEAH
				to_chat(user, "<span class='warning'>Access denied.</span>")//Unless emagged of course
				flick(icon_deny,src)
				return

			var/key = text2num(href_list["vend"])
			var/datum/stored_items/vending_products/R = product_records[key]

			// This should not happen unless the request from NanoUI was bad
			if(!(R.category & src.categories))
				return

			if(R.price <= 0)
				src.vend(R, usr)
			// else if(istype(usr,/mob/living/silicon)) //If the item is not free, provide feedback if a synth is trying to buy something.
			// 	to_chat(usr, "<span class='danger'>Artificial unit recognized.  Artificial units cannot complete this transaction.  Purchase canceled.</span>")
			// 	return
			// else
			var/mob/living/carbon/human/H = user
			var/obj/item/organ/internal/stack/ST
			if(istype(H))
				ST = H.get_stack()

			src.currently_vending = R
			if(!vendor_account || vendor_account.suspended)
				src.status_message = "This machine is currently unable to process payments due to problems with the associated account."
				src.status_error = 1
			else if(istype(ST)) //If we got a lace with a record and account, we can bypass payment!
				if(pay_with_lace(ST))
					src.status_message = "Payment processing using LacePay&trade;, the leading payment option in the frontier."
					src.status_error = 0
					src.vend(src.currently_vending, user)
			else
				status_message = "Please swipe a card or insert cash to pay for the item."
				status_error = 0
			return TOPIC_REFRESH

		else if (href_list["cancelpurchase"])
			src.currently_vending = null
			return TOPIC_REFRESH

		else if ((href_list["togglevoice"]) && (src.panel_open))
			src.shut_up = !src.shut_up
			return TOPIC_HANDLED

		SSnano.update_uis(src)

/obj/machinery/vending/get_req_access()
	if(!scan_id)
		return list()
	return ..()

//Reimplement completely to get rid of dionas
/obj/machinery/vending/vend(var/datum/stored_items/vending_products/R, mob/user)
	if((!allowed(user)) && !emagged && scan_id)	//For SECURE VENDING MACHINES YEAH
		to_chat(user, "<span class='warning'>Access denied.</span>")//Unless emagged of course
		flick(src.icon_deny,src)
		return
	src.vend_ready = 0 //One thing at a time!!
	src.status_message = "Vending..."
	src.status_error = 0
	SSnano.update_uis(src)

	if (R.category & VENDINGM_CAT_COIN)
		if(!coin)
			to_chat(user, "<span class='notice'>You need to insert a coin to get this item.</span>")
			return
		if(!isnull(coin.string_colour))
			if(prob(50))
				to_chat(user, "<span class='notice'>You successfully pull the coin out before \the [src] could swallow it.</span>")
			else
				to_chat(user, "<span class='notice'>You weren't able to pull the coin out fast enough, the machine ate it, string and all.</span>")
				qdel(coin)
				coin = null
				categories &= ~VENDINGM_CAT_COIN
		else
			qdel(coin)
			coin = null
			categories &= ~VENDINGM_CAT_COIN

	if(((src.last_reply + (src.vend_delay + 200)) <= world.time) && src.vend_reply)
		spawn(0)
			src.speak(src.vend_reply)
			src.last_reply = world.time

	use_power_oneoff(vend_power_usage)	//actuators and stuff
	if (src.icon_vend) //Show the vending animation if needed
		flick(src.icon_vend,src)
	spawn(src.vend_delay) //Time to vend
		if(prob(vermin_spawn_chance)) //Hehehe
			var/turf/T = get_turf(src)
			var/mob/living/simple_animal/mouse/V = new(T)
			src.visible_message("<span class='notice'>\The [src] makes an odd grinding noise before coming to a halt as \a [V.name] slurmps out from the receptacle.</span>")
			V.emote("squeak")
		else //Just a normal vend, then
			R.get_product(get_turf(src))
			src.visible_message("\The [src] clunks as it vends \the [R.item_name].")
			playsound(src, 'sound/machines/vending_machine.ogg', 25, 1)
			if(prob(1)) //The vending gods look favorably upon you
				sleep(3)
				if(R.get_product(get_turf(src)))
					src.visible_message("<span class='notice'>\The [src] clunks as it vends an additional [R.item_name].</span>")

		src.status_message = ""
		src.status_error = 0
		src.vend_ready = 1
		currently_vending = null
		SSnano.update_uis(src)

/**
 * Add item to the machine
 *
 * Checks if item is vendable in this machine should be performed before
 * calling. W is the item being inserted, R is the associated vending_product entry.
 */
/obj/machinery/vending/stock(obj/item/weapon/W, var/datum/stored_items/vending_products/R, var/mob/user)
	if(product_records.len >= max_single_product)
		to_chat(user, SPAN_WARNING("There's not enough space left for \the [W]!"))
		return FALSE
	if(!user.unEquip(W))
		return FALSE
	if(R.add_product(W))
		to_chat(user, "<span class='notice'>You insert \the [W] in the product receptor.</span>")
		SSnano.update_uis(src)
		return 1
	else
		to_chat(user, SPAN_WARNING("Couldn't insert the \the [W]!"))
	SSnano.update_uis(src)

/obj/machinery/vending/on_update_icon()
	overlays.Cut()
	var/datum/extension/base_icon_state/bis = get_extension(src, /datum/extension/base_icon_state)
	if(stat & BROKEN)
		icon_state = "[bis.base_icon_state]-broken"
	else if( !(stat & NOPOWER) )
		icon_state = bis.base_icon_state
	else
		spawn(rand(0, 15))
			src.icon_state = "[bis.base_icon_state]-off"
	if(panel_open)
		overlays += image(src.icon, "[bis.base_icon_state]-panel")

/obj/machinery/vending/proc/can_change_base_icon()
	return FALSE

/*
 * Vending machine types
 */
/obj/machinery/vending/custom
	base_type = /obj/machinery/vending/custom
	var/global/list/possible_base_icons = list(
		"Generic machine"				= "generic",
		"Booze machine" 				= "boozeomat",
		"Coffee machine" 				= "coffee",
		"Snack machine" 				= "snack",
		"Soda machine" 					= "Cola_Machine",
		"Fitness machine" 				= "fitness",
		"Cigarettes machine" 			= "cigs",
		"Medical machine" 				= "med",
		"Military gear machine" 		= "sec",
		"Farming supplies machine" 		= "nutri",
		"Farming supplies machine2" 	= "nutri_generic",
		"Seeds machine" 				= "seeds",
		"Seeds machine 2" 				= "seeds_generic",
		"Magi machine" 					= "MagiVend",
		"Dinnerware machine" 			= "dinnerware",
		"Soviet soda machine" 			= "sovietsoda",
		"Tool machine" 					= "tool",
		"Engineer equipment machine" 	= "engivend",
		"Engineer equipment machine2" 	= "engi",
		"Robotics machine" 				= "robotics",
		"Costume machine" 				= "theater",
		"Games machine" 				= "games",
		"Lavatory supplies machine" 	= "lavatory",
		"Old snack machine" 			= "snix",
		"Hot food machine" 				= "hotfood", 
		"Uniform machine"				= "uniform",
		"Laptop machine"				= "laptop",
	)

/obj/machinery/vending/custom/OnTopic(mob/user, href_list, datum/topic_state/state)
	. = ..()
	if(href_list["set_icon"])
		var/datum/extension/base_icon_state/bis = get_extension(src, /datum/extension/base_icon_state)
		var/chosen = input(user, "Chose the model of the machine you want.", "Appearence modification", possible_base_icons[1]) in possible_base_icons
		if(chosen)
			bis.base_icon_state = possible_base_icons[chosen]
			icon_state 			= possible_base_icons[chosen]
			icon_deny			= "[possible_base_icons[chosen]]-deny"
			icon_vend			= "[possible_base_icons[chosen]]-vend"

/obj/machinery/vending/custom/RefreshParts()
	. = ..()
	var/binrating 	= 0
	var/maniprating = 0
	for(var/obj/item/weapon/stock_parts/matter_bin/B in component_parts)
		binrating += B.rating
	for(var/obj/item/weapon/stock_parts/manipulator/M in component_parts)
		maniprating += M.rating

	vermin_spawn_chance = between(0, (maniprating * 2) - vermin_spawn_chance, initial(vermin_spawn_chance))
	max_nb_products		= between(initial(max_nb_products),    (binrating * 2),  24)
	max_single_product 	= between(initial(max_single_product), (binrating * 20), 240)
	max_size_class		= between(ITEM_SIZE_SMALL, round(binrating/3.0) + 1, ITEM_SIZE_LARGE) //Minimum size should be small

/obj/machinery/vending/can_change_base_icon()
	return TRUE

