GLOBAL_LIST_EMPTY(recent_articles)
var/PriorityQueue/all_feeds

/datum/world_faction
	var/datum/NewsFeed/feed
	var/datum/LibraryDatabase/library

/datum/LibraryDatabase
	var/list/books = list()
