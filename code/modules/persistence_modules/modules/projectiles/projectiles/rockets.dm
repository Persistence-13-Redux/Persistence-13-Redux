//
// High explosive
//
/obj/item/missile
	name = "40mm missile"
	icon = 'icons/obj/grenade.dmi'
	icon_state = "missile"
	throwforce = 15

/obj/item/missile/throw_impact(atom/hit_atom)
	if(primed)
		detonate(hit_atom)
		return
	return ..()

/obj/item/missile/proc/detonate(var/atom/hit_atom)
	explosion(hit_atom, devastation_range = 0, heavy_impact_range = 1, light_impact_range = 2, flash_range = 4, shaped = TRUE)
	qdel(src)

//
// Incendiary
//
/obj/item/missile/incendiary

/obj/item/missile/incendiary/detonate(var/atom/hit_atom)
	explosion(hit_atom, devastation_range = 0, heavy_impact_range = 0, light_impact_range = 3, flash_range = 6, shaped = FALSE)
	var/turf/T = get_turf(hit_atom)
	if(T)
		ignite_turf(T)
	qdel(src)

/obj/item/missile/incendiary/proc/ignite_turf(var/turf/target)
	if(is_space_turf(target))
		return
	new/obj/effect/decal/cleanable/liquid_fuel/flamethrower_fuel(target, 50, get_dir(loc,target))
	spawn(5)
		target.hotspot_expose(600,1200)