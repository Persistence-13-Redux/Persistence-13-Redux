/datum/world_faction/business/proc/revenue_objectives(var/amount) // run this anytime a revenue objective might be filled
	if(istype(hourly_objective, /datum/module_objective/hourly/revenue)) // checks if the hourly objective is a revenue objective
		hourly_objective.filled += amount // fill by the amount
		hourly_objective.check_completion() // check if its done
	if(istype(daily_objective, /datum/module_objective/daily/revenue)) // repeat for daily, weekly
		daily_objective.filled += amount
		daily_objective.check_completion()
	if(istype(weekly_objective, /datum/module_objective/weekly/revenue))
		weekly_objective.filled += amount
		weekly_objective.check_completion()

/datum/world_faction/business/proc/cost_objectives(var/amount) // run this anytime a cost objective might be filled
	if(istype(hourly_objective, /datum/module_objective/hourly/cost)) // checks if the hourly objective is a cost objective
		hourly_objective.filled += amount // fill by the amount
		hourly_objective.check_completion() // check if its done
	if(istype(daily_objective, /datum/module_objective/daily/cost)) // repeat for daily, weekly
		daily_objective.filled += amount
		daily_objective.check_completion()
	if(istype(weekly_objective, /datum/module_objective/weekly/cost))
		weekly_objective.filled += amount
		weekly_objective.check_completion()

/datum/world_faction/business/proc/monster_objectives() // run this anytime a monster objective might be filled
	if(istype(hourly_objective, /datum/module_objective/hourly/monsters))
		hourly_objective.filled++ // fill by one
		hourly_objective.check_completion()
	if(istype(daily_objective, /datum/module_objective/daily/monsters)) // repeat for daily, weekly
		daily_objective.filled++
		daily_objective.check_completion()
	if(istype(weekly_objective, /datum/module_objective/weekly/monsters))
		weekly_objective.filled++
		weekly_objective.check_completion()

/datum/world_faction/business/proc/publish_article_objectives() // run this anytime a publish article objective might be filled
	if(istype(hourly_objective, /datum/module_objective/hourly/publish_article))
		hourly_objective.filled++ // fill by one
		hourly_objective.check_completion()

/datum/world_faction/business/proc/publish_book_objectives(var/real_name) // run this anytime a publish book objective might be filled
	if(istype(hourly_objective, /datum/module_objective/hourly/publish_book))
		hourly_objective.filled++ // fill by one
		hourly_objective.check_completion()
	if(istype(daily_objective, /datum/module_objective/daily/publish_book) && !(real_name in daily_objective.unique_characters)) // repeat for daily, weekly
		daily_objective.filled++
		daily_objective.check_completion()
	if(istype(weekly_objective, /datum/module_objective/weekly/publish_book) && !(real_name in weekly_objective.unique_characters))
		weekly_objective.filled++
		weekly_objective.check_completion()

/datum/world_faction/business/proc/contract_objectives(var/namee, var/sale_type)
	if(istype(hourly_objective, /datum/module_objective/hourly/contract))
		if(sale_type == CONTRACT_PERSON && !(namee in hourly_objective.unique_characters)) //
			hourly_objective.filled++ // increase by one
			hourly_objective.unique_characters |= namee
			hourly_objective.check_completion() // check if its done
		else if(sale_type == CONTRACT_BUSINESS && !(namee in hourly_objective.unique_factions)) //
			hourly_objective.filled++ // increase by one
			hourly_objective.unique_factions |= namee
			hourly_objective.check_completion() // check if its done
	if(istype(daily_objective, /datum/module_objective/daily/contract)) //
		if(sale_type == CONTRACT_PERSON && !(namee in daily_objective.unique_characters)) //
			daily_objective.filled++ // increase by one
			daily_objective.unique_characters |= namee
			daily_objective.check_completion() // check if its done
		else if(sale_type == CONTRACT_BUSINESS && !(namee in daily_objective.unique_factions)) //
			daily_objective.filled++ // increase by one
			daily_objective.unique_factions |= namee
			daily_objective.check_completion() // check if its done
	if(istype(weekly_objective, /datum/module_objective/weekly/contract)) //
		if(sale_type == CONTRACT_PERSON && !(namee in weekly_objective.unique_characters)) //
			weekly_objective.filled++ // increase by one
			weekly_objective.unique_characters |= namee
			weekly_objective.check_completion() // check if its done
		else if(sale_type == CONTRACT_BUSINESS && !(namee in weekly_objective.unique_factions)) //
			weekly_objective.filled++ // increase by one
			weekly_objective.unique_factions |= namee
			weekly_objective.check_completion() // check if its done

/datum/world_faction/business/proc/sales_objectives(var/namee, var/sale_type) // sale_type 1 == character, 2 == business
	if(istype(hourly_objective, /datum/module_objective/hourly/sales))
		if(sale_type == 1 && !(namee in hourly_objective.unique_characters)) // if its a individual sale, check if the name is already used by characters
			hourly_objective.filled++ // increase by one
			hourly_objective.unique_characters |= namee
			hourly_objective.check_completion() // check if its done
		else if(sale_type == 2 && !(namee in hourly_objective.unique_factions)) // if its with another faction, check if its in the list of factions
			hourly_objective.filled++ // increase by one
			hourly_objective.unique_factions |= namee
			hourly_objective.check_completion() // check if its done
	if(istype(daily_objective, /datum/module_objective/daily/sales)) // checks if the hourly objective is a cost objective
		if(sale_type == 1 && !(namee in daily_objective.unique_characters)) // if its a individual sale, check if the name is already used by characters
			daily_objective.filled++ // increase by one
			daily_objective.unique_characters |= namee
			daily_objective.check_completion() // check if its done
		else if(sale_type == 2 && !(namee in daily_objective.unique_factions)) // if its with another faction, check if its in the list of factions
			daily_objective.filled++ // increase by one
			daily_objective.unique_factions |= namee
			daily_objective.check_completion() // check if its done
	if(istype(weekly_objective, /datum/module_objective/weekly/sales)) // checks if the hourly objective is a cost objective
		if(sale_type == 1 && !(namee in weekly_objective.unique_characters)) // if its a individual sale, check if the name is already used by characters
			weekly_objective.filled++ // increase by one
			weekly_objective.unique_characters |= namee
			weekly_objective.check_completion() // check if its done
		else if(sale_type == 2 && !(namee in weekly_objective.unique_factions)) // if its with another faction, check if its in the list of factions
			weekly_objective.filled++ // increase by one
			weekly_objective.unique_factions |= namee
			weekly_objective.check_completion() // check if its done

/datum/world_faction/business/proc/employee_objectives(var/real_name) // run anytime a employee objective might be filled
	if(istype(hourly_objective, /datum/module_objective/hourly/employees)) // check for objective
		if(!(real_name in hourly_objective.unique_characters)) // this means IF the name of the employee IS NOT already used to fill the objective
			hourly_objective.unique_characters |= real_name // put the name in the unique names list to prevent duplicates
			hourly_objective.filled++ // increased filled by 1 (++ increases by 1)
			hourly_objective.check_completion() // check if its done
	if(istype(daily_objective, /datum/module_objective/daily/employees)) // repeat for daily, weekly
		if(!(real_name in daily_objective.unique_characters))
			daily_objective.unique_characters |= real_name
			daily_objective.filled++
			daily_objective.check_completion()
	if(istype(weekly_objective, /datum/module_objective/weekly/employees)) // repeat for daily, weekly
		if(!(real_name in weekly_objective.unique_characters))
			weekly_objective.unique_characters |= real_name
			weekly_objective.filled++
			weekly_objective.check_completion()

/datum/world_faction/business/proc/fabricator_objectives()
	if(istype(hourly_objective, /datum/module_objective/hourly/fabricate))
		hourly_objective.filled++ // fill by one
		hourly_objective.check_completion()
	if(istype(daily_objective, /datum/module_objective/daily/fabricate)) // repeat for daily, weekly
		daily_objective.filled++
		daily_objective.check_completion()
	if(istype(weekly_objective, /datum/module_objective/weekly/fabricate))
		weekly_objective.filled++
		weekly_objective.check_completion()

/datum/world_faction/business/proc/article_view_objectives(var/real_name) // run anytime a employee objective might be filled
	if(istype(daily_objective, /datum/module_objective/daily/article_viewers)) // repeat for daily, weekly
		if(!(real_name in daily_objective.unique_characters))
			daily_objective.unique_characters |= real_name
			daily_objective.filled++
			daily_objective.check_completion()
	if(istype(weekly_objective, /datum/module_objective/weekly/article_viewers)) // repeat for daily, weekly
		if(!(real_name in weekly_objective.unique_characters))
			weekly_objective.unique_characters |= real_name
			weekly_objective.filled++
			weekly_objective.check_completion()