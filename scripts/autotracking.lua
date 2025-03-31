-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true and ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP = true and AUTOTRACKER_ENABLE_DEBUG_LOGGING
-------------------------------------------------------
function debugLog()
	print("")
	print("Active Auto-Tracker Configuration")
	print("---------------------------------------------------------------------")
	print("Enable Item Tracking:		", AUTOTRACKER_ENABLE_ITEM_TRACKING)
	print("Enable Location Tracking:	", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
		print("Enable Debug Logging:		", AUTOTRACKER_ENABLE_DEBUG_LOGGING)
		print("Enable AP Debug Logging:		", AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP)
	end
	print("---------------------------------------------------------------------")
	print("")
end
function debugAP(msg)
	if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
		print(msg)
	end
end

ScriptHost:LoadScript("scripts/item_mapping.lua")
ScriptHost:LoadScript("scripts/location_mapping.lua")


CUR_INDEX = -1

function dump_table(o, depth)
	if depth == nil then
		depth = 0
	end
	if type(o) == 'table' then
		local tabs = ('\t'):rep(depth)
		local tabs2 = ('\t'):rep(depth + 1)
		local s = '{\n'
		for k, v in pairs(o) do
			if type(k) ~= 'number' then
				k = '"' .. k .. '"'
			end
			s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
		end
		return s .. tabs .. '}'
	else
		return tostring(o)
	end
end

function onClear(slot_data)
	debugAP(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
	SLOT_DATA = slot_data
	SLOT_DATA.Settings["Lakebed Entrance Requirements"] = SLOT_DATA.Settings["Lakebed Entrance Requirements"] or SLOT_DATA.Settings["Lakebed Enterance Requirements"]
	SLOT_DATA.Settings["Arbiters Grounds Entrance Requirements"] = SLOT_DATA.Settings["Arbiters Grounds Entrance Requirements"] or SLOT_DATA.Settings["Arbiters Grounds Requirements"]
	SLOT_DATA.Settings["Snowpeak Entrance Requirements"] = SLOT_DATA.Settings["Snowpeak Entrance Requirements"] or SLOT_DATA.Settings["Snowpeak Enterance Requirements"]
	SLOT_DATA.Settings["City in the Sky Entrance Requirements"] = SLOT_DATA.Settings["City in the Sky Entrance Requirements"] or SLOT_DATA.Settings["City in the Sky Enterance Requirements"]
	SLOT_DATA.Settings["Goron Mines Entrance Requirements"] = SLOT_DATA.Settings["Goron Mines Entrance Requirements"] or SLOT_DATA.Settings["Goron Mines Enterance Requirements"]
	SLOT_DATA.Settings["Temple of Time Entrance Requirements"] = SLOT_DATA.Settings["Temple of Time Entrance Requirements"] or SLOT_DATA.Settings["Temple of Time Enterance Requirements"]
	SLOT_DATA.Settings["Damage Magnification"] = SLOT_DATA.Settings["Damage Magnification"] or SLOT_DATA.Settings["Damage Magnifiation"]
	CUR_INDEX = -1
	--Clear Items
	for _, v in pairs(ITEM_MAPPING) do
		if v[1] and v[2] then
			debugAP(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
			local obj = Tracker:FindObjectForCode(v[1])
			if obj then
				if v[2] == "toggle" then
					obj.Active = false
				elseif v[2] == "progressive" then
					obj.CurrentStage = 0
					obj.Active = false
				elseif v[2] == "consumable" then
					obj.AcquiredCount = 0
				else 
					debugAP(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
				end
			else
				debugAP(string.format("onClear: could not find object for code %s", v[1]))
			end
		end
	end
	Tracker:FindObjectForCode("waterbomb").Active = false
	Tracker:FindObjectForCode("p_memory").CurrentStage = 0
	Tracker:FindObjectForCode("p_memory").Active = false
	Tracker:FindObjectForCode("youthsscent").Active = false
	Tracker:FindObjectForCode("iliascent").Active = false
	Tracker:FindObjectForCode("poescent").Active = false
	Tracker:FindObjectForCode("reekfishscent").Active = false
	Tracker:FindObjectForCode("medicinescent").Active = false
	Tracker:FindObjectForCode("faronvesseloflight").Active = false
	Tracker:FindObjectForCode("eldinvesseloflight").Active = false
	Tracker:FindObjectForCode("lanayruvesseloflight").Active = false
	Tracker:FindObjectForCode("ftcompleted").Active = false
	Tracker:FindObjectForCode("gmcompleted").Active = false
	Tracker:FindObjectForCode("ltcompleted").Active = false
	Tracker:FindObjectForCode("agcompleted").Active = false
	Tracker:FindObjectForCode("srcompleted").Active = false
	Tracker:FindObjectForCode("ttcompleted").Active = false
	Tracker:FindObjectForCode("cscompleted").Active = false
	Tracker:FindObjectForCode("ptcompleted").Active = false
	Tracker:FindObjectForCode("hccompleted").Active = false
	--Clear Locations
	for _, v in pairs(LOCATION_MAPPING) do
		if v[1] then
			debugAP(string.format("onClear: clearing location %s", v[1]))
			local obj = Tracker:FindObjectForCode(v[1])
			if obj then
				if v[1]:sub(1, 1) == "@" then
					obj.AvailableChestCount = obj.ChestCount
				else
					obj.Active = false
				end
			else
				debugAP(string.format("onClear: could not find object for code %s", v[1]))
			end
		end
	end
	--Set Settings
	if SLOT_DATA.Settings["Logic Settings"] == "Glitchless" then
		Tracker:FindObjectForCode("glitched").CurrentStage = 1
	elseif (SLOT_DATA.Settings["Logic Settings"] == "No Logic") or (SLOT_DATA.Settings["Logic Settings"] == "Glitched") then
		Tracker:FindObjectForCode("glitched").CurrentStage = 0
	end
	if SLOT_DATA.Settings["Poes Shuffled"] == "Yes" then
		Tracker:FindObjectForCode("poes").CurrentStage = 0
	elseif SLOT_DATA.Settings["Poes Shuffled"] == "No" then
		Tracker:FindObjectForCode("poes").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Golden Bugs Shuffled"] == "Yes" then
		Tracker:FindObjectForCode("gbugs").CurrentStage = 0
	elseif SLOT_DATA.Settings["Golden Bugs Shuffled"] == "No" then
		Tracker:FindObjectForCode("gbugs").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Castle Requirements"] == "Open" then
		Tracker:FindObjectForCode("castlerequirements").CurrentStage = 4
	elseif SLOT_DATA.Settings["Castle Requirements"] == "Fused Shadows" then
		Tracker:FindObjectForCode("castlerequirements").CurrentStage = 1
	elseif SLOT_DATA.Settings["Castle Requirements"] == "Mirror Shards" then
		Tracker:FindObjectForCode("castlerequirements").CurrentStage = 2
	elseif SLOT_DATA.Settings["Castle Requirements"] == "All Dungeons" then
		Tracker:FindObjectForCode("castlerequirements").CurrentStage = 3
	elseif SLOT_DATA.Settings["Castle Requirements"] == "Vanilla" then
		Tracker:FindObjectForCode("castlerequirements").CurrentStage = 0
	end
	if SLOT_DATA.Settings["Palace of Twilight Requirements"] == "Open" then
		Tracker:FindObjectForCode("palacerequirements").CurrentStage = 3
	elseif SLOT_DATA.Settings["Palace of Twilight Requirements"] == "Fused Shadows" then
		Tracker:FindObjectForCode("palacerequirements").CurrentStage = 1
	elseif SLOT_DATA.Settings["Palace of Twilight Requirements"] == "Mirror Shards" then
		Tracker:FindObjectForCode("palacerequirements").CurrentStage = 2
	elseif SLOT_DATA.Settings["Palace of Twilight Requirements"] == "Vanilla" then
		Tracker:FindObjectForCode("palacerequirements").CurrentStage = 0
	end
	if SLOT_DATA.Settings["Faron Woods Logic"] == "Open" then
		Tracker:FindObjectForCode("faronwoods").CurrentStage = 0
	elseif SLOT_DATA.Settings["Faron Woods Logic"] == "Closed" then
		Tracker:FindObjectForCode("faronwoods").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Lakebed Entrance Requirements"] == "Yes" then
		Tracker:FindObjectForCode("skiplakebedentrance").CurrentStage = 0
	elseif SLOT_DATA.Settings["Lakebed Entrance Requirements"] == "No" then
		Tracker:FindObjectForCode("skiplakebedentrance").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Arbiters Grounds Entrance Requirements"] == "Yes" then
		Tracker:FindObjectForCode("skiparbitersentrance").CurrentStage = 0
	elseif SLOT_DATA.Settings["Arbiters Grounds Entrance Requirements"] == "No" then
		Tracker:FindObjectForCode("skiparbitersentrance").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Snowpeak Entrance Requirements"] == "Yes" then
		Tracker:FindObjectForCode("skipsnowpeakentrance").CurrentStage = 0
	elseif SLOT_DATA.Settings["Snowpeak Entrance Requirements"] == "No" then
		Tracker:FindObjectForCode("skipsnowpeakentrance").CurrentStage = 1
	end
	if SLOT_DATA.Settings["City in the Sky Entrance Requirements"] == "Yes" then
		Tracker:FindObjectForCode("skipcityintheskyentrance").CurrentStage = 0
	elseif SLOT_DATA.Settings["City in the Sky Entrance Requirements"] == "No" then
		Tracker:FindObjectForCode("skipcityintheskyentrance").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Goron Mines Entrance Requirements"] == "Open" then
		Tracker:FindObjectForCode("goronminesentrance").CurrentStage = 0
	elseif SLOT_DATA.Settings["Goron Mines Entrance Requirements"] == "No Wrestling" then
		Tracker:FindObjectForCode("goronminesentrance").CurrentStage = 1
	elseif SLOT_DATA.Settings["Goron Mines Entrance Requirements"] == "Closed" then
		Tracker:FindObjectForCode("goronminesentrance").CurrentStage = 2
	end
	if SLOT_DATA.Settings["Temple of Time Entrance Requirements"] == "Open" then
		Tracker:FindObjectForCode("templeoftimeentrance").CurrentStage = 0
	elseif SLOT_DATA.Settings["Temple of Time Entrance Requirements"] == "Open Grove" then
		Tracker:FindObjectForCode("templeoftimeentrance").CurrentStage = 1
	elseif SLOT_DATA.Settings["Temple of Time Entrance Requirements"] == "Closed" then
		Tracker:FindObjectForCode("templeoftimeentrance").CurrentStage = 2
	end
	if SLOT_DATA.Settings["Skip Prologue"] == "Yes" then
		Tracker:FindObjectForCode("skipprologue").CurrentStage = 0
	end
	if SLOT_DATA.Settings["Faron Twilight Cleared"] == "Yes" then
		Tracker:FindObjectForCode("farontwilightcleared").CurrentStage = 0
	end
	if SLOT_DATA.Settings["Eldin Twilight Cleared"] == "Yes" then
		Tracker:FindObjectForCode("eldintwilightcleared").CurrentStage = 0
	end
	if SLOT_DATA.Settings["Lanayru Twilight Cleared"] == "Yes" then
		Tracker:FindObjectForCode("lanayrutwilightcleared").CurrentStage = 0
	end
	if SLOT_DATA.Settings["Skip MDH"] == "Yes" then
		Tracker:FindObjectForCode("skipmdh").CurrentStage = 0
	end
	if SLOT_DATA.Settings["Open Map"] == "Yes" then
		Tracker:FindObjectForCode("openmap").CurrentStage = 0
	elseif SLOT_DATA.Settings["Open Map"] == "No" then
		Tracker:FindObjectForCode("openmap").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Increase Wallet"] == "Yes" then
		Tracker:FindObjectForCode("increasewallet").CurrentStage = 0
	elseif SLOT_DATA.Settings["Increase Wallet"] == "No" then
		Tracker:FindObjectForCode("increasewallet").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Transform Anywhere"] == "Yes" then
		Tracker:FindObjectForCode("transformanywhere").CurrentStage = 0
	elseif SLOT_DATA.Settings["Transform Anywhere"] == "No" then
		Tracker:FindObjectForCode("transformanywhere").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Bonks do Damage"] == "Yes" then
		Tracker:FindObjectForCode("bonksdodamage").CurrentStage = 0
	elseif SLOT_DATA.Settings["Bonks do Damage"] == "No" then
		Tracker:FindObjectForCode("bonksdodamage").CurrentStage = 1
	end
	if SLOT_DATA.Settings["Damage Magnification"] == "Vanilla" then
		Tracker:FindObjectForCode("damagemagnification").CurrentStage = 0
	elseif SLOT_DATA.Settings["Damage Magnification"] == "Double" then
		Tracker:FindObjectForCode("damagemagnification").CurrentStage = 1
	elseif SLOT_DATA.Settings["Damage Magnification"] == "Triple" then
		Tracker:FindObjectForCode("damagemagnification").CurrentStage = 2
	elseif SLOT_DATA.Settings["Damage Magnification"] == "Quadruple" then
		Tracker:FindObjectForCode("damagemagnification").CurrentStage = 3
	elseif SLOT_DATA.Settings["Damage Magnification"] == "Ohko" then
		Tracker:FindObjectForCode("damagemagnification").CurrentStage = 4
	end
	if SLOT_DATA.Settings["Small Key Settings"] == "Vanilla" then
		Tracker:FindObjectForCode("smallkeys").CurrentStage = 0
	elseif SLOT_DATA.Settings["Small Key Settings"] == "Own Dungeon" then
		Tracker:FindObjectForCode("smallkeys").CurrentStage = 1
	elseif SLOT_DATA.Settings["Small Key Settings"] == "Any Dungeon" then
		Tracker:FindObjectForCode("smallkeys").CurrentStage = 2
	elseif SLOT_DATA.Settings["Small Key Settings"] == "Anywhere" then
		Tracker:FindObjectForCode("smallkeys").CurrentStage = 3
	elseif SLOT_DATA.Settings["Small Key Settings"] == "Start With" then
		Tracker:FindObjectForCode("smallkeys").CurrentStage = 4
	end
	if SLOT_DATA.Settings["Big Key Settings"] == "Vanilla" then
		Tracker:FindObjectForCode("bigkeys").CurrentStage = 0
	elseif SLOT_DATA.Settings["Big Key Settings"] == "Own Dungeon" then
		Tracker:FindObjectForCode("bigkeys").CurrentStage = 1
	elseif SLOT_DATA.Settings["Big Key Settings"] == "Any Dungeon" then
		Tracker:FindObjectForCode("bigkeys").CurrentStage = 2
	elseif SLOT_DATA.Settings["Big Key Settings"] == "Anywhere" then
		Tracker:FindObjectForCode("bigkeys").CurrentStage = 3
	elseif SLOT_DATA.Settings["Big Key Settings"] == "Start With" then
		Tracker:FindObjectForCode("bigkeys").CurrentStage = 4
	end
	--Initial Setup
	Tracker:UiHint("ActivateTab", "Full Map")
	Tracker:UiHint("ActivateTab", "Overworld")
	Tracker:UiHint("ActivateTab", "Main Map")
	
	Tracker:FindObjectForCode("faronvesseloflight").Active = true
	Tracker:FindObjectForCode("eldinvesseloflight").Active = true
	Tracker:FindObjectForCode("lanayruvesseloflight").Active = true
	Tracker:FindObjectForCode("faronwoodskey").Active = true
end

function onItem(index, item_id, item_name, player_number)
	debugAP(string.format("called onItem: %s, %s, %s, %s, %s", index, item_id, item_name, player_number, CUR_INDEX))
	if not AUTOTRACKER_ENABLE_ITEM_TRACKING then
		return
	end
	if index <= CUR_INDEX then
		return
	end
	CUR_INDEX = index;
	local v = ITEM_MAPPING[item_id]
	if not v then
		debugAP(string.format("onItem: could not find item mapping for id %s", item_id))
		return
	end
	debugAP(string.format("onItem: code: %s, type %s", v[1], v[2]))
	if not v[1] then
		return
	end
	local obj = Tracker:FindObjectForCode(v[1])
	if obj then
		if v[1] == "bombbag" and obj.CurrentStage == 0 then
			Tracker:FindObjectForCode("waterbomb").Active = true
		elseif v[1] == "skybook" then --[TMP] on skybook get, set amount to 7
			Tracker:FindObjectForCode("skybook").AcquiredCount = 6
		end
		if v[2] == "toggle" then
			obj.Active = true
		elseif v[2] == "progressive" then
			if obj.Active then
				obj.CurrentStage = obj.CurrentStage + 1
			else
				obj.Active = true
			end
		elseif v[2] == "consumable" then
			obj.AcquiredCount = obj.AcquiredCount + obj.Increment
		else
			debugAP(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
		end
	else
		debugAP(string.format("onItem: could not find object for code %s", v[1]))
	end
end

function onLocation(location_id, location_name)
	debugAP(string.format("called onLocation: %s, %s", location_id, location_name))
	if not AUTOTRACKER_ENABLE_LOCATION_TRACKING then
		return
	end
	local v = LOCATION_MAPPING[location_id]
	if not v then
		debugAP(string.format("onLocation: could not find location mapping for id %s", location_id))
	end
	if not v[1] then
		return
	end
	local obj = Tracker:FindObjectForCode(v[1])
	if obj then
		if v[1]:sub(1, 1) == "@" then
			obj.AvailableChestCount = obj.AvailableChestCount - 1
		else
			obj.Active = true
		end
	else
		debugAP(string.format("onLocation: could not find object for code %s", v[1]))
	end
	if location_id == 2320002 then
		Tracker:FindObjectForCode("agcompleted").Active = true
	elseif location_id == 2320035 then
		Tracker:FindObjectForCode("cscompleted").Active = true
	elseif location_id == 2320059 then
		Tracker:FindObjectForCode("ftcompleted").Active = true
	elseif location_id == 2320077 then
		Tracker:FindObjectForCode("gmcompleted").Active = true
	elseif location_id == 2320130 then
		Tracker:FindObjectForCode("ltcompleted").Active = true
	elseif location_id == 2320167 then --[TMP] currently uses heart container id
		Tracker:FindObjectForCode("ptcompleted").Active = true
	elseif location_id == 2320174 then
		Tracker:FindObjectForCode("srcompleted").Active = true
	elseif location_id == 2320199 then
		Tracker:FindObjectForCode("ttcompleted").Active = true
	end
end

function onSetReply(key, value, old)
	debugAP(string.format("called onSetReply: %s", dump_table(json)))
end

function onScout(location_id, location_name, item_id, item_name, item_player)
	debugAP(string.format("called onScout: %s, %s, %s, %s, %s", location_id, location_name, item_id, item_name, item_player))
end

function onBounce(json)
	debugAP(string.format("called onBounce: %s", dump_table(json)))
end

function onRetrieved(key, value)
	debugAP(string.format("called onRetrieved: %s", dump_table(json)))
end

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("set reply handler", onSetReply)
Archipelago:AddScoutHandler("scout handler", onScout)
Archipelago:AddBouncedHandler("bounce handler", onBounce)
Archipelago:AddRetrievedHandler("retrieved handler", onRetrieved)