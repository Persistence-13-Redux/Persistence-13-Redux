/decl/emote/audible/scream/do_extra(var/atom/user)
	var/mob/living/carbon/C = user
	if(!istype(C)) return
	if(C.gender=="female")
		playsound(C.loc, pick('sound/emote/fear_woman1.ogg',\
			'sound/emote/fear_woman2.ogg',\
			'sound/emote/fear_woman3.ogg'), 50, 0)
	else//i dont really care about "other" sounding like men
		playsound(C.loc, pick('sound/emote/fear_scream1.ogg',\
			'sound/emote/fear_scream2.ogg'), 50, 0)

/decl/emote/audible/unathi_hiss
	key ="hiss"
	emote_message_3p_target = "USER hisses at TARGET."
	emote_message_3p = "USER hisses."
	emote_sound = 'sound/voice/unathihiss.ogg' //Credit for sound: www.zapsplat.com
