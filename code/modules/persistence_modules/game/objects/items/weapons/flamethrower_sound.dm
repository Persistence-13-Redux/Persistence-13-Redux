//Called from turf.dm turf/dblclick
/obj/item/weapon/flamethrower/flame_turf(turflist)
	if(!lit || operating)	return
	operating = 1
	playsound(src.loc, 'sound/weapons/flamethrower.ogg', 50, 0)
	for(var/turf/T in turflist)
		if(T.density)
			break
		if(!previousturf && length(turflist)>1)
			previousturf = get_turf(src)
			continue	//so we don't burn the tile we be standin on
		if(previousturf && LinkBlocked(previousturf, T))
			break
		ignite_turf(T)
		sleep(1)
	previousturf = null
	operating = 0
	for(var/mob/M in viewers(1, loc))
		if((M.client && M.machine == src))
			attack_self(M)
