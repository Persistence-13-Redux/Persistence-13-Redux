// /datum/council_vote
// 	var/name = "" // title of votes
// 	var/bill_type = 1 //  1 = criminal law, 2 = civil law, 3 = tax policy, 4 = impeachment (judge) 5 = nomination (judge) 6 = repeal law

// 	var/sponsor = "" // real_name of the vote starter
// 	var/time_started // realtime of when the vote started.
// 	var/time_signed // realtime when passed

// 	var/signer = ""

// 	var/list/yes_votes = list()
// 	var/list/no_votes = list()

// 	var/body = "" // used by civil and criminal laws

// 	var/tax = 0 // 1 = personal 2 = business

// 	var/taxtype = 1 // 1 = flat, 2 = progressive

// 	var/flatrate = 0

// 	var/prograte1 = 0
// 	var/prograte2 = 0
// 	var/prograte3 = 0
// 	var/prograte4 = 0

// 	var/progamount2 = 0
// 	var/progamount3 = 0
// 	var/progamount4 = 0

// 	var/impeaching = "" // real_name of impaechment target

// 	var/nominated = ""

// 	var/datum/council_vote/repealing
