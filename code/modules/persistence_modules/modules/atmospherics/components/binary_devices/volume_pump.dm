//Keep base class from overwriting loaded values
/obj/machinery/atmospherics/binary/pump/high_power/on/distribution/Initialize()
	var/old_pressure = target_pressure
	. = ..()
	if(map_storage_loaded)
		target_pressure = old_pressure