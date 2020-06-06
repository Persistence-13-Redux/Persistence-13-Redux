//Global instance of the SQL Helper
var/global/datum/sql_helper/SQL_HELPER = new()

//A set of methods to make things simpler to read or avoid repeating code when dealing with SQL
/datum/sql_helper

//Handles making an SQL equal statement for the where clause, and automatically handling putting the quotes as needed
/datum/sql_helper/proc/EqualStatement(var/FieldName, var/FieldValue)
	return "[FieldName] = [istext(FieldValue)? PSDB.psdbcon.Quote(FieldValue) : FieldValue]"

/datum/sql_helper/proc/Quote(var/statement)
	return PSDB.psdbcon.Quote(statement)