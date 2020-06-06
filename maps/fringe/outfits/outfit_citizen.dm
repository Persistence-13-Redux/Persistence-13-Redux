/decl/hierarchy/outfit/job/fringe/citizen
	hierarchy_type = /decl/hierarchy/outfit/job/fringe/citizen
	name = OUTFIT_JOB_NAME("Citizen")
	uniform = /obj/item/clothing/under/color/grey
	l_ear = null
	shoes = /obj/item/clothing/shoes/black
	pda_type = null
	id_type = /obj/item/weapon/card/id/civilian

/decl/hierarchy/outfit/job/fringe/citizen/psychologist
	name = OUTFIT_JOB_NAME("Psychologist")
	uniform = /obj/item/clothing/under/rank/psych/turtleneck
	shoes = /obj/item/clothing/shoes/laceup
	pda_type = /obj/item/modular_computer/pda
	l_ear = /obj/item/device/radio/headset
	id_type = /obj/item/weapon/card/id/medical

/decl/hierarchy/outfit/job/fringe/citizen/journalist
	name = OUTFIT_JOB_NAME("Journalist")
	backpack_contents = list(
			/obj/item/device/camera/tvcamera = 1,
			/obj/item/clothing/accessory/badge/press = 1
			)
	pda_type = /obj/item/modular_computer/pda
	l_ear = /obj/item/device/radio/headset

/decl/hierarchy/outfit/job/fringe/citizen/investor
	name = OUTFIT_JOB_NAME("Investor")
	pda_type = /obj/item/modular_computer/pda/cargo
	uniform = /obj/item/clothing/under/suit_jacket

/decl/hierarchy/outfit/job/fringe/citizen/entertainer
	name = OUTFIT_JOB_NAME("Entertainer")
	pda_type = null
	uniform = /obj/item/clothing/under/gentlesuit

/decl/hierarchy/outfit/job/fringe/citizen/refuge
	name = OUTFIT_JOB_NAME("Refugee")

/decl/hierarchy/outfit/job/fringe/citizen/contractor
	name = OUTFIT_JOB_NAME("Contractor")
	pda_type = /obj/item/modular_computer/pda/engineering
	l_ear = null
	head = /obj/item/clothing/head/hardhat
	uniform = /obj/item/clothing/under/rank/engineer
	shoes = /obj/item/clothing/shoes/workboots
	id_type = /obj/item/weapon/card/id/engineering
	backpack_contents = list(
			/obj/item/device/radio = 1,
			)
/decl/hierarchy/outfit/job/fringe/citizen/contractor/New()
	. = ..()
	BACKPACK_OVERRIDE_ENGINEERING

/decl/hierarchy/outfit/job/fringe/citizen/security_contractor
	name = OUTFIT_JOB_NAME("Security Contractor")
	pda_type = /obj/item/modular_computer/pda/security
	gloves = /obj/item/clothing/gloves/thick/duty
	uniform = /obj/item/clothing/under/pcrc
	suit = /obj/item/clothing/suit/storage/vest/pcrc
	shoes = /obj/item/clothing/shoes/dutyboots
	l_ear = null
	id_type = /obj/item/weapon/card/id/security
	backpack_contents = list(
			/obj/item/device/radio = 1,
			)
/decl/hierarchy/outfit/job/fringe/citizen/security_contractor/New()
	. = ..()
	BACKPACK_OVERRIDE_SECURITY

/decl/hierarchy/outfit/job/fringe/citizen/pilot
	name = OUTFIT_JOB_NAME("Pilot")
	pda_type = /obj/item/modular_computer/pda/explorer
	l_ear = /obj/item/device/radio/headset
	uniform = /obj/item/clothing/under/rank/ntpilot

/decl/hierarchy/outfit/job/fringe/citizen/miner
	name = OUTFIT_JOB_NAME("Miner")
	gloves = /obj/item/clothing/gloves/thick
	uniform = /obj/item/clothing/under/rank/miner
	l_ear = /obj/item/device/radio/headset
	shoes = /obj/item/clothing/shoes/workboots
	id_type = /obj/item/weapon/card/id/cargo/mining
	backpack_contents = list(
			/obj/item/device/radio = 1,
			)

/decl/hierarchy/outfit/job/fringe/citizen/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	pda_type = /obj/item/modular_computer/pda/science
	uniform = /obj/item/clothing/under/rank/scientist
	id_type = /obj/item/weapon/card/id/science

/decl/hierarchy/outfit/job/fringe/citizen/chef
	name = OUTFIT_JOB_NAME("Chef")
	pda_type = null
	uniform = /obj/item/clothing/under/rank/chef
	id_type = /obj/item/weapon/card/id/civilian/chef

/decl/hierarchy/outfit/job/fringe/citizen/doctor
	name = OUTFIT_JOB_NAME("Doctor")
	pda_type = /obj/item/modular_computer/pda/medical
	l_ear = /obj/item/device/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical
	id_type = /obj/item/weapon/card/id/medical
/decl/hierarchy/outfit/job/fringe/citizen/doctor/New()
	. = ..()
	BACKPACK_OVERRIDE_MEDICAL