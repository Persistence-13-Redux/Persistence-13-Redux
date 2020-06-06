/proc/MakeCloningContract(var/loc, var/text, var/title, var/purpose, var/issuer, var/issuer_account, var/creator, var/amount_to_pay)
	var/obj/item/weapon/paper/contract/C = MakeMiscContract(loc, text, title, purpose, issuer, issuer_account, creator, amount_to_pay, CONTRACT_TYPE_CLONING, FALSE)
	C.commit_to_db()
	C.update_icon()
	return C
