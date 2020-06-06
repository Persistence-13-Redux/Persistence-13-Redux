//Engineering
/area/fringe/engineering
	name = FRINGE_STATION_NAME_ABBR + " Engineering"
	icon_state = "engineering"
/area/fringe/engineering/storage
	name = FRINGE_STATION_NAME_ABBR + " Engineering Storage"
	sound_env = SMALL_ENCLOSED
/area/fringe/engineering/atmos
	name = FRINGE_STATION_NAME_ABBR + " Atmospherics"
	icon_state = "atmos"
	sound_env = LARGE_ENCLOSED
	req_access = list(access_atmospherics)
/area/fringe/engineering/atmos/tank
	name = FRINGE_STATION_NAME_ABBR + " Storage Tank"
	sound_env = SMALL_ENCLOSED
/area/fringe/engineering/engine
	name = FRINGE_STATION_NAME_ABBR + " Engine Room"
	icon_state = "engine"
	sound_env = LARGE_ENCLOSED
	req_access = list(access_engine, access_engine_equip)
/area/fringe/engineering/engine/reactor
	name = FRINGE_STATION_NAME_ABBR + " Reactor Room"
	sound_env = SMALL_ENCLOSED
/area/fringe/engineering/power
	name = FRINGE_STATION_NAME_ABBR + " Power Room"
	icon_state = "engine_smes"
	sound_env = SMALL_ENCLOSED
	req_access = list(access_engine, access_engine_equip)
/area/fringe/engineering/comms
	name = FRINGE_STATION_NAME_ABBR + " Telecomms Room"
	sound_env = SMALL_ENCLOSED
	req_access = list(access_tcomsat)
/area/fringe/engineering/comms/servers
	name = FRINGE_STATION_NAME_ABBR + " Telecomms Server Room"
	sound_env = SMALL_ENCLOSED

//Command
/area/fringe/admin
	name = FRINGE_STATION_NAME_ABBR + " Administration"
	icon_state = "conference"
	req_access = list(access_heads)
/area/fringe/admin/bridge
	name = FRINGE_STATION_NAME_ABBR + " Bridge"
	icon_state = "bridge"
	req_access = list(access_bridge)
/area/fringe/admin/brig
	name = FRINGE_STATION_NAME_ABBR + " Brig"
	icon_state = "brig"
	req_access = list(access_sec_doors)

//Dinner
/area/fringe/dinner
	name = FRINGE_STATION_NAME_ABBR + " Dinner"
	icon_state = "cafeteria"
	sound_env = LARGE_SOFTFLOOR
/area/fringe/dinner/kitchen
	name = FRINGE_STATION_NAME_ABBR + " Dinner Kitchen"
	sound_env = SMALL_ENCLOSED
	icon_state = "kitchen"
	req_access = list(access_kitchen)
/area/fringe/dinner/storage
	name = FRINGE_STATION_NAME_ABBR + " Dinner Storage"
	sound_env = SMALL_ENCLOSED
	icon_state = "kitchen"
	req_access = list(access_kitchen)
/area/fringe/dinner/hydro
	name = FRINGE_STATION_NAME_ABBR + " Dinner Hydroponics"
	sound_env = SMALL_ENCLOSED
	icon_state = "hydro"
	req_access = list(access_kitchen)
/area/fringe/dinner/restroom
	name = FRINGE_STATION_NAME_ABBR + " Dinner Restroom"
	icon_state = "toilet"
	sound_env = SMALL_ENCLOSED
	req_access = list()

//Bar
/area/fringe/bar
	name = FRINGE_STATION_NAME_ABBR + " Bar"
	icon_state = "bar"
	sound_env = LARGE_SOFTFLOOR
/area/fringe/bar/backroom
	name = FRINGE_STATION_NAME_ABBR + " Bar Backroom"
	sound_env = SMALL_ENCLOSED
	req_access = list(access_bar)

//Recroom
/area/fringe/recreation
	name = FRINGE_STATION_NAME_ABBR + " Recreation Room"
	icon_state = "crew_quarters"
	sound_env = MEDIUM_SOFTFLOOR

//Common area
/area/fringe/common
	name = FRINGE_STATION_NAME_ABBR + " Common Area"
	sound_env = MEDIUM_SOFTFLOOR

//Hangars
/area/fringe/hangar
	icon_state = "hangar"
	sound_env = LARGE_ENCLOSED
/area/fringe/hangar/west
	name = FRINGE_STATION_NAME_ABBR + " West Shuttle Hangar"
/area/fringe/hangar/east/south
	name = FRINGE_STATION_NAME_ABBR + " South East Shuttle Hangar"
/area/fringe/hangar/east/north
	name = FRINGE_STATION_NAME_ABBR + " North East Shuttle Hangar"

//Cargo
/area/fringe/cargo
	req_access = list(access_cargo)
/area/fringe/cargo/storage
	name = FRINGE_STATION_NAME_ABBR + " Cargo Storage"
	icon_state = "quartstorage"
	sound_env = SMALL_ENCLOSED
/area/fringe/cargo/mail
	name = FRINGE_STATION_NAME_ABBR + " Cargo Delivery"
/area/fringe/cargo/reception
	name = FRINGE_STATION_NAME_ABBR + " Cargo Reception"
/area/fringe/cargo/disposal
	name = FRINGE_STATION_NAME_ABBR + " Cargo Disposal"
	icon_state = "disposal"

//Airlocks
/area/fringe/airlock
	name = FRINGE_STATION_NAME_ABBR + " Airlock"

//Cryo
/area/fringe/cryo
	name = FRINGE_STATION_NAME_ABBR + " Cryogenic Storage"
	icon_state = "Sleep"
	sound_env = SMALL_SOFTFLOOR
	area_flags = AREA_FLAG_RAD_SHIELDED | AREA_FLAG_ION_SHIELDED

//Arrivals
/area/fringe/arrivals
	name = FRINGE_STATION_NAME_ABBR + " Arrivals"
	icon_state = "teleporter"
	sound_env = SMALL_ENCLOSED
/area/fringe/arrivals/equipment
	name = FRINGE_STATION_NAME_ABBR + " Arrivals Equipment Room"
	sound_env = SMALL_ENCLOSED
/area/fringe/arrivals/hall
	name = FRINGE_STATION_NAME_ABBR + " Arrivals Hall"
	sound_env = HALLWAY

//Medical
/area/fringe/infirmary
	name = FRINGE_STATION_NAME_ABBR + " Infirmary"
	icon_state = "medbay"
	req_access = list(access_medical)
	ambience = list('sound/ambience/signal.ogg')
	sound_env = SMALL_ENCLOSED
/area/fringe/infirmary/storage
	name = FRINGE_STATION_NAME_ABBR + " Infirmary Storage"
	icon_state = "medbay4"
	ambience = list('sound/ambience/signal.ogg')
	req_access = list(access_medical_equip)
	sound_env = SMALL_ENCLOSED

//Shuttles/Elevators
/area/fringe/shuttle/lift
	name = FRINGE_STATION_NAME_ABBR + " Cargo Lift"
	icon_state = "shuttle3"
	base_turf = /turf/simulated/open