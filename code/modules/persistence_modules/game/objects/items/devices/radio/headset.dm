/obj/item/device/radio/headset/New()
	..()
	ADD_SAVED_VAR(encryption_keys)
	ADD_SKIP_EMPTY(encryption_keys)

/obj/item/device/radio/headset/after_load()
	. = ..()
	recalculateChannels(1)