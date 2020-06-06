/datum/stack_recipe/box/crackers
	title = "cracker box"
	result_type = /obj/item/weapon/storage/fancy/crackers/empty

/datum/stack_recipe/box/cigs
	title = "cigarette carton"
	result_type = 	/obj/item/weapon/storage/box/cigarettes
	req_amount = 4

/datum/stack_recipe/box/vials
	title = "vial box"
	result_type = /obj/item/weapon/storage/fancy/vials/empty
	req_amount = 5

// /datum/stack_recipe/storage/wall_safe_frame
// 	title = "wall safe frame"
// 	result_type = /obj/item/frame/wall_safe
// 	req_amount = 15
// 	time = 75

/datum/stack_recipe/storage/item_safe
	title = "item safe"
	result_type = /obj/structure/safe
	req_amount = 10
	time = 50
	one_per_turf = 1
	on_floor = 1

/datum/stack_recipe/storage/trash_bin
	title = "trash bin" 
	result_type = /obj/structure/closet/crate/bin
	req_amount = 5
	time = 50
	one_per_turf = 1
	on_floor = 1

/datum/stack_recipe/storage/tank_dispenser
	title = "tank dispenser" 
	result_type = /obj/structure/dispenser/empty
	req_amount = 5
	time = 25
	one_per_turf = 1
	on_floor = 1

/datum/stack_recipe/storage/filing_cabinet
	title = "filing cabinet" 
	result_type = /obj/structure/filingcabinet
	req_amount = 3
	time = 25
	one_per_turf = 1
	on_floor = 1

/datum/stack_recipe/storage/chest_drawer
	title = "chest drawer"
	result_type = /obj/structure/filingcabinet/chestdrawer
	req_amount = 3
	time = 25
	one_per_turf = 1
	on_floor = 1

// /datum/stack_recipe/storage/wall
// 	title = "wall mounted closet"
// 	result_type = /obj/item/frame/general_closet
// 	req_amount = 5
// 	time = 5 SECONDS
// 	one_per_turf = 0
// 	on_floor = 0
// /datum/stack_recipe/storage/wall/aid
// 	title = "wall mounted first aid closet"
// 	result_type = /obj/item/frame/medical_closet
// /datum/stack_recipe/storage/wall/fire
// 	title = "wall mounted fire-safety closet"
// 	result_type = /obj/item/frame/hydrant_closet
// /datum/stack_recipe/storage/wall/cargo
// 	title = "wall mounted supplies closet"
// 	result_type = /obj/item/frame/shipping_closet

// /datum/stack_recipe/storage/wall/extinguisher_cabinet
// 	title = "extinguisher cabinet"
// 	result_type = /obj/item/frame/extinguisher_cabinet

/datum/stack_recipe/storage/shipping_crate
	title = "Wooden shipping crate"
	result_type = /obj/structure/largecrate
	req_amount = 5
	time = 30
	one_per_turf = 1
	on_floor = 1
	difficulty = 0

//
//	Reagent storage
//
/datum/stack_recipe/storage/reagents
	req_amount = 10
	time = 80
	one_per_turf = 1
	on_floor = 1
	difficulty = 2

/datum/stack_recipe/storage/reagents/watertank
	title = "Water tank"
	result_type = /obj/structure/reagent_dispensers/watertank/empty

/datum/stack_recipe/storage/reagents/fueltank
	title = "Fuel tank"
	result_type = /obj/structure/reagent_dispensers/fueltank/empty
