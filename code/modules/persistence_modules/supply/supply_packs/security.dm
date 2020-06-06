/decl/hierarchy/supply_pack/security/explosivearmor
	name = "Armor - Security explosive resistant suit (x2)"
	contains = list(/obj/item/clothing/head/bomb_hood/security = 2,
					/obj/item/clothing/suit/bomb_suit/security = 2,
					/obj/item/clothing/shoes/eod = 2)
	cost = 60
	containertype = /obj/structure/closet/bombclosetsecurity
	containername = "EOD closet"

//eva
/decl/hierarchy/supply_pack/security/softsuit
	name = "EVA - Security softsuit"
	contains = list(/obj/item/clothing/suit/space/softsuit/security,
					/obj/item/clothing/head/helmet/space/softsuit/security,
					/obj/item/clothing/shoes/magboots,
					/obj/item/weapon/tank/emergency/oxygen/engi)
	cost = 30
	containername = "security softsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/voidsuit
	name = "EVA - Security voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/security,
					/obj/item/clothing/head/helmet/space/void/security,
					/obj/item/clothing/shoes/magboots)
	cost = 150
	containername = "security voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/voidsuit_heavyduty
	name = "EVA - Heavy-duty security voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/security/alt,
					/obj/item/clothing/head/helmet/space/void/security/alt,
					/obj/item/clothing/shoes/magboots)
	cost = 250
	containername = "heavy-duty security voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = core_access_security_programs

//weapons
/decl/hierarchy/supply_pack/security/weapons_stunbatons
	name = "Weapons - Stun Batons (x5)"
	contains = list(/obj/item/weapon/melee/baton/loaded = 5)
	cost = 25
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "stun batons crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/weapons_flashes
	name = "Weapons - Flashes (x5)"
	contains = list(/obj/item/device/flash = 5)
	cost = 20
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "flashes crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/weapons_pepperspray
	name = "Weapons - Pepper Spray (x5)"
	contains = list(/obj/item/weapon/reagent_containers/spray/pepper = 5)
	cost = 10
	containertype = /obj/structure/closet/crate/secure/gear
	containername = "pepper spray crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/weapons_tasers
	name = "Weapons - Tasers (x5)"
	contains = list(/obj/item/weapon/gun/energy/taser = 5)
	cost = 50
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "tasers crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/weapons_detrevolver
	name = "Weapons - Detective revolvers"
	contains = list(/obj/item/weapon/gun/projectile/revolver/detective = 2)
	cost = 40
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "detective revolver crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/weapons_detcolt
	name = "Weapons - Detective handguns"
	contains = list(/obj/item/weapon/gun/projectile/pistol/m1911 = 2)
	cost = 40
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "detective handgun crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/weapons_shotguns
	name = "Weapons - Riot shotguns (x3)"
	contains = list(/obj/item/weapon/gun/projectile/shotgun/pump = 3)
	cost = 120
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "riot shotguns crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/weapons_civshotgun
	name = "Weapons - Civilian double-barreled shotgun"
	contains = list(/obj/item/weapon/gun/projectile/shotgun/doublebarrel)
	cost = 35
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "double-barreled shotgun crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/ammo762practice
	name = "Ammunition - 7.62 practice"
	contains = list(/obj/item/ammo_magazine/box/c762/practice = 8)
	cost = 8
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "\improper 7.62 practice ammunition crate"
	access = core_access_security_programs

/decl/hierarchy/supply_pack/security/holowarrants
	name = "Devices - Holowarrant projectors"
	contains = list(/obj/item/device/holowarrant = 4)
	cost = 32
	containername = "holowarrants crate"

/decl/hierarchy/supply_pack/security/portableflash
	name = "Devices - Portable flashers (x2)"
	contains = list(/obj/machinery/flasher/portable = 2)
	cost = 20
	containertype = /obj/structure/largecrate
	containername = "portable flasher crate"
	access = core_access_security_programs

//clothing
/decl/hierarchy/supply_pack/security/prisoneruniforms
	name = "Clothing - Prisoner uniforms"
	contains = list(/obj/item/clothing/under/color/orange = 4,
					/obj/item/clothing/shoes/orange = 4)
	cost = 20
	containername = "prisoner uniforms crate"
