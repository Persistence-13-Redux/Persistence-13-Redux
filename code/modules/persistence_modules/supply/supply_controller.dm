/datum/controller/subsystem/supply
	var/points_per_platinum = 5 // 5 points per sheet
	var/points_per_phoron = 5
	var/exportnum = 0
	var/list/all_exports = list()
	var/list/old_exports = list()

/datum/controller/subsystem/supply/proc/generate_initial()
	generate_export("manufacturing-basic")
	generate_export("manufacturing-advanced")
	generate_export("manufacturing-phoron")
	generate_export("manufacturing-phoron")
	generate_export(MATERIAL_PHORON)
	generate_export(MATERIAL_BSPACE_CRYSTAL)
	generate_export("xenobiology")
	generate_export("cooking")

/datum/controller/subsystem/supply/fire()

/datum/controller/subsystem/supply/proc/close_order(var/datum/export_order/export)
	var/order_type = export.order_type
	old_exports |= export
	all_exports -= export
	sleep(rand(25 MINUTES, 35 MINUTES))
	generate_export(order_type)

/datum/controller/subsystem/supply/proc/get_export_name(var/id)
	for(var/datum/export_order/export in all_exports)
		if(export.id == id)
			return export.name
	return "None"

/datum/controller/subsystem/supply/proc/fill_order(var/id, var/closet)
	for(var/datum/export_order/export in all_exports)
		if(export.id == id)
			return export.fill(closet)
	return 0

/datum/controller/subsystem/supply/proc/generate_export(var/typee = "")
	exportnum++
	var/datum/export_order/export
	switch(typee)
		// if("manufacturing-basic")
		// 	var/datum/autolathe/recipe/recipe = pick(autolathe_recipes)
		// 	var/per = rand(5,10)
		// 	if(recipe.is_stack)
		// 		export = new /datum/export_order/stack()
		// 		export.required = rand(50,150)
		// 	else
		// 		export = new()
		// 		export.required = rand(30, 50)
		// 	for(var/x in recipe.resources)
		// 		if(!x)
		// 			to_world("[recipe] had a blank resource")
		// 			continue
		// 		var/material/mat = SSmaterials.get_material_by_name(x)
		// 		if(mat)
		// 			per += round(mat.value*recipe.resources[x]/2000,0.01)
		// 	export.typepath = recipe.path
		// 	export.rate = per
		// 	export.order_type = typee
		// 	export.id = exportnum
		// 	var/obj/ob = new recipe.path()
		// 	export.parent_typepath = ob.parent_type
		// 	export.looking_name = ob.name
		// 	export.name = recipe.is_stack ? "Order for [export.required] [ob.name]\s at [export.rate] for each unit." : "Order for [export.required] [ob.name]\s at [export.rate] for each item."
		// 	all_exports |= export
		// 	return export
		if("manufacturing-advanced")
			export = new()
			var/list/possible_designs = list()
			for(var/D in subtypesof(/datum/design))
				possible_designs += new D(src)
			if(!possible_designs.len)
				return
			var/datum/design/design = pick(possible_designs)
			var/valid = 0
			var/per = rand(10,20)
			while(!valid)
				if(TECH_ESOTERIC in design.req_tech)
					design = pick(possible_designs)
				else
					var/restart = 0
					for(var/x in design.req_tech)
						if(design.req_tech[x] > 4)
							restart = 1
							design = pick(possible_designs)
					if(!restart) valid = 1
			export.required = rand(30, 70)
			for(var/x in design.materials)
				if(!x)
					to_world("[design] had a blank resource")
					continue
				var/material/mat = SSmaterials.get_material_by_name(x)
				if(mat)
					per += round(mat.value*design.materials[x]/2000,0.01)
			for(var/x in design.req_tech)
				per += design.req_tech[x]*5
			export.typepath = design.build_path
			export.rate = per
			export.order_type = typee
			export.id = exportnum
			if(design.build_path)
				var/obj/ob = new design.build_path()
				export.typepath = ob.parent_type
				export.parent_typepath = ob.parent_type
				export.name = "Order for [export.required] [ob.name]\s at [export.rate] for each item."
				all_exports |= export
				return export

		if("cooking")
			export = new()
			var/list/possible_designs = list()
			for(var/D in subtypesof(/obj/item/weapon/reagent_containers/food/snacks/variable))
				possible_designs += D
			export.required = rand(12, 32)
			var/per = rand(10,30)
			export.typepath = pick(possible_designs)
			export.rate = per
			export.order_type = typee
			export.id = exportnum
			var/obj/ob = new export.typepath()
			export.name = "Order for [export.required] [ob.name]\s at [export.rate] for each item."
			all_exports |= export
			qdel(ob)
			return export

		if("xenobiology")
			export = new /datum/export_order/static()
			export.typepath = /obj/item/slime_extract
			export.name = "Order for slime extracts of any type. Payment depends on the rarity of the extract."
			export.order_type = typee
			export.id = exportnum
			all_exports |= export
			return export

		if("material")
			export = new /datum/export_order/stack()
			var/list/possible = list(
								/obj/item/stack/material/diamond = 50,
								/obj/item/stack/material/uranium = 50,
								/obj/item/stack/material/gold = 30,
								/obj/item/stack/material/platinum = 30,
								/obj/item/stack/material/osmium = 30,
								)
			var/x = pick(possible)
			var/per = possible[x]+rand(0,5)
			export.typepath = x
			export.rate = per
			export.order_type = typee
			export.id = exportnum
			export.required = rand(50, 150)
			var/obj/ob = new x()
			export.name = "Order for [export.required] [ob.name]\s at [export.rate] for each unit."
			qdel(ob)
			all_exports |= export
			return export

		if(MATERIAL_PHORON)
			export = new /datum/export_order/stack()
			export.typepath = /obj/item/stack/material/phoron
			export.rate = rand(60,100)
			export.order_type = typee
			export.id = exportnum
			export.required = rand(300, 500)
			var/obj/ob = new export.typepath()
			export.name = "Order for [export.required] [ob.name]\s at [export.rate] for each unit."
			qdel(ob)
			all_exports |= export
			return export

		// if(MATERIAL_BSPACE_CRYSTAL)
		// 	export = new /datum/export_order/static()
		// 	export.typepath = /obj/item/bluespace_crystal
		// 	export.name = "Order for bluespace crystals. $$500 per crystal."
		// 	export.order_type = typee
		// 	export.id = exportnum
		// 	export.rate = 500
		// 	all_exports |= export
		// 	return export


		// if("manufacturing-phoron")
		// 	export = new()
		// 	var/list/possible_designs = list()
		// 	for(var/D in valid_phoron_designs)
		// 		possible_designs += new D(src)
		// 	if(!possible_designs.len)
		// 		return
		// 	var/datum/design/design = pick(possible_designs)
		// 	export.required = rand(50, 100)
		// 	var/per = rand(10,30)
		// 	for(var/x in design.materials)
		// 		if(!x)
		// 			to_world("[design] had a blank resource")
		// 			continue
		// 		var/material/mat = SSmaterials.get_material_by_name(x)
		// 		if(mat)
		// 			per += round(mat.value*design.materials[x]/2000,0.01)
		// 	for(var/x in design.req_tech)
		// 		per += design.req_tech[x]*5
		// 	export.typepath = design.build_path
		// 	export.rate = per
		// 	export.order_type = typee
		// 	export.id = exportnum
		// 	if(design.build_path)
		// 		var/obj/ob = new design.build_path()
		// 		export.typepath = ob.parent_type
		// 		export.parent_typepath = ob.parent_type
		// 		export.name = "Order for [export.required] [ob.name]\s at [export.rate] for each item."
		// 		all_exports |= export
		// 		return export
