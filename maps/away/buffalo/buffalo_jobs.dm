/datum/job/spawnonly/submap


/datum/job/submap/buffalo_captain
	title = "Captain"
	total_positions = 1
	outfit_type = /decl/hierarchy/outfit/job/buffalo/captain
	supervisors = "your bottom line"
	info = 
{"
You awoke from cryo finding something went very wrong. 
Your ship diverged from its destination. And now you're lost.
Your crew is bound to be annoyed.
"}

/datum/job/submap/buffalo_crewman
	title = "Crewmember"
	outfit_type = /decl/hierarchy/outfit/job/buffalo/crew
	supervisors = "the Captain"
	info = 
{"
You awoke from cryo finding something went very wrong. 
Your ship diverged from its destination. And now you're lost.
And you thought you could finally gets some shore leave after all this time in space.
"}

//Helper types used by the spawn beacons
/obj/effect/submap_landmark/spawnpoint/buffalo/crewman
	name = BUFFALO_SHIP_SPAWN_POINT_NAME