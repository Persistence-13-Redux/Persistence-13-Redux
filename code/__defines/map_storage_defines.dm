
#define ADD_SAVED_VAR(X) map_storage_saved_vars = "[map_storage_saved_vars][length(map_storage_saved_vars)? ";" : null][#X]"
#define ADD_SKIP_EMPTY(X) skip_empty = "[skip_empty][length(skip_empty)? ";" : null][#X]"

//Adds a global datum not referred to by an entity on the map to be saved when saving the map
#define SAVE_ORPHAN_DATUM(X) LAZYDISTINCTADD(saved_datums, X)

//Adds a global list not referred to by an entity on the map to be saved when saving the map
#define SAVE_ORPHAN_LIST(X) LAZYDISTINCTADD(saved_lists, X)

#define DEFAULT_MAX_SAVE_SLOTS 3
#define MAXIMUM_GLOBAL_SAVE_SLOTS 25 //The absolute maximum ever allowed, mainly used for sanity checks