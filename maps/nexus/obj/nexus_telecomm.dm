//hub
/obj/machinery/telecomms/hub/preset/nexus
	id = "NEX_HUB"
	network = "NEXUSCOM"
	autolinkers = list("NEX_HUB", "NEX_RLAY", "NEX_RCVR", "NEX_BCST",
	"NEX_SUP_SRVR", "NEX_SVC_SRVR", "NEX_UNK_SRVR", "NEX_PUB_SRVR", "NEX_ENT_SRVR", "NEX_CMD_SRVR", "NEX_SEC_SRVR", "NEX_ENG_SRVR", "NEX_AI_SRVR", "NEX_SCI_SRVR", "NEX_MED_SRVR")

//receiver
/obj/machinery/telecomms/receiver/preset/nexus
	id = "NEX_RCVR"
	network = "NEXUSCOM"
	autolinkers = list("NEX_RCVR")
	freq_listening = list(AI_FREQ, SCI_FREQ, MED_FREQ, SUP_FREQ, SRV_FREQ, COMM_FREQ, ENG_FREQ, SEC_FREQ, ENT_FREQ)

/obj/machinery/telecomms/receiver/preset/nexus/New()
	for(var/i = PUBLIC_LOW_FREQ, i < PUBLIC_HIGH_FREQ, i += 2)
		freq_listening |= i
	..()

//bus
/obj/machinery/telecomms/bus/preset/nexus
	network = "NEXUSCOM"

/obj/machinery/telecomms/bus/preset/nexus/service
	id = "NEX_SVC_BUS"
	freq_listening = list(SUP_FREQ, SRV_FREQ)
	autolinkers = list("NEX_SVC_PROC", "NEX_SUP_SRVR", "NEX_SVC_SRVR", "NEX_UNK_SRVR")
/obj/machinery/telecomms/bus/preset/nexus/service/New()
	for(var/i = PUBLIC_LOW_FREQ, i < PUBLIC_HIGH_FREQ, i += 2)
		if(i == PUB_FREQ)
			continue
		freq_listening |= i
	..()

/obj/machinery/telecomms/bus/preset/nexus/public
	id = "NEX_PUB_BUS"
	freq_listening = list(PUB_FREQ, ENT_FREQ)
	autolinkers = list("NEX_PUB_PROC", "NEX_PUB_SRVR", "NEX_ENT_SRVR")

/obj/machinery/telecomms/bus/preset/nexus/command
	id = "NEX_CMD_BUS"
	freq_listening = list(SEC_FREQ, COMM_FREQ)
	autolinkers = list("NEX_CMD_PROC", "NEX_CMD_SRVR", "NEX_SEC_SRVR")

/obj/machinery/telecomms/bus/preset/nexus/engineering
	id = "NEX_ENG_BUS"
	freq_listening = list(ENG_FREQ, AI_FREQ)
	autolinkers = list("NEX_ENG_PROC", "NEX_ENG_SRVR", "NEX_AI_SRVR")

/obj/machinery/telecomms/bus/preset/nexus/science
	id = "NEX_SCI_BUS"
	freq_listening = list(SCI_FREQ, MED_FREQ)
	autolinkers = list("NEX_SCI_PROC", "NEX_SCI_SRVR", "NEX_MED_SRVR")

//processor
/obj/machinery/telecomms/processor/preset/nexus
	network = "NEXUSCOM"

/obj/machinery/telecomms/processor/preset/nexus/public
	id = "NEX_PUB_PROC"
	autolinkers = list("NEX_PUB_PROC")

/obj/machinery/telecomms/processor/preset/nexus/service
	id = "NEX_SVC_PROC"
	autolinkers = list("NEX_SVC_PROC")

/obj/machinery/telecomms/processor/preset/nexus/command
	id = "NEX_CMD_PROC"
	autolinkers = list("NEX_CMD_PROC")

/obj/machinery/telecomms/processor/preset/nexus/engineering
	id = "NEX_ENG_PROC"
	autolinkers = list("NEX_ENG_PROC")

/obj/machinery/telecomms/processor/preset/nexus/science
	id = "NEX_SCI_PROC"
	autolinkers = list("NEX_SCI_PROC")

//
/obj/machinery/telecomms/server/presets/nexus
	network = "NEXUSCOM"

/obj/machinery/telecomms/server/presets/nexus/public
	id = "NEX_PUB_SRVR"
	freq_listening = list(PUB_FREQ)
	autolinkers = list("NEX_PUB_SRVR")

/obj/machinery/telecomms/server/presets/nexus/service
	id = "NEX_SVC_SRVR"
	freq_listening = list(SRV_FREQ)
	autolinkers = list("NEX_SVC_SRVR")

/obj/machinery/telecomms/server/presets/nexus/entertainment
	id = "NEX_ENT_SRVR"
	freq_listening = list(ENT_FREQ)
	autolinkers = list("NEX_ENT_SRVR")

/obj/machinery/telecomms/server/presets/nexus/ai
	id = "NEX_AI_SRVR"
	freq_listening = list(AI_FREQ)
	autolinkers = list("NEX_AI_SRVR")

/obj/machinery/telecomms/server/presets/nexus/command
	id = "NEX_CMD_SRVR"
	freq_listening = list(COMM_FREQ)
	autolinkers = list("NEX_CMD_SRVR")

/obj/machinery/telecomms/server/presets/nexus/security
	id = "NEX_SEC_SRVR"
	freq_listening = list(SEC_FREQ)
	autolinkers = list("NEX_SEC_SRVR")

/obj/machinery/telecomms/server/presets/nexus/engineering
	id = "NEX_ENG_SRVR"
	freq_listening = list(ENG_FREQ)
	autolinkers = list("NEX_ENG_SRVR")

/obj/machinery/telecomms/server/presets/nexus/supply
	id = "NEX_SUP_SRVR"
	freq_listening = list(SUP_FREQ)
	autolinkers = list("NEX_SUP_SRVR")

/obj/machinery/telecomms/server/presets/nexus/medical
	id = "NEX_MED_SRVR"
	freq_listening = list(MED_FREQ)
	autolinkers = list("NEX_MED_SRVR")

/obj/machinery/telecomms/server/presets/nexus/science
	id = "NEX_SCI_SRVR"
	freq_listening = list(SCI_FREQ)
	autolinkers = list("NEX_SCI_SRVR")

/obj/machinery/telecomms/server/presets/nexus/unknown
	id = "NEX_UNK_SRVR"
	freq_listening = list()
	autolinkers = list("NEX_UNK_SRVR")

/obj/machinery/telecomms/server/presets/nexus/unknown/New()
	for(var/i = PUBLIC_LOW_FREQ, i < PUBLIC_HIGH_FREQ, i += 2)
		if(i == AI_FREQ || i == PUB_FREQ)
			continue
		freq_listening |= i
	..()

//broadcaster
/obj/machinery/telecomms/broadcaster/preset/nexus
	id = "NEX_BCST"
	network = "NEXUSCOM"
	autolinkers = list("NEX_BCST")