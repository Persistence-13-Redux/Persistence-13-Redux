/obj/item/weapon/paper/invoice
	name = "Invoice"
	icon_state = "invoice"
	var/transaction_amount = 0
	var/linked_faction
	var/paid = FALSE
	var/purpose = ""
	var/salesperson = ""
	var/salesperson_account_number
	var/title = "Invoice" //Basically what is inserted into the "source" field of the transaction

/obj/item/weapon/paper/invoice/on_update_icon()
	if(paid)
		icon_state = "invoice-paid"
	else
		icon_state = "invoice"

/obj/item/weapon/paper/invoice/show_content(mob/user, forceshow)
	var/can_read = (istype(user, /mob/living/carbon/human) || isghost(user) || istype(user, /mob/living/silicon)) || forceshow
	if(!forceshow && istype(user,/mob/living/silicon/ai))
		var/mob/living/silicon/ai/AI = user
		can_read = get_dist(src, AI.camera) < 2
	var/info2 = info
	if(src.Adjacent(user) && !paid)
		info2 += "<br><A href='?src=\ref[src];pay=1'>Or enter account info here.</A>"
	else
		info2 += "<br>Or enter account info here."
	show_browser(user, "<HTML><HEAD><TITLE>[name]</TITLE></HEAD><BODY bgcolor='[color]'>[can_read ? info2 : stars(info)][stamps]</BODY></HTML>", "window=[name]")
	onclose(user, "[name]")

/obj/item/weapon/paper/invoice/attackby(obj/item/weapon/P as obj, mob/user as mob)
	if(istype(P, /obj/item/weapon/pen))
		return
	if(istype(P, /obj/item/weapon/card))
		return handle_payment(user, P)
	return ..()

/obj/item/weapon/paper/invoice/proc/handle_payment(var/mob/user, var/obj/item/weapon/card/C)
	if(paid) 
		to_chat(user, SPAN_WARNING("\The [src] was already paid for!"))
		return
	
	//Get the actual payer's name
	var/datum/money_account/paying_account = GetAccountFromPaymentItems(C)
	var/payer = paying_account ? paying_account.owner_name : "Unknown"
	//Compute the profit the faction makes 
	var/datum/world_faction/connected_faction = FindFaction(linked_faction)
	if(!connected_faction)
		to_chat(user, SPAN_WARNING("\The associated issuer uid \"[linked_faction]\" doesn't exist!"))
		return
	
	//Commission stuff
	var/datum/money_account/sales_account = null
	var/commission_amount = 0
	var/datum/world_faction/business/business = istype(connected_faction, /datum/world_faction/business) ? connected_faction : null
	if(business && business.commission)
		commission_amount = round((transaction_amount/100) * business.commission)
		sales_account = get_account(salesperson_account_number)

	//Do the actual payment
	if(!HandlePaymentItems(user, C, transaction_amount, connected_faction.central_account, purpose, title, commission_amount, sales_account, "[connected_faction.name] (via invoice commission)"))
		return FALSE
	handle_post_payment(user, transaction_amount, payer, connected_faction)
	return TRUE

//Do the things we need to do after the invoice was successfully paid
/obj/item/weapon/paper/invoice/proc/handle_post_payment(var/mob/user, var/paid, var/payer, var/datum/world_faction/F)
	paid = TRUE
	info = replacetext(info, "*Unpaid*", "Paid")
	info = replacetext(info, "*None*", "[payer]")
	//If its a business, handle objectives
	if(istype(F, /datum/world_faction/business))
		var/datum/world_faction/business/business = F
		business.sales_objectives(payer, 1)
	update_icon()

/obj/item/weapon/paper/invoice/OnTopic(var/mob/user, var/href_list, var/datum/topic_state/state)
	if(href_list["pay"] && !paid)
		handle_payment(user, user.GetIdCard())
	. = ..()

//
// IMPORT
//
/obj/item/weapon/paper/invoice/import
	name = "Import invoice"
	title = "Import Invoice"
	var/datum/supply_order/linked_order
	var/raw_total = 0 //Price of only the goods/service without the commission/taxes

/obj/item/weapon/paper/invoice/import/handle_post_payment(var/mob/user, var/paid, var/payer, var/datum/world_faction/F)
	F.approve_pending_order(linked_order.ordernum, payer)
	. = ..()

//
// Business
//
/obj/item/weapon/paper/invoice/business
	title = "Business Invoice"

/obj/item/weapon/paper/invoice/import/handle_post_payment(var/mob/user, var/paid, var/payer, var/datum/world_faction/business/B)
	B.pay_tax(paid)
	B.sales_short += paid
	. = ..()
