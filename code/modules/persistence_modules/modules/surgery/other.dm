#define DUCTTAPE_NEEDED_TENDONFIX 10
#define DUCTTAPE_NEEDED_IBFIX 10
/decl/surgery_step/fix_tendon/New()
	allowed_tools[/obj/item/stack/tape_roll] = 50
	. = ..()

/decl/surgery_step/fix_tendon/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	. = ..()
	if(istype(tool, /obj/item/stack/tape_roll))
		var/obj/item/stack/tape_roll/thetape = tool
		thetape.use(DUCTTAPE_NEEDED_TENDONFIX)

/decl/surgery_step/fix_vein/New()
	allowed_tools[/obj/item/stack/tape_roll] = 50
	. = ..()

/decl/surgery_step/fix_vein/end_step(mob/living/user, mob/living/carbon/human/target, target_zone, obj/item/tool)
	. = ..()
	if(istype(tool, /obj/item/stack/tape_roll))
		var/obj/item/stack/tape_roll/thetape = tool
		thetape.use(DUCTTAPE_NEEDED_IBFIX)

#undef DUCTTAPE_NEEDED_TENDONFIX
#undef DUCTTAPE_NEEDED_IBFIX