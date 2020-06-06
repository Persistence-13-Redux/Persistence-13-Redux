/obj/map_storage_saved_vars = "density;icon_state;name;pixel_x;pixel_y;contents;dir"
/obj/after_load()
	..()
	queue_icon_update()

/obj/effect/landmark/map_data/map_storage_saved_vars = "height"

/obj/item/organ/internal/augment/active/after_load()
	. = ..()
	onInstall()

/obj/item/weapon/sample/New(var/newloc, var/atom/supplied)
	..()
	ADD_SAVED_VAR(evidence)
	ADD_SAVED_VAR(object)
/obj/item/weapon/forensics/swab/New()
	. = ..()
	ADD_SAVED_VAR(gunshot_residue_sample)
	ADD_SAVED_VAR(dna)
	ADD_SAVED_VAR(trace_dna)
	ADD_SAVED_VAR(used)

/obj/item/weapon/grenade/New()
	. = ..()
	ADD_SAVED_VAR(active)
	ADD_SAVED_VAR(det_time)
/obj/item/weapon/grenade/after_load()
	. = ..()
	if(active)
		activate(null) //that could happen

/obj/item/weapon/grenade/chem_grenade/New()
	..()
	ADD_SAVED_VAR(stage)
	ADD_SAVED_VAR(state)
	ADD_SAVED_VAR(path)
	ADD_SAVED_VAR(detonator)
	ADD_SAVED_VAR(beakers)
	ADD_SAVED_VAR(affected_area)
	
/obj/item/projectile/should_save = FALSE
