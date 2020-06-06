#define ENERGY_LOAD_FIXED_CELL 0
#define ENERGY_LOAD_HOTSWAP_CELL 1
#define ENERGY_LOAD_REMOVABLE_CELL 2

/obj/item/weapon/gun/energy
	cell_type = /obj/item/weapon/cell/device/variable
	var/load_method = ENERGY_LOAD_REMOVABLE_CELL
	var/cell_secured = TRUE //For energy weapons that needs their cells unsecured first
	var/accepted_cell_types = list(
		/obj/item/weapon/cell/device/variable,
		/obj/item/weapon/cell/device/standard,
		/obj/item/weapon/cell/device/high,
		/obj/item/weapon/cell/device/super,
		) //Cells typepaths that are accepted by this weapon

/obj/item/weapon/gun/energy/New()
	..()
	ADD_SAVED_VAR(cell_secured)
	ADD_SAVED_VAR(power_supply)
	ADD_SKIP_EMPTY(power_supply)



/obj/item/weapon/gun/energy/proc/load_ammo(var/obj/item/A, mob/user)
	if(istype(A, /obj/item/weapon/cell))
		if(power_supply)
			user.visible_message("[user] quickly swap [power_supply] for a [A] into \the [src]!", "<span class='warning'>You quickly swap the current [power_supply] for the new [A], dropping the old one!</span>")
			power_supply.dropInto(user.loc)
			power_supply = null
		else
			user.visible_message("[user] insert \the [A] into [src].", "<span class='notice'>You insert the [A]!</span>")
		user.remove_from_mob(A)
		A.loc = src
		power_supply = A
		playsound(src.loc, 'sound/weapons/empty.ogg', 50, 1)
	update_icon()

/obj/item/weapon/gun/energy/proc/unload_ammo(mob/user)
	if(!power_supply)
		to_chat(user, "<span class='warning'>There is no cell in the [src]!</span>")
		return
	if(load_method == ENERGY_LOAD_HOTSWAP_CELL || load_method == ENERGY_LOAD_REMOVABLE_CELL)
		user.put_in_hands(power_supply)
		user.visible_message("[user] removes [power_supply] from [src].", "<span class='notice'>You remove [power_supply] from [src].</span>")
		power_supply = null
	update_icon()

/obj/item/weapon/gun/energy/attackby(var/obj/item/A as obj, mob/user as mob)
	if(istype(A, /obj/item/weapon/cell))
		if(!is_valid_cell(A))
			to_chat(user,"<span class='warning'>This weapon is not compatible with \the [A]!</span>")
			return
		switch(load_method)
			if(ENERGY_LOAD_HOTSWAP_CELL)
				load_ammo(A, user)
				return
			if(ENERGY_LOAD_REMOVABLE_CELL)
				if(check_cover_open())
					load_ammo(A, user)
				return
			else
				to_chat(user,"<span class='warning'>This weapon does not accepts powercells!</span>")
				return
	else if(isScrewdriver(A))
		switch(load_method)
			if(ENERGY_LOAD_REMOVABLE_CELL)
				var/curact = cell_secured? "unscrew": "screw"
				user.visible_message("[user] [curact] the cover.","<span class='notice'>You [curact] the cover.</span>")
				cell_secured = !cell_secured
			else
				to_chat(user,"<span class='warning'>There are no covers to unscrew on this weapon!</span>")
				return
	return ..()

/obj/item/weapon/gun/energy/proc/check_cover_open()
	if(cell_secured)
		to_chat(usr,"<span class='warning'>You must first unscrew the cover!</span>")
	return !cell_secured

/obj/item/weapon/gun/energy/attack_self(mob/user as mob)
	if(firemodes.len > 1)
		..()
	else
		switch(load_method)
			if(ENERGY_LOAD_REMOVABLE_CELL)
				if(check_cover_open())
					unload_ammo(user)
			if(ENERGY_LOAD_HOTSWAP_CELL)
				unload_ammo(user)

/obj/item/weapon/gun/energy/attack_hand(mob/user as mob)
	if(user.get_inactive_hand() == src)
		switch(load_method)
			if(ENERGY_LOAD_REMOVABLE_CELL)
				if(check_cover_open())
					unload_ammo(user)
				return
			if(ENERGY_LOAD_HOTSWAP_CELL)
				unload_ammo(user)
				return
	else
		return ..()

/obj/item/weapon/gun/energy/proc/is_valid_cell(var/obj/item/weapon/cell/pcell)
	return(ispath(accepted_cell_types) && istype(pcell, accepted_cell_types) || islist(accepted_cell_types) && is_type_in_list(pcell, accepted_cell_types))
