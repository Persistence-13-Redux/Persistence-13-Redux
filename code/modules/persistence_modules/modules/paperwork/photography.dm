// /obj/item/weapon/photo
// 	var/image/render

// /obj/item/weapon/photo/after_load()		
// 	..()
// 	queue_icon_update()

// /obj/item/weapon/photo/on_update_icon()
// 	if(!img && tiny)
// 		render = image(tiny.icon)
// 		overlays.Cut()
// 		var/scale = 8/(photo_size*32)
// 		var/image/small_img = image(tiny.icon)
// 		small_img.transform *= scale
// 		small_img.pixel_x = -32*(photo_size-1)/2 - 3
// 		small_img.pixel_y = -32*(photo_size-1)/2
// 		overlays |= small_img

// 		tiny.transform *= 0.5*scale
// 		tiny.underlays += image('icons/obj/bureaucracy.dmi',"photo")
// 		tiny.pixel_x = -32*(photo_size-1)/2 - 3
// 		tiny.pixel_y = -32*(photo_size-1)/2 + 3
// 	else
// 		overlays.Cut()
// 		var/scale = 8/(photo_size*32)
// 		var/image/small_img = image(img.icon)
// 		small_img.transform *= scale
// 		small_img.pixel_x = -32*(photo_size-1)/2 - 3
// 		small_img.pixel_y = -32*(photo_size-1)/2
// 		overlays |= small_img

// 		tiny = image(img.icon)
// 		tiny.transform *= 0.5*scale
// 		tiny.underlays += image('icons/obj/bureaucracy.dmi',"photo")
// 		tiny.pixel_x = -32*(photo_size-1)/2 - 3
// 		tiny.pixel_y = -32*(photo_size-1)/2 + 3

// /obj/item/weapon/photo/show(mob/user as mob)
// 	if(img)
// 		user << browse_rsc(img.icon, "tmp_photo_[id].png")
// 		user << browse("<html><head><title>[name]</title></head>" \
// 			+ "<body style='overflow:hidden;margin:0;text-align:center'>" \
// 			+ "<img src='tmp_photo_[id].png' width='[64*photo_size]' style='-ms-interpolation-mode:nearest-neighbor' />" \
// 			+ "[scribble ? "<br>Written on the back:<br><i>[scribble]</i>" : ""]"\
// 			+ "</body></html>", "window=book;size=[64*photo_size]x[scribble ? 400 : 64*photo_size]")
// 		onclose(user, "[name]")
// 		return
// 	else if(render)
// 		user << browse_rsc(render.icon, "tmp_photo_[id].png")
// 		user << browse("<html><head><title>[name]</title></head>" \
// 			+ "<body style='overflow:hidden;margin:0;text-align:center'>" \
// 			+ "<img src='tmp_photo_[id].png' width='[64*photo_size]' style='-ms-interpolation-mode:nearest-neighbor' />" \
// 			+ "[scribble ? "<br>Written on the back:<br><i>[scribble]</i>" : ""]"\
// 			+ "</body></html>", "window=book;size=[64*photo_size]x[scribble ? 400 : 64*photo_size]")
// 		onclose(user, "[name]")
// 		return

// /obj/item/device/camera/empty
// 	pictures_left = 0

// /obj/item/weapon/photo/copy(var/copy_id = 0)
// 	var/obj/item/weapon/photo/p = new/obj/item/weapon/photo()
// 	p.SetName(name) // Do this first, manually, to make sure listeners are alerted properly.
// 	p.appearance = appearance
// 	p.icon = icon(icon, icon_state)
// 	p.tiny = new
// 	p.tiny = icon(tiny)
// 	p.tiny.appearance = tiny.appearance
// 	if(img)
// 		p.img = icon(img)
// 	else
// 		p.update_icon()
// 	p.desc = desc
// 	p.photo_size = photo_size
// 	p.scribble = scribble
// 	if(copy_id)
// 		p.id = id
// 	return p