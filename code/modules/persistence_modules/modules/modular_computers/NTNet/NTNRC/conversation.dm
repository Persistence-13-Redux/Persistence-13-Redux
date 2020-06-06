/datum/ntnet_conversation
	var/saved_operatorid = null

/datum/ntnet_conversation/New(var/_z)
	title = "[title][ntnrc_uid]"
	..()
	ADD_SAVED_VAR(title)
	ADD_SAVED_VAR(messages)
	ADD_SAVED_VAR(password)
	ADD_SAVED_VAR(saved_operatorid)

/datum/ntnet_conversation/before_save()
	. = ..()
	saved_operatorid = operator.username

/datum/ntnet_conversation/after_load()
	. = ..()