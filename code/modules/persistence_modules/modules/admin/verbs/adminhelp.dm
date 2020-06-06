/client/adminhelp(msg as text)
	. = ..()
	GLOB.discord_api.on_new_ahelp(mob, msg)