/datum/computer_file/data/email_account
	var/list/blocked = list()

/datum/computer_file/data/email_account/New(_login, _fullname, _assignment)
	..()
	ADD_SAVED_VAR(inbox)
	ADD_SAVED_VAR(outbox)
	ADD_SAVED_VAR(spam)
	ADD_SAVED_VAR(deleted)
	ADD_SAVED_VAR(login)
	ADD_SAVED_VAR(password)
	ADD_SAVED_VAR(can_login)
	ADD_SAVED_VAR(suspended)
	ADD_SAVED_VAR(blocked)

/datum/computer_file/data/email_account/proc/unread()
	var/count = 0
	for(var/datum/computer_file/data/email_message/stored_message in inbox)
		if(stored_message.unread)
			count++
	return count

/datum/computer_file/data/email_account/receive_mail(var/datum/computer_file/data/email_message/received_message, var/relayed)
	. = ..()
	GLOB.discord_api.mail(src.login, received_message)

