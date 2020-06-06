//Need to do this shitty hack because bay doesn't split default values from initialization.
/obj/structure/closet/secure_closet/freezer/money/Initialize()
	var/list/old_content
	if(map_storage_loaded)
		old_content = list()
		for(var/I in contents)
			old_content += I
	. = ..()
	if(old_content)
		for(var/I in contents)
			contents -= I
		for(var/I in old_content)
			contents += I