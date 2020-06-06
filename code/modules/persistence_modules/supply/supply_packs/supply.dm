/decl/hierarchy/supply_pack/supply/paper
	name = "Refills - Paper"
	contains = list(/obj/item/weapon/paper_package)
	cost = 4
	containertype = /obj/structure/closet/crate/paper_refill
	containername = "paper refill crate"

/decl/hierarchy/supply_pack/supply/duct_tape_crate
	name = "Refills - Duct tape"
	contains = list(/obj/item/stack/tape_roll = 10)
	cost = 5
	containername = "duct tape crate"

//misc
/decl/hierarchy/supply_pack/supply/glowsticks
	name = "Misc - Glowsticks (x20)"
	contains = list(/obj/item/device/flashlight/flare/glowstick,
					/obj/item/device/flashlight/flare/glowstick/red,
					/obj/item/device/flashlight/flare/glowstick/yellow,
					/obj/item/device/flashlight/flare/glowstick/orange,
					/obj/item/device/flashlight/flare/glowstick/blue)
	cost = 2
	containername = "glowstick crate"
	num_contained = 20
	supply_method = /decl/supply_method/randomized

/decl/hierarchy/supply_pack/supply/colortubes
	name = "Misc - Colored light tubes"
	contains = list(/obj/item/weapon/light/tube/red = 3,
					/obj/item/weapon/light/tube/green = 3,
					/obj/item/weapon/light/tube/blue = 3,
					/obj/item/weapon/light/tube/purple = 3,
					/obj/item/weapon/light/tube/pink = 3,
					/obj/item/weapon/light/tube/yellow = 3,
					/obj/item/weapon/light/tube/orange = 3)
	cost = 4
	containername = "colored light tube crate"

/decl/hierarchy/supply_pack/supply/colorbulbs
	name = "Misc - Colored light bulbs"
	contains = list(/obj/item/weapon/light/bulb/red = 4,
					/obj/item/weapon/light/bulb/green = 4,
					/obj/item/weapon/light/bulb/blue = 4,
					/obj/item/weapon/light/bulb/purple = 4,
					/obj/item/weapon/light/bulb/pink = 4,
					/obj/item/weapon/light/bulb/yellow = 4,
					/obj/item/weapon/light/bulb/orange = 4)
	cost = 4
	containername = "colored light bulb crate"

//high-risk
/decl/hierarchy/supply_pack/supply/blueprints
	name = "High-risk - Blueprints"
	contains = list(/obj/item/blueprints)
	cost = 150
	containertype = /obj/structure/closet/crate/secure
	containername = "blueprints crate"
	access = core_access_leader

