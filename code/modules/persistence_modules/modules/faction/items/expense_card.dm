GLOBAL_LIST_EMPTY(all_expense_cards)

/proc/devalidate_expense_cards(var/stype = 1, var/name)
	for(var/obj/item/weapon/card/expense/expense in GLOB.all_expense_cards)
		if(expense.ctype == stype && expense.linked == name)
			expense.name = "devalidated expense card"
			expense.linked = ""
			expense.owner_name = null
			expense.valid = 0

/obj/item/weapon/card/expense // the fabled expense card
	desc = "This card is used to expense invoices."
	name = "expense card"
	icon = 'code/modules/persistence_modules/icons/obj/items/extra_card.dmi'
	icon_state = "expense"
	item_state = "card-id"
	var/ctype = 1 // 1 = faction, 2 = business
	var/owner_name = ""
	var/linked = "" // either business or faction
	var/valid = 1
	var/detail_color = COLOR_SILVER
	var/stripe_color = COLOR_BLUE

/obj/item/weapon/card/expense/New()
	..()
	GLOB.all_expense_cards |= src

/obj/item/weapon/card/expense/Destroy()
	GLOB.all_expense_cards -= src
	..()

/obj/item/weapon/card/expense/on_update_icon()
	overlays.Cut()
	var/image/detail_overlay = image(icon, src,"[icon_state]-color")
	var/image/stripe_overlay = image(icon, src,"[icon_state]-color-stripe")
	detail_overlay.color = detail_color
	stripe_overlay.color = stripe_color
	overlays += detail_overlay
	overlays += stripe_overlay

/obj/item/weapon/card/expense/proc/pay(var/amount, var/mob/user, var/obj/item/weapon/paper/invoice/invoice)
	if(!user || !invoice || !valid)
		return 0

	var/username = user.get_id_name("NULL!@#")
	if(username == "NULL!@#")
		to_chat(user, "Invalid ID!")
		return 0

	var/linked_name
	var/datum/world_faction/linked_faction = FindFaction(invoice.linked_faction)
	linked_name = linked_faction.name
	var/datum/world_faction/F = FindFaction(linked)

	var/datum/computer_file/report/crew_record/faction/R = F.get_record(username)
	if(!R)
		return 0
	var/datum/assignment/assignment = F.get_assignment(R.get_assignment_uid(), R.get_name())
	if(!assignment)
		return 0
	// var/datum/accesses/copy = assignment.accesses[R.get_rank()]
	// if(!copy)
	// 	return 0
	var/available = F.get_member_available_expenses(username)
	if(available < amount)
		to_chat(user, "This exceeds your expense limit.")
		return 0
	if(F.get_central_account().get_balance() < amount)
		to_chat(user, "Insufficent funds.")
		return 0

	F.get_central_account().withdraw(amount, invoice.purpose, "[linked_name] (via [username] expense card)")
	linked_faction.add_to_member_expenses(R.get_name(), amount)
	return 1




