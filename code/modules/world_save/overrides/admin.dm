/datum/get_view_variables_options()
	return ..() + {"
		<option value='?_src_=vars;saved_vars=\ref[src]'>Add/Remove Saved Vars</option>
	"}
