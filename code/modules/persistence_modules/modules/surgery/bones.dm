//
// Override to use ductape
//
#define DUCTTAPE_NEEDED_BONEGELLING 30
#define DUCTTAPE_NEEDED_POST_BONEGELLING 15

/decl/surgery_step/bone/glue/New()
	allowed_tools[/obj/item/stack/tape_roll] = 75
	. = ..()

/decl/surgery_step/bone/glue/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	. = ..()
	if(istype(tool, /obj/item/stack/tape_roll))
		var/obj/item/stack/tape_roll/thetape = tool
		thetape.use(DUCTTAPE_NEEDED_BONEGELLING)
	
/decl/surgery_step/bone/finish/New()
	allowed_tools[/obj/item/stack/tape_roll] = 75
	. = ..()

/decl/surgery_step/bone/finish/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	. = ..()
	if(istype(tool, /obj/item/stack/tape_roll))
		var/obj/item/stack/tape_roll/thetape = tool
		thetape.use(DUCTTAPE_NEEDED_POST_BONEGELLING)

#undef DUCTTAPE_NEEDED_BONEGELLING
#undef DUCTTAPE_NEEDED_POST_BONEGELLING

//
//
//