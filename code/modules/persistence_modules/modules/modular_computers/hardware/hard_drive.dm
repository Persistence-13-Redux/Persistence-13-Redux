/obj/item/weapon/stock_parts/computer/hard_drive/install_default_programs()
	. = ..()
	store_file(new/datum/computer_file/program/ntnetrouter(src))

/obj/item/weapon/stock_parts/computer/hard_drive/New()
	install_default_programs()
	..()
	ADD_SAVED_VAR(stored_files)
	ADD_SAVED_VAR(used_capacity)

/obj/item/weapon/stock_parts/computer/hard_drive/Initialize()
	.=..()
	if(!map_storage_loaded)
		install_default_programs()