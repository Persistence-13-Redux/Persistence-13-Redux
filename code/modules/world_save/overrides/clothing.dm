/obj/item/clothing/New()
	. = ..()
	ADD_SAVED_VAR(accessories)
	ADD_SAVED_VAR(visible_name)
	ADD_SAVED_VAR(ironed_state)
	ADD_SAVED_VAR(smell_state)

/obj/item/clothing/after_load()
	. = ..()
	for(var/obj/item/clothing/accessory/A in accessories)
		src.attach_accessory(null, A)

/obj/item/clothing/mask/gas/New()
	. = ..()
	ADD_SAVED_VAR(clogged)

/obj/item/clothing/mask/smokable/New()
	..()
	ADD_SAVED_VAR(lit)
	ADD_SAVED_VAR(atom_flags)

/obj/item/voice_changer/New()
	. = ..()
	ADD_SAVED_VAR(voice)
	ADD_SAVED_VAR(active)

/obj/item/clothing/mask/chameleon/voice/New()
	..()
	ADD_SAVED_VAR(changer)

//BOOTS
/obj/item/clothing/shoes/magboots/New()
	. = ..()
	ADD_SAVED_VAR(magpulse)
	ADD_SAVED_VAR(shoes)
	ADD_SAVED_VAR(online_slowdown)
	ADD_SKIP_EMPTY(shoes)

/obj/item/clothing/shoes/magboots/after_load()
	. = ..()
	if(ismob(loc))
		wearer = loc
		equipped()

//RIGS
/obj/item/weapon/rig/New()
	. = ..()
	ADD_SAVED_VAR(open)
	ADD_SAVED_VAR(p_open)
	ADD_SAVED_VAR(locked)
	ADD_SAVED_VAR(subverted)
	ADD_SAVED_VAR(malfunctioning)
	ADD_SAVED_VAR(security_check_enabled)
	ADD_SAVED_VAR(electrified)
	ADD_SAVED_VAR(locked_down)
	ADD_SAVED_VAR(sealing)
	ADD_SAVED_VAR(installed_modules)
	ADD_SAVED_VAR(cell)
	ADD_SAVED_VAR(air_supply)

/stat_rig_module/activate/after_load()
	..()
	if(module)
		name = module.activate_string
		if(module.active_power_cost)
			name += " ([module.active_power_cost*10]A)"

/stat_rig_module/deactivate/after_load()
	..()
	if(module)
		name = module.deactivate_string
		// Show cost despite being 0, if it means changing from an active cost.
		if(module.active_power_cost || module.passive_power_cost)
			name += " ([module.passive_power_cost*10]P)"

		module_mode = "deactivate"

/stat_rig_module/engage/after_load()
	..()
	if(module)
		name = module.engage_string
		if(module.use_power_cost)
			name += " ([module.use_power_cost*10]E)"
		module_mode = "engage"

/obj/item/clothing/accessory/toggleable/after_load()
	if(!icon_closed)
		icon_closed = icon_state
	if(has_suit)
		has_suit.verbs += /obj/item/clothing/accessory/toggleable/verb/toggle
	..()

/obj/item/clothing/accessory/locket/New()
	. = ..()
	ADD_SAVED_VAR(open)
	ADD_SAVED_VAR(held)
	ADD_SKIP_EMPTY(held)

/obj/item/clothing/accessory/storage/New()
	. = ..()
	ADD_SAVED_VAR(hold)


/obj/item/clothing/accessory/bowtie
	var/icon_tied
/obj/item/clothing/accessory/bowtie/New()
	icon_tied = icon_tied || icon_state
	..()

/obj/item/clothing/accessory/bowtie/after_load()
	if(has_suit)
		has_suit.verbs += /obj/item/clothing/accessory/bowtie/verb/toggle
	icon_tied = icon_tied || icon_state
	..()

/obj/item/underwear/New()
	. = ..()
	//Because the underwears are by default all a single item, we gotta save these
	ADD_SAVED_VAR(name)
	ADD_SAVED_VAR(gender)
	ADD_SAVED_VAR(color)
	ADD_SAVED_VAR(icon)
	ADD_SAVED_VAR(icon_state)

/obj/item/underwear/Initialize()
	. = ..()
	if(!icon_state)
		log_debug("[src](\ref[src])([x],[y],[z]) was deleted, because it had no sprite.")
		return INITIALIZE_HINT_QDEL //Lets avoid having bugged out underwears everywhere


