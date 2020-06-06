/decl/surgery_step/internal/fix_organ/New()
	allowed_tools[/obj/item/stack/tape_roll] = 20
	. = ..()

/decl/surgery_step/internal/detatch_organ/New()
	allowed_tools[/obj/item/weapon/material/knife] = 75
	. = ..()

/decl/surgery_step/internal/attach_organ/New()
	allowed_tools[/obj/item/stack/tape_roll] = 50
	. = ..()
	