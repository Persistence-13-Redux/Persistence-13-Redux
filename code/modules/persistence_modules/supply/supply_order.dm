/datum/supply_order
	var/paidby = null
	var/last_print = 0
	var/list/point_source_descriptions = list(
			"time" = "Base station supply",
			"manifest" = "From exported manifests",
			"crate" = "From exported crates",
			MATERIAL_PHORON = "From exported phoron",
			MATERIAL_PLATINUM = "From exported platinum",
			"virology" = "From uploaded antibody data",
			"total" = "Total" // If you're adding additional point sources, add it here in a new line. Don't forget to put a comma after the old last line.
		)
