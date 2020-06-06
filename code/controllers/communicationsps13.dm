var/const/RADIO_CUSTOM_FREQ = 1700
var/const/RADIO_CUSTOM_FREQ_MAX = 1800

//Machines
var/const/MAGNET_FREQ			= 1311
var/const/INCINERATOR_FREQ		= 1378
var/const/DOOR_FREQ				= 1379
var/const/MISC_MACHINE_FREQ		= 1202
var/const/ALARMLOCKS_FREQ		= 1437
var/const/ENGINE_FREQ			= 1438
var/const/AIRALARM_FREQ			= 1439
var/const/STATUS_FREQ 			= 1435
var/const/ATMOS_CONTROL_FREQ 	= 1441
var/const/POD_LAUNCHER_FREQ 	= 1452

var/const/RADIO_EMITTERS 		= "radio_emitter"
var/const/RADIO_MASSDRIVER		= "radio_massdriver"
var/const/RADIO_FLASHERS		= "radio_flasher"
var/const/RADIO_STATUS_DISPLAY  = "radio_status_display"
var/const/RADIO_INCINERATOR  	= "radio_incinerator"
var/const/RADIO_POD_LAUNCHER	= "radio_podlauncher"
var/const/RADIO_FOAM_DISPENSER	= "radio_foam_dispenser"
var/const/RADIO_RECYCLER		= "radio_recycler"
var/const/RADIO_ENGI			= "radio_engi"
var/const/RADIO_BLAST_DOORS		= "radio_blastdoor"

/obj/receive_signal(var/datum/signal/signal, var/receive_method = TRANSMISSION_RADIO, var/receive_param = null)
	return ..()
