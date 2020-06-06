//All character records loaded from the db are cached into this glabal list. Use the procs to load/save them first!!!
GLOBAL_LIST_EMPTY(all_character_records)

// Record status as strings
var/global/const/CHARACTER_RECORD_STATUS_DEAD 		= "dead"
var/global/const/CHARACTER_RECORD_STATUS_ACTIVE 	= "active"
var/global/const/CHARACTER_RECORD_STATUS_NEW 		= "new"
var/global/const/CHARACTER_RECORD_STATUS_CRYO 		= "in cryosleep"
var/global/const/CHARACTER_RECORD_STATUS_STORAGE 	= "in storage"

//List of all possible character record status and their equivalent numeric value
GLOBAL_LIST_INIT(character_record_status, list(CHARACTER_RECORD_STATUS_NEW = 0, CHARACTER_RECORD_STATUS_CRYO = 1, CHARACTER_RECORD_STATUS_STORAGE = 2, CHARACTER_RECORD_STATUS_ACTIVE = 3, CHARACTER_RECORD_STATUS_DEAD = 4))

/proc/CharacterRecordStatusNumToString(var/num)
	for(var/entry in GLOB.character_record_status)
		if(GLOB.character_record_status[entry] == num)
			return entry
	return

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

/////////////////////////////////////////
// Helper Procs for Character Records
/////////////////////////////////////////

//
//Gets the character record for a character from the cache, or load it from the DB into the cache
//
proc/GetCharacterRecord(var/realname)
	if(!GLOB.all_character_records[realname])
		GLOB.all_character_records[realname] = PSDB.characters.GetCharacterRecord(realname)
	return GLOB.all_character_records[realname]

proc/DeleteCharacterRecord(var/realname)
	GLOB.all_character_records[realname] = null
	. = PSDB.characters.RemoveCharacterRecord(realname)
	if(.)
		message_staff("'[usr]' deleted character '[realname]'!")

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
	log_debug("proc/GetCharacterRecordsForCKEYAndSaveSlot([ckey], [saveslot]): Result : [length(result)]")
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

/////////////////////////////////////////
// Character Records Datum
/////////////////////////////////////////

//
// Used to store character data that's beyond the scope of just the in-game crew records. Those are unique and globally shared unlike crew records.
// When making any changes to this, you should commit them with the commit proc.
//
/datum/character_records

//Don't modify those 2 procs without modifying the macros!
/datum/character_records/proc/parse_row(var/list/rowdata)
/datum/character_records/proc/to_sql() return list()

/datum/character_records/proc/fetch(var/real_name)
	parse_row(PSDB.characters.GetCharacterRecord(real_name))

/datum/character_records/proc/commit()
	PSDB.characters.CommitCharacterRecord(src)

/datum/character_records/proc/load_from_mob(var/mob/living/L)
	set_ckey(LAST_CKEY(L))
	set_real_name(L.real_name)
	set_status(!L.is_dead()? GLOB.character_record_status[CHARACTER_RECORD_STATUS_ACTIVE] : GLOB.character_record_status[CHARACTER_RECORD_STATUS_DEAD])

	if(L.dna)
		set_dna(L.dna.get_dna_hash())
	set_fingerprint(L.get_full_print(TRUE))
	if(L.mind)
		set_memory(datum2text(L.mind.memories))

	//Make the pics
	set_front_picture(getFlatIcon(L, SOUTH, always_use_defdir = 1))
	set_side_picture(getFlatIcon(L, WEST, always_use_defdir = 1))

	//Save an initial copy of the character
	var/savefile/S = new()
	S << L
	set_saved_character(S.ExportText())

/datum/character_records/proc/restore_saved_character()
	var/savefile/S = new()
	S.ImportText(,get_saved_character())
	var/mob/M
	S >> M
	return M

/////////////////////////////////////////
// Character Records Field Definition
/////////////////////////////////////////
MAKE_CHARACTER_RECORD_FIELD(ckey, "")
MAKE_CHARACTER_RECORD_FIELD(save_slot, "-1") //Keep track of the save slot
MAKE_CHARACTER_RECORD_FIELD(real_name, "")
MAKE_CHARACTER_RECORD_FIELD(status, 0)
MAKE_CHARACTER_RECORD_FIELD(starting_faction_uid, "")
MAKE_CHARACTER_RECORD_FIELD(saved_character, "")
MAKE_CHARACTER_RECORD_FIELD(dna, "")
MAKE_CHARACTER_RECORD_FIELD(fingerprint, "")
MAKE_CHARACTER_RECORD_FIELD(memory, "")
MAKE_CHARACTER_RECORD_TYPED_FIELD(side_picture, /icon, new/icon())
MAKE_CHARACTER_RECORD_TYPED_FIELD(front_picture, /icon, new/icon())
// >> !!! Don't forget to update the sql script if you add/modify fields here !!! <<

#undef CONVERT_TO_STRING
#undef CONVERT_FROM_STRING
#undef MAKE_CHARACTER_RECORD_FIELD
#undef MAKE_CHARACTER_RECORD_TYPED_FIELD
#undef MAKE_CHARACTER_RECORD_LIST_FIELD