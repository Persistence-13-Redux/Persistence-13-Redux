//Some common things we don't want
/*
	Byond defines those already as tmp vars (http://www.byond.com/docs/ref/#/var/tmp):
    type 
    parent_type 
    vars 
    verbs 
    group 
    loc 
    locs 
    vis_locs 
    x 
    y 
    z 
    ckey 
    visibility 
    bound_x 
    bound_y 
    bound_width 
    bound_height 
    mouse_over_pointer 
    mouse_drag_pointer 
    mouse_drop_pointer 
*/
/atom/should_never_save(list/L)
	L.Add("icon","icon_state","overlays","underlays")
	return ..(L)

//No screen_loc please
/atom/movable/should_never_save(list/L)
	L.Add("screen_loc")
    return ..(L)

//Ckey is special
/mob/Write(var/savefile/F, var/list/neversave = null)
	. = ..(F, neversave)
	F.dir.Remove("key")
	return .
