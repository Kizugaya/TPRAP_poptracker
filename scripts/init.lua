--
ENABLE_DEBUG_LOG = true

ScriptHost:LoadScript("scripts/region_rules.lua")
ScriptHost:LoadScript("scripts/item_mapping.lua")
ScriptHost:LoadScript("scripts/location_mapping.lua")
ScriptHost:LoadScript("scripts/region_mapping.lua")
ScriptHost:LoadScript("scripts/server_copy_keys.lua")
ScriptHost:LoadScript("scripts/control.lua")
ScriptHost:LoadScript("scripts/autotracking.lua")
ScriptHost:LoadScript("scripts/code_watchers.lua")
ScriptHost:LoadScript("scripts/init_rando_doors.lua")

--
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/dungeonnames.json")
Tracker:AddItems("items/item_settings.json")
Tracker:AddItems("items/entrance_rando_doors.json")



--
Tracker:AddMaps("maps/maps.json")
Tracker:AddMaps("maps/coo.json")



--
Tracker:AddLayouts("layouts/tracker.json")

Tracker:AddLayouts("layouts/archipelago_item_grid.json")
Tracker:AddLayouts("layouts/bugs.json")
Tracker:AddLayouts("layouts/archipelago_keys.json")
Tracker:AddLayouts("layouts/portals.json")

Tracker:AddLayouts("layouts/layout_settings.json")
Tracker:AddLayouts("layouts/broadcast_items.json")


Tracker:AddLayouts("layouts/tutorial.json")

--
Tracker:AddLocations("locations/tutorial.json")

Tracker:AddLocations("locations/overworld/eldin.json")
Tracker:AddLocations("locations/overworld/faron.json")
Tracker:AddLocations("locations/overworld/gerudo desert.json")
Tracker:AddLocations("locations/overworld/lanayru.json")
Tracker:AddLocations("locations/overworld/ordon.json")
Tracker:AddLocations("locations/overworld/snowpeak mountain.json")
Tracker:AddLocations("locations/overworld/main map.json")

Tracker:AddLocations("locations/dungeons/forest temple.json")
Tracker:AddLocations("locations/dungeons/goron mines.json")
Tracker:AddLocations("locations/dungeons/lakebed temple.json")
Tracker:AddLocations("locations/dungeons/arbiter's grounds.json")
Tracker:AddLocations("locations/dungeons/snowpeak ruins.json")
Tracker:AddLocations("locations/dungeons/temple of time.json")
Tracker:AddLocations("locations/dungeons/city in the sky.json")
Tracker:AddLocations("locations/dungeons/palace of twilight.json")
Tracker:AddLocations("locations/dungeons/hyrule castle.json")


Tracker:FindObjectForCode("@Tutorial Locations/Obtained/").AvailableChestCount = 0

occupyRoomSetting()