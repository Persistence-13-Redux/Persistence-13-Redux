/datum/machine_limits
	var/cost = 0 // used when this serves as a business level datum

	var/limit_genfab = 0
	var/list/genfabs = list()
	var/limit_engfab = 0
	var/list/engfabs = list()
	var/limit_medicalfab = 0
	var/list/medicalfabs = list()
	var/limit_mechfab = 0
	var/list/mechfabs = list()
	var/limit_voidfab = 0
	var/list/voidfabs = list()
	var/limit_ataccessories = 0
	var/list/ataccessories = list()
	var/limit_atnonstandard = 0
	var/list/atnonstandards = list()
	var/limit_atstandard = 0
	var/list/atstandards = list()
	var/limit_ammofab = 0
	var/list/ammofabs = list()
	var/limit_consumerfab = 0
	var/list/consumerfabs = list()
	var/limit_servicefab = 0
	var/list/servicefabs = list()

	var/limit_drills = 0
	var/list/drills = list()

	var/limit_botany = 0
	var/list/botany = list()

	var/limit_shuttles = 0
	var/list/shuttles = list()

	var/limit_area = 0
	var/list/apcs = list()
	var/claimed_area = 0


	var/limit_tcomms = 0
	var/list/tcomms = list()



	var/limit_tech_general = 0
	var/limit_tech_engi = 0
	var/limit_tech_medical = 0
	var/limit_tech_consumer = 0
	var/limit_tech_combat = 0


	var/desc = ""


/datum/machine_limits/democracy
	limit_genfab = 5
	limit_engfab = 5
	limit_medicalfab = 5
	limit_mechfab = 5
	limit_voidfab = 5
	limit_ataccessories = 5
	limit_atnonstandard = 5
	limit_atstandard = 5
	limit_ammofab = 5
	limit_consumerfab = 5
	limit_servicefab = 5
	limit_drills = 5
	limit_botany = 10
	limit_shuttles = 10
	limit_area = 2000000 //size of the nexus at most 3z levels of 255x255
	limit_tcomms = 5
	limit_tech_general = 4
	limit_tech_engi = 4
	limit_tech_medical = 4
	limit_tech_consumer = 4
	limit_tech_combat = 4