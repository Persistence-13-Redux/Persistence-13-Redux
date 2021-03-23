GLOBAL_DATUM(SQL_HELPER, /datum/sql_helper)

//Handles making an SQL equal statement for the where clause, and automatically handling putting the quotes as needed
/datum/sql_helper/proc/EqualStatement(var/FieldName, var/FieldValue)
	return "[FieldName] = [istext(FieldValue)? dbcon_master.Quote(FieldValue) : FieldValue]"