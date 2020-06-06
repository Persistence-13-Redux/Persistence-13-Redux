/datum/module_objective
	var/name = "Objective name"
	var/payout = 0 // how much to pay upon completion
	var/research_payout = 0 // ho many research points to award

	var/filled = 0 // how much has been provided of whatever is required
	var/required = 10 // How much of whatever is required to fill the objective

	var/completed = 0 // is the objective completed

	var/list/unique_characters = list() // a list of unique characters for objective tracking
	var/list/unique_factions = list() // a list of unique factions for objective tracking

	var/datum/world_faction/business/parent


/datum/module_objective/proc/check_completion()
	if(completed) return 1
	if(filled >= required)
		completed = 1
		if(parent)
			parent.central_account.deposit(payout, "Nexus Economic Stimulus", "Nexus Economic Module")
			parent.research.points += research_payout
		return 1

/datum/module_objective/proc/get_status()
	if(completed)
		return "Objective Complete. [payout]$$ and [research_payout] tech has been awarded to the business."
	else
		return "[filled] out of [required] complete."

/datum/module_objective/hourly // these are for every 2 hours
	payout = 250
	research_payout = 100


/datum/module_objective/hourly/visitors
	name = "Have 7 people visit an area controlled by your business and remain for long enough to be counted."
	required = 7

/datum/module_objective/hourly/visitors/check_completion() // special cod to handle vistors compltion
	if(parent) // parent is faction objective is assigned to
		for(var/obj/machinery/power/apc/apc in parent.limits.apcs) // parent.limits.apcs is a list of all apcs connected to the faction, iterate through them
			var/area/A = apc.area // area the apc represents
			if(A)
				for(var/mob/living/carbon/M in A) // all valid mobs (laces and humans) in the area
					if(M.key && !(M.real_name in unique_characters)) // the mob must have a key (a player active) and not be in the unique_characters list
						unique_characters |= M.real_name // add them to list to prevent duplicates
						filled++ // add to filled
	..()


/datum/module_objective/hourly/revenue
	name = "Earn 350$$ in revenue from any source by providing a useful function in the economy."
	required = 350

/datum/module_objective/hourly/employees
	name = "Have 3 employees get paid for productively working."
	required = 3

/datum/module_objective/hourly/cost
	name = "Spend 300$$ out of the business account for useful goods and services."
	required = 300

/datum/module_objective/hourly/sales
	name = "Have 4 people or businesses pay us through an invoice."
	required = 4

/datum/module_objective/hourly/monsters
	name = "Have clocked in employees kill 5 wilderness creatures."
	required = 5

/datum/module_objective/hourly/travel
	name = "Have clocked in employees travel to 2 different wilderness sectors and remain long enough to be counted."
	required = 2

/datum/module_objective/hourly/travel/check_completion()
	// if(parent)
	// 	for(var/obj/item/organ/internal/stack/stack in parent.connected_laces)
	// 		var/mob/M = stack.get_owner()
	// 		if(M && M.z > 3 && !("[M.z]" in unique_factions))
	// 			unique_factions |= "[M.z]"
	// 			filled++
	// return ..()

/datum/module_objective/hourly/publish_article
	name = "Publish a quality article in the news feed."
	required = 1

/datum/module_objective/hourly/publish_book
	name = "Add a new book to the library database."
	required = 1

/datum/module_objective/hourly/contract
	name = "Have an individual or organization sign a new contract with us."
	required = 1

/datum/module_objective/hourly/fabricate
	name = "Fabricate 15 items to sell or help us conduct business."
	required = 15


/datum/module_objective/daily
	payout = 650
	research_payout = 400

/datum/module_objective/daily/visitors
	name = "Have 20 people visit an area controlled by your business and remain for long enough to be counted."
	required = 20

/datum/module_objective/daily/visitors/check_completion() // special cod to handle vistors compltion
	if(parent) // parent is faction objective is assigned to
		for(var/obj/machinery/power/apc/apc in parent.limits.apcs) // parent.limits.apcs is a list of all apcs connected to the faction, iterate through them
			var/area/A = apc.area // area the apc represents
			if(A)
				for(var/mob/living/carbon/M in A) // all valid mobs (laces and humans) in the area
					if(M.key && !(M.real_name in unique_characters)) // the mob must have a key (a player active) and not be in the unique_characters list
						unique_characters |= M.real_name // add them to list to prevent duplicates
						filled++ // add to filled
	..()


/datum/module_objective/daily/revenue
	name = "Earn 1100$$ in revenue from any source by providing a useful function in the economy."
	required = 1100

/datum/module_objective/daily/employees
	name = "Have 6 employees get paid for productively working."
	required = 6

/datum/module_objective/daily/cost
	name = "Spend 1000$$ out of the business account for useful goods and services."
	required = 1000

/datum/module_objective/daily/sales
	name = "Have 10 people or businesses pay us through an invoice."
	required = 10

/datum/module_objective/daily/monsters
	name = "Have 25 wilderness creatures die in proximity to a clocked in employee."
	required = 25

/datum/module_objective/daily/travel
	name = "Have clocked in employees travel to 4 different wilderness sectors and remain long enough to be counted."
	required = 4


// /datum/module_objective/daily/travel/check_completion()
// 	if(parent)
// 		for(var/obj/item/organ/internal/stack/stack in parent.connected_laces)
// 			var/mob/M = stack.get_owner()
// 			if(M && M.z > 3 && !("[M.z]" in unique_factions))
// 				unique_factions |= "[M.z]"
// 				filled++
// 	..()

/datum/module_objective/daily/article_viewers
	name = "Have 15 unique viewers for articles in your news feed."
	required = 15

/datum/module_objective/daily/publish_book
	name = "Add 3 books printed by seperate individuals to the library database."
	required = 3

/datum/module_objective/daily/contract
	name = "Have 2 individuals or organizations sign new contracts with us."
	required = 2

/datum/module_objective/daily/fabricate
	name = "Fabricate 40 items to sell or help us conduct business."
	required = 40


/datum/module_objective/weekly
	payout = 1200
	research_payout = 1000

/datum/module_objective/weekly/visitors
	name = "Have 60 people visit an area controlled by your business and remain for long enough to be counted."
	required = 60

/datum/module_objective/weekly/visitors/check_completion() // special cod to handle vistors compltion
	if(parent) // parent is faction objective is assigned to
		for(var/obj/machinery/power/apc/apc in parent.limits.apcs) // parent.limits.apcs is a list of all apcs connected to the faction, iterate through them
			var/area/A = apc.area // area the apc represents
			if(A)
				for(var/mob/living/carbon/M in A) // all valid mobs (laces and humans) in the area
					if(M.key && !(M.real_name in unique_characters)) // the mob must have a key (a player active) and not be in the unique_characters list
						unique_characters |= M.real_name // add them to list to prevent duplicates
						filled++ // add to filled
	..()


/datum/module_objective/weekly/employees
	name = "Have 12 employees get paid for productively working."
	required = 12

/datum/module_objective/weekly/revenue
	name = "Earn 6500$$ in revenue from any source by providing a useful function in the economy."
	required = 6500


/datum/module_objective/weekly/cost
	name = "Spend 6000$$ out of the business account for useful goods and services."
	required = 6000

/datum/module_objective/weekly/sales
	name = "Have 40 people or businesses pay us through an invoice."
	required = 40

/datum/module_objective/weekly/monsters
	name = "Have 100 wilderness creatures die in proximity to a clocked in employee."
	required = 100

// /datum/module_objective/weekly/travel
// 	name = "Have clocked in employees travel to 8 different wilderness sectors and remain long enough to be counted."
// 	required = 8

// /datum/module_objective/weekly/travel/check_completion()
// 	if(parent && istype(parent))
// 		for(var/obj/item/organ/internal/stack/stack in parent.connected_laces)
// 			var/mob/M = stack.get_owner()
// 			if(M && M.z > 3 && !("[M.z]" in unique_factions))
// 				unique_factions |= "[M.z]"
// 				filled++
// 	..()

/datum/module_objective/weekly/article_viewers
	name = "Have 40 unique viewers for articles in your news feed."
	required = 40

/datum/module_objective/weekly/publish_book
	name = "Add 7 books printed by seperate individuals to the library database."
	required = 3

/datum/module_objective/weekly/contract
	name = "Have 6 individuals or organizations sign new contracts with us."
	required = 6

/datum/module_objective/weekly/fabricate
	name = "Fabricate 200 items to sell or help us conduct business."
	required = 200