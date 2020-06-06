/datum/material_inventory
	var/steel = 0
	var/glass = 0
	var/gold = 0
	var/silver = 0
	var/copper = 0
	var/wood = 0
	var/cloth = 0
	var/leather = 0
	var/phoron = 0
	var/diamond = 0
	var/uranium = 0


/datum/world_faction
	var/list/cargo_telepads = list()
	var/datum/material_inventory/inventory
	var/obj/machinery/telepad_cargo/default_telepad
	var/default_telepad_x
	var/default_telepad_y
	var/default_telepad_z

/datum/world_faction/New()
	..()
	inventory = new()

/datum/world_faction/before_save()
	if(default_telepad)
		default_telepad_x = default_telepad.x
		default_telepad_y = default_telepad.y
		default_telepad_z = default_telepad.z

/datum/world_faction/after_load()
	if(default_telepad_x && default_telepad_y && default_telepad_z)
		var/turf/T = locate(default_telepad_x, default_telepad_y, default_telepad_z)
		for(var/obj/machinery/telepad_cargo/telepad in T.contents)
			default_telepad = telepad
			break
	..()

/datum/world_faction/proc/rebuild_cargo_telepads()
	cargo_telepads.Cut()
	for(var/obj/machinery/telepad_cargo/telepad in GLOB.cargotelepads)
		if(telepad.req_access_faction == uid)
			telepad.connected_faction = src
			cargo_telepads |= telepad

/datum/world_faction/proc/give_inventory(var/typepath, var/amount)
	var/obj/machinery/telepad_cargo/using_telepad
	var/remaining_amount = amount
	rebuild_cargo_telepads()
	if(default_telepad)
		using_telepad = default_telepad
	else
		using_telepad = pick(cargo_telepads)
	if(!using_telepad) return 0
	for(var/x in 1 to amount)
		if(!remaining_amount) break
		var/obj/item/stack/material/stack = new typepath(using_telepad.loc)
		var/distributing = min(remaining_amount, stack.max_amount)
		remaining_amount -= distributing
		stack.amount = distributing
	return 1

/datum/world_faction/proc/take_inventory(var/typepath, var/amount)
	var/remaining_amount = amount
	rebuild_cargo_telepads()
	var/list/found_stacks
	for(var/obj/machinery/telepad_cargo/telepad in cargo_telepads)
		if(!remaining_amount)
			break
		if(telepad.loc)
			var/list/stacks = telepad.loc.search_contents_for(/obj/item/stack/material, list(/mob/))
			if(!stacks.len) continue
			for(var/ind in 1 to stacks.len)
				if(!remaining_amount)
					break
				var/obj/item/stack/material/stack = stacks[ind]
				if(istype(stack, typepath))
					remaining_amount -= stack.amount
					found_stacks |= stack
	if(remaining_amount)
		return 0
	var/taken = 0
	for(var/obj/item/stack/material/stack in found_stacks)
		if(taken >= amount)
			break
		var/take = min(stack.amount, (amount-taken))
		stack.amount -= take
		if(!stack.amount)
			qdel(stack)
		taken += take
	return 1

/datum/world_faction/proc/rebuild_inventory()
	inventory.steel = 0
	inventory.glass = 0
	inventory.gold = 0
	inventory.silver = 0
	inventory.copper = 0
	inventory.wood = 0
	inventory.cloth = 0
	inventory.leather = 0
	inventory.phoron = 0
	inventory.diamond = 0
	inventory.uranium = 0
	rebuild_cargo_telepads()
	for(var/obj/machinery/telepad_cargo/telepad in cargo_telepads)
		if(telepad.loc)
			var/list/stacks = telepad.loc.search_contents_for(/obj/item/stack/material, list(/mob/))
			if(!stacks.len) continue
			for(var/ind in 1 to stacks.len)
				var/obj/item/stack/material/stack = stacks[ind]
				if(istype(stack, /obj/item/stack/material/steel))
					inventory.steel += stack.amount
				if(istype(stack, /obj/item/stack/material/glass))
					inventory.glass += stack.amount
				if(istype(stack, /obj/item/stack/material/gold))
					inventory.gold += stack.amount
				if(istype(stack, /obj/item/stack/material/silver))
					inventory.silver += stack.amount
				if(istype(stack, /obj/item/stack/material/copper))
					inventory.copper += stack.amount
				if(istype(stack, /obj/item/stack/material/wood))
					inventory.wood += stack.amount
				if(istype(stack, /obj/item/stack/material/cloth))
					inventory.cloth += stack.amount
				if(istype(stack, /obj/item/stack/material/leather))
					inventory.leather += stack.amount
				if(istype(stack, /obj/item/stack/material/phoron))
					inventory.phoron += stack.amount
				if(istype(stack, /obj/item/stack/material/diamond))
					inventory.diamond += stack.amount
				if(istype(stack, /obj/item/stack/material/uranium))
					inventory.uranium += stack.amount


