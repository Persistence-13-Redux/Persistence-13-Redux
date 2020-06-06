
/decl/emote/visible/snap
	key = "snap"
	emote_message_3p_target = "USER snaps their fingers at TARGET."
	emote_message_3p = "USER snaps their fingers."
	
/decl/emote/visible/snap/do_extra(var/mob/user)	
	playsound(user.loc, 'sound/effects/fingersnap.ogg', 50, 1)
