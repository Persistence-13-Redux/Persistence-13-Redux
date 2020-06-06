/obj/machinery/computer/shuttle_control/lift/fringe/cargo_main
	name = "cargo lift controls"
	shuttle_tag = "Primary Cargo Lift"
	ui_template = "shuttle_control_console_lift.tmpl"
	icon_state = "tiny"
	icon_keyboard = "tiny_keyboard"
	icon_screen = "lift"
	density = 0

/obj/effect/shuttle_landmark/lift/fringe/cargo_top
	name = "Top Deck"
	landmark_tag = "nav_cargo_lift_top"
	base_area = /area/fringe/hangar
	base_turf = /turf/simulated/open

/obj/effect/shuttle_landmark/lift/fringe/cargo_bottom
	name = "Lower Deck"
	landmark_tag = "nav_cargo_lift_bottom"
	flags = SLANDMARK_FLAG_AUTOSET
	base_area = /area/fringe/hangar
	base_turf = /turf/simulated/floor/plating