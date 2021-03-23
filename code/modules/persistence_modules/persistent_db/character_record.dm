GLOBAL_LIST_EMPTY(all_character_records)
var/global/const/CHARACTER_RECORD_STATUS_DEAD 		= "dead"
var/global/const/CHARACTER_RECORD_STATUS_ACTIVE 	= "active"
var/global/const/CHARACTER_RECORD_STATUS_NEW 		= "new"
var/global/const/CHARACTER_RECORD_STATUS_CRYO 		= "in cryosleep"
var/global/const/CHARACTER_RECORD_STATUS_STORAGE 	= "in storage"
GLOBAL_LIST_INIT(character_record_status, list(CHARACTER_RECORD_STATUS_NEW = 0, CHARACTER_RECORD_STATUS_CRYO = 1, CHARACTER_RECORD_STATUS_STORAGE = 2, CHARACTER_RECORD_STATUS_ACTIVE = 3,  CHARACTER_RECORD_STATUS_DEAD = 4))

//Macros for populating character records
#define CONVERT_TO_STRING(VAR) (isnum(VAR)?num2text(VAR):(istype(VAR,/datum)?datum2text(VAR):(islist(VAR)?list2params(VAR):VAR)))
#define CONVERT_FROM_STRING(VAR, DESTVAR) (isnum(DESTVAR)?text2num(VAR):(istype(DESTVAR,/datum)?text2datum(VAR):(islist(DESTVAR)?params2list(VAR):VAR)))

#define _MAKE_GETTER_SETTER(NAME, TYPE) /datum/character_records/proc/get_##NAME(){return NAME;};/datum/character_records/proc/set_##NAME(value){NAME = value;commit();};

#define MAKE_CHARACTER_RECORD_FIELD(NAME, DEFAULT) /datum/character_records/var/##NAME = DEFAULT;\
_MAKE_GETTER_SETTER(NAME, var/)\
/datum/character_records/parse_row(var/list/rowdata){.=..(); NAME = CONVERT_FROM_STRING(rowdata["##NAME"], NAME);};\
/datum/character_records/to_sql(){.=..(); .["##NAME"] = CONVERT_TO_STRING(NAME);};

#define MAKE_CHARACTER_RECORD_TYPED_FIELD(NAME, TYPE, DEFAULT) /datum/character_records/var##TYPE/##NAME = DEFAULT;\
_MAKE_GETTER_SETTER(NAME, TYPE)\
/datum/character_records/parse_row(var/list/rowdata){.=..(); NAME = CONVERT_FROM_STRING(rowdata["##NAME"], NAME);};\
/datum/character_records/to_sql(){.=..(); .["##NAME"] = CONVERT_TO_STRING(NAME);};

#define MAKE_CHARACTER_RECORD_LIST_FIELD(NAME, TYPE, DEFAULT) /datum/character_records/var##TYPE/##NAME = new##TYPE();\
_MAKE_GETTER_SETTER(NAME, TYPE)\
/datum/character_records/parse_row(var/list/rowdata){.=..(); NAME = savedtext2list(rowdata["##NAME"]);};\
/datum/character_records/to_sql(){.=..(); .["##NAME"] = list2savedtext(NAME);};

//
//Gets the character record for a character from the cache, or load it from the DB into the cache
//
proc/GetCharacterRecord(var/realname)
	if(!GLOB.all_character_records[realname])
		GLOB.all_character_records[realname] = PSDB.characters.GetCharacterRecord(realname)
	return GLOB.all_character_records[realname]

proc/GetCharacterRecordsForCKEY(var/ckey)
	var/list/rows = PSDB.characters.GetCharacterRecordsForCKEY(ckey)
	var/datum/character_records/result = list()
	//Cache the records
	for(var/list/L in rows)
		var/datum/character_records/CR = new()
		CR.parse_row(L)
		GLOB.all_character_records[CR.get_real_name()] = CR
		result += CR
	return result

proc/GetCharacterRecordsForCKEYAndSaveSlot(var/ckey, var/saveslot)
	var/list/rows = PSDB.characters.GetCharacterRecordsForCKEY(ckey, saveslot)
	var/datum/character_records/result = list()
	//Cache the records
	for(var/list/L in rows)
		var/datum/character_records/CR = new()
		CR.parse_row(L)
		GLOB.all_character_records[CR.get_real_name()] = CR
		result += CR
	return result

proc/CreateCharacterRecord(var/realname, var/ckey)
	var/datum/character_records/CR = new()
	CR.set_real_name(realname)
	CR.set_ckey(ckey)
	CR.set_status(GLOB.character_record_status[CHARACTER_RECORD_STATUS_NEW])
	CR.commit()
	return CR

//Re-implement this so base bay cooperates
// /proc/get_crewmember_record(var/name)
// 	var/datum/computer_file/report/crew_record/CR
// 	for(CR in GLOB.all_crew_records)
// 		if(CR.get_name() == name)
// 			return CR
// 	//Since crew records are used by baycode, we kinda have to do this..
// 	if(!CR)
// 		CR = PSDB.GetGlobalCrewRecord(name)
// 		GLOB.all_crew_records |= CR
// 	return CR

//
// Used to store character data that's beyond the scope of just the in-game crew records. Those are unique and globally shared unlike crew records.
// When making any changes to this, you should commit them with the commit proc.
//
/datum/character_records
/datum/character_records/proc/parse_row(var/list/rowdata)
/datum/character_records/proc/to_sql() return list()

/datum/character_records/proc/fetch(var/real_name)
	parse_row(PSDB.characters.GetCharacterRecord(real_name))

/datum/character_records/proc/commit()
	PSDB.characters.CommitCharacterRecord(src)

/datum/character_records/proc/load_from_mob(var/mob/living/L)
	set_ckey(LAST_CKEY(L))
	set_real_name(L.real_name)
	set_status(!L.is_dead()? CHARACTER_RECORD_STATUS_ACTIVE : CHARACTER_RECORD_STATUS_DEAD)

	//Make the pics
	set_front_picture(getFlatIcon(L, SOUTH, always_use_defdir = 1))
	set_side_picture(getFlatIcon(L, WEST, always_use_defdir = 1))

	//Save an initial copy of the character
	var/savefile/S = new()
	S << L
	set_saved_character(S.ExportText())

/datum/character_records/proc/restore_saved_character()
	var/savefile/S = new()
	S.ImportText(source = get_saved_character())
	var/mob/M
	S >> M
	return M

// Field Definition
//
MAKE_CHARACTER_RECORD_FIELD(ckey, "")
MAKE_CHARACTER_RECORD_FIELD(save_slot, "-1") //Keep track of the save slot
MAKE_CHARACTER_RECORD_FIELD(real_name, "")
MAKE_CHARACTER_RECORD_FIELD(status, CHARACTER_RECORD_STATUS_ACTIVE)
// MAKE_CHARACTER_RECORD_FIELD(specie, SPECIES_HUMAN)
MAKE_CHARACTER_RECORD_FIELD(starting_faction_uid, "")
MAKE_CHARACTER_RECORD_FIELD(saved_character, "")
//Typed stuff
MAKE_CHARACTER_RECORD_TYPED_FIELD(side_picture, /icon, new/icon())
MAKE_CHARACTER_RECORD_TYPED_FIELD(front_picture, /icon, new/icon())
// MAKE_CHARACTER_RECORD_LIST_FIELD(subscribed_orgs, /list, new/list())
// MAKE_CHARACTER_RECORD_LIST_FIELD(owned_stocks, /list, new/list())

#undef CONVERT_TO_STRING
#undef CONVERT_FROM_STRING
#undef MAKE_CHARACTER_RECORD_FIELD
#undef MAKE_CHARACTER_RECORD_TYPED_FIELD
#undef MAKE_CHARACTER_RECORD_LIST_FIELD