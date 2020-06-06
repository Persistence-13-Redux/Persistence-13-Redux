/obj/machinery/ntnet_relay
	name = "Net Quantum Relay"

/obj/machinery/ntnet_relay/New()
	uid = gl_uid
	gl_uid++
	register_relay()
	..()
	ADD_SAVED_VAR(enabled)

/obj/machinery/ntnet_relay/Destroy()
	unregister_relay()
	NTNet = null
	for(var/datum/computer_file/program/ntnet_dos/D in dos_sources)
		D.target = null
		D.error = "Connection to quantum relay severed"
	return ..()

//Code ran at creation to register the relay
/obj/machinery/ntnet_relay/proc/register_relay()
	if(ntnet_global)
		ntnet_global.relays.Add(src)
		NTNet = ntnet_global
		ntnet_global.add_log("New quantum relay activated. Current amount of linked relays: [NTNet.relays.len]")

//Code ran at destruction to unregister the relay
/obj/machinery/ntnet_relay/proc/unregister_relay()
	if(ntnet_global)
		ntnet_global.relays.Remove(src)
		ntnet_global.add_log("Quantum relay connection severed. Current amount of linked relays: [NTNet.relays.len]")