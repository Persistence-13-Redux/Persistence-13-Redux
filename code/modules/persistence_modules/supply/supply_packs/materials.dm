// Material Sheets - Bulk!
/decl/hierarchy/supply_pack/materials/steel200
	name = "Basic Material - Steel Bulk Order - (x200)"
	contains = list(/obj/item/stack/material/steel/fifty = 4)
	cost = 90
	containername = "bulk steel order crate"

/decl/hierarchy/supply_pack/materials/glass200
	name = "Basic Material - Glass Bulk Order (x200)"
	contains = list(/obj/item/stack/material/glass/fifty = 4)
	cost = 50
	containername = "bulk glass order crate"

// Material sheets (50 - full stack)
/decl/hierarchy/supply_pack/materials/steel50
	name = "Basic Material - Steel (x50)"
	contains = list(/obj/item/stack/material/steel/fifty)
	cost = 30
	containername = "steel sheets crate"

/decl/hierarchy/supply_pack/materials/plasteel50
	cost = 80

/decl/hierarchy/supply_pack/materials/ocp50
	cost = 100

/decl/hierarchy/supply_pack/materials/plasteel10
	cost = 25

/decl/hierarchy/supply_pack/materials/ocp10
	cost = 30

/decl/hierarchy/supply_pack/materials/copper10
	name = "10 copper sheets"
	contains = list(/obj/item/stack/material/copper/ten)
	cost = 18
	containername = "copper sheets crate"

/decl/hierarchy/supply_pack/materials/phoron10
	name = "10 phoron sheets"
	contains = list(/obj/item/stack/material/phoron/ten)
	cost = 350
	containername = "phoron sheets crate"
	containertype = /obj/structure/closet/crate/secure/phoron
	access = core_access_engineering_programs

/decl/hierarchy/supply_pack/materials/gold10
	cost = 100

/decl/hierarchy/supply_pack/materials/silver10
	cost = 80

/decl/hierarchy/supply_pack/materials/uranium10
	cost = 125
	containertype = /obj/structure/closet/crate/uranium

/decl/hierarchy/supply_pack/materials/diamond10
	cost = 200


/decl/hierarchy/supply_pack/materials/cardboard50
	name = "Basic Material - Cardboard (x50)"
	contains = list(/obj/item/stack/material/cardboard/fifty)
	cost = 5
	containername = "cardboard sheets crate"
