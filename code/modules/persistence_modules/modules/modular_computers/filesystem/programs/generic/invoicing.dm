/datum/computer_file/program/invoicing
	filename = "invoicing-program"
	filedesc = "Organization Invoice Creation"
	nanomodule_path = /datum/nano_module/program/invoicing
	program_icon_state = "supply"
	program_menu_icon = "cart"
	extended_desc = "A tool for creating digital invoices that act as one time payment processors for networks to recieve payment from individual accounts."
	size = 2
	available_on_ntnet = 1
	requires_ntnet = 1
	usage_flags = PROGRAM_ALL
	category = PROG_UTIL

/datum/nano_module/program/invoicing
	name = "Invoicing program"
	var/screen = 1		// 0: Ordering menu, 1: Statistics 2: Shuttle control, 3: Orders menu
	var/selected_category
	var/list/category_names
	var/list/category_contents
	var/current_security_level
	var/reason
	var/amount = 0

/datum/nano_module/program/invoicing/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, state = GLOB.default_state)
	var/list/data = host.initial_data()
	var/datum/world_faction/connected_faction = program.get_network_faction()
	if(!connected_faction)
		program.computer.kill_program()
	data["faction_name"] = connected_faction.name
	data["credits"] = connected_faction.central_account.money
	data["can_print"] = can_print()
	data["screen"] = screen
	data["amount"] = amount
	data["reason"] = reason ? reason : "Unset"

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "invoicing.tmpl", name, 1050, 500, state = state)
		ui.set_auto_update(1)
		ui.set_initial_data(data)
		ui.open()

/datum/nano_module/program/invoicing/Topic(href, href_list)
	if(..())
		return 1
	var/datum/world_faction/connected_faction = program.get_network_faction()
	if(!connected_faction)
		return 1

	if(href_list["change_reason"])
		var/newtext = sanitize(input(usr, "Enter the reason for the invoice, used in related transactions.", "Change reason", reason) as message|null, MAX_TEXTFILE_LENGTH)
		if(!newtext)
			to_chat(usr,"Text was not valid.")
			return 1
		reason = newtext
		return 1

	if(href_list["change_amount"])
		var/newtext = input("Invoice amount", "Invoice amount", amount) as null|num
		if(!newtext)
			to_chat(usr,"You cannot create an invoice for nothing.")
			return 1
		amount = newtext
		return 1
	if(href_list["finish"])
		if(!amount || !reason || reason == "")
			to_chat(usr,"You must have a valid amount and reason before you can print the invoice.")
			return 1
		print_invoice(usr)
		amount = 0
		reason = null
		return 1

/datum/nano_module/program/invoicing/proc/can_print()
	var/obj/item/modular_computer/MC = nano_host()
	if(!istype(MC) || !istype(MC.nano_printer))
		return 0
	return 1

/datum/nano_module/program/invoicing/proc/print_invoice(var/mob/user)
	if(amount < 0) return
	var/datum/world_faction/connected_faction = program.get_network_faction()
	if(!connected_faction)
		return 1
	var/idname = "*None Provided*"
	var/idrank = "*None Provided*"
	var/acc_num = 0
	var/obj/item/weapon/card/id/I = user.GetIdCard()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		idname = H.get_authentification_name()
		idrank = H.get_assignment()
	else if(issilicon(user))
		idname = user.real_name
	acc_num = I.associated_account_number
	var/t = ""
	t += "<font face='Verdana' color=blue><table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'><center></td><tr><td><H1>[connected_faction.name]</td>"
	t += "<tr><td><br><b>Status:</b>*Unpaid*<br>"
	t += "<b>Total:</b> [amount] $$ Ethericoins<br><br><table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>"
	t += "<td>Authorized by:<br>[idname] [idrank]<br><td>Paid by:<br>*None*</td></tr></table><br></td>"
	t += "<tr><td><h3>Reason</H3><font size = '1'>[reason]<br></td></tr></table><br><table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>"
	t += "<td></font><font size='4'><b>Swipe Expense Card to confirm transaction.</b></font></center></font>"
	var/obj/item/weapon/paper/invoice/invoice = new()
	invoice.info = t
	invoice.purpose = reason
	invoice.transaction_amount = amount
	invoice.linked_faction = connected_faction.uid
	invoice.loc = get_turf(program.computer)
	playsound(get_turf(program.computer), pick('sound/items/polaroid1.ogg', 'sound/items/polaroid2.ogg'), 75, 1, -3)
	invoice.name = "[connected_faction.abbreviation] digital invoice"
	invoice.salesperson = idname
	invoice.salesperson_account_number = acc_num
