/obj/item/weapon/storage/wallet/GetAccess(var/faction_uid)
	var/obj/item/I = GetIdCard()
	if(I)
		return I.GetAccess(faction_uid)
	else
		return ..(faction_uid)