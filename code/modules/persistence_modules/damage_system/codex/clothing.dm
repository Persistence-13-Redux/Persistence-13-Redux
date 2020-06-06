/obj/item/clothing
	armour_to_descriptive_term = list(
		DAM_BLUNT = "blunt force",
		DAM_PIERCE = "piercing force",
		DAM_CUT = "shearing force",
		DAM_BULLET = "ballistics",
		DAM_LASER = "lasers",
		DAM_ENERGY = "energy",
		DAM_EMP = "EMP",
		DAM_BURN = "burns",
		DAM_BOMB = "explosions",
		DAM_BIO = "biohazards",
		DAM_RADS = "radiation",
		DAM_STUN = "stun"
		)

/obj/item/clothing/get_mechanics_info()
	var/list/armor_strings = list()
	if(armor)
		for(var/armor_type in armour_to_descriptive_term)
			if(armor[armor_type])
				switch(armor[armor_type])
					if(1 to 20)
						armor_strings += "It barely protects against [armour_to_descriptive_term[armor_type]]."
					if(21 to 30)
						armor_strings += "It provides a very small defense against [armour_to_descriptive_term[armor_type]]."
					if(31 to 40)
						armor_strings += "It offers a small amount of protection against [armour_to_descriptive_term[armor_type]]."
					if(41 to 50)
						armor_strings += "It offers a moderate defense against [armour_to_descriptive_term[armor_type]]."
					if(51 to 60)
						armor_strings += "It provides a strong defense against [armour_to_descriptive_term[armor_type]]."
					if(61 to 70)
						armor_strings += "It is very strong against [armour_to_descriptive_term[armor_type]]."
					if(71 to 80)
						armor_strings += "This gives a very robust defense against [armour_to_descriptive_term[armor_type]]."
					if(81 to 99)
						armor_strings += "Wearing this would make you nigh-invulerable against [armour_to_descriptive_term[armor_type]]."
					if(100)
						armor_strings += "You would be immune to [armour_to_descriptive_term[armor_type]] if you wore this."
