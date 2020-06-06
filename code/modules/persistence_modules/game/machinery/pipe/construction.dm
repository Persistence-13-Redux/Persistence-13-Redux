/obj/item/pipe
	matter = list(MATERIAL_STEEL = SHEET_MATERIAL_AMOUNT)


/obj/item/pipe/attackby(var/obj/item/weapon/W as obj, var/mob/user as mob)
	if(isWrench(W))
		return wrench_down(user)
	return ..()

/obj/item/pipe/proc/wrench_down(var/mob/user as mob)
	if (!isturf(loc))
		return 1

	sanitize_dir()
	var/obj/machinery/atmospherics/fake_machine = constructed_path
	var/pipe_dir = base_pipe_initialize_directions(dir, initial(fake_machine.connect_dir_type))

	for(var/obj/machinery/atmospherics/M in loc)
		if((M.initialize_directions & pipe_dir) && M.check_connect_types_construction(M,src))	// matches at least one direction on either type of pipe & same connection type
			to_chat(user, "<span class='warning'>There is already a pipe of the same type at this location.</span>")
			return 1
	// no conflicts found

	var/pipefailtext = "<span class='warning'>There's nothing to connect this pipe section to!</span>" //(with how the pipe code works, at least one end needs to be connected to something, otherwise the game deletes the segment)"

	//TODO: Move all of this stuff into the various pipe constructors.
	var/obj/machinery/atmospherics/P = new constructed_path(get_turf(src))

	P.pipe_color = color
	P.set_dir(dir)
	P.set_initial_level()

	if(P.pipe_class == PIPE_CLASS_UNARY)
		if(build_unary(P, pipefailtext))
			return 1

	if(P.pipe_class == PIPE_CLASS_BINARY)
		if(build_binary(P, pipefailtext))
			return 1

	if(P.pipe_class == PIPE_CLASS_TRINARY)
		if(build_trinary(P, pipefailtext))
			return 1

	if(P.pipe_class == PIPE_CLASS_QUATERNARY)
		if(build_quaternary(P, pipefailtext))
			return 1

	if(P.pipe_class == PIPE_CLASS_OMNI)
		P.atmos_init()
		P.build_network()

	playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
	user.visible_message( \
		"[user] fastens the [src].", \
		"<span class='notice'>You have fastened the [src].</span>", \
		"You hear ratchet.")
	qdel(src)	// remove the pipe item