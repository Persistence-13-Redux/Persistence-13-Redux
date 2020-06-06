/datum/computer_file/program/wordprocessor/New(comp)
	..(comp)
	ADD_SAVED_VAR(open_file)
	ADD_SKIP_EMPTY(open_file)

/datum/computer_file/program/wordprocessor/after_load()
	. = ..()
	if(open_file)
		open_file(open_file)
