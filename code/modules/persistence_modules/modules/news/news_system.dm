/datum/NewsStory/proc/allowed(var/real_name)
	if(real_name in purchased)
		return 1
	if(!cost)
		return 1
	return 0


/datum/NewsStory
	var/name = "None" // headline
	var/image/image1
	var/image/image2
	var/body = ""
	var/author = ""
	var/true_author = ""
	var/publish_date = 0

	var/list/purchased = list()

	var/datum/NewsIssue/parent

	var/uid

	var/announce = 0
	var/cost = 0

/datum/NewsStory/proc/view_story(var/mob/M)
	purchased |= M.real_name
	if(istype(parent.parent.parent))
		parent.parent.parent.article_view_objectives(M.real_name)


/datum/NewsIssue
	var/name = "None"
	var/list/stories = list()
	var/publish_date
	var/publisher = ""

	var/datum/NewsFeed/parent

	var/uid

	var/cost = 0


/datum/NewsFeed
	var/name = "None"
	var/visible = 0
	var/datum/NewsIssue/current_issue
	var/list/all_issues = list()
	var/per_article = 20
	var/per_issue = 60
	var/announcement = "Breaking News!"
	var/last_published = 0
	var/datum/world_faction/business/parent

/datum/NewsFeed/New()
	current_issue = new()
	current_issue.parent = src
	current_issue.name = "[name] News Issue"
	all_feeds.Enqueue(src)


/datum/NewsFeed/proc/publish_issue()

	for(var/obj/machinery/newscaster/caster in allCasters)
		caster.newsAlert("[name] just published a full issue! [current_issue.name]")
	all_issues |= current_issue
	all_feeds.Enqueue(current_issue)
	current_issue = new()
	current_issue.parent = src
	current_issue.name = "[name] News Issue"
	last_published = current_issue.publish_date
	all_feeds.ReSort(src)

/datum/NewsFeed/proc/publish_story(var/datum/NewsStory/story)
	current_issue.stories |= story
	story.parent = current_issue
	if(story.announce)
		for(var/obj/machinery/newscaster/caster in allCasters)
			caster.newsAlert("(From [name]) [announcement] ([story.name])")
	GLOB.recent_articles |= story
	GLOB.discord_api.broadcast("(From [name]) [announcement] ([story.name])")