/obj/item/device/hailer/attack_self(mob/living/carbon/user as mob)
	if (spamcheck)
		return

	if(isnull(insults))
		playsound(get_turf(src), 'sound/voice/halt.ogg', 100, 1, vary = 0)
		user.audible_message("<span class='warning'>[user]'s [name] rasps, \"[use_message]\"</span>", null, "<span class='warning'>\The [user] holds up \the [name].</span>")
	else
		if(insults > 0)
			playsound(get_turf(src), 'sound/voice/binsult.ogg', 100, 1, vary = 0)
			// Yes, it used to show the transcription of the sound clip. That was a) inaccurate b) immature as shit.
			user.audible_message("<span class='warning'>[user]'s [name] gurgles something indecipherable and deeply offensive.</span>", null, "<span class='warning'>\The [user] holds up \the [name].</span>")
			insults--
		else
			to_chat(user, "<span class='danger'>*BZZZZZZZZT*</span>")

	spamcheck = 1
	spawn(20)
		spamcheck = 0