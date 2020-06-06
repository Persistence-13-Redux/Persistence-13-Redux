/datum/world_faction/business/proc/assign_hourly_objective()
	var/list/possible = list()
	possible |= module.hourly_objectives
	possible |= module.spec.hourly_objectives
	var/chose_type = pick(possible)
	hourly_objective = new chose_type()
	hourly_objective.parent = src
	hourly_assigned = world.realtime
/datum/world_faction/business/proc/assign_daily_objective()
	var/list/possible = list()
	possible |= module.daily_objectives
	possible |= module.spec.daily_objectives
	var/chose_type = pick(possible)
	daily_objective = new chose_type()
	daily_objective.parent = src
	daily_assigned = world.realtime
/datum/world_faction/business/proc/assign_weekly_objective()
	var/list/possible = list()
	possible |= module.weekly_objectives
	possible |= module.spec.weekly_objectives
	var/chose_type = pick(possible)
	weekly_objective = new chose_type()
	weekly_objective.parent = src
	weekly_assigned = world.realtime

/datum/world_faction/business/get_limits()
	rebuild_limits()
	return limits
	/**
	var/datum/machine_limits/final_limits = new()
	var/datum/machine_limits/module_limits = module.levels[module.current_level]
	var/datum/machine_limits/spec_limits = module.spec.limits

	final_limits.genfabs = module_limits.genfabs
	final_limits.engfabs = module_limits.engfabs
	final_limits.medicalfabs = module_limits.medicalfabs
	final_limits.voidfabs = module_limits.voidfabs
	final_limits.ataccessories = module_limits.ataccessories
	final_limits.atnonstandards = module_limits.atnonstandards
	final_limits.atstandards = module_limits.atstandards
	final_limits.ammofabs = module_limits.ammofabs
	final_limits.consumerfabs = module_limits.consumerfabs
	final_limits.servicefabs = module_limits.servicefabs
	final_limits.drills = module_limits.drills
	final_limits.botany = module_limits.botany
	final_limits.shuttles = module_limits.shuttles
	final_limits.apcs = module_limits.apcs
	final_limits.tcomms = module_limits.tcomms


	final_limits.limit_genfab = module_limits.limit_genfab + spec_limits.limit_genfab
	final_limits.limit_engfab = module_limits.limit_engfab + spec_limits.limit_engfab
	final_limits.limit_medicalfab = module_limits.limit_medicalfab + spec_limits.limit_medicalfab
	final_limits.limit_voidfab = module_limits.limit_voidfab + spec_limits.limit_voidfab
	final_limits.limit_ataccessories = module_limits.limit_ataccessories + spec_limits.limit_ataccessories
	final_limits.limit_atnonstandard = module_limits.limit_atnonstandard + spec_limits.limit_atnonstandard
	final_limits.limit_atstandard = module_limits.limit_atstandard + spec_limits.limit_atstandard
	final_limits.limit_ammofab = module_limits.limit_ammofab + spec_limits.limit_ammofab
	final_limits.limit_consumerfab = module_limits.limit_consumerfab + spec_limits.limit_consumerfab
	final_limits.limit_servicefab = module_limits.limit_servicefab + spec_limits.limit_servicefab
	final_limits.limit_drills = module_limits.limit_drills + spec_limits.limit_drills
	final_limits.limit_botany = module_limits.limit_botany + spec_limits.limit_botany
	final_limits.limit_shuttles = module_limits.limit_shuttles + spec_limits.limit_shuttles
	final_limits.limit_area = module_limits.limit_area + spec_limits.limit_area
	final_limits.limit_tcomms = module_limits.limit_tcomms + spec_limits.limit_tcomms
	final_limits.limit_tech_combat = min(4, module_limits.limit_tech_combat + spec_limits.limit_tech_combat)
	final_limits.limit_tech_consumer = min(4, module_limits.limit_tech_consumer + spec_limits.limit_tech_consumer)
	final_limits.limit_tech_engi = min(4, module_limits.limit_tech_engi + spec_limits.limit_tech_engi)
	final_limits.limit_tech_general = min(4, module_limits.limit_tech_general + spec_limits.limit_tech_general)
	final_limits.limit_tech_medical = min(4, module_limits.limit_tech_medical + spec_limits.limit_tech_medical)
	return final_limits
	**/

/datum/world_faction/business/rebuild_limits()
	var/datum/machine_limits/current_level = module.levels[module.current_level]
	limits.limit_genfab = module.spec.limits.limit_genfab + current_level.limit_genfab
	limits.limit_engfab = module.spec.limits.limit_engfab + current_level.limit_engfab
	limits.limit_medicalfab = module.spec.limits.limit_medicalfab + current_level.limit_medicalfab
	limits.limit_mechfab = module.spec.limits.limit_mechfab + current_level.limit_mechfab
	limits.limit_voidfab = module.spec.limits.limit_voidfab + current_level.limit_voidfab
	limits.limit_ataccessories = module.spec.limits.limit_ataccessories + current_level.limit_ataccessories
	limits.limit_atnonstandard = module.spec.limits.limit_atnonstandard + current_level.limit_atnonstandard
	limits.limit_atstandard = module.spec.limits.limit_atstandard + current_level.limit_atstandard
	limits.limit_ammofab = module.spec.limits.limit_ammofab + current_level.limit_ammofab
	limits.limit_consumerfab = module.spec.limits.limit_consumerfab + current_level.limit_consumerfab
	limits.limit_servicefab = module.spec.limits.limit_servicefab + current_level.limit_servicefab

	limits.limit_drills = module.spec.limits.limit_drills + current_level.limit_drills

	limits.limit_botany = module.spec.limits.limit_botany + current_level.limit_botany

	limits.limit_shuttles = module.spec.limits.limit_shuttles + current_level.limit_shuttles

	limits.limit_area = module.spec.limits.limit_area + current_level.limit_area + 200

	limits.limit_tcomms = module.spec.limits.limit_tcomms + current_level.limit_tcomms

	limits.limit_tech_general = module.spec.limits.limit_tech_general + current_level.limit_tech_general
	limits.limit_tech_engi = module.spec.limits.limit_tech_engi + current_level.limit_tech_engi
	limits.limit_tech_medical = module.spec.limits.limit_tech_medical + current_level.limit_tech_medical
	limits.limit_tech_consumer =  module.spec.limits.limit_tech_consumer + current_level.limit_tech_consumer
	limits.limit_tech_combat =  module.spec.limits.limit_tech_combat + current_level.limit_tech_combat


/datum/business_spec
	var/name = ""
	var/desc = ""
	var/datum/machine_limits/limits
	var/list/hourly_objectives = list()
	var/list/daily_objectives = list()
	var/list/weekly_objectives = list()
/datum/business_spec/New()
	limits = new limits()

/datum/business_module
	var/cost = 750
	var/name = ""
	var/desc = ""
	var/current_level = 1
	var/list/levels = list()
	var/datum/business_spec/spec
	var/list/specs = list()

	var/list/hourly_objectives = list()
	var/list/daily_objectives = list()
	var/list/weekly_objectives = list()

	var/list/starting_items = list()

/datum/business_module/New()
	var/list/specs_c = specs.Copy()
	specs = list()
	for(var/x in specs_c)
		specs |= new x()
	var/list/levels_c = levels.Copy()
	levels = list()
	for(var/x in levels_c)
		levels |= new x()

/datum/business_module/engineering
	cost = 1400
	name = "Engineering"
	desc = "An engineering business has tools to develop areas of the station and construct shuttles plus the unique capacity to manage private radio communications. Engineering businesses can reserve larger spaces than other businesses and develop those into residential areas to be leased to individuals."
	levels = list(/datum/machine_limits/eng/one, /datum/machine_limits/eng/two, /datum/machine_limits/eng/three, /datum/machine_limits/eng/four)
	specs = list(/datum/business_spec/eng/realestate, /datum/business_spec/eng/tcomms)
	hourly_objectives = list(/datum/module_objective/hourly/revenue, /datum/module_objective/hourly/employees, /datum/module_objective/hourly/cost, /datum/module_objective/hourly/contract)
	daily_objectives = list(/datum/module_objective/daily/revenue, /datum/module_objective/daily/employees, /datum/module_objective/daily/cost, /datum/module_objective/daily/contract)
	weekly_objectives = list(/datum/module_objective/weekly/revenue, /datum/module_objective/weekly/employees, /datum/module_objective/weekly/cost, /datum/module_objective/weekly/contract)
	starting_items = list(/obj/item/weapon/storage/toolbox/mechanical/filled = 1, /obj/item/stack/cable_coil/thirty = 1, /obj/item/weapon/stock_parts/matter_bin = 3, /obj/item/weapon/stock_parts/micro_laser = 4, /obj/item/weapon/stock_parts/console_screen = 1, /obj/item/modular_computer/pda = 1, /obj/item/weapon/stock_parts/circuitboard/fabricator/genfab = 1, /obj/item/weapon/stock_parts/circuitboard/telepad = 1, /obj/item/stack/material/steel/ten = 2, /obj/item/stack/material/glass/ten = 2, /obj/item/clothing/gloves/insulated/cheap = 2, /obj/item/weapon/storage/belt/utility/full = 2)

/datum/business_spec/eng/realestate
	name = "Real-Estate"
	desc = "With this specialization the engineering business gains another 200 tiles of area limit plus a consumer fabricator limit and two levels of consumer tech limit so that you can better furnish interiors."
	limits = /datum/machine_limits/eng/spec/realestate

/datum/business_spec/eng/tcomms
	name = "Communication & Travel"
	desc = "This specialization grants operation of three extra telecomms machines that can operate three frequencies each. It also allows for two shuttles and an extra EVA fabricator."
	limits = /datum/machine_limits/eng/spec/realestate


/datum/business_module/medical
	cost = 1200
	name = "Medical"
	desc = "A medical firm has unqiue capacity to develop medications and implants. Programs can be used to register clients under your care and recieve a weekly insurance payment from them, in exchange for tracking their health and responding to medical emergencies."
	specs = list(/datum/business_spec/medical/pharma, /datum/business_spec/medical/paramedic)
	levels = list(/datum/machine_limits/medical/one, /datum/machine_limits/medical/two, /datum/machine_limits/medical/three, /datum/machine_limits/medical/four)
	hourly_objectives = list(/datum/module_objective/hourly/visitors, /datum/module_objective/hourly/employees, /datum/module_objective/hourly/cost, /datum/module_objective/hourly/contract)
	daily_objectives = list(/datum/module_objective/daily/visitors, /datum/module_objective/daily/employees, /datum/module_objective/daily/cost, /datum/module_objective/daily/contract)
	weekly_objectives = list(/datum/module_objective/weekly/visitors, /datum/module_objective/weekly/employees, /datum/module_objective/weekly/cost, /datum/module_objective/weekly/contract)
	starting_items = list(/obj/item/weapon/storage/toolbox/mechanical/filled = 1, /obj/item/stack/cable_coil/thirty = 1, /obj/item/weapon/stock_parts/matter_bin = 3, /obj/item/weapon/stock_parts/micro_laser = 4, /obj/item/weapon/stock_parts/console_screen = 1, /obj/item/modular_computer/pda = 1, /obj/item/weapon/stock_parts/circuitboard/fabricator/genfab = 1, /obj/item/weapon/stock_parts/circuitboard/telepad = 1, /obj/item/stack/material/steel/ten = 2, /obj/item/stack/material/glass/ten = 2, /obj/item/weapon/storage/firstaid/surgery/full = 1, /obj/item/clothing/gloves/latex = 2, /obj/item/device/scanner/health = 2)

/datum/business_spec/medical/paramedic
	name = "Paramedic"
	desc = "The Paramedic specialization allows the business to operate a voidsuit fabricator and two shuttles to retrieve clients from the dangerous sectors of the Nexus outer-space."
	limits = /datum/machine_limits/medical/spec/paramedic
	hourly_objectives = list(/datum/module_objective/hourly/travel)
	daily_objectives = list(/datum/module_objective/daily/travel)
	weekly_objectives = list(/datum/module_objective/weekly/travel)

/datum/business_spec/medical/pharma
	name = "Pharmacy"
	desc = "This specialization gives the business capacity for a service fabricator and two botany trays that can produce reagents that can be further refined into valuable and effective medicines. It also grants 200 extra tiles to the area limit so you can have larger medical facilities."
	limits = /datum/machine_limits/medical/spec/pharma


/datum/business_module/retail
	cost = 1200
	name = "Retail"
	desc = "A retail business has exclusive production capacity so that they can sell clothing and furniture to individuals and organizations. With additional specialization they can branch out into combat equipment or engineering supplies, but they are reliant on the material market to supply their production."
	levels = list(/datum/machine_limits/retail/one, /datum/machine_limits/retail/two, /datum/machine_limits/retail/three, /datum/machine_limits/retail/four)
	specs = list(/datum/business_spec/retail/combat, /datum/business_spec/retail/bigstore)
	hourly_objectives = list(/datum/module_objective/hourly/visitors, /datum/module_objective/hourly/employees, /datum/module_objective/hourly/cost, /datum/module_objective/hourly/sales, /datum/module_objective/hourly/fabricate, /datum/module_objective/hourly/revenue)
	daily_objectives = list(/datum/module_objective/daily/visitors, /datum/module_objective/daily/employees, /datum/module_objective/daily/cost, /datum/module_objective/daily/sales, /datum/module_objective/daily/fabricate, /datum/module_objective/daily/revenue)
	weekly_objectives = list(/datum/module_objective/weekly/visitors, /datum/module_objective/weekly/employees, /datum/module_objective/weekly/cost, /datum/module_objective/weekly/sales, /datum/module_objective/weekly/fabricate, /datum/module_objective/weekly/revenue)
	starting_items = list(/obj/item/weapon/storage/toolbox/mechanical/filled = 1, /obj/item/stack/cable_coil/thirty = 1, /obj/item/weapon/stock_parts/matter_bin = 3, /obj/item/weapon/stock_parts/micro_laser = 4, /obj/item/weapon/stock_parts/console_screen = 1, /obj/item/modular_computer/pda = 1, /obj/item/weapon/stock_parts/circuitboard/fabricator/genfab = 1, /obj/item/weapon/stock_parts/circuitboard/telepad = 1, /obj/item/stack/material/steel/ten = 4, /obj/item/stack/material/glass/ten = 4)

/datum/business_spec/retail/combat
	name = "Combat"
	desc = "The Combat specialization gives limits for a combat fabricator and an early combat tech limit which will increase as the business network expands. You can also maintain a shuttle, but you'll need to purchase the EVA equipment elsewhere."
	limits = /datum/machine_limits/retail/spec/combat

/datum/business_spec/retail/bigstore
	name = "Grand Emporium"
	desc = "This specialization gives the business capacity for an engineering fabricator, an EVA fabricator, an engineering tech limit, plus 200 extra tiles for the area limit so that you can produce a grand emporium that sells all manner of things."
	limits = /datum/machine_limits/retail/spec/bigstore



/datum/business_module/service
	cost = 1100
	name = "Service"
	desc = "A service business has a fabricator that can produce culinary and botany equipment. A service business can serve food or drink and supply freshly grown plants for other organizations, a crucial source of cloth and biomass."
	levels = list(/datum/machine_limits/service/one, /datum/machine_limits/service/two, /datum/machine_limits/service/three, /datum/machine_limits/service/four)
	specs = list(/datum/business_spec/service/culinary, /datum/business_spec/service/farmer)
	hourly_objectives = list(/datum/module_objective/hourly/employees, /datum/module_objective/hourly/revenue, /datum/module_objective/hourly/sales, /datum/module_objective/hourly/cost)
	daily_objectives = list(/datum/module_objective/daily/employees, /datum/module_objective/daily/revenue, /datum/module_objective/daily/sales, /datum/module_objective/daily/cost)
	weekly_objectives = list(/datum/module_objective/weekly/employees, /datum/module_objective/weekly/revenue, /datum/module_objective/weekly/sales, /datum/module_objective/weekly/cost)
	starting_items = list(/obj/item/weapon/storage/toolbox/mechanical/filled = 1, /obj/item/stack/cable_coil/thirty = 1, /obj/item/weapon/stock_parts/matter_bin = 3, /obj/item/weapon/stock_parts/micro_laser = 4, /obj/item/weapon/stock_parts/console_screen = 1, /obj/item/modular_computer/pda = 1, /obj/item/weapon/stock_parts/circuitboard/fabricator/genfab = 1, /obj/item/weapon/stock_parts/circuitboard/telepad = 1, /obj/item/stack/material/steel/ten = 3, /obj/item/stack/material/glass/ten = 3, /obj/item/seeds/potatoseed = 1, /obj/item/seeds/towermycelium = 1)

/datum/business_spec/service/culinary
	name = "Culinary"
	desc = "This specialization gives 200 extra tiles to the area limit, plus an engineering fabricator and tech level so that you can put together the perfect space for your customers."
	limits = /datum/machine_limits/service/spec/culinary
	hourly_objectives = list(/datum/module_objective/hourly/visitors)
	daily_objectives = list(/datum/module_objective/daily/visitors)
	weekly_objectives = list(/datum/module_objective/weekly/visitors)


/datum/business_spec/service/farmer
	name = "Farming"
	desc = "Farming gives four additional botany trays and limits for two of the exclusive auto-tailor types, so you can process cloth into a finished product for selling. The extra botany trays can produce plants or reagents to be sold to all sorts of other businesses."
	limits = /datum/machine_limits/service/spec/farmer


/datum/business_module/mining
	cost = 1400
	name = "Mining"
	desc = "Mining companies send teams out into the hostile outer-space armed with picks, drills and a variety of other EVA equipment plus weapons and armor to defend themselves. The ores they recover can be processed and then sold on the Material Marketplace to other organizations for massive profits."
	levels = list(/datum/machine_limits/mining/one, /datum/machine_limits/mining/two, /datum/machine_limits/mining/three, /datum/machine_limits/mining/four)
	specs = list(/datum/business_spec/mining/massdrill, /datum/business_spec/mining/monsterhunter)
	hourly_objectives = list(/datum/module_objective/hourly/employees, /datum/module_objective/hourly/revenue, /datum/module_objective/hourly/sales)
	daily_objectives = list(/datum/module_objective/daily/employees, /datum/module_objective/daily/revenue, /datum/module_objective/daily/sales)
	weekly_objectives = list(/datum/module_objective/weekly/employees, /datum/module_objective/weekly/revenue, /datum/module_objective/weekly/sales)
	starting_items = list(/obj/item/weapon/storage/toolbox/mechanical/filled = 1, /obj/item/stack/cable_coil/thirty = 1, /obj/item/weapon/stock_parts/matter_bin = 3, /obj/item/weapon/stock_parts/micro_laser = 4, /obj/item/weapon/stock_parts/console_screen = 1, /obj/item/modular_computer/pda = 1, /obj/item/weapon/stock_parts/circuitboard/fabricator/genfab = 1, /obj/item/weapon/stock_parts/circuitboard/telepad = 1, /obj/item/stack/material/steel/ten = 2, /obj/item/stack/material/glass/ten = 2, /obj/item/weapon/pickaxe = 2, /obj/item/clothing/head/helmet/space/mining = 2, /obj/item/clothing/suit/space/mining = 2)



/datum/business_spec/mining/massdrill
	name = "Mass Production"
	desc = "The Mass Production specialization allows operation of two extra drills, an extra shuttle, plus an engineering fabricator and a engineering tech limit. Take multiple teams to harvest materials from the managable sectors of outer-space."
	limits = /datum/machine_limits/mining/spec/massdrill

/datum/business_spec/mining/monsterhunter
	name = "Monster Hunter"
	desc = "This specialization gives the business capacity for a medical fabricator and tech that can produce machines and equipment to keep employees alive while fighting the top tier of monsters. Travel to the outer reaches and dig for riches, let the monsters come to you."
	limits = /datum/machine_limits/mining/spec/monsterhunter
	hourly_objectives = list(/datum/module_objective/hourly/monsters)
	daily_objectives = list(/datum/module_objective/daily/monsters)
	weekly_objectives = list(/datum/module_objective/weekly/monsters)

/datum/business_module/media
	cost = 1100
	name = "Media"
	desc = "Media companies have simple production and tech capacities but exclusive access to programs that can publish books and news articles for paid redistribution. It is also much less expensive than other types, making it a good choice for generic business."
	levels = list(/datum/machine_limits/media/one, /datum/machine_limits/media/two, /datum/machine_limits/media/three, /datum/machine_limits/media/four)
	specs = list(/datum/business_spec/media/journalism, /datum/business_spec/media/bookpublishing)
	hourly_objectives = list(/datum/module_objective/hourly/employees, /datum/module_objective/hourly/revenue, /datum/module_objective/hourly/sales)
	daily_objectives = list(/datum/module_objective/daily/employees, /datum/module_objective/daily/revenue, /datum/module_objective/daily/sales)
	weekly_objectives = list(/datum/module_objective/weekly/employees, /datum/module_objective/weekly/revenue, /datum/module_objective/weekly/sales)
	starting_items = list(/obj/item/weapon/storage/toolbox/mechanical/filled = 1, /obj/item/stack/cable_coil/thirty = 1, /obj/item/weapon/stock_parts/matter_bin = 3, /obj/item/weapon/stock_parts/micro_laser = 4, /obj/item/weapon/stock_parts/console_screen = 1, /obj/item/modular_computer/pda = 1, /obj/item/weapon/stock_parts/circuitboard/fabricator/genfab = 1, /obj/item/weapon/stock_parts/circuitboard/telepad = 1, /obj/item/stack/material/steel/ten = 2, /obj/item/stack/material/glass/ten = 2, /obj/item/device/camera = 2, /obj/item/weapon/paper_bin = 1, /obj/item/weapon/pen = 2)


/datum/business_spec/media/journalism
	name = "Journalism"
	desc = "Specializing in Journalism gives capacity for an EVA fabricator and shuttle, plus a medical fabricator with basic medical tech limitation. Explore every corner of Nexus-space, but best to carry basic medical supplies."
	limits = /datum/machine_limits/media/spec/journalism
	hourly_objectives = list(/datum/module_objective/hourly/publish_article)
	daily_objectives = list(/datum/module_objective/daily/article_viewers)
	weekly_objectives = list(/datum/module_objective/weekly/article_viewers)



/datum/business_spec/media/bookpublishing
	name = "Publishing"
	desc = "The Publishing specialization grants 200 extra tiles to the area limit and an engineering fabricator and tech limit. You can build a proper library and publishing house, or perhaps some other artistic facility."
	limits = /datum/machine_limits/media/spec/bookpublishing
	hourly_objectives = list(/datum/module_objective/hourly/publish_book)
	daily_objectives = list(/datum/module_objective/daily/publish_book)
	weekly_objectives = list(/datum/module_objective/weekly/publish_book)



/datum/business_module/science
	cost = 1200
	name = "Science"
	desc = "Science businesses produce unique products through xenobiology, xenobotany, robotics and learn the mysteries of the frontier through archeology and anomaly research."
	levels = list(/datum/machine_limits/science/one, /datum/machine_limits/science/two, /datum/machine_limits/science/three, /datum/machine_limits/science/four)
	specs = list(/datum/business_spec/science/practical, /datum/business_spec/science/theory)
	hourly_objectives = list(/datum/module_objective/hourly/employees, /datum/module_objective/hourly/revenue, /datum/module_objective/hourly/sales)
	daily_objectives = list(/datum/module_objective/daily/employees, /datum/module_objective/daily/revenue, /datum/module_objective/daily/sales)
	weekly_objectives = list(/datum/module_objective/weekly/employees, /datum/module_objective/weekly/revenue, /datum/module_objective/weekly/sales)
	starting_items = list(/obj/item/weapon/storage/toolbox/mechanical/filled = 1, /obj/item/stack/cable_coil/thirty = 1, /obj/item/weapon/stock_parts/matter_bin = 3, /obj/item/weapon/stock_parts/micro_laser = 4, /obj/item/weapon/stock_parts/console_screen = 1, /obj/item/modular_computer/pda = 1, /obj/item/weapon/stock_parts/circuitboard/fabricator/genfab = 1, /obj/item/weapon/stock_parts/circuitboard/telepad = 1, /obj/item/stack/material/steel/ten = 2, /obj/item/stack/material/glass/ten = 2, /obj/item/slime_extract/grey = 2)


/datum/business_spec/science/practical
	name = "Practical Application"
	desc = "Specializing in the practical application of science gives fabricators for medical, robotics and service allowing for all sorts of practical science production. Lacking a shuttle, you may be reliant on other businesses to get around the frontier."
	limits = /datum/machine_limits/science/spec/practical


/datum/business_spec/science/theory
	name = "Theory & Research"
	desc = "The theory specialization has a unique mandate to learn about the artifacts and anomolies found in the frontier. With limited manufacturing capabilities, your business will use its extra shuttle and basic fabricators to explore the frontier."
	limits = /datum/machine_limits/science/spec/theory


/datum/business_module/social
	cost = 1100
	name = "Social"
	desc = "Social companies have simple production and tech capacities but exclusive access to programs and objectives that track voluntary membership, so that mass-emails can be sent and events can be planned for the members."
	levels = list(/datum/machine_limits/social/one, /datum/machine_limits/social/two, /datum/machine_limits/social/three, /datum/machine_limits/social/four)
	specs = list(/datum/business_spec/social/religion, /datum/business_spec/social/club)
	hourly_objectives = list(/datum/module_objective/hourly/employees, /datum/module_objective/hourly/revenue, /datum/module_objective/hourly/sales)
	daily_objectives = list(/datum/module_objective/daily/employees, /datum/module_objective/daily/revenue, /datum/module_objective/daily/sales)
	weekly_objectives = list(/datum/module_objective/weekly/employees, /datum/module_objective/weekly/revenue, /datum/module_objective/weekly/sales)
	starting_items = list(/obj/item/weapon/storage/toolbox/mechanical/filled = 1, /obj/item/stack/cable_coil/thirty = 1, /obj/item/weapon/stock_parts/matter_bin = 3, /obj/item/weapon/stock_parts/micro_laser = 4, /obj/item/weapon/stock_parts/console_screen = 1, /obj/item/modular_computer/pda = 1, /obj/item/weapon/stock_parts/circuitboard/fabricator/genfab = 1, /obj/item/weapon/stock_parts/circuitboard/telepad = 1, /obj/item/stack/material/steel/ten = 2, /obj/item/stack/material/glass/ten = 2, /obj/item/device/camera = 2, /obj/item/weapon/paper_bin = 1, /obj/item/weapon/pen = 2)


/datum/business_spec/social/religion
	name = "Religion"
	desc = "The Religion specialization presumes this organization will represent a religion. You can hold plan and hold events using the mass-email and scheduling systems for your congregation. You have access to the costume fabricator to make religious clothing."
	limits = /datum/machine_limits/social/spec/religion

/datum/business_spec/social/club
	name = "Club"
	desc = "The club specialization is for organizations like political parties, artists guilds or other social groups. Use the unique programs to plan and hold events. You have access to an accessory fabricator to make unique accoutrements for your members."
	limits = /datum/machine_limits/social/spec/club