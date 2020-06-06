/obj/item/weapon/tank
	matter = list(MATERIAL_STEEL = 4000)

//We start with higher pressure in PS13
/obj/item/weapon/tank/oxygen
	starting_pressure = list(GAS_OXYGEN = 10*ONE_ATMOSPHERE)
	matter = list(MATERIAL_STEEL = 2000)

/obj/item/weapon/tank/anesthetic
	matter = list(MATERIAL_STEEL = 3000)

/obj/item/weapon/tank/air
	matter = list(MATERIAL_STEEL = 2000)

/obj/item/weapon/tank/hydrogen
	matter = list(MATERIAL_STEEL = 2500)

/obj/item/weapon/tank/emergency
	matter = list(MATERIAL_STEEL = 800)

/obj/item/weapon/tank/emergency/oxygen/engi
	matter = list(MATERIAL_STEEL = 950)

/obj/item/weapon/tank/emergency/oxygen/double
	matter = list(MATERIAL_STEEL = 1200)

/obj/item/weapon/tank/emergency/nitrogen/double
	matter = list(MATERIAL_STEEL = 1200)

/obj/item/weapon/tank/nitrogen
	matter = list(MATERIAL_STEEL = 2000)

/*
 * Phorosian Phoron
 */
/obj/item/weapon/tank/phoron
	volume = 180
	matter = list(MATERIAL_STEEL = 2500)

/obj/item/weapon/tank/phoron/phorosian
	desc = "The lifeblood of Phorosians.  Warning:  Extremely flammable, do not inhale (unless you're a Phorosian)."
	icon_state = "phoronfr"
	gauge_icon = "indicator_tank"
	distribute_pressure = ONE_ATMOSPHERE*O2STANDARD
	starting_pressure = list(GAS_PHORON = 6*ONE_ATMOSPHERE)
	volume = 180

/obj/item/weapon/tank/emergency/phoron
	name = "emergency phoron tank"
	desc = "An emergency air tank hastily painted orange and issued to Phorosian crewmembers."
	icon_state = "emergency_phoron"
	gauge_icon = "indicator_emergency"
	starting_pressure = list(GAS_PHORON = 10*ONE_ATMOSPHERE)

/*
 * Empty Tanks
 */
/obj/item/weapon/tank/oxygen/empty
	starting_pressure = null
/obj/item/weapon/tank/oxygen/yellow/empty
	starting_pressure = null
/obj/item/weapon/tank/oxygen/red/empty
	starting_pressure = null
/obj/item/weapon/tank/emergency/oxygen/empty
	starting_pressure = null
/obj/item/weapon/tank/emergency/oxygen/engi/empty
	starting_pressure = null
/obj/item/weapon/tank/emergency/oxygen/double/empty
	starting_pressure = null
/obj/item/weapon/tank/emergency/empty
	starting_pressure = null

/obj/item/weapon/tank/hydrogen/empty //fuel
	starting_pressure = null

/obj/item/weapon/tank/phoron/empty //fuel tank
	starting_pressure = null
/obj/item/weapon/tank/emergency/phoron/empty
	starting_pressure = null

/obj/item/weapon/tank/nitrogen/empty
	starting_pressure = null
/obj/item/weapon/tank/emergency/nitrogen/empty
	starting_pressure = null
/obj/item/weapon/tank/emergency/nitrogen/double/empty
	starting_pressure = null
