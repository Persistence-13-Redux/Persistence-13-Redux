/obj/item/weapon/gun/magnetic/New()
	. = ..()
	ADD_SAVED_VAR(cell)
	ADD_SAVED_VAR(capacitor)
	ADD_SAVED_VAR(loaded)
	
	ADD_SKIP_EMPTY(cell)
	ADD_SKIP_EMPTY(capacitor)
	ADD_SKIP_EMPTY(loaded)

/obj/item/weapon/gun/magnetic/get_cell()
	return cell