--
ENABLE_DEBUG_LOG = true

ScriptHost:LoadScript("scripts/control.lua")
ScriptHost:LoadScript("scripts/autotracking.lua")



--
Tracker:AddItems("items/items.json")



--
Tracker:AddMaps("maps/maps.json")



--
Tracker:AddLayouts("layouts/tracker.json")


Tracker:AddLayouts("layouts/layouts_maps.json")

Tracker:AddLayouts("layouts/item_grid.json")
Tracker:AddLayouts("layouts/bugs.json")
Tracker:AddLayouts("layouts/keys.json")
Tracker:AddLayouts("layouts/bosses.json")
Tracker:AddLayouts("layouts/dungeon_keys.json")

Tracker:AddLayouts("layouts/settings.json")



--
Tracker:AddLocations("locations/rooms/overworld.json")
Tracker:AddLocations("locations/rooms/ft.json")
Tracker:AddLocations("locations/rooms/gm.json")
Tracker:AddLocations("locations/rooms/lt.json")
Tracker:AddLocations("locations/rooms/ag.json")
Tracker:AddLocations("locations/rooms/sr.json")
Tracker:AddLocations("locations/rooms/tt.json")
Tracker:AddLocations("locations/rooms/cs.json")
Tracker:AddLocations("locations/rooms/pt.json")
Tracker:AddLocations("locations/rooms/hc.json")

Tracker:AddLocations("locations/overworld.json")

Tracker:AddLocations("locations/forest temple.json")
Tracker:AddLocations("locations/goron mines.json")
Tracker:AddLocations("locations/lakebed temple.json")
Tracker:AddLocations("locations/arbiter's grounds.json")
Tracker:AddLocations("locations/snowpeak ruins.json")
Tracker:AddLocations("locations/temple of time.json")
Tracker:AddLocations("locations/city in the sky.json")
Tracker:AddLocations("locations/palace of twilight.json")
Tracker:AddLocations("locations/hyrule castle.json")