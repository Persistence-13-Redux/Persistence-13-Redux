#define SOUND_ID "pipe_leakage"
/obj/machinery/atmospherics/pipe
	//var/soud_id

/obj/machinery/atmospherics/pipe/New()
	..()
	ADD_SAVED_VAR(air_temporary)
	ADD_SAVED_VAR(leaking)
	ADD_SAVED_VAR(in_stasis)

/obj/machinery/atmospherics/pipe/after_load()
	. = ..()
	set_leaking(leaking)

/obj/machinery/atmospherics/pipe/set_leaking(var/new_leaking)
	if(new_leaking && !leaking && parent && parent.network)
		playsound(src, 'sound/effects/bang.ogg', 45, TRUE, 10, 4)
		var/turf/T = get_turf(src)
		if(!T.is_plating() && istype(T,/turf/simulated/floor)) //intact floor, pop the tile
			var/turf/simulated/floor/F = T
			F.break_tile()
	return ..()

/obj/machinery/atmospherics/pipe/update_sound(var/playing)
	if(playing && !sound_token)
		sound_token = GLOB.sound_player.PlayLoopingSound(src, SOUND_ID, "sound/machines/pipeleak.ogg", volume = 35, range = 6, falloff = 1, prefer_mute = TRUE)
	else if(!playing && sound_token)
		QDEL_NULL(sound_token)

#undef SOUND_ID