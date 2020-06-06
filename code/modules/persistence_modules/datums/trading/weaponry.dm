/datum/trader/ship/gunshop
	possible_trading_items = list(/obj/item/weapon/gun/projectile/pistol     = TRADER_ALL,
								/obj/item/weapon/gun/projectile/pistol/m1911 = TRADER_ALL,
								/obj/item/weapon/gun/projectile/pistol/sec   = TRADER_ALL,
								/obj/item/weapon/gun/projectile/pistol/sec/MK   = TRADER_ALL,
								/obj/item/weapon/gun/projectile/shotgun/pump = TRADER_SUBTYPES_ONLY,
								/obj/item/ammo_magazine                      = TRADER_SUBTYPES_ONLY,
								/obj/item/ammo_magazine/box/c762/empty       = TRADER_BLACKLIST,
								/obj/item/ammo_magazine/box/c9mm/empty       = TRADER_BLACKLIST,
								/obj/item/ammo_magazine/box/wt550/empty      = TRADER_BLACKLIST,
								/obj/item/ammo_magazine/box/c45/empty        = TRADER_BLACKLIST,
								/obj/item/ammo_magazine/box/c556/empty       = TRADER_BLACKLIST,
								/obj/item/ammo_magazine/box/c45uzi/empty     = TRADER_BLACKLIST,
								/obj/item/ammo_magazine/box/c50/empty        = TRADER_BLACKLIST,
								/obj/item/clothing/accessory/storage/holster = TRADER_ALL)

/datum/trader/dogan
	possible_trading_items = list(/obj/item/weapon/gun/projectile/pirate                = TRADER_THIS_TYPE,
								/obj/item/weapon/gun/projectile/pistol/sec/MK                  = TRADER_THIS_TYPE,
								/obj/item/weapon/gun/projectile/boltaction/heavysniper/ant         = TRADER_THIS_TYPE,
								/obj/item/weapon/gun/energy/laser/dogan                 = TRADER_THIS_TYPE,
								/obj/item/weapon/gun/projectile/automatic/machine_pistol/usi  = TRADER_THIS_TYPE,
								/obj/item/clothing/accessory/storage/holster                    = TRADER_ALL)