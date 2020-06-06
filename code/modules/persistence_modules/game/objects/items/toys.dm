/obj/item/toy/crossbow
	New()
		. = ..()
		ADD_SAVED_VAR(bullets)

	examine(mob/user)
		if(..(user, 2) && bullets)
			to_chat(user, "<span class='notice'>It is loaded with [bullets] foam darts!</span>")

/obj/item/toy/desk/New()
	. = ..()
	ADD_SAVED_VAR(on)

/obj/item/toy/desk/after_load()
	. = ..()
	queue_icon_update()