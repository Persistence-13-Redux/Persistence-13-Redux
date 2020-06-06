//Status Flags for the faction
var/const/FACTION_STATUS_FLAG_ACTIVE	= 1 //Whether the business/faction is Opened/Closed
var/const/FACTION_STATUS_FLAG_PENDING 	= 2 //Whether the faction is awaiting finalization or not
var/const/FACTION_STATUS_FLAG_TERMINATED= 4 //Whether the faction was terminated and shouldn't be considered an existing faction anymore

/*
	Definition for the world_faction datum
*/
/datum/world_faction
	var/uid										//Unique identifier for the faction. Should not be changed manually.
	var/name									//The displayed name for the faction.
	var/abbreviation							//Shorter one word display name for the faction
	var/short_tag								//Shortest 4 characters displayed tag for the faction
	var/desc									//Long description for the faction
	var/status									//Current state type of the faction. Whether its pending, terminated, active, etc..

	//Access
	var/password								//Password to access the faction network
	var/owner_name								//Character real_name of the current leader of this faction
	var/allow_new_player_spawn					//Whether new players should be allowed to spawn from available spawnpoints this faction owns
	var/tmp/list/accesses = list()				//List of accesses uid to each of the access datum {uid, datum}. Buffered from DB.

	//Network
	var/network_uid								//UID of the faction's ntnet network
	var/network_flags							//Saved parameters of the associated ntnet network
	var/tmp/datum/ntnet/faction/network			//Faction ntnet network reference. Loaded at runtime from the network DB!

	//Money
	var/central_account_id						//Account number of the central faction account
	var/tmp/datum/money_account/central_account	//Reference on the central faction account

	//Faction Relations
	var/parent_faction_uid 						//Faction that owns this faction, and receive taxes and etc from them
	var/tmp/datum/world_faction/parent_faction	//Reference on the parent faction

	//Members
	var/tmp/list/records_byname = list()		//List of names to their corresponding faction crew record. Is buffered from the DB, so make sure to use the procs in this class.
	var/list/expenses = list()					//Current Expenses for each characters

	//Employment
	var/tmp/list/assignments = list()			//List of assignments uid to each assignments datum {uid, datum/assignment_category} currently existing for this faction. Is cached from the DB.
	var/hiring									//Whether the faction is currently allowing hiring people.
	var/tmp/list/employe_log = list()			//Text log for various employe actions. Buffered from DB.

//========================================
//	Standard Stuff
//========================================
/datum/world_faction/New(var/_uid, var/_name, var/_abbreviation, var/_short_tag, var/_desc)
	. = ..()
	src.uid = _uid
	src.name = _name
	src.abbreviation = _abbreviation
	src.short_tag = _short_tag
	src.desc = _desc

/datum/world_faction/after_load()
	. = ..()
	load_assignments()
	load_network()
	get_central_account() //Make sure the central account is loaded

/datum/world_faction/Destroy()
	network = null
	central_account = null
	parent_faction = null
	QDEL_NULL_LIST(records_byname)
	QDEL_NULL_LIST(assignments)
	return ..()

//========================================
//	Initiate all faction related stuff
//========================================

//Should only be called when the faction is created for the first time.
/datum/world_faction/proc/InitialSetup()
	create_network(uid, name)
	create_faction_account()
	setup_stocks()
	callHook("faction_created", list(src, uid))

//In most cases, you probably just want to set the faction's status to terminated instead of doing a full delete like this
/datum/world_faction/proc/DeleteFaction()
	callHook("faction_deleting", list(src, uid))
	delete_network()
	delete_faction_account()
	delete_stocks()
	parent_faction = null
	parent_faction_uid = null

/datum/world_faction/proc/create_network(var/_uid, var/_name)
	network = new(_uid, _name, _faction_uid = uid, _visible = TRUE, _secure = TRUE, _password = password)

/datum/world_faction/proc/create_faction_account()
	central_account = create_account("[name] central account", uid, 0, ACCOUNT_TYPE_DEPARTMENT)
	central_account_id = central_account.account_number

/datum/world_faction/proc/setup_stocks()
	return PSDB.factions.AddStockHolding(src.uid, src.uid, 100)

/datum/world_faction/proc/delete_network()
	GLOB.FactionNetManager.DeleteNetwork(network_uid)
	network = null
	network_uid = null

/datum/world_faction/proc/delete_faction_account()
	PSDB.bank.RemoveBankAccount(central_account_id)
	central_account = null
	central_account_id = null

/datum/world_faction/proc/delete_stocks()
	PSDB.factions.DeleteAllFactionStocks(src.uid)

//========================================
//	Generic Stuff
//========================================

//Fetch the current faction's network's data from the SQL DB
/datum/world_faction/proc/get_network()
	if(!network)
		load_network()
	return network

/datum/world_faction/proc/load_network()
	if(!length(network_uid))
		return FALSE
	GLOB.FactionNetManager.AddNetwork(PSDB.factions.GetFactionNetwork(network_uid))
	network = GLOB.FactionNetManager.GetNetwork(network_uid)
	return TRUE

//========================================
//	Faction SQL
//========================================
/datum/world_faction/proc/to_sql()
	//Make sure we only save the fields we can actually save only
	. = {"
	name =               [SQL_HELPER.Quote(name)],
	abbreviation =       [SQL_HELPER.Quote(abbreviation)],
	desc =               [SQL_HELPER.Quote(desc)],
	password =           [SQL_HELPER.Quote(password)],
	owner_name =         [SQL_HELPER.Quote(owner_name)],
	network_uid =        [SQL_HELPER.Quote(network_uid)],
	central_account_id = [SQL_HELPER.Quote(central_account_id)],
	expenses =           '[list2savedtext(expenses)]',
	status =             [status],
	hiring =             [hiring],
	"}

/datum/world_faction/proc/parse_row(var/list/row)
	uid = 					row["uid"]
	name = 					row["name"]
	abbreviation = 			row["abbreviation"]
	desc = 					row["description"]
	password = 				row["password"]
	owner_name = 			row["owner_name"]
	network_uid = 			row["network_uid"]
	central_account_id = 	text2num(row["bank_id"])
	expenses = 				savedtext2list(row["expenses"])
	status = 				text2num(row["status"])
	hiring = 				text2num(row["hiring"])
