/obj/item/latexballon/New()
	. = ..()
	ADD_SAVED_VAR(state)
	ADD_SAVED_VAR(air_contents)

/obj/item/latexballon/after_load()
	. = ..()
	queue_icon_update()
