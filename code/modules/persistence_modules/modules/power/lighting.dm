/obj/machinery/light_construct/New()
	..()
	ADD_SAVED_VAR(stage)

/obj/machinery/light_construct/Initialize()
	. = ..()
	queue_icon_update()

/obj/machinery/light/Initialize()
	var/old_lightbulb
	if(map_storage_loaded)
		old_lightbulb = lightbulb
	. = ..()
	if(map_storage_loaded)
		lightbulb = old_lightbulb

/obj/item/weapon/light/tube/party/Initialize(mapload) //Randomly colored light tubes. Mostly for testing, but maybe someone will find a use for them.
	var/old_color = b_colour
	. = ..()
	if(map_storage_loaded)
		b_colour = old_color
	queue_icon_update()

/obj/item/weapon/light/tube/large/party/Initialize(mapload) //Randomly colored light tubes. Mostly for testing, but maybe someone will find a use for them.
	var/old_color = b_colour
	. = ..()
	if(map_storage_loaded)
		b_colour = old_color
	queue_icon_update()

/obj/item/weapon/light
	mass = 0.050

/obj/item/weapon/light/New(atom/newloc, obj/machinery/light/fixture = null)
	..()
	ADD_SAVED_VAR(status)
	ADD_SAVED_VAR(switchcount)
	ADD_SAVED_VAR(rigged)

//-----------------------------------------
// Small floor light fixture
//-----------------------------------------
/obj/machinery/light/small/floor
	name = "floor light"
	desc = "A small, floor mounted lighting fixture."
	light_type = /obj/item/weapon/light/bulb
	frame_type = /obj/machinery/light_construct/small/floor
	icon_state = "floor_map"
	base_state = "floor"
	layer = BELOW_DOOR_LAYER

//-----------------------------------------
// Small floor light construct
//-----------------------------------------
/obj/machinery/light_construct/small/floor
	name = "small floor light fixture frame"
	desc = "A small floor light fixture under construction."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "floor-construct-stage1"
	anchored = TRUE
	layer = BELOW_DOOR_LAYER
	stage = 1
	fixture_type = /obj/machinery/light/small/floor
	sheets_refunded = 1

/obj/machinery/light_construct/small/on_update_icon()
	switch(stage)
		if(1) icon_state = "floor-construct-stage1"
		if(2) icon_state = "floor-construct-stage2"
		if(3) icon_state = "floor-empty"

//-----------------------------------------
// Navigation light construct
//-----------------------------------------
//Nav light fixture
/obj/machinery/light_construct/nav
	name = "small light fixture frame"
	desc = "A small light fixture under construction."
	icon = 'code/modules/persistence_modules/icons/obj/navlight_construct.dmi'
	icon_state = "nav-construct"
	anchored = TRUE
	layer = BELOW_DOOR_LAYER
	stage = 1
	fixture_type = /obj/machinery/light/navigation
	sheets_refunded = 1

/obj/machinery/light_construct/small/on_update_icon()
	icon_state = initial(icon_state) //Placeholder

/obj/item/weapon/light/bulb/green
	name = "green light bulb"
	color = "#71da02"
	b_colour = "#71da02"

/obj/item/weapon/light/bulb/blue
	name = "blue light bulb"
	color = "#0271da"
	b_colour = "#0271da"

/obj/item/weapon/light/bulb/purple
	name = "purple light bulb"
	color = "#6b02da"
	b_colour = "#6b02da"

/obj/item/weapon/light/bulb/pink
	name = "pink light bulb"
	color = "#da0271"
	b_colour = "#da0271"

/obj/item/weapon/light/bulb/yellow

	name = "yellow light bulb"
	color = "#dad702"
	b_colour = "#dad702"

/obj/item/weapon/light/bulb/orange
	name = "orange light bulb"
	color = "#da6b02"
	b_colour = "#da6b02"


/obj/item/weapon/light/tube/red
	name = "red light tube"
	color = "#da0205"
	b_colour = "#da0205"

/obj/item/weapon/light/tube/green
	name = "green light tube"
	color = "#71da02"
	b_colour = "#71da02"

/obj/item/weapon/light/tube/blue
	name = "blue light tube"
	color = "#0271da"
	b_colour = "#0271da"

/obj/item/weapon/light/tube/purple
	name = "purple light tube"
	color = "#6b02da"
	b_colour = "#6b02da"

/obj/item/weapon/light/tube/pink
	name = "pink light tube"
	color = "#da0271"
	b_colour = "#da0271"

/obj/item/weapon/light/tube/yellow
	name = "yellow light tube"
	color = "#dad702"
	b_colour = "#dad702"

/obj/item/weapon/light/tube/orange
	name = "orange light tube"
	color = "#da6b02"
	b_colour = "#da6b02"
