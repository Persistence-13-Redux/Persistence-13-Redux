/datum/transaction
	var/__internal_idx = 0 //Keep track of the internal DB index, so we can delete individual loaded transactions

/datum/transaction/proc/parse_row(var/list/row)
	__internal_idx 	= text2num(row["id"])
	purpose 		= row["purpose"]
	amount 			= text2num(row["amount"])
	date 			= row["date"]
	time 			= row["time"]
	if(row["source"])
		source 		= get_account(text2num(row["source"]))
	if(row["target"])
		target 		= get_account(text2num(row["target"]))

/datum/transaction/proc/to_sql()
	. = "purpose = '[purpose]',"
	. += "amount = [amount],"
	. += "date =   '[date]',"
	. += "time =   '[time]'"
	if(source)
		. += ",source = '[source.account_number]'"
	if(target && source)
		. += ","
	if(target)
		. += "target = '[target.account_number]'"