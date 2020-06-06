//---------------------------------------------------
//	.22lr Bullet (~277 J)(31gr)
//---------------------------------------------------
/obj/item/projectile/bullet/pistol/c22lr
	force = 20
	armor_penetration = 2
	penetration_modifier = 0.5
	distance_falloff = 5
/obj/item/projectile/bullet/pistol/c22lr/practice
	force = 2
	armor_penetration = 1
	penetration_modifier = 0.1

//---------------------------------------------------
//	.38 Bullet (~451 J)(.38 special(158 gr)
//---------------------------------------------------
//Can be fired from .357 cal weapons too
/obj/item/projectile/bullet/pistol/c38
	force = 25
	penetration_modifier = 0.8
	armor_penetration = 12
	distance_falloff = 3
/obj/item/projectile/bullet/pistol/c38/practice
	force = 2
	armor_penetration = 1
	penetration_modifier = 0.1

//---------------------------------------------------
//	9mm Bullet (~617 J)(115gr)
//---------------------------------------------------
/obj/item/projectile/bullet/pistol/c9mm
	force = 28 //9mm, .38, etc
	armor_penetration = 13.5
	penetration_modifier = 0.8
	distance_falloff = 3
/obj/item/projectile/bullet/rubber/c9mm
	distance_falloff = 4
/obj/item/projectile/bullet/pistol/c9mm/practice
	force = 4
	armor_penetration = 1
	penetration_modifier = 0.1

/obj/item/projectile/bullet/smg/c9mm //SMGs gotta be nerfed a bit since they fire quickly
	force = 10
	armor_penetration = 10
	penetration_modifier = 0.6
	distance_falloff = 4

//---------------------------------------------------
//	.45 Bullet (~796 J)
//---------------------------------------------------
/obj/item/projectile/bullet/pistol/c45
	force =  32//.45
	armor_penetration = 14.5
	penetration_modifier = 1.2
	distance_falloff = 4
/obj/item/projectile/bullet/rubber/c45
	distance_falloff = 6
/obj/item/projectile/bullet/pistol/c45/practice
	force = 4
	armor_penetration = 1
	penetration_modifier = 0.1


/obj/item/projectile/bullet/smg/c45 //SMGs gotta be nerfed a bit since they fire quickly
	force = 12
	armor_penetration = 12
	penetration_modifier = 1.2
	distance_falloff = 4

//---------------------------------------------------
//	.357 Bullet (~866 J)
//---------------------------------------------------
/obj/item/projectile/bullet/pistol/c357
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	force = 35
	penetration_modifier = 0.8
	armor_penetration = 16

//---------------------------------------------------
//	5.56mm Rifle Bullet (~1,709 J)(M855 (62gr))
//---------------------------------------------------
/obj/item/projectile/bullet/rifle/c556
	fire_sound = 'sound/weapons/gunshot/gunshot3.ogg'
	force = 40
	armor_penetration = 25
	penetration_modifier = 1.5
	penetrating = 1
	distance_falloff = 1.5
	mass = 0.004
/obj/item/projectile/bullet/rifle/c556/practice
	force = 5
	armor_penetration = 1
	penetration_modifier = 0.1

//---------------------------------------------------
//	.44 Bullet (~2,078 J)
//---------------------------------------------------
/obj/item/projectile/bullet/pistol/c44
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	force = 40 //.44 magnum or something
	armor_penetration = 25
	penetration_modifier = 1.0
	distance_falloff = 2.5
/obj/item/projectile/bullet/pistol/c44/practice
	force = 5
	armor_penetration = 1
	penetration_modifier = 0.1

//---------------------------------------------------
//	.50 Bullet (~2,200 J) (300gr)
//---------------------------------------------------
/obj/item/projectile/bullet/pistol/c50 
	fire_sound = 'sound/weapons/gunshot/gunshot_strong.ogg'
	force = 50 //.50AE
	armor_penetration = 30
	penetration_modifier = 1.8
	distance_falloff = 2.5
/obj/item/projectile/bullet/pistol/c50/practice
	force = 5
	armor_penetration = 1
	penetration_modifier = 0.1

//---------------------------------------------------
//	.50 Bullet Revolver (~2,200 J) (300gr)
//---------------------------------------------------
/obj/item/projectile/bullet/revolver/c50 //revolvers
	force = 60 //Revolvers get snowflake bullets, to keep them relevant
	armor_penetration = 30
	penetration_modifier = 1.8
	distance_falloff = 2.5

//---------------------------------------------------
//	7.62mm Rifle Bullet (~3,275 J) (M80 (144gr))
//---------------------------------------------------
/obj/item/projectile/bullet/rifle/c762
	fire_sound = 'sound/weapons/gunshot/gunshot2.ogg'
	force = 50
	armor_penetration = 30
	penetration_modifier = 1.8
	distance_falloff = 2
	mass = 0.009
/obj/item/projectile/bullet/rifle/c762/practice
	force = 6
	armor_penetration = 1
	penetration_modifier = 0.1

//---------------------------------------------------
//	14.5mm Rifle Bullet (~32,200 J) (994gr)
//---------------------------------------------------
/obj/item/projectile/bullet/rifle/c145
	fire_sound = 'sound/weapons/gunshot/sniper.ogg'
	force = 95
	weaken = 2
	penetrating = 5
	armor_penetration = 80
	hitscan = 1 //so the PTR isn't useless as a sniper weapon
	penetration_modifier = 1.25
	distance_falloff = 0.5
	mass = 0.0665

//---------------------------------------------------
//	14.5mm Rifle Armor Piercing Discarding Sabot
//---------------------------------------------------
/obj/item/projectile/bullet/rifle/c145/apds
	force = 70
	penetrating = 6
	armor_penetration = 95
	penetration_modifier = 1.5 //Internal damage, nothing to do with penetration..
	distance_falloff = 0.25
	mass = 0.0665

//---------------------------------------------------
//	12 Gauge Slug
//---------------------------------------------------
/obj/item/projectile/bullet/shotgun
	name = "slug"
	fire_sound = 'sound/weapons/gunshot/shotgun.ogg'
	force = 65
	penetrating = 1
	armor_penetration = 10
	penetration_modifier = 1.5
	distance_falloff = 4
	mass = 0.008

//---------------------------------------------------
//	12 Gauge BeanBag
//---------------------------------------------------
/obj/item/projectile/bullet/shotgun/beanbag		//because beanbags are not bullets
	name = "beanbag"
	force = 5
	damage_type = PAIN
	agony = 60
	embed = 0
	penetration_modifier = 0.1
	armor_penetration = 0
	distance_falloff = 6
	sharp = 0
	mass = 0.008

//---------------------------------------------------
//	12 Gauge Pellets
//---------------------------------------------------
//Should do about 80 damage at 1 tile distance (adjacent), and 50 damage at 3 tiles distance.
//Overall less damage than slugs in exchange for more damage at very close range and more embedding
/obj/item/projectile/bullet/pellet/shotgun
	name = "shrapnel"
	fire_sound = 'sound/weapons/gunshot/shotgun.ogg'
	force = 30
	pellets = 6
	range_step = 1
	spread_step = 10
	damage_type = DAM_BULLET
	distance_falloff = 4
	penetration_modifier = 0.4
	mass = 0.004

//---------------------------------------------------
//	12 Gauge Rubber Balls
//---------------------------------------------------
/obj/item/projectile/bullet/pellet/shotgun/rubber
	name = "rubber ball"
	damage_type = PAIN
	force = 10
	agony = 70
	embed = 0
	sharp = 0
	range_step = 1
	spread_step = 12
	base_spread = 80
	distance_falloff = 6
	penetration_modifier = 0.1
	mass = 0.008

//---------------------------------------------------
//	12 Gauge Beanbag Net
//---------------------------------------------------
/obj/item/projectile/bullet/shotgun/beanbag/net
	name = "netshell"
	force = 5
	agony = 10

/obj/item/projectile/bullet/shotgun/beanbag/net/on_hit(var/atom/target, var/blocked = 0, var/def_zone = null)
	var/obj/item/weapon/energy_net/safari/net = new(loc)
	net.throw_impact(target)
	return TRUE

//---------------------------------------------------
//	4mm Flechette
//---------------------------------------------------
//4mm. Tiny, very low damage, does not embed, but has very high penetration. Only to be used for the experimental SMG.
/obj/item/projectile/bullet/flechette
	fire_sound = 'sound/weapons/gunshot/gunshot_4mm.ogg'
	force = 23
	penetrating = 1
	penetration_modifier = 0.3
	armor_penetration = 70
	embed = 0
	distance_falloff = 2
	mass = 0.001
