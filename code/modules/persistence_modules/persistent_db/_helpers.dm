//Turns a list of things into a comma separated list of values in a text string
proc/list2text(var/list/L)
	var/textout = ""
	for(var/key in L)
		if(length(textout) > 0)
			textout = "[textout]," //add a comma when we append if not empty
		var/val = istext(L[key])? "\"[L[key]]\"" : L[key]
		textout = "[textout][istext(key)? "\"[key]\"" : key ] = [val]"
	return textout

//
//	Saving/Loading datums as text
//
proc/datum2text(var/datum/D)
	if(!D) return
	var/savefile/F = new()
	F << D
	return F.ExportText()

proc/text2datum(var/T)
	if(!T) return
	var/savefile/F = new()
	F.ImportText("/", T)
	var/datum/D
	F >> D
	return D

//
//	Saving/Loading lists as text
//
proc/savedtext2list(var/T)
	if(!T) return
	var/savefile/F = new()
	F.ImportText("/", T)
	var/list/L
	F >> L
	return L

proc/list2savedtext(var/list/L)
	if(!L) return
	var/savefile/F = new()
	F << L
	return F.ExportText()