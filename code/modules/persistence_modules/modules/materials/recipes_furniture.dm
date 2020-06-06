/datum/stack_recipe/furniture/door
	time = 10 SECONDS
	send_material_data = TRUE
	difficulty = 3

/datum/stack_recipe/furniture/barricade
	send_material_data = TRUE
	time = 15 SECONDS
	difficulty = 0

/datum/stack_recipe/furniture/stool
	difficulty = 1

/datum/stack_recipe/furniture/door_assembly/door_assembly_keyp
	title = "Keypad Airlock"
	result_type = /obj/structure/door_assembly/door_assembly_keyp

/datum/stack_recipe/furniture/door_assembly/door_assembly_personal
	title = "Personal Airlock"
	result_type = /obj/structure/door_assembly/door_assembly_personal

/datum/stack_recipe/furniture/cheval
	title = "cheval-de-frise(spikey barricade)"
	result_type = /obj/structure/barricade/spike
	req_amount = 5
	time = 10 SECONDS
	one_per_turf = 1
	difficulty = 1

/datum/stack_recipe/furniture/wheelchair
	title = "wheelchair"
	result_type = /obj/structure/bed/chair/wheelchair
	req_amount = 20
	time = 25 SECONDS
	on_floor = 1
	one_per_turf = 1
	difficulty = 3

/datum/stack_recipe/furniture/water_cooler
	title = "Water cooler"
	result_type = /obj/structure/reagent_dispensers/water_cooler/empty
	req_amount = 10
	time = 50
	one_per_turf = 1
	on_floor = 1
