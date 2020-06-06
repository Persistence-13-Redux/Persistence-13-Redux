//PS13 mob defines (don't rename file otherwise the defines will be overriden by the bay original)

// Gluttony levels.
#define GLUT_NONE 0       // Eat nothing, meant for phorosians

//Specie flag
#define IS_PHOROSIAN 8
#define IS_RESOMI  9

//Cultures
#define CULTURE_PHOROSIAN "Phorosian"
#define CULTURE_RESOMI "Resomi"

//Languages
#define LANGUAGE_RESOMI "Schechi"

//New species
#define SPECIES_PHOROSIAN   "Phorosian"
#define SPECIES_RESOMI		"Resomi"

//Primitives
#define SPECIES_MONKEY      "Monkey"
#define SPECIES_FARWA       "Farwa"
#define SPECIES_NEAERA      "Neaera"
#define SPECIES_STOK        "Stok"

#ifdef UNRESTRICTED_SPECIES
	#undef UNRESTRICTED_SPECIES
#endif
#define UNRESTRICTED_SPECIES list(SPECIES_HUMAN, SPECIES_DIONA, SPECIES_IPC, SPECIES_UNATHI, SPECIES_SKRELL, SPECIES_TRITONIAN, SPECIES_SPACER, SPECIES_VATGROWN, SPECIES_GRAVWORLDER, SPECIES_BOOSTER, SPECIES_MULE, SPECIES_RESOMI)

#ifdef RESTRICTED_SPECIES
	#undef RESTRICTED_SPECIES
#endif
#define RESTRICTED_SPECIES list(SPECIES_VOX, SPECIES_ALIEN, SPECIES_GOLEM, SPECIES_MANTID_GYNE, SPECIES_MANTID_ALATE, SPECIES_MONARCH_WORKER, SPECIES_MONARCH_QUEEN)

//Spawn types for characters
#define CHARACTER_SPAWN_TYPE_CRYONET         1 //Will spawn at a cryopod of the last network and faction stored in the character
#define CHARACTER_SPAWN_TYPE_FRONTIER_BEACON 2 //Will spawn at a frontier beacon of the same faction as the character's default faction
#define CHARACTER_SPAWN_TYPE_LACE_STORAGE    3 //Will spawn at the lace storage
#define CHARACTER_SPAWN_TYPE_IMPORT          4 //frontier beacon
#define CHARACTER_SPAWN_TYPE_PERSONAL        5 //Same as cryonet, but for personal cryonets
