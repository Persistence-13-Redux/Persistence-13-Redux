// /obj/var/const/MaxArmorValue = 100

// /obj
// 	//Sounds
// 	var/hitsound
// 	var/sound_destroyed	//Sound the object does when its health reaches 0

// 	//Fire
// 	var/burn_point					= -1
// 	var/burning						= FALSE

// 	//Damage handling
// 	var/health 						= null	//Current health
// 	var/maxhealth 			= 0		//Maximum health
// 	var/broken_threshold		= -1 	//If the object's health goes under this value, its considered "broken", and the broken() proc is called.
// 	var/list/armor			= null	//Resistance to damage types
// 	var/damthreshold_brute 	= 0		//Minimum amount of brute damages required to damage the object. Damages of that type below this value have no effect.
// 	var/damthreshold_burn		= 0		//Minimum amount of burn damages required to damage the object. Damages of that type below this value have no effect.
// 	var/explosion_base_damage = 5 	//The base of the severity exponent used. See ex_act for details
// 	var/emp_base_damage 		= 5 	//The base of the severity exponent used. See emp_act for details
// 	var/ThrowMissChance		= 15	//in percent, chances for things thrown at this object to miss it
// 	var/damage_flags				= 0
// 	var/damage_type 				= BRUTE

// /obj/New()
// 	..()
// 	ADD_SAVED_VAR(health)

// /obj/OneTimeInit()
// 	. = ..()
// 	health = maxhealth

// /obj/proc/damage_description(var/mob/user)
// 	if(!is_damaged())
// 		return SPAN_NOTICE("It looks fully intact.")
// 	else
// 		var/perc = health_percentage()
// 		if(perc > 75)
// 			return SPAN_NOTICE("It has a few scratches.")
// 		else if(perc > 50)
// 			return SPAN_WARNING("It looks slightly damaged.")
// 		else if(perc > 25)
// 			return SPAN_NOTICE("It looks moderately damaged.")
// 		else
// 			return SPAN_DANGER("It looks heavily damaged.")
// 	if(is_broken())
// 		return SPAN_WARNING("It seems broken.")

// /obj/examine(mob/user)
// 	. = ..()
// 	if(is_damageable())
// 		to_chat(user, damage_description(user))

// //The minimum health is not included in this.
// /obj/proc/health_percentage()
// 	if(!is_damageable())
// 		return 100
// 	if(maxhealth != 0)
// 		return health * 100 / maxhealth
// 	else
// 		return 0
// //Whether the object's health is past the broken threshold
// /obj/proc/is_broken()
// 	return health <= broken_threshold
// //Whether object can be damaged/destroyed
// /obj/proc/is_damageable()
// 	return !(obj_flags & OBJ_FLAG_NODAMAGE)
// //Returns whether the object is damaged or not
// /obj/proc/is_damaged()
// 	return  health < maxhealth

// //Returns true if the damage is over the brute or burn damage threshold
// /obj/proc/pass_damage_threshold(var/damage, var/damtype)
// 	return (damtype == BRUTE  && damage > damthreshold_brute) || \
// 		   (damtype == BURN   && damage > damthreshold_burn)

// //Return whether the entity is vulenrable to the specified damage type
// // override to change what damage will be rejected on take_damage
// /obj/proc/vulnerable_to_damtype(var/damtype)
// 	return DAMAGE_AFFECT_OBJ(damtype)

// /obj/proc/get_armor_value(var/damagetype)
// 	if(!armor)
// 		return 0
// 	ASSERT(damagetype)
// 	. = armor[damagetype]
// 	if(!.)
// 		. = 0 //Don't return null!

// //Used to calculate armor damage reduction. Returns the integer percentage of the damage absorbed
// /obj/proc/armor_absorb(var/damage, var/ap, var/damagetype)
// 	if(!damagetype)
// 		log_warning("Null damage type was passed to armor_absorb for \the [src] \ref[src] object! With damage = [damage], and ap = [ap]!")
// 		return 0
// 	if(ap >= MaxArmorValue || !armor)
// 		return 0 //bypass armor

// 	//If the damage is below our minimum thresholds, reject it all
// 	if( !pass_damage_threshold(damage, damagetype) )
// 		log_debug("[damagetype] damage of [damage](ap [ap]) blocked by damage threshold!")
// 		return MaxArmorValue

// 	for(var/dmgkey in src.armor)
// 		if(ISDAMTYPE(damagetype, dmgkey) && src.armor[dmgkey])
// 			var/resist = src.armor[dmgkey]
// 			if(ap >= resist)
// 				return 0 //bypass armor
// 			var/effective_armor = (resist - ap)/MaxArmorValue
// 			var/fullblock = (effective_armor*effective_armor)

// 			if(fullblock >= 1 || prob(fullblock * MaxArmorValue))
// 				. = MaxArmorValue
// 			else
// 				. = round(((effective_armor - fullblock)/(1 - fullblock) * MaxArmorValue), 1)
// 			log_debug("[dmgkey] armor ([resist]/[effective_armor]), blocked [.]% out of [damage]([ap] ap) damages! Fullblock [fullblock], with probability [fullblock*MaxArmorValue]%")
// 			return .

// 	return 0 //no resistance found

// //Called whenever the object is receiving damages
// // returns the amount of damages that was applied to the object
// // - armorbypass: how much armor is bypassed for the damage specified. Usually a number from 0 to 100
// // - used_weapon: A string or object reference to what caused the damage.
// /obj/proc/take_damage(var/damage = 0 as num, var/damtype = DAM_BLUNT, var/armorbypass = 0, var/used_weapon = null, var/damflags = null)
// 	if(!isnum(damage))
// 		log_warning(" obj.proc.take_damage(): damage is not a number! [damage]")
// 		return 0
// 	if(!istext(damtype))
// 		log_warning(" obj.proc.take_damage(): damtype is not a string! [damtype]")
// 		return 0
// 	if(!isnum(armorbypass))
// 		log_warning(" obj.proc.take_damage(): armorbypass is not a number! [armorbypass]")
// 		return 0
// 	if(!is_damageable() || !vulnerable_to_damtype(damtype))
// 		return 0
// 	var/resultingdmg = max(0, damage * blocked_mult(armor_absorb(damage, armorbypass, damtype)))
// 	//var/name_ref = "\The \"[src]\" (\ref[src])([x], [y], [z])"

// 	//Dispersed affect contents
// 	if(damflags & DAM_DISPERSED && resultingdmg)
// 		for(var/atom/movable/A as mob|obj in src)
// 			if(isobj(A))
// 				var/obj/O = A
// 				O.take_damage(resultingdmg, damtype, armorbypass, used_weapon)
// 			if(isliving(A))
// 				var/mob/living/M = A
// 				M.apply_damage(resultingdmg, damtype, null, damflags, used_weapon, armorbypass)

// 	rem_health(resultingdmg, damtype)
// 	. = resultingdmg
// 	//testing("[name_ref] took [resultingdmg] \"[damtype]\" damages from \"[used_weapon]\"! Before armor: [damage] damages.")
// 	return .

// //Like take damage, but meant to instantly destroy the object from an external source.
// // Call this if you want to instantly destroy something and have its damage effects, debris and etc to trigger as it would from take_damage.
// /obj/proc/kill(var/damagetype = DAM_BLUNT)
// 	if(!is_damageable())
// 		return
// 	set_health(0, damagetype)

// //Called when the health of the object goes below the broken_threshold, and while the health is higher than min_health
// /obj/proc/broken(var/damagetype, var/user)
// 	//do stuff

// //Handles checking if the object is destroyed and etc..
// // - damagetype : is the damage type that triggered the health update.
// // - user : is the attacker
// /obj/proc/update_health(var/damagetype, var/mob/user = null)
// 	if(!is_damageable())
// 		return //Assume we don't care about damages
// 	if(health <= 0)
// 		if(damagetype == BURN)
// 			melt(user)
// 		else
// 			destroyed(damagetype,user)
// 	else if(health <= broken_threshold)
// 		broken(damagetype, user)
// 	update_icon()

// //Called when the object's health reaches 0, with the last damage type that hit it
// //Differs from Destroy in that Destroy has been mostly used as a destructor more than a damage effect proc. 
// //And since we don't always want to create debris and stuff when destroying an object, its better to separate them.
// // - damagetype : is the damage type that dealt the killing blow.
// // - user : is the attacker
// /obj/proc/destroyed(var/damagetype, var/user = null)
// 	health = 0
// 	playsound(loc, sound_destroyed, vol=70, vary=1, extrarange=10, falloff=5)
// 	visible_message(SPAN_WARNING("\The [src] breaks appart!"))
// 	make_debris()
// 	qdel(src)

// //Directly sets health, without updating object state
// /obj/proc/set_health(var/newhealth, var/dtype = DAM_BLUNT)
// 	health = between(0, round(newhealth, 0.1), maxhealth) //round(max(0, min(newhealth, maxhealth)), 0.1)
// 	update_health(dtype, usr)

// //Convenience proc to handle adding health to the object
// /obj/proc/add_health(var/addhealth, var/dtype = DAM_BLUNT)
// 	set_health(addhealth + health, dtype)

// //Convenience proc to handle removing health from the object
// /obj/proc/rem_health(var/remhealth, var/dtype = DAM_BLUNT)
// 	set_health(health - remhealth, dtype)

// //Returns the damages the object took so far
// /obj/proc/get_damages()
// 	return maxhealth - health

// //
// //	- If the attack is considered damaging, damageoverride will override the default unarmed damage
// /obj/attack_hand(var/mob/living/user, var/damageoverride = null)
// 	. = ..()
// 	if(!is_damageable() || user.a_intent != I_HURT)
// 		return .

// 	var/list/verbs
// 	var/dealt_damage
// 	var/damage_type = BRUTE
// 	var/damage_flags = 0

// 	if(ishuman(user) && user.get_species())
// 		var/mob/living/carbon/human/H = user
// 		var/datum/unarmed_attack/attack = H.get_unarmed_attack(src)
// 		dealt_damage = attack.damage
// 		verbs = attack.attack_verb
// 		damage_type = attack.get_damage_type()
// 		damage_flags = attack.damage_flags()
// 	else if(isanimal(user))
// 		var/mob/living/simple_animal/A = user
// 		damage_type = A.damage_type

// 	//Handle punching the thing
// 	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
// 	attack_generic(user, damageoverride? damageoverride : dealt_damage, verbs, FALSE, damage_type, damage_flags)


// /obj/attackby(obj/item/O as obj, mob/user as mob)
// 	if(is_damageable() && user.a_intent == I_HURT && O.force > 0 && !(O.item_flags & ITEM_FLAG_NO_BLUDGEON))
// 		attack_melee(user, O)
// 		return 1
// 	return 0 //The code in atom/movable/attackby is causing more trouble than it solves.. AKA, prints messages to chat, when there's no actual damage being done

// //Handle generic hits
// /obj/attack_generic(var/mob/user, var/damage, var/attack_verb, var/wallbreaker, var/damtype = BRUTE, var/damflags = 0)
// 	if(!is_damageable())
// 		return 0
// 	add_hiddenprint(user)
// 	add_fingerprint(user)

// 	//Ideally unarmed attacks should be handled by the mobs.. But for now I guess We'll make do.
// 	var/hitsoundoverride = hitsound //So we can override the sound for special cases
// 	var/mob/living/carbon/human/H = user
// 	if(MUTATION_HULK in user.mutations)
// 		user.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!"))
// 		user.visible_message(SPAN_DANGER("[user] smashes through [src]!"))
// 	else if(H && H.species.can_shred(user))
// 		visible_message(SPAN_WARNING("[user] [pick("slashes", "swipes", "scratches")] at \the [src]!"))
// 		hitsoundoverride = 'sound/weapons/slash.ogg'
// 		damflags |= DAM_SHARP
// 	else
// 		visible_message(SPAN_DANGER("[user] [attack_verb? pick(attack_verb) : "attacks"] \the [src]!"))
// 	attack_animation(user)

// 	//When damages don't go through the damage threshold, give player feedback
// 	if(!pass_damage_threshold(damage,damtype))
// 		user.visible_message(SPAN_WARNING("[user] hit [src] without any visible effect.."))
// 		playsound(loc, hitsoundoverride, vol=30, vary=1, extrarange=2, falloff=1)
// 		return 0

// 	take_damage(damage, damtype, 0, user, damflags)
// 	playsound(loc, hitsoundoverride, vol=60, vary=1, extrarange=8, falloff=6)
// 	return 1

// //Handle weapon attacks
// /obj/proc/attack_melee(var/mob/user, var/obj/item/W)
// 	if(!is_damageable() || !istype(W))
// 		return

// 	if(!istype(W, /obj/item/weapon)) // Some objects don't have click cooldowns/attack anims
// 		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
// 		if(W.hitsound)
// 			playsound(loc, W.hitsound, vol=60, vary=1, extrarange=8, falloff=6)
// 		attack_animation(user)
// 		take_damage(W.force, W.damage_type, W.armor_penetration, W, W.damage_flags)
// 	else
// 		W.attack(src, user)

// //Called by a weapon's "afterattack" proc when an attack has succeeded. Returns blocked damage
// /obj/hit_with_weapon(obj/item/W, mob/living/user, var/effective_force)
// 	if(!pass_damage_threshold(W.force, W.damage_type))
// 		hit_deflected_by_armor(W, user)
// 		return 0
// 	take_damage(W.force, W.damage_type, armorbypass = W.armor_penetration, used_weapon = W, damflags = damage_flags)
// 	playsound(loc, hitsound, vol=40, vary=1, extrarange=4, falloff=1)
// 	return ..()

// //Called when the damage of an attack is resisted completely by the damage threshold
// /obj/proc/hit_deflected_by_armor(obj/item/W, mob/living/user)
// 	log_debug("damage deflected by damage threshold of [src]")
// 	visible_message(SPAN_WARNING("[user]'s hit wasn't enough to pierce [src]'s armor!"))
// 	playsound(loc, hitsound, vol=30, vary=1, extrarange=2, falloff=1) //ricochet sound I guess

// //Placed a "force" argument, so whenever we fix explosions so they do damages, it'll be ready
// /obj/ex_act(var/severity, var/force = 0)
// 	. = ..()
// 	if(!is_damageable())
// 		return
// 	if(!force)
// 		force = (explosion_base_damage ** (4 - severity)) //Severity is a value from 1 to 3, with 1 being the strongest. So each severity level is
// 	take_damage(force, BURN, 0, "Explosion", DAM_DISPERSED | DAM_EXPLODE)

// //Called when under effect of a emp weapon
// /obj/emp_act(var/severity, var/force = 0)
// 	. = ..()
// 	if(!is_damageable())
// 		return
// 	if(!force)
// 		force = (emp_base_damage ** (4 - severity))
// 	take_damage(force, BURN, 100, null, DAM_DISPERSED)

// //Called when shot with a projectile
// /obj/bullet_act(obj/item/projectile/P, def_zone)
// 	. = ..()
// 	if(!is_damageable())
// 		return
// 	//var/list/bdam = P.get_structure_damage()
// 	//When damages don't go through the damage threshold, give player feedback
// 	if(!pass_damage_threshold(P.force, P.damage_type))
// 		visible_message(SPAN_WARNING("\The [src] was hit by \the [P]'s [P.damage_type] with no visible effect."))
// 		playsound(loc, hitsound, vol=40, vary=1, extrarange=4, falloff=2)
// 		return 0
// 	take_damage(P.force, P.damage_type, P.penetration_modifier, P, P.damage_flags)

// //Called when the entity is touched by fire or burning
// // /obj/fire_act(var/datum/gas_mixture/air, var/exposed_temperature, var/exposed_volume)
// // 	. = ..()
// // 	if(!is_damageable() || !exposed_temperature || !air)
// // 		return

// // 	if(!burning && burn_point >= exposed_temperature)
// // 		ignite()
// // 	else if(burning && (burn_point < exposed_temperature ))
// // 		extinguish()
// // 	else
// // 		fire_consume(air, exposed_temperature, exposed_volume)

// //Called when the object touches lava turfs
// /obj/lava_act()
// 	if(!is_damageable())
// 		return
// 	. = ..() //Base proc insta delete

// //Called when the object is hit by fluid
// /obj/water_act(var/depth)
// 	. = ..()
// 	if(!is_damageable())
// 		return .
// 	//Some things can take water damage
// 	if(depth)
// 		take_damage(depth, OXY, damage_flags = DAM_DISPERSED) //Used oxy damage for now. Kinda more or less makes sense

// //Called when the object is showered by radiation
// /obj/rad_act(var/severity)
// 	. = ..()
// 	if(!is_damageable())
// 		return .
// 	//Some things can take radiation damage
// 	if(severity)
// 		take_damage(severity, IRRADIATE, damage_flags = DAM_DISPERSED)
// 		//Don't apply to object's content for now.. It would be slow as hell anyways

// //Handles being hit by a thrown atom_movable
// //	- damageoverride : if subclasses have a different damage calculation, pass the damage in this var
// /obj/hitby(atom/movable/AM as mob|obj, var/datum/thrownthing/TT, var/damageoverride = null)
// 	..()
// 	var/obj/O = AM
// 	var/mob/M = AM
// 	//Handle missing
// 	var/miss_chance = ThrowMissChance
// 	if(TT.thrower)
// 		miss_chance = max(ThrowMissChance*(TT.dist_travelled-2), 0)
// 	if(prob(miss_chance))
// 		visible_message(SPAN_NOTICE("\The [O] misses [src] narrowly!"))
// 		return 0

// 	//Handle damages
// 	var/damtype = O? O.damage_type : BRUTE
// 	var/ap = O? O.armor_penetration : 0
// 	var/throw_damage = 0
// 	if(damageoverride)
// 		throw_damage = damageoverride
// 	else
// 		throw_damage = (TT.speed / THROWFORCE_SPEED_DIVISOR) * AM.mass
// 		//Applie the respective modifiers
// 		if(M)
// 			throw_damage *= M.mob_size
// 		else if(O)
// 			throw_damage *= O.throwforce

// 	//When damages don't go through the damage threshold, give player feedback
// 	if(!pass_damage_threshold(throw_damage, damtype))
// 		visible_message(SPAN_WARNING("\The [src] was hit by \the [AM] with no visible effect."))
// 		playsound(loc, hitsound, vol=40, vary=1, extrarange=4, falloff=2)
// 		return 0
// 	take_damage(throw_damage, damtype, ap, AM, O.damage_flags)
// 	take_damage(throw_damage/4, BRUTE, 0, O, 0) //Take some impact damage

// 	src.visible_message(SPAN_WARNING("\The [src] has been hit by \the [O]."))
// 	playsound(loc, hitsound, vol=50, vary=1, extrarange=8, falloff=6)

// 	//Handle knockback
// 	if(!anchored) //No knockback if we're anchored
// 		var/momentum = TT.speed * TT.thrownthing.mass
// 		if(momentum >= THROWNOBJ_KNOCKBACK_SPEED)
// 			visible_message(SPAN_WARNING("\The [src] is sent flying from the impact!"))
// 			src.throw_at(get_edge_target_turf(src, TT.init_dir), 1, momentum)
// 	return 1

// //called when src is thrown into hit_atom
// /obj/throw_impact(var/atom/hit_atom, var/datum/thrownthing/TT)
// 	. = ..()
// 	var/throw_damage = (TT.speed / THROWFORCE_SPEED_DIVISOR) * mass
// 	if(TT.thrower)
// 		throw_damage *= TT.thrower.mob_size
// 	else
// 		throw_damage *= throwforce

// 	//Divide the damage by a random value between 1 and 4
// 	throw_damage /= rand(1, 4)

// 	//Get the right damage type
// 	var/dtype = DAM_BLUNT
// 	if(isobj(hit_atom))
// 		var/obj/O = hit_atom
// 		dtype = O.damage_type
	
// 	//Apply it
// 	take_damage(throw_damage, dtype, 0, "crashed into [hit_atom]")

// //Implementation of the object burning from being in contact with fire
// // /obj/proc/fire_consume(var/datum/gas_mixture/air, var/exposed_temperature, var/exposed_volume)
// // 	var/expvol = exposed_volume
// // 	if(!burn_point || !air)
// // 		return
// // 	if(expvol <= 0)
// // 		expvol = 1
// // 	var/fire_damage = (exposed_temperature/burn_point) * (air.volume/expvol)
// // 	take_damage(fire_damage, DAM_BURN) //might make more sense to use laser here...

// // //Called when set on fire
// // /obj/proc/ignite()
// // 	burning = TRUE

// // //Called when fire is put out
// // /obj/proc/extinguish()
// // 	burning = FALSE

// //This is called when the object is destroyed by fire
// /obj/melt(var/user = null)
// 	if(!is_damageable())
// 		return
// 	. = ..()
// 	qdel(src)

// //Called when the object is destroyed in-game and should release debris
// /obj/proc/make_debris()
// 	for(var/key in matter)
// 		var/material/M = SSmaterials.get_material_by_name(key)
// 		if(M)
// 			M.place_shard(get_turf(loc))

// //Simple quick proc for repairing things with a welder.
// /obj/proc/default_welder_repair(var/mob/user, var/obj/item/weapon/weldingtool/W, var/delay=5 SECONDS, var/repairedhealth = maxhealth)
// 	if(!istype(W))
// 		return FALSE
// 	if(!is_damaged())
// 		to_chat(user, SPAN_WARNING("\The [src] does not need repairs!"))
// 		return FALSE
// 	user.visible_message("[user] begins repairing \the [src].", "You begin repairing \the [src].")
// 	if(do_mob(user, src, delay) && W.isOn())
// 		if(!src) return
// 		to_chat(user, SPAN_NOTICE("You repaired some damage!"))
// 		add_health(repairedhealth)
// 	return TRUE

// /obj/proc/Ignite()
// /obj/proc/Extinguish()