/datum/computer_file/data/email_message/
	var/unread = 1

/datum/computer_file/data/email_message/New()
	. = ..()
	ADD_SAVED_VAR(title)
	ADD_SAVED_VAR(source)
	ADD_SAVED_VAR(spam)
	ADD_SAVED_VAR(timestamp)
	ADD_SAVED_VAR(attachment)
	ADD_SAVED_VAR(unread)