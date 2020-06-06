/proc/medical_scan_results_virus(var/mob/living/carbon/human/H, var/verbose, var/skill_level, var/print_reagent_default_message)
	. = ""
	if(H.virus2.len)
		for (var/ID in H.virus2)
			if (ID in virusDB)
				print_reagent_default_message = FALSE
				var/datum/computer_file/data/virus_record/V = virusDB[ID]
				. += "<span class='scan_warning'>Warning: Pathogen [V.fields["name"]] detected in subject's blood. Known antigen : [V.fields["antigen"]]</span>"
	. = jointext(.,"<br>")

