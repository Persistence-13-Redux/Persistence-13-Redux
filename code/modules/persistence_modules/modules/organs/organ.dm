//	Organs
/obj/item/organ/New()
	. = ..()
	create_initial_content()
	//Setup saved vars
	ADD_SAVED_VAR(min_broken_damage)
	ADD_SAVED_VAR(status)
	ADD_SAVED_VAR(owner)
	ADD_SAVED_VAR(dna)
	ADD_SAVED_VAR(rejecting)
	ADD_SAVED_VAR(death_time)
	ADD_SAVED_VAR(organ_tag)

//Don't save the species, because its set from the DNA on init
/obj/item/organ/should_never_save(list/L)
	L.Add("species")
	return ..(L)

/obj/item/organ/after_load()
	. = ..()
	set_dna(src.dna)
	if(BP_IS_ROBOTIC(src))
		robotize()

/obj/item/organ/Destroy()
#ifdef TESTING
	testing("Destroying [src]\ref[src]([x], [y], [z]), in \the '[loc]'\ref[loc]([loc?.x], [loc?.y], [loc?.z]), with owner: [owner? owner : "null"]\ref[owner]([owner?.x], [owner?.y], [owner?.z])!")
#endif
	species = null
	return ..()

/obj/item/organ/die()
	..()
	update_icon()

/obj/item/organ/is_preserved()
	if(istype(loc,/obj/item/organ))
		var/obj/item/organ/O = loc
		return O.is_preserved()
	else if(loc && loc.return_air())
		var/datum/gas_mixture/G = loc.return_air()
		return (G.temperature < T0C)
	else
		return (istype(loc,/obj/item/device/mmi) || istype(loc,/obj/structure/closet/body_bag/cryobag) || istype(loc,/obj/structure/closet/crate/freezer) || istype(loc,/obj/item/weapon/storage/box/freezer))

/obj/item/organ/robotize() //Being used to make robutt hearts, etc
	status = ORGAN_ROBOTIC
	update_icon()

/obj/item/organ/mechassist() //Used to add things like pacemakers, etc
	status = ORGAN_ASSISTED
	update_icon()

/obj/item/organ/removed(var/mob/living/user, var/drop_organ=1)
	if(!istype(owner) || QDELETED(owner))
		rejecting = null
		owner = null
		return
	return ..()

/obj/item/organ/proc/create_initial_content()
	matter = list(MATERIAL_PINK_GOO = w_class * 100) //Organ goo in units, updated from weight class 
