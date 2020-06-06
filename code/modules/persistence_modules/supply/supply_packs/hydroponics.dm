/decl/hierarchy/supply_pack/hydroponics/hydroponics
	contains = list(/obj/item/weapon/reagent_containers/spray/plantbgone = 4,
					/obj/item/weapon/reagent_containers/glass/bottle/ammonia = 2,
					/obj/item/weapon/material/hatchet,
					/obj/item/weapon/material/minihoe,
					/obj/item/device/scanner/plant,
					/obj/item/clothing/gloves/thick/botany,
					/obj/item/clothing/suit/apron,
					/obj/item/weapon/material/minihoe,
					/obj/item/weapon/storage/box/botanydisk,
					/obj/item/weapon/wirecutters/clippers,
					)

/decl/hierarchy/supply_pack/hydroponics/exoticseeds
	name = "Samples - Exotic seeds"
	contains = list(/obj/item/seeds/libertymycelium,
					/obj/item/seeds/reishimycelium,
					/obj/item/seeds/random = 6,
					/obj/item/seeds/kudzuseed)
	cost = 15
	containertype = /obj/structure/closet/crate/secure
	containername = "exotic seeds crate"
	access = access_xenobiology