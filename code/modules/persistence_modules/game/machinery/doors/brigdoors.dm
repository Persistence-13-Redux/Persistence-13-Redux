//Main door timer loop, if it's timing and time is >0 reduce time by 1.
// if it's less than 0, open door, reset timer
// update the door_timer window and the icon
/obj/machinery/door_timer/Process()
	if(inoperable())
		return
	if(src.timing)
		if(REALTIMEOFDAY > src.releasetime)
			src.timer_end() // open doors, reset timer, clear status screen
			src.timing = 0
		src.update_icon()
	else
		timer_end()

	return

/obj/machinery/door_timer/timer_start()
	if(inoperable())	
		return FALSE
	// Set releasetime
	releasetime = REALTIMEOFDAY + timetoset
	//set timing
	timing = 1

	for(var/obj/machinery/door/window/brigdoor/door in targets)
		if(door.density)	continue
		spawn(0)
			door.close()

	for(var/obj/structure/closet/secure_closet/brig/C in targets)
		if(C.broken)	continue
		if(C.opened && !C.close())	continue
		C.locked = TRUE
		C.queue_icon_update()
	return 1

/obj/machinery/door_timer/update_icon()
	. = ..()
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = -32
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = 32
		if(EAST)
			src.pixel_x = -32
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = 32
			src.pixel_y = 0

