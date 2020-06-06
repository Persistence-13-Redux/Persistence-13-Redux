/decl/hierarchy/supply_pack/medical/blood
	name = "Refills - O- blood packs"
	contains = list(/obj/item/weapon/reagent_containers/ivbag/blood/OMinus = 4)
	cost = 100
	containername = "\improper O- blood crate"

/decl/hierarchy/supply_pack/medical/surgery
	contains = list(/obj/item/weapon/cautery,
					/obj/item/weapon/surgicaldrill,
					/obj/item/clothing/mask/breath/medical,
					/obj/item/weapon/tank/anesthetic,
					/obj/item/weapon/FixOVein,
					/obj/item/weapon/hemostat,
					/obj/item/weapon/scalpel,
					/obj/item/weapon/bonegel,
					/obj/item/weapon/retractor,
					/obj/item/weapon/bonesetter,
					/obj/item/weapon/circular_saw,
					/obj/item/stack/medical/bruise_pack)

//gear
/decl/hierarchy/supply_pack/medical/medicalbiosuits
	name = "Gear - Medical bio-suit gear"
	contains = list(/obj/item/clothing/head/bio_hood = 3,
					/obj/item/clothing/suit/bio_suit = 3,
					/obj/item/clothing/head/bio_hood/virology = 2,
					/obj/item/clothing/suit/bio_suit/virology = 2,
					/obj/item/clothing/mask/gas = 5,
					/obj/item/weapon/tank/oxygen = 5)
	cost = 40
	containertype = /obj/structure/closet/crate/secure
	containername = "medical biohazard equipment crate"
	access = core_access_medical_programs

/decl/hierarchy/supply_pack/medical/belts
	name = "Gear - Medical belts"
	contains = list(/obj/item/weapon/storage/belt/medical = 3)
	cost = 16
	containername = "medical belts crate"

//clothing
/decl/hierarchy/supply_pack/medical/medicalscrubs
	name = "Clothing - Assorted medical scrubs"
	contains = list(/obj/item/clothing/shoes/white = 16,
					/obj/item/clothing/under/rank/medical/scrubs/blue = 2,
					/obj/item/clothing/under/rank/medical/scrubs/green = 2,
					/obj/item/clothing/under/rank/medical/scrubs/purple = 2,
					/obj/item/clothing/under/rank/medical/scrubs/black = 2,
					/obj/item/clothing/under/rank/medical/scrubs/navyblue = 2,
					/obj/item/clothing/under/rank/medical/scrubs/lilac = 2,
					/obj/item/clothing/under/rank/medical/scrubs/teal = 2,
					/obj/item/clothing/under/rank/medical/scrubs/heliodor = 2,
					/obj/item/clothing/head/surgery/black = 2,
					/obj/item/clothing/head/surgery/purple = 2,
					/obj/item/clothing/head/surgery/blue = 2,
					/obj/item/clothing/head/surgery/green = 2,
					/obj/item/clothing/head/surgery/navyblue = 2,
					/obj/item/clothing/head/surgery/lilac = 2,
					/obj/item/clothing/head/surgery/teal = 2,
					/obj/item/clothing/head/surgery/heliodor = 2,
					/obj/item/clothing/suit/hospital/blue = 2,
					/obj/item/clothing/suit/hospital/green = 2,
					/obj/item/clothing/suit/hospital/pink = 2,
					/obj/item/clothing/suit/surgicalapron = 2,
					/obj/item/weapon/storage/box/masks,
					/obj/item/weapon/storage/box/gloves)
	cost = 20
	containertype = /obj/structure/closet/crate/large
	containername = "medical scrubs crate"

//eva
/decl/hierarchy/supply_pack/medical/softsuit
	name = "EVA - Medical softsuit"
	contains = list(/obj/item/clothing/suit/space/softsuit/medical,
					/obj/item/clothing/head/helmet/space/softsuit/medical,
					/obj/item/clothing/shoes/magboots,
					/obj/item/weapon/tank/emergency/oxygen/engi)
	cost = 30
	containername = "medical voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = core_access_medical_programs

/decl/hierarchy/supply_pack/medical/voidsuit
	name = "EVA - Medical voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/medical,
					/obj/item/clothing/head/helmet/space/void/medical,
					/obj/item/clothing/shoes/magboots)
	cost = 100
	containername = "medical voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = core_access_medical_programs

/decl/hierarchy/supply_pack/medical/voidsuit_heavyduty
	name = "EVA - Heavy-duty medical voidsuit"
	contains = list(/obj/item/clothing/suit/space/void/medical/alt/,
					/obj/item/clothing/head/helmet/space/void/medical/alt,
					/obj/item/clothing/shoes/magboots)
	cost = 150
	containername = "heavy-duty medical voidsuit crate"
	containertype = /obj/structure/closet/crate/secure/large
	access = core_access_medical_programs

//equipment
/decl/hierarchy/supply_pack/medical/cryobag
	name = "Equipment - Stasis bag"
	contains = list(/obj/item/bodybag/cryobag = 3)
	cost = 50
	containername = "stasis bag crate"

/decl/hierarchy/supply_pack/medical/anesthetic
	name = "Equipment - Anesthetic tanks"
	contains = list(/obj/item/weapon/tank/anesthetic = 8,
					/obj/item/clothing/mask/breath/medical = 2)
	cost = 75
	containername = "anesthetic tanks crate"
