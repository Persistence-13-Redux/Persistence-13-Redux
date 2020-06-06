/obj/item/stack
	var/list/materials_per_unit = list() //The materials a single unit of the stack contains. Used to calculate total material value

/obj/item/stack/Initialize()
	. = ..()
	update_material_value()
	base_state = icon_state
	queue_icon_update()

/obj/item/stack/Destroy()
	synths = null
	return ..()

//Called whenever stacked amount changes
/obj/item/stack/proc/update_material_value()
	if(matter)
		matter.Cut()
	else
		matter = list()
	for(var/key in materials_per_unit)
		matter[key] = materials_per_unit[key] * amount

/obj/item/stack/Topic(href, href_list)
	if(href_list["top"])
		list_recipes(usr) //Otherwise just draw the main screen again
	. = ..()

/obj/item/stack/use(var/used)
	if (!can_use(used))
		return 0
	if(!uses_charge)
		amount -= used
		if (amount <= 0)
			qdel(src) //should be safe to qdel immediately since if someone is still using this stack it will persist for a little while longer
		else
			update_material_value()
			update_icon()
		return 1
	else
		if(get_amount() < used)
			return 0
		for(var/i = 1 to charge_costs.len)
			var/datum/matter_synth/S = synths[i]
			S.use_charge(charge_costs[i] * used) // Doesn't need to be deleted
		update_material_value()
		update_icon()
		return 1
	return 0

/obj/item/stack/add(var/extra)
	. = ..()
	update_material_value()
	update_icon()

/obj/item/stack/transfer_to(obj/item/stack/S)
	if(!stacks_can_merge(S))
		return 0
	. = ..()
	if(. > 0 && blood_DNA)
		S.blood_DNA |= blood_DNA
	update_material_value()
	update_icon()

//Override this so that any extra steps needed in the creation of a new similar stack are handled in a simple polymorphic way, so
// you don't have to reimplement anything that constructs a new similar stack just to change the constructor call..
/obj/item/stack/proc/create_new(var/location, var/newamount)
	var/obj/item/stack/newstack = new src.type(location, newamount)
	newstack.copy_from(src)
	src.update_icon()
	return newstack

/obj/item/stack/split(var/tamount, var/force=FALSE)
	. = ..()
	if(!.)
		return .
	var/obj/item/stack/newstack = .
	if(blood_DNA)
		newstack.blood_DNA |= blood_DNA
	newstack.update_material_value()
	newstack.update_icon()
	update_material_value()
	update_icon()

/obj/item/stack/proc/set_amount(var/newamount)
	amount = max(1, min(newamount, max_amount))
	update_material_value()
	update_icon()

/obj/item/stack/add_to_stacks(mob/user, check_hands)
	var/list/stacks = list()
	if(check_hands)
		if(isstack(user.l_hand))
			stacks += user.l_hand
		if(isstack(user.r_hand))
			stacks += user.r_hand
	for (var/obj/item/stack/item in user.loc)
		if(stacks_can_merge(item))
			stacks += item
	for (var/obj/item/stack/item in stacks)
		if (item==src)
			continue
		var/transfer = transfer_to(item)
		if (transfer)
			to_chat(user, "<span class='notice'>You add a new [item.singular_name] to the stack. It now contains [item.amount] [item.singular_name]\s.</span>")
		if(!amount)
			break
	update_material_value()
	update_icon()

/obj/item/stack/proc/drop_to_stacks(var/location)
	var/list/stacks = list()
	if(!location)
		location = loc
	for (var/obj/item/stack/I in location)
		if(stacks_can_merge(I))
			stacks += I
	for (var/obj/item/stack/I in stacks)
		if (I==src)
			continue
		transfer_to(I)
		if(!amount)
			break
	if(!stacks.len)
		forceMove(location)
	update_material_value()
	update_icon()

/obj/item/stack/attackby(obj/item/W as obj, mob/user as mob)
	if (istype(W, /obj/item/stack) && stacks_can_merge(W))
		.=..()

//Override this to check if another stack can merge with this one depending on specific criteras
/obj/item/stack/proc/stacks_can_merge(var/obj/item/stack/other)
	return (src.get_amount() < src.get_max_amount() && other.get_amount() < other.get_max_amount() && src.stacktype == other.stacktype)


/obj/item/stack/list_recipes(mob/user as mob, recipes_sublist)
	if (!recipes)
		return
	if (!src || get_amount() <= 0)
		user << browse(null, "window=stack")
	user.set_machine(src) //for correct work of onclose
	var/list/recipe_list = recipes
	if (recipes_sublist && recipe_list[recipes_sublist] && istype(recipe_list[recipes_sublist], /datum/stack_recipe_list))
		var/datum/stack_recipe_list/srl = recipe_list[recipes_sublist]
		recipe_list = srl.recipes
	var/t1 = list()
	t1 += "<HTML><HEAD><title>Constructions from [src]</title></HEAD><body><TT>Amount Left: [src.get_amount()]<br>"
	for(var/i=1;i<=recipe_list.len,i++)
		var/E = recipe_list[i]
		if (isnull(E))
			t1 += "<hr>"
			continue

		if (istype(E, /datum/stack_recipe_list))
			t1+="<br>"
			var/datum/stack_recipe_list/srl = E
			t1 += "\[Sub-menu] <a href='?src=\ref[src];sublist=[i]'>[srl.title]</a>"

		if (istype(E, /datum/stack_recipe))
			var/datum/stack_recipe/R = E
			t1+="<br>"
			var/max_multiplier = round(src.get_amount() / R.req_amount)
			var/title
			var/can_build = 1
			can_build = can_build && (max_multiplier>0)
			if (R.res_amount>1)
				title+= "[R.res_amount]x [R.display_name()]\s"
			else
				title+= "[R.display_name()]"
			title+= " ([R.req_amount] [src.singular_name]\s)"
			var/skill_label = ""
			if(!user.skill_check(SKILL_CONSTRUCTION, R.difficulty))
				var/decl/hierarchy/skill/S = decls_repository.get_decl(SKILL_CONSTRUCTION)
				skill_label = "<font color='red'>\[[S.levels[R.difficulty]]]</font>"
			if (can_build)
				t1 +="[skill_label]<A href='?src=\ref[src];sublist=[recipes_sublist];make=[i];multiplier=1'>[title]</A>"
			else
				t1 += "[skill_label][title]"
			if (R.max_res_amount>1 && max_multiplier>1)
				max_multiplier = min(max_multiplier, round(R.max_res_amount/R.res_amount))
				t1 += " |"
				var/list/multipliers = list(5,10,25)
				for (var/n in multipliers)
					if (max_multiplier>=n)
						t1 += " <A href='?src=\ref[src];make=[i];multiplier=[n]'>[n*R.res_amount]x</A>"
				if (!(max_multiplier in multipliers))
					t1 += " <A href='?src=\ref[src];make=[i];multiplier=[max_multiplier]'>[max_multiplier*R.res_amount]x</A>"

	if(recipes_sublist)  //Only show in a sublist
		t1 += "<br><div><a href='?src=\ref[src];top=1'>go back</a></div>"
	t1 += "</TT></body></HTML>"
	user << browse(JOINTEXT(t1), "window=stack")
	onclose(user, "stack")