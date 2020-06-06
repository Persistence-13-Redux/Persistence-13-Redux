/obj/item/weapon/material/clipboard/New(newloc, material_key)
	..()
	ADD_SAVED_VAR(haspen)
	ADD_SAVED_VAR(toppaper)

/obj/item/weapon/material/clipboard/Initialize()
	. = ..()
	if(material)
		desc = initial(desc)
		desc += " It's made of [material.use_name]."
	queue_icon_update()
