/obj/machinery/mineral/unloading_machine/Process()
	if(input_turf && output_turf)
		if(length(output_turf.contents) < 15)
			var/ore_this_tick = 10
			for(var/obj/structure/ore_box/unloading in input_turf)
				for(var/obj/item/stack/ore/_ore in unloading)
					_ore.dropInto(output_turf)
					if(--ore_this_tick<=0) return
			for(var/obj/item/_ore in input_turf)
				if(_ore.simulated && !_ore.anchored)
					_ore.dropInto(output_turf)
					if(--ore_this_tick<=0) return