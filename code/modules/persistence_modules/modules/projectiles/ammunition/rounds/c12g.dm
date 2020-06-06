//--------------------------------
//	12 Gauge Rounds
//--------------------------------
/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 12 gauge slug."
	icon_state = "slshell"
	spent_icon = "slshell-spent"
	caliber = CALIBER_SHOTGUN
	projectile_type = /obj/item/projectile/bullet/shotgun
	matter = list(MATERIAL_STEEL = 500, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 500)
	fall_sounds = list('sound/weapons/guns/shotgun_fall.ogg')

/obj/item/ammo_casing/shotgun/pellet
	name = "shotgun shell"
	desc = "A 12 gauge shell."
	icon_state = "gshell"
	spent_icon = "gshell-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(MATERIAL_STEEL = 400, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 500)

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun shell"
	desc = "A blank shell."
	icon_state = "blshell"
	spent_icon = "blshell-spent"
	projectile_type = /obj/item/projectile/bullet/blank
	matter = list(MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 500)

/obj/item/ammo_casing/shotgun/practice
	name = "shotgun shell"
	desc = "A practice shell."
	icon_state = "pshell"
	spent_icon = "pshell-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/practice
	matter = list(MATERIAL_STEEL = 100, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 500)

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A beanbag shell."
	icon_state = "bshell"
	spent_icon = "bshell-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list(MATERIAL_WOOD = 400, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 500)

/obj/item/ammo_casing/shotgun/rubber
	name = "rubber shell"
	desc = "A rubber ball filled shell."
	icon_state = "bshell"
	spent_icon = "bshell-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun/rubber
	matter = list(MATERIAL_STEEL = 200, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 800)

//Can stun in one hit if aimed at the head, but
//is blocked by clothing that stops tasers and is vulnerable to EMP
/obj/item/ammo_casing/shotgun/stunshell
	name = "stun shell"
	desc = "A 12 gauge taser cartridge."
	icon_state = "stunshell"
	spent_icon = "stunshell-spent"
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	leaves_residue = 0
	matter = list(MATERIAL_STEEL = 360, MATERIAL_GLASS = 720, MATERIAL_URANIUM = 50, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 500)

/obj/item/ammo_casing/shotgun/stunshell/emp_act(severity)
	if(prob(100/severity)) BB = null
	update_icon()

//Does not stun, only blinds, but has area of effect.
/obj/item/ammo_casing/shotgun/flash
	name = "flash shell"
	desc = "A chemical shell used to signal distress or provide illumination."
	icon_state = "fshell"
	spent_icon = "fshell-spent"
	projectile_type = /obj/item/projectile/energy/flash/flare
	matter = list(MATERIAL_COPPER = 500, MATERIAL_SULFUR = 500, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 500)

/obj/item/ammo_casing/shotgun/emp
	name = "haywire slug"
	desc = "A 12-gauge shotgun slug fitted with a single-use ion pulse generator."
	icon_state = "empshell"
	spent_icon = "empshell-spent"
	projectile_type  = /obj/item/projectile/ion
	matter = list(MATERIAL_STEEL = 250, MATERIAL_URANIUM = 200, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 500)

/obj/item/ammo_casing/shotgun/net
	name = "net shell"
	desc = "A net shell."
	icon_state = "netshell"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag/net
	matter = list(MATERIAL_STEEL = 200, MATERIAL_BRASS = 250, MATERIAL_PLASTIC = 1500, MATERIAL_CLOTH = 1500)
