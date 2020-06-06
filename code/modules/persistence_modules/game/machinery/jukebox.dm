/datum/track
	var/genre

/datum/track/New(var/title, var/track, var/genre)
	..(title, track)
	src.genre = genre

/obj/machinery/media/jukebox
	var/selected_genre = "ALL"

/obj/machinery/media/jukebox/Initialize()
	. = ..()
	for(var/music_track/T in subtypesof(/music_track/jukebox))
		tracks += new/datum/track(T.title, T.song)

/obj/machinery/media/jukebox/Initialize(mapload, d=0, populate_parts = TRUE)
	if(d)
		set_dir(d)
	START_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF) // It's safe to remove machines from here, but only if base machinery/Process returned PROCESS_KILL.
	SSmachines.machinery += src // All machines should remain in this list, always.
	if(ispath(wires))
		wires = new wires(src)
	if(!map_storage_loaded) //Don't do that on load
		populate_parts(populate_parts)
	RefreshParts()
	power_change()

	for(var/music_track/T in subtypesof(/music_track/jukebox))
		tracks += new/datum/track(T.title, T.song)

/obj/machinery/media/jukebox/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/list/juke_tracks = new
	for(var/datum/track/T in tracks)
		juke_tracks.Add(list(list("track"=T.title)))

	var/list/data = list(
		"current_track" = current_track != null ? current_track.title : "No track selected",
		"playing" = playing,
		"tracks" = juke_tracks,
		"volume" = volume,
		"genre" = selected_genre
	)

	var/list/tracks_pleasent = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Pleasent")
			tracks_pleasent[++tracks_pleasent.len] = list("track" = T.title)
	data["tracks_pleasent"] = tracks_pleasent

	var/list/tracks_country = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Country")
			tracks_country[++tracks_country.len] = list("track" = T.title)
	data["tracks_country"] = tracks_country

	var/list/tracks_moody = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Moody")
			tracks_moody[++tracks_moody.len] = list("track" = T.title)
	data["tracks_moody"] = tracks_moody

	var/list/tracks_agarthan = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Agarthan")
			tracks_agarthan[++tracks_agarthan.len] = list("track" = T.title)
	data["tracks_agarthan"] = tracks_agarthan

	var/list/tracks_jazz = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Jazz")
			tracks_jazz[++tracks_jazz.len] = list("track" = T.title)
	data["tracks_jazz"] = tracks_jazz

	var/list/tracks_classical = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Classical")
			tracks_classical[++tracks_classical.len] = list("track" = T.title)
	data["tracks_classical"] = tracks_classical
	
	var/list/tracks_faeren = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Faeren")
			tracks_faeren[++tracks_faeren.len] = list("track" = T.title)
	data["tracks_faeren"] = tracks_faeren
	
	var/list/tracks_spacer = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Mercenary/Spacer")
			tracks_spacer[++tracks_spacer.len] = list("track" = T.title)
	data["tracks_spacer"] = tracks_spacer
	
	var/list/tracks_ss13 = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "SS13")
			tracks_ss13[++tracks_ss13.len] = list("track" = T.title)
	data["tracks_ss13"] = tracks_ss13

	var/list/tracks_cyberpunk = list()
	for(var/datum/track/T in tracks)
		if(T.genre == "Cyberpunk")
			tracks_cyberpunk[++tracks_cyberpunk.len] = list("track" = T.title)
	data["tracks_cyberpunk"] = tracks_cyberpunk

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "jukebox.tmpl", "Your Media Library", 340, 440)
		ui.set_initial_data(data)
		ui.open()

/obj/machinery/media/jukebox/OnTopic(var/mob/user, var/list/href_list, state)
	if(href_list["change_genre"])
		selected_genre = href_list["change_genre"]
		return TOPIC_REFRESH
	. = ..()

/obj/machinery/media/jukebox/StartPlaying()
	StopPlaying()
	if(!current_track)
		return

	// Jukeboxes cheat massively and actually don't share id. This is only done because it's music rather than ambient noise.
	sound_token = GLOB.sound_player.PlayLoopingSound(src, sound_id, current_track.GetTrack(), volume = volume, range = 7, falloff = 3, prefer_mute = TRUE, channel = GLOB.sound_channels.RequestChannel(src.type) )

	playing = 1
	update_use_power(POWER_USE_ACTIVE)
	update_icon()