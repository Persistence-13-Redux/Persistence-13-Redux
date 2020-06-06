/mob/observer/ghost/New(mob/body)
	..()
	verbs -= /mob/proc/toggle_antag_pool //No antag pool

/mob/ghostize(var/shouldGhost = 0)
	// Are we the body of an aghosted admin? If so, don't make a ghost.
	if(teleop && istype(teleop, /mob/observer/ghost))
		var/mob/observer/ghost/G = teleop
		if(G.admin_ghosted)
			return
	if(key)
		hide_fullscreens()
		if(check_rights(R_ADMIN, 0, src) && shouldGhost)
			var/mob/observer/ghost/ghost = new(src)	//Transfer safety to observer spawning proc.
			ghost.timeofdeath = src.stat == DEAD ? src.timeofdeath : world.time
			ghost.key = key
			if(ghost.client && !ghost.client.holder && !config.antag_hud_allowed)		// For new ghosts we remove the verb from even showing up if it's not allowed.
				ghost.verbs -= /mob/observer/ghost/verb/toggle_antagHUD	// Poor guys, don't know what they are missing!
			return ghost
		else if(client)
			var/mob/new_player/M = new /mob/new_player()
			client.eye = M
			M.key = key
			M.loc = null
	return null

/mob/living/ghost()
	return //Nope