/datum/module_objective_manager

/datum/module_objective_manager/proc/process()
	// for(var/datum/world_faction/business/faction in GLOB.all_world_factions)
	// 	if(faction.hourly_objective)
	// 		if(faction.hourly_objective.completed || faction.hourly_objective.check_completion())
	// 			if((faction.hourly_assigned + 2 HOURS) < world.realtime)
	// 				faction.assign_hourly_objective()
	// 	else
	// 		if((faction.hourly_assigned + 2 HOURS) < world.realtime)
	// 			faction.assign_hourly_objective()
	// 	if((faction.hourly_assigned + 1 DAY) < world.realtime)
	// 		faction.hourly_assigned = world.realtime
	// 	if(faction.module.current_level >= 2)
	// 		if(faction.daily_objective)
	// 			if(faction.daily_objective.completed || faction.daily_objective.check_completion())
	// 				if((faction.daily_assigned + 1 DAY) < world.realtime)
	// 					faction.assign_daily_objective()
	// 		else
	// 			if((faction.daily_assigned + 1 DAY) < world.realtime)
	// 				faction.assign_daily_objective()
	// 		if((faction.daily_assigned + 1 DAY) < world.realtime)
	// 			faction.daily_assigned = world.realtime
	// 	if(faction.module.current_level >= 3)
	// 		if(faction.weekly_objective)
	// 			if(faction.weekly_objective.completed || faction.weekly_objective.check_completion())
	// 				if((faction.weekly_assigned + 7 DAY) < world.realtime)
	// 					faction.assign_weekly_objective()
	// 		else
	// 			if((faction.weekly_assigned + 7 DAYS) < world.realtime)
	// 				faction.assign_weekly_objective()
	// 		if((faction.weekly_assigned + 7 DAYS) < world.realtime)
	// 			faction.weekly_assigned = world.realtime
