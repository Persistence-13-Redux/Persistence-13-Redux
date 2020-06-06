/obj/item/sticky_pad/New()
	..()
	ADD_SAVED_VAR(papers)
	ADD_SAVED_VAR(written_text)
	ADD_SAVED_VAR(paper_type)

//Keep base class from overwriting our saved color
/obj/item/sticky_pad/random/Initialize()
	var/old_color = color
	. = ..()
	if(map_storage_loaded)
		color = old_color

