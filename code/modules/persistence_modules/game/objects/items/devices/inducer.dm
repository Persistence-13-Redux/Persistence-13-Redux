/obj/item/inducer
	matter = list(MATERIAL_ALUMINIUM = 2 SHEETS, MATERIAL_GRAPHITE = 1 SHEET, MATERIAL_COPPER = 2 SHEETS, MATERIAL_STEEL = 0.5 SHEETS)

/obj/item/inducer/empty
	cell = null

/obj/item/inducer/New()
	. = ..()
	ADD_SAVED_VAR(opened)
	ADD_SAVED_VAR(failsafe)
	ADD_SAVED_VAR(cell)

/obj/item/inducer/Destroy()
	. = ..()
	if(!ispath(cell))
		qdel(cell)
	cell = null


