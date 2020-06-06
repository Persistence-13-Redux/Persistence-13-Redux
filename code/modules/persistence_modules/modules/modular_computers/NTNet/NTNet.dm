
/datum/ntnet/proc/does_email_exist(var/login)
	return find_email_by_name(login) != null