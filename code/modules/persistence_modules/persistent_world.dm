/world/New()
	if(config && config.persistent_mode)
		src.mob = /mob/new_player/persistent //Use the persistent new playerm when in persistent mode!
	. = ..()