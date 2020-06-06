/obj/item/weapon/storage/belt/security/fed
	name = "federation combat belt"
	desc = "Can hold combat gear such as ammo magazines and grenades."
	icon_state = "ammobelt"
	item_state = "ammobelt"
	storage_slots = 9

/obj/item/weapon/storage/belt/security/military
	name = "parade belt"
	desc = "A striking red ammo belt, more for style than camouflage."
	icon_state = "military"
	item_state = "military"
	storage_slots = 9

/obj/item/weapon/storage/belt/security/assault
	name = "assault belt"
	desc = "A tactical assault belt."
	icon_state = "assault"
	item_state = "assault"
	storage_slots = 6

/obj/item/weapon/storage/belt/botany
	name = "botanist belt"
	desc = "Can hold various botanical supplies."
	icon_state = "botany"
	item_state = "botany"
	can_hold = list(
		/obj/item/device/scanner/plant,
		/obj/item/weapon/material/minihoe,
		/obj/item/weapon/material/hatchet,
		/obj/item/weapon/shovel,
		/obj/item/weapon/reagent_containers/glass/bottle,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/reagent_containers/glass/beaker,
		/obj/item/weapon/reagent_containers/spray,
		/obj/item/weapon/flame/lighter/zippo,
		/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/wirecutters/clippers,
		/obj/item/weapon/crowbar,
		/obj/item/device/flashlight,
		/obj/item/device/flashlight/pen,
		/obj/item/taperoll,
		/obj/item/weapon/gun/energy/floragun,
		/obj/item/weapon/grenade/chem_grenade/antiweed,
		/obj/item/seeds/
		)

/obj/item/weapon/storage/belt/janitor
	name = "janibelt"
	desc = "A belt used to hold most janitorial supplies."
	icon_state = "janibelt"
	item_state = "janibelt"
	storage_slots = 6
	can_hold = list(
		/obj/item/weapon/caution,
		/obj/item/device/lightreplacer,
		/obj/item/weapon/reagent_containers/glass/bottle,
		/obj/item/weapon/reagent_containers/syringe,
		/obj/item/weapon/reagent_containers/glass/beaker,
		/obj/item/weapon/reagent_containers/spray/cleaner,
		/obj/item/weapon/reagent_containers/glass/rag,
		/obj/item/weapon/grenade/chem_grenade/cleaner,
		/obj/item/weapon/soap,
		/obj/item/clothing/mask/gas,
		/obj/item/weapon/reagent_containers/spray,
		/obj/item/weapon/flame/lighter/zippo,
		/obj/item/weapon/storage/fancy/cigarettes,
		/obj/item/weapon/crowbar,
		/obj/item/device/flashlight,
		/obj/item/device/flashlight/pen,
		/obj/item/taperoll,
		)

/obj/item/weapon/storage/belt/janitor/large
	icon_state = "soulstonebelt"
	item_state = "soulstonebelt"

/obj/item/weapon/storage/belt/bandolier
	name = "bandolier"
	desc = "A bandolier for holding ammunition."
	icon_state = "bandolier"
	item_state = "bandolier"
	storage_slots = 8
	can_hold = list(
		/obj/item/ammo_casing/
		)

/obj/item/weapon/storage/belt/fannypack
	name = "fannypack"
	desc = "A dorky fannypack for keeping small items in."
	icon_state = "fannypack_leather"
	item_state = "fannypack_leather"
	storage_slots = null
	max_w_class = ITEM_SIZE_SMALL
	max_storage_space = ITEM_SIZE_SMALL * 4

/obj/item/weapon/storage/belt/fannypack/black
	name = "black fannypack"
	icon_state = "fannypack_black"
	item_state = "fannypack_black"

/obj/item/weapon/storage/belt/fannypack/red
	name = "red fannypack"
	icon_state = "fannypack_red"
	item_state = "fannypack_red"

/obj/item/weapon/storage/belt/fannypack/purple
	name = "purple fannypack"
	icon_state = "fannypack_purple"
	item_state = "fannypack_purple"

/obj/item/weapon/storage/belt/fannypack/blue
	name = "blue fannypack"
	icon_state = "fannypack_blue"
	item_state = "fannypack_blue"

/obj/item/weapon/storage/belt/fannypack/orange
	name = "orange fannypack"
	icon_state = "fannypack_orange"
	item_state = "fannypack_orange"

/obj/item/weapon/storage/belt/fannypack/green
	name = "green fannypack"
	icon_state = "fannypack_green"
	item_state = "fannypack_green"

/obj/item/weapon/storage/belt/fannypack/pink
	name = "pink fannypack"
	icon_state = "fannypack_pink"
	item_state = "fannypack_pink"

/obj/item/weapon/storage/belt/fannypack/cyan
	name = "cyan fannypack"
	icon_state = "fannypack_cyan"
	item_state = "fannypack_cyan"

/obj/item/weapon/storage/belt/fannypack/yellow
	name = "yellow fannypack"
	icon_state = "fannypack_yellow"
	item_state = "fannypack_yellow"

/obj/item/weapon/storage/belt/fannypack/white
	name = "white fannypack"
	icon_state = "fannypack_blanca"
	item_state = "fannypack_blanca"
//This is mixed up with the small waistpack above.
//I dont wan't to break anything so this is the blanca version.

/obj/item/weapon/storage/belt/peddler
	name = "Peddlers Belt"
	desc = "Holds things while business is conducted."
	icon_state = "lazbelt"
	item_state = "lazbelt"
	storage_slots = 6
	// If someone ever ports the lazarus injector, so sorry about this.

/obj/item/weapon/storage/belt/bluespace
	name = "Belt of Holding"
	desc = "The greatest in pants-supporting technology."
	icon_state = "holdingbelt"
	item_state = "holdingbelt"
	storage_slots = 14
	origin_tech = "bluespace=5;materials=4;engineering=4;plasmatech=5"
	can_hold = list()

/obj/item/weapon/storage/belt/utility/chief
	name = "Chief Engineer's toolbelt"
	desc = "Holds tools, looks snazzy"
	icon_state = "utility_ce"
	item_state = "utility_ce"