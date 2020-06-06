/decl/crafting_stage/material/ghetto_splint
	progress_message = "You tape the rods together"
	completion_trigger_type = /obj/item/stack/tape_roll
	stack_consume_amount = 2
	next_stages = list(
		/decl/crafting_stage/material/ghetto_splint_other_rod,
		/decl/crafting_stage/material/ghetto_splint_duct_tape,
	)

/decl/crafting_stage/material/ghetto_splint/can_begin_with(var/obj/item/stack/material/rods/R)
	if(!istype(R))
		return
	if(R.amount != 1)
		return
	return TRUE

/decl/crafting_stage/material/ghetto_splint_other_rod
	progress_message = "You add 3 more rods"
	completion_trigger_type = /obj/item/stack/material/rods
	stack_consume_amount = 3
	next_stages = list(/decl/crafting_stage/material/ghetto_splint_duct_tape)

/decl/crafting_stage/material/ghetto_splint_duct_tape
	progress_message = "You tape up the rods with 8 lengths of tape"
	completion_trigger_type = /obj/item/stack/tape_roll
	stack_consume_amount = 8
	product = /obj/item/stack/medical/splint/ghetto
