/datum/book_constructor
	var/title
	var/list/pages = list()
	var/author

/datum/book_constructor/proc/construct()
	var/obj/item/weapon/book/multipage/book = new()
	book.name = title
	book.author = author
	book.title = title
	// book.author_real = "premade"

	for(var/x in pages)
		var/obj/item/weapon/paper/P = new x()
		book.pages |= P
	return book

/obj/item/weapon/book/multipage
	var/list/pages = list()
	var/current_page = 0 // If 0 the book is closed
	var/original = 0

/obj/item/weapon/book/multipage/attack_self(var/mob/user as mob)
	if(carved)
		if(store)
			to_chat(user, "<span class='notice'>[store] falls out of [title]!</span>")
			store.loc = get_turf(src.loc)
			store = null
			return
		else
			to_chat(user, "<span class='notice'>The pages of [title] have been cut out!</span>")
			return
	browse_mob(user)
//	user.visible_message("[user] opens a book titled \"[src.title]\" and begins reading intently.")
	onclose(user, "book")

/obj/item/weapon/book/multipage/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(carved == 1)
		if(!store)
			if(W.w_class < ITEM_SIZE_NORMAL)
				user.drop_item()
				W.loc = src
				store = W
				to_chat(user, "<span class='notice'>You put [W] in [title].</span>")
				return
			else
				to_chat(user, "<span class='notice'>[W] won't fit in [title].</span>")
				return
		else
			to_chat(user, "<span class='notice'>There's already something in [title]!</span>")
			return
	if(istype(W, /obj/item/weapon/pen))
		to_chat(user, "These pages don't seem to take the ink well. Looks like you can't modify it.")
		return
	else if(istype(W, /obj/item/weapon/material/knife) || isWirecutter(W))
		if(carved)	return
		to_chat(user, "<span class='notice'>You begin to carve out [title].</span>")
		if(do_after(user, 30, src))
			to_chat(user, "<span class='notice'>You carve out the pages from [title]! You didn't want to read it anyway.</span>")
			carved = 1
			return
	else
		..()

/obj/item/weapon/book/multipage/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	if(user.zone_sel.selecting == BP_EYES)
		if(carved)
			to_chat(user, "The book is carved out and so you cannot show its contents.")
			return
		user.visible_message("<span class='notice'>You open up the book and show it to [M]. </span>", \
			"<span class='notice'> [user] opens up a book and shows it to [M]. </span>")
		browse_mob(M)
		user.setClickCooldown(DEFAULT_QUICK_COOLDOWN) //to prevent spam

/obj/item/weapon/book/multipage/proc/browse_mob(mob/living/carbon/M as mob)

	if(current_page)
		if(current_page > pages.len)
			current_page = 0
			return
		var/dat
		if(current_page == pages.len)
			dat+= "<DIV STYLE='float:left; text-align:left; width:33.33333%'><A href='?src=\ref[src];choice=prev_page'>Previous Page</A></DIV>"
			dat+= "<DIV STYLE='float:left; text-align:left; width:33.33333%'><A href='?src=\ref[src];choice=close_book'>Close Book</A></DIV>"
			dat+= "<DIV STYLE='float;left; text-align:right; with:33.33333%'><A href='?src=\ref[src];'>Back of book</A></DIV><BR><HR>"
		// middle pages
		else
			dat+= "<DIV STYLE='float:left; text-align:left; width:33.33333%'><A href='?src=\ref[src];choice=prev_page'>Previous Page</A></DIV>"
			dat+= "<DIV STYLE='float:left; text-align:left; width:33.33333%'><A href='?src=\ref[src];choice=close_book'>Close Book</A></DIV>"
			dat+= "<DIV STYLE='float:left; text-align:right; width:33.33333%'><A href='?src=\ref[src];choice=next_page'>Next Page</A></DIV><BR><HR>"
		if(istype(pages[current_page], /obj/item/weapon/paper))
			var/obj/item/weapon/paper/P = pages[current_page]
			dat+= "<HTML><HEAD><TITLE>[title]</TITLE></HEAD><BODY>[P.info][P.stamps]</BODY></HTML>"
			M << browse(dat, "window=[title]")
		else if(istype(pages[current_page], /obj/item/weapon/photo))
			var/obj/item/weapon/photo/P = pages[current_page]
			if(P.img)
				M << browse_rsc(P.img, "tmp_photo.png")
			// else if(P.render)
			// 	M << browse_rsc(P.render.icon, "tmp_photo.png")
			M << browse(dat + "<html><head><title>[title]</title></head>" \
			+ "<body style='overflow:hidden'>" \
			+ "<div> <center><img src='tmp_photo.png' width = '180'" \
			+ "[P.scribble ? "<div><i>[P.scribble]</i>" : null]"\
			+ "</center></body></html>", "window=[title]")

	else
		M << browse("<center><h1>[title]</h1></center><br><br><i>Authored: [author].</i><br><br>" + "<br><br><a href='?src=\ref[src];choice=next_page'>Open Book</a>", "window=[title]")

/obj/item/weapon/book/multipage/Topic(href, href_list)
	if(..())
		return 1
	if((src in usr.contents) || Adjacent(usr))
		usr.set_machine(src)
		if(href_list["choice"])
			switch(href_list["choice"])
				if("next_page")
					if(current_page < pages.len)
						current_page++
						playsound(src.loc, "pageturn", 50, 1)
				if("prev_page")
					if(current_page > 0)
						current_page--
						playsound(src.loc, "pageturn", 50, 1)
				if("close_book")
					current_page = 0
					playsound(src.loc, "pageturn", 50, 1)

			src.attack_self(usr)
	else
		to_chat(usr, "<span class='notice'>You need to hold it in hands!</span>")
