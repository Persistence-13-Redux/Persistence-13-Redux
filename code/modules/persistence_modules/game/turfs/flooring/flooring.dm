/decl/flooring/tiling
	apply_thermal_conductivity = 45
	apply_heat_capacity = 480

/decl/flooring/tiling/dark/mono
	icon_base = "monotile"
	//build_type = /obj/item/stack/tile/floor_dark/mono

/decl/flooring/tiling/freezer
	flags = TURF_REMOVE_CROWBAR | TURF_ACID_IMMUNE | TURF_CAN_BREAK
	apply_thermal_conductivity = 0.035
	apply_heat_capacity = 1000
	can_paint = 1

/decl/flooring/tiling/new_tile
	build_type = /obj/item/stack/tile/new_tile

/decl/flooring/tiling/new_tile/gray
	icon_base = "tile_full"
	color = COLOR_GRAY
	build_type = /obj/item/stack/tile/new_tile/gray

/decl/flooring/tiling/new_tile/old_cargo
	icon_base = "cargo_one_full"
	build_type = /obj/item/stack/tile/old_cargo

/decl/flooring/tiling/new_tile/old_cargo/gray
	icon_base = "cargo_one_full"
	color = COLOR_GRAY
	build_type = /obj/item/stack/tile/old_cargo/gray

/decl/flooring/tiling/new_tile/kafel
	build_type = /obj/item/stack/tile/kafel

/decl/flooring/wood
	apply_thermal_conductivity = 0.14
	apply_heat_capacity = 1200

/decl/flooring/wood/mahogany
	desc = "Polished mahogany planks."
/decl/flooring/wood/maple
	desc = "Polished maple planks."
/decl/flooring/wood/ebony
	desc = "Polished ebony planks."
/decl/flooring/wood/walnut
	desc = "Polished walnut planks."
/decl/flooring/wood/bamboo
	desc = "Polished bamboo planks."
/decl/flooring/wood/yew
	desc = "Polished yew planks."

/decl/flooring/reinforced/circuit
	build_type = /obj/item/stack/tile/floor_bcircuit
	build_cost = 1
	build_time = 3 SECONDS

/decl/flooring/reinforced/circuit/green
	build_type = /obj/item/stack/tile/floor_gcircuit
/decl/flooring/reinforced/circuit/red
	build_type = /obj/item/stack/tile/floor_rcircuit

/decl/flooring/reinforced/shuttle
	build_type = /obj/item/stack/tile/shuttle/blue
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK | TURF_REMOVE_WRENCH | TURF_CAN_BURN
	has_damage_range = 4
	damage_temperature = T0C+1400
	build_time = 5 SECONDS

/decl/flooring/reinforced/shuttle/blue
	build_type = /obj/item/stack/tile/shuttle/blue

/decl/flooring/reinforced/shuttle/yellow
	build_type = /obj/item/stack/tile/shuttle/yellow

/decl/flooring/reinforced/shuttle/white
	build_type = /obj/item/stack/tile/shuttle/white

/decl/flooring/reinforced/shuttle/red
	build_type = /obj/item/stack/tile/shuttle/red

/decl/flooring/reinforced/shuttle/purple
	build_type = /obj/item/stack/tile/shuttle/purple

/decl/flooring/reinforced/shuttle/darkred
	build_type = /obj/item/stack/tile/shuttle/darkred

/decl/flooring/reinforced/shuttle/black
	build_type = /obj/item/stack/tile/shuttle/black

/decl/flooring/reinforced/shuttle/plates
	icon_base = "vfloor"
	build_type = /obj/item/stack/tile/shuttle/plates

/decl/flooring/concrete
	name = "concrete"
	desc = "Good old concrete."
	icon = 'icons/turf/flooring/misc.dmi'
	icon_base = "concrete"
	build_type = /obj/item/stack/tile/concrete
	damage_temperature = T0C+1500
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BURN | TURF_CAN_BREAK
	apply_thermal_conductivity = 1.13
	apply_heat_capacity = 1000

/decl/flooring/rockvault
	name = "vault floor"
	desc = "Sturdy looking floor."
	icon = 'icons/turf/flooring/misc.dmi'
	icon_base = "rockvault"
	build_type = /obj/item/stack/tile/rockvault
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK

/decl/flooring/sandstonevault
	name = "sandstone vault floor"
	desc = "Sturdy looking floor."
	icon = 'icons/turf/flooring/misc.dmi'
	icon_base = "sandstonevault"
	build_type = /obj/item/stack/tile/sandstonevault
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK

//You can remove it, but you don't get anything from it!
//Mainly because the elevator code will respawn elevator shaft turfs as its being used
//We just want people to be able to remove the leftover tiles if an elevator is removed
/decl/flooring/elevatorshaft
	name = "elevator shaft floor"
	icon = 'icons/turf/flooring/misc.dmi'
	icon_base = "elevatorshaft"
	build_type = null///obj/item/stack/tile/elevatorshaft
	build_time = 5 SECONDS
	flags = TURF_REMOVE_WRENCH | TURF_ACID_IMMUNE