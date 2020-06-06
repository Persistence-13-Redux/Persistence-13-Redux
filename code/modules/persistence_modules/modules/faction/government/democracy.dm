/datum/world_faction
	var/tax_rate = 10
	var/import_profit = 10
	var/export_profit = 20

// /datum/democracy
// 	var/real_name // real_name of elected
// 	var/term_start // real time
// 	var/title = "Councillor"
// 	var/description = "Vote on laws civil and criminal, the tax code and confirming judges nominated by the governor."
// 	var/consecutive_terms = 0

// 	var/election_desc = ""
// 	var/seeking_reelection = 1

// 	var/list/candidates = list()
// 	var/list/voted_ckeys = list() // to prevent double voting

// /datum/democracy/governor
// 	title = "Governor"
// 	description = "Manage the executive government by creating assignments, ranks and accesses while publishing executive policy documents. Nominate Judges."

// /datum/democracy/councillor

// /datum/democracy/judge
// 	title = "Judge"

// /datum/candidate
// 	var/real_name = "" // real name of candidate
// 	var/ckey = "" // ckey of candidate to prevent self voting
// 	var/list/votes = list() // list of unqiue names voting for the candidate

// 	var/desc = ""

// /datum/verdict
// 	var/name = "" //title
// 	var/judge = ""
// 	var/defendant = ""
// 	var/body = ""
// 	var/time_rendered = 0
// 	var/citizenship_change = 0

// /datum/judge_trial
// 	var/name = "" //title
// 	var/judge = ""
// 	var/defendant = ""
// 	var/plaintiff = ""
// 	var/body = ""
// 	var/month = ""
// 	var/day = 0
// 	var/hour = 0