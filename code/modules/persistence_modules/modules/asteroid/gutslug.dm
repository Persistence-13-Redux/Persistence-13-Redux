//
// Gutslug
//
/mob/living/simple_animal/hostile/voxlug/gutslug
	name = "gutslug"

/mob/living/simple_animal/hostile/voxlug/gutslug/Move()
	. = ..()
	if(.)
		pixel_x = rand(-10,10)
		pixel_y = rand(-10,10)
