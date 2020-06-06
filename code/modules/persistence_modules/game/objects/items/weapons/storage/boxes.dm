/obj/item/weapon/storage/box/cigarettes
	name = "cigarette carton"
	desc = "A carton of cigarettes."


/obj/item/weapon/storage/box/phoron/
	name = "Phorosian survival kit"
	desc = "A box decorated in warning colors that contains a limited supply of survival tools. The panel and purple stripe indicate this one contains Phoron."
	icon_state = "survival"
	startswith = list(/obj/item/weapon/tank/emergency/phoron = 1,
					/obj/item/weapon/reagent_containers/hypospray/autoinjector = 1,
					/obj/item/device/flashlight/flare/glowstick = 1)

/obj/item/weapon/storage/box/ammo/beanbags
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

/obj/item/weapon/storage/box/ammo/shotgunammo
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

/obj/item/weapon/storage/box/ammo/shotgunshells
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

/obj/item/weapon/storage/box/ammo/flashshells
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

/obj/item/weapon/storage/box/ammo/stunshells
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."

/obj/item/weapon/storage/box/practiceshells
	name = "box of practice shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."
	startswith = list(/obj/item/ammo_magazine/shotholder/practice = 2)

/obj/item/weapon/storage/box/ammo/sniperammo
	name = "box of 14.5mm shells"
	desc = "It has a picture of a gun and several warning symbols on the front.<br>WARNING: Live ammunition. Misuse may result in serious injury or death."
	startswith = list(/obj/item/ammo_casing/c145 = 7)

/obj/item/weapon/storage/box/ammo/sniperammo/apds
	name = "box of 14.5mm APDS shells"
	startswith = list(/obj/item/ammo_casing/c145/apds = 3)

