/obj/item/weapon/gun/New()
	..()
	ADD_SAVED_VAR(sel_mode)
	ADD_SAVED_VAR(safety_state)

/obj/item/weapon/gun/verb/rename_gun()
	set name = "Name Gun"
	set category = "Object"
	set desc = "Click to rename your gun."

	var/mob/M = usr
	if(!M.mind)	return 0

	var/input = sanitizeSafe(input("What do you want to name the gun?", ,""), MAX_NAME_LEN)

	if(src && input && !M.stat && in_range(M,src))
		name = input
		to_chat(M, "You name the gun [input]. Say hello to your new friend.")
		return 1