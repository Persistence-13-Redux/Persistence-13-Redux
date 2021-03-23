/datum/AccountDB
	var/datum/AccountDB/Contracts/contracts = new()

/datum/AccountDB/Contracts
	var/const/CONTRACTS_TABLE 	= "contracts"

//=========================
// Contracts
//=========================

/*
	Return the ID if successful
*/
/datum/AccountDB/Contracts/proc/CreateContract(var/obj/item/weapon/paper/contract/C)
	if(!C) return
	if(!check_connection()) return
	var/uuid = null
	var/DBQuery/dbq = dbcon_master.NewQuery("INSERT INTO [CONTRACTS_TABLE] VALUES [C.to_sql()];")
	dbq.Execute()
	if(dbq.RowsAffected())
		var/DBQuery/idquery = dbcon_master.NewQuery("SELECT LAST_INSERT_ID();")
		idquery.Execute()
		uuid = idquery.item[1]
	return uuid

/*
	Remove a contract entry from the database via its contract ID.
*/
/datum/AccountDB/Contracts/proc/RemoveContract(var/contract_id)
	if(!isnum(contract_id)) return
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("DELETE FROM [CONTRACTS_TABLE] WHERE uuid = [contract_id];")
	dbq.Execute()
	return dbq.RowsAffected()

/*
	Returns a single contract for the given contract UID
*/
/datum/AccountDB/Contracts/proc/GetContract(var/contract_id)
	var/list/obj/item/weapon/paper/contract/result = __GetContracts("uuid = [contract_id]")
	return result? result[1] : null

/*
	Returns all contracts that were signed by the specified character name.
*/
/datum/AccountDB/Contracts/proc/GetContracts_SignedBy(var/signed_by)
	return __GetContracts("signed_by = [signed_by]")

/*
	Returns all the contracts that were paid to the specified faction uid or character name
*/
/datum/AccountDB/Contracts/proc/GetContracts_PaidTo(var/paid_to)
	return __GetContracts("paid_to = [paid_to]")

/*
	Used internally to simplify making contract queries. Not intended to be used outside.
*/
/datum/AccountDB/Contracts/proc/__GetContracts(var/condition)
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("SELECT * FROM [CONTRACTS_TABLE] WHERE [condition];")
	dbq.Execute()
	var/list/obj/item/weapon/paper/contract/result = list()
	while(dbq.NextRow())
		var/obj/item/weapon/paper/contract/C = new()
		C.parse_row(dbq.GetRowData())
		result += C
	return result

/*
	Overwrite the existing contract entry in the DB. The contract object is expected to refer to an existing entry in the database.
*/
/datum/AccountDB/Contracts/proc/SetContract(var/obj/item/weapon/paper/contract/C)
	if(!C) return
	if(!check_connection()) return
	var/DBQuery/dbq = dbcon_master.NewQuery("UPDATE [CONTRACTS_TABLE] SET ([C.to_sql()]) WHERE uuid = [C.uuid];")
	dbq.Execute()
	return dbq.RowsAffected()

//=========================
// Parsing
//=========================
/obj/item/weapon/paper/contract/proc/to_sql()
	. =  "uuid =              '[uuid]',"
	. += "purpose =           [dbcon_master.Quote(purpose)],"
	. += "info =              [dbcon_master.Quote(info)],"
	. += "signer =            [dbcon_master.Quote(signer)],"
	. += "signer_account =    '[signer_account]',"
	. += "issuer =            [dbcon_master.Quote(issuer)],"
	. += "issuer_account =    '[issuer_account]',"
	. += "creator =           [dbcon_master.Quote(creator)],"
	. += "value =             [value],"
	. += "stocks =            [stocks],"
	. += "stocks_source_uid = [dbcon_master.Quote(stocks_source_uid)],"
	. += "state =             [state],"
	. += "contract_type =     [dbcon_master.Quote(contract_type)]"
	. += "extra_fields =      '[list2savedtext(extra_fields)]'"

/obj/item/weapon/paper/contract/proc/parse_row(var/list/row)
	uuid 				= text2num(row["uuid"])
	purpose 			= row["purpose"]
	info 				= row["info"]
	signer 				= row["signer"]
	signer_account 		= text2num(row["signer_account"])
	issuer 				= row["issuer"]
	issuer_account 		= text2num(row["issuer_account"])
	creator 			= row["creator"]
	value 				= text2num(row["value"])
	stocks 				= text2num(row["stocks"])
	stocks_source_uid 	= row["stocks_source_uid"]
	state 				= text2num(row["state"])
	contract_type 		= row["contract_type"]
	extra_fields 		= savedtext2list(row["extra_fields"])