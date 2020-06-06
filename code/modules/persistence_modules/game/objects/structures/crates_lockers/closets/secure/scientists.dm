/obj/structure/closet/secure_closet/empty/scientist
	name = "scientist's locker"
	req_access = list(core_access_science_programs)
	closet_appearance = /decl/closet_appearance/secure_closet/expedition/science

/obj/structure/closet/secure_closet/empty/RD
	name = "research director's locker"
	req_access = list(core_access_science_programs)
	closet_appearance = /decl/closet_appearance/secure_closet/rd

/obj/structure/closet/secure_closet/RD/WillContain()
	. = ..()
	.[/obj/item/clothing/under/rank/research_director] = 1
	.[/obj/item/clothing/under/rank/research_director/rdalt] = 1
	.[/obj/item/clothing/under/rank/research_director/dress_rd] = 1
	.[/obj/item/clothing/under/rank/scientist/executive] = 1
	.[/obj/item/clothing/shoes/leather] = 1
	.[/obj/item/clothing/suit/storage/toggle/labcoat/rd] = 1
