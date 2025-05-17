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
ScriptHost:LoadScript("scripts/server_copy_keys.lua")
ScriptHost:LoadScript("scripts/region_mapping.lua")


CUR_INDEX = -1
SLOT_DATA = nil

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

function clearItems()
	for _, v in pairs(ITEM_MAPPING) do
		if v[1] and v[2] then
			debugAP(string.format("onClear: clearing item '%s' of type '%s'", v[1], v[2]))
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
					debugAP(string.format("onClear: unknown item type '%s' for code '%s'", v[2], v[1]))
				end
			else
				debugAP(string.format("onClear: could not find object for code '%s'", v[1]))
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
	Tracker:FindObjectForCode("fwkey").Active = false
	Tracker:FindObjectForCode("ftcompleted").Active = false
	Tracker:FindObjectForCode("gmcompleted").Active = false
	Tracker:FindObjectForCode("ltcompleted").Active = false
	Tracker:FindObjectForCode("agcompleted").Active = false
	Tracker:FindObjectForCode("srcompleted").Active = false
	Tracker:FindObjectForCode("ttcompleted").Active = false
	Tracker:FindObjectForCode("cscompleted").Active = false
	Tracker:FindObjectForCode("ptcompleted").Active = false
	Tracker:FindObjectForCode("hccompleted").Active = false
	Tracker:FindObjectForCode("dmhowlingstone").Active = false
	Tracker:FindObjectForCode("uzrhowlingstone").Active = false
	Tracker:FindObjectForCode("nfwhowlingstone").Active = false
	Tracker:FindObjectForCode("lhhowlingstone").Active = false
	Tracker:FindObjectForCode("smhowlingstone").Active = false
	Tracker:FindObjectForCode("hvhowlingstone").Active = false
end
function clearLocations()
	for _, v in pairs(LOCATION_MAPPING) do
		if v[1] then
			debugAP(string.format("onClear: clearing location '%s'", v[1]))
			local obj = Tracker:FindObjectForCode(v[1])
			if obj then
				if v[1]:sub(1, 1) == "@" then
					obj.AvailableChestCount = obj.ChestCount
				else
					obj.Active = false
				end
			else
				debugAP(string.format("onClear: could not find object for code '%s'", v[1]))
			end
		end
	end
	Tracker:FindObjectForCode("@Hyrule Castle/5F/Victory/").AvailableChestCount = Tracker:FindObjectForCode("@Hyrule Castle/5F/Victory/").ChestCount
end
function clearPortals()
	Tracker:FindObjectForCode("osportal").CurrentStage = 0
	Tracker:FindObjectForCode("sfwportal").CurrentStage = 0
	Tracker:FindObjectForCode("nfwportal").CurrentStage = 0
	Tracker:FindObjectForCode("kgportal").CurrentStage = 0
	Tracker:FindObjectForCode("kvportal").CurrentStage = 0
	Tracker:FindObjectForCode("dmportal").CurrentStage = 0
	Tracker:FindObjectForCode("boeportal").CurrentStage = 0
	Tracker:FindObjectForCode("zdportal").CurrentStage = 0
	Tracker:FindObjectForCode("lhportal").CurrentStage = 0
	Tracker:FindObjectForCode("ctportal").CurrentStage = 0
	Tracker:FindObjectForCode("uzrportal").CurrentStage = 0
	Tracker:FindObjectForCode("gmportal").CurrentStage = 0
	Tracker:FindObjectForCode("mcportal").CurrentStage = 0
	Tracker:FindObjectForCode("stportal").CurrentStage = 0
	Tracker:FindObjectForCode("sgportal").CurrentStage = 0
end
function setSettings()
	if SLOT_DATA["World Version"] == "v0.2.2" or SLOT_DATA["World Version"] == "v0.2.1" or SLOT_DATA["World Version"] == "v0.2.0" or SLOT_DATA["World Version"] == "v0.1.5" or SLOT_DATA["World Version"] == "v0.1.3" or SLOT_DATA["World Version"] == "v0.1.2" or SLOT_DATA["World Version"] == "v0.1.1" or SLOT_DATA["World Version"] == "v0.1" then
		--skip if version is less than v0.2.3
	else
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
	end
end
function initPortals()
	Tracker:FindObjectForCode("osportal").CurrentStage = 1
	Tracker:FindObjectForCode("sfwportal").CurrentStage = 1
	Tracker:FindObjectForCode("nfwportal").CurrentStage = 1
	Tracker:FindObjectForCode("kgportal").CurrentStage = 1
	Tracker:FindObjectForCode("kvportal").CurrentStage = 1
	Tracker:FindObjectForCode("dmportal").CurrentStage = 1
	Tracker:FindObjectForCode("zdportal").CurrentStage = 1
	Tracker:FindObjectForCode("lhportal").CurrentStage = 1
	Tracker:FindObjectForCode("ctportal").CurrentStage = 1
	Tracker:FindObjectForCode("stportal").CurrentStage = 1
	Tracker:FindObjectForCode("sgportal").CurrentStage = 1
end
function initItems()
	Tracker:FindObjectForCode("faronvesseloflight").Active = true
	Tracker:FindObjectForCode("eldinvesseloflight").Active = true
	Tracker:FindObjectForCode("lanayruvesseloflight").Active = true
	Tracker:FindObjectForCode("faronwoodskey").Active = true
end
function initMap()
	Tracker:UiHint("ActivateTab", "Full Map")
	Tracker:UiHint("ActivateTab", "Overworld")
	Tracker:UiHint("ActivateTab", "Main Map")
end
function correctMistakes()
	if SLOT_DATA["World Version"] == "v0.2.3" then
		SLOT_DATA.Settings["Lakebed Entrance Requirements"] = SLOT_DATA.Settings["Lakebed Entrance Requirements"] or SLOT_DATA.Settings["Lakebed Enterance Requirements"]
		SLOT_DATA.Settings["Arbiters Grounds Entrance Requirements"] = SLOT_DATA.Settings["Arbiters Grounds Entrance Requirements"] or SLOT_DATA.Settings["Arbiters Grounds Requirements"]
		SLOT_DATA.Settings["Snowpeak Entrance Requirements"] = SLOT_DATA.Settings["Snowpeak Entrance Requirements"] or SLOT_DATA.Settings["Snowpeak Enterance Requirements"]
		SLOT_DATA.Settings["City in the Sky Entrance Requirements"] = SLOT_DATA.Settings["City in the Sky Entrance Requirements"] or SLOT_DATA.Settings["City in the Sky Enterance Requirements"]
		SLOT_DATA.Settings["Goron Mines Entrance Requirements"] = SLOT_DATA.Settings["Goron Mines Entrance Requirements"] or SLOT_DATA.Settings["Goron Mines Enterance Requirements"]
		SLOT_DATA.Settings["Temple of Time Entrance Requirements"] = SLOT_DATA.Settings["Temple of Time Entrance Requirements"] or SLOT_DATA.Settings["Temple of Time Enterance Requirements"]
		SLOT_DATA.Settings["Damage Magnification"] = SLOT_DATA.Settings["Damage Magnification"] or SLOT_DATA.Settings["Damage Magnifiation"]
	end
end


function onClear(slot_data)
	debugAP(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
	SLOT_DATA = slot_data
	correctMistakes()
	CUR_INDEX = -1
	PLAYER_ID = Archipelago.PlayerNumber or -1
	TEAM_NUMBER = Archipelago.TeamNumber or 0
	if SLOT_DATA["World Version"] == "v0.2.3" or SLOT_DATA["World Version"] == "v0.2.2" or SLOT_DATA["World Version"] == "v0.2.1" or SLOT_DATA["World Version"] == "v0.2.0" or SLOT_DATA["World Version"] == "v0.1.5" or SLOT_DATA["World Version"] == "v0.1.3" or SLOT_DATA["World Version"] == "v0.1.2" or SLOT_DATA["World Version"] == "v0.1.1" or SLOT_DATA["World Version"] == "v0.1" then
		--skip if version is less than v0.2.4
	elseif SLOT_DATA["World Version"] == "v0.2.4" then
		Archipelago:SetNotify(SERVER_COPY)
		Archipelago:Get(SERVER_COPY)
	else --apply for all version v0.2.5+
		local server_copy = {}
		for _, sd in pairs(SERVER_COPY) do
			table.insert(server_copy, "TP_"..TEAM_NUMBER.."_"..PLAYER_ID.."_"..sd)
		end
		Archipelago:SetNotify(server_copy)
		Archipelago:Get(server_copy)
	end
	local game_beaten = {"_read_client_status_"..TEAM_NUMBER.."_"..PLAYER_ID}
	Archipelago:SetNotify(game_beaten)
	Archipelago:Get(game_beaten)
	clearItems()
	clearLocations()
	clearPortals()
	setSettings()
	initPortals()
	initItems()
	initMap()
end

function onItem(index, item_id, item_name, player_number)
	debugAP(string.format("called onItem: index:'%s' id:'%s' name:'%s' player:'%s' cur_index:'%s'", index, item_id, item_name, player_number, CUR_INDEX))
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
	debugAP(string.format("called onLocation: id:'%s' name:'%s'", location_id, location_name))
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
end

function onScout(location_id, location_name, item_id, item_name, item_player)
	debugAP(string.format("called onScout: location:'%s', '%s' item:%s, %s, %s", location_id, location_name, item_id, item_name, item_player))
end

function onBounce(json)
	debugAP(string.format("called onBounce: %s", dump_table(json)))
end

function onNotify(_key, value, old)
	debugAP(string.format("called onNotify: key:'%s' value:'%s' old_value:'%s'", _key, value, old))
	local key = _key
	if value == old then return end
	--if _key == string.find(_key, "_read_client_status_.*_.*") then
		_, _, team, player = string.find(_key, "_read_client_status_(.*)_(.*)")
		if team == ""..TEAM_NUMBER and player == ""..PLAYER_ID then
			victory = value == 30
			Tracker:FindObjectForCode("hccompleted").Active = victory
			Tracker:FindObjectForCode("@Hyrule Castle/5F/Victory/").AvailableChestCount = Tracker:FindObjectForCode("@Hyrule Castle/5F/Victory/").AvailableChestCount - (victory and 1 or 0)
		end
	--end
	if SLOT_DATA["World Version"] == "v0.2.3" or SLOT_DATA["World Version"] == "v0.2.2" or SLOT_DATA["World Version"] == "v0.2.1" or SLOT_DATA["World Version"] == "v0.2.0" or SLOT_DATA["World Version"] == "v0.1.5" or SLOT_DATA["World Version"] == "v0.1.3" or SLOT_DATA["World Version"] == "v0.1.2" or SLOT_DATA["World Version"] == "v0.1.1" or SLOT_DATA["World Version"] == "v0.1" then
		--skip for up to v0.2.3
	else
		if SLOT_DATA["World Version"] == "v0.2.4" then
			--skip if v0.2.4
		else
			_, _, key = string.find(_key, "TP_.*_.*_(.*)")
		end
		if key == "Death Mountain Stone" then
			Tracker:FindObjectForCode("dmhowlingstone").Active = value
			Tracker:FindObjectForCode("@Eldin Region/Death Mountain Golden Wolves/Ordon Spring Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Eldin Region/Death Mountain Golden Wolves/Ordon Spring Stone/").AvailableChestCount - (value and 1 or 0)
			Tracker:FindObjectForCode("@Ordon Golden Wolves/Death Mountain Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Ordon Golden Wolves/Death Mountain Stone/").AvailableChestCount - (value and 1 or 0)
		elseif key == "Zora River Stone" then
			Tracker:FindObjectForCode("uzrhowlingstone").Active = value
			Tracker:FindObjectForCode("@Lanayru Region/Beside Castle Town Golden Wolves/Upper Zora's River Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Lanayru Region/Beside Castle Town Golden Wolves/Upper Zora's River Stone/").AvailableChestCount - (value and 1 or 0)
			Tracker:FindObjectForCode("@Lanayru Region/Upper Zora's River Golden Wolves/West Castle Town Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Lanayru Region/Upper Zora's River Golden Wolves/West Castle Town Stone/").AvailableChestCount - (value and 1 or 0)
		elseif key == "Sacred Grove Stone" then
			Tracker:FindObjectForCode("nfwhowlingstone").Active = value
			Tracker:FindObjectForCode("@Faron Region/Faron Woods Golden Wolves/South Castle Town Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Faron Region/Faron Woods Golden Wolves/South Castle Town Stone/").AvailableChestCount - (value and 1 or 0)
			Tracker:FindObjectForCode("@Lanayru Region/South Castle Town Golden Wolves/North Faron Woods Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Lanayru Region/South Castle Town Golden Wolves/North Faron Woods Stone/").AvailableChestCount - (value and 1 or 0)
		elseif key == "Lake Hylia Stone" then
			Tracker:FindObjectForCode("lhhowlingstone").Active = value
			Tracker:FindObjectForCode("@Gerudo Desert Golden Wolves/Lake Hylia Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Gerudo Desert Golden Wolves/Lake Hylia Stone/").AvailableChestCount - (value and 1 or 0)
			Tracker:FindObjectForCode("@Lanayru Region/Lake Hylia Golden Wolves/Gerudo Desert Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Lanayru Region/Lake Hylia Golden Wolves/Gerudo Desert Stone/").AvailableChestCount - (value and 1 or 0)
		elseif key == "Snowpeak Stone" then
			Tracker:FindObjectForCode("smhowlingstone").Active = value
			Tracker:FindObjectForCode("@Eldin Region/Kakariko Golden Wolves/Snowpeak Mountain Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Eldin Region/Kakariko Golden Wolves/Snowpeak Mountain Stone/").AvailableChestCount - (value and 1 or 0)
			Tracker:FindObjectForCode("@Snowpeak Mountain Golden Wolves/Kakariko Graveyard Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Snowpeak Mountain Golden Wolves/Kakariko Graveyard Stone/").AvailableChestCount - (value and 1 or 0)
		elseif key == "Hidden Village Stone" then
			Tracker:FindObjectForCode("hvhowlingstone").Active = value
			Tracker:FindObjectForCode("@Castle Town Golden Wolves/Hidden Village Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Castle Town Golden Wolves/Hidden Village Stone/").AvailableChestCount - (value and 1 or 0)
			Tracker:FindObjectForCode("@Eldin Region/Hidden Village Golden Wolves/North Castle Town Stone/").AvailableChestCount = Tracker:FindObjectForCode("@Eldin Region/Hidden Village Golden Wolves/North Castle Town Stone/").AvailableChestCount - (value and 1 or 0)
		elseif key == "Youth Scent" then
			Tracker:FindObjectForCode("youthsscent").Active = value or (Tracker:FindObjectForCode("eldintwilightcleared").CurrentStage == 0)
		elseif key == "Ilias Scent" then
			Tracker:FindObjectForCode("iliascent").Active = value or (Tracker:FindObjectForCode("lanayrutwilightcleared").CurrentStage == 0)
		elseif key == "Medicine Scent" then
			Tracker:FindObjectForCode("medicinescent").Active = value
		elseif key == "ReekFish Scent" then
			Tracker:FindObjectForCode("reekfishscent").Active = value or (Tracker:FindObjectForCode("skipsnowpeakentrance").CurrentStage == 0)
		elseif key == "Poe Scent" then
			Tracker:FindObjectForCode("poescent").Active = value
		elseif key == "Renados letter" then
			if value == true then
				Tracker:FindObjectForCode("renadosletter").CurrentStage = Tracker:FindObjectForCode("renadosletter").CurrentStage + 1
			end
		elseif key == "Telmas Invoice" then
			if value == true then
				Tracker:FindObjectForCode("invoice").CurrentStage = Tracker:FindObjectForCode("invoice").CurrentStage + 1
			end
		elseif key == "Wooden Statue" then
			if value == true then
				Tracker:FindObjectForCode("woodenstatue").CurrentStage = Tracker:FindObjectForCode("woodenstatue").CurrentStage + 1
			end
		elseif key == "Ilias Charm" then
			if value == true then
				Tracker:FindObjectForCode("iliascharm").CurrentStage = Tracker:FindObjectForCode("iliascharm").CurrentStage + 1
			end
		elseif key == "Memory Reward" then
			Tracker:FindObjectForCode("@Eldin Region/Kakariko/Renado's Sanctuary/Ilia Memory Reward").AvailableChestCount = Tracker:FindObjectForCode("@Eldin Region/Kakariko/Renado's Sanctuary/Ilia Memory Reward").AvailableChestCount - (value and 1 or 0)
		elseif key == "Zant Defeated" then
			Tracker:FindObjectForCode("ptcompleted").Active = value
		elseif key == "Stallord Defeated" then
			Tracker:FindObjectForCode("agcompleted").Active = value
		elseif key == "Argorok Defeated" then
			Tracker:FindObjectForCode("cscompleted").Active = value
		elseif key == "Diababa Defeated" then
			Tracker:FindObjectForCode("ftcompleted").Active = value
		elseif key == "Fyrus Defeated" then
			Tracker:FindObjectForCode("gmcompleted").Active = value
		elseif key == "Morpheel Defeated" then
			Tracker:FindObjectForCode("ltcompleted").Active = value
		elseif key == "Blizzeta Defeated" then
			Tracker:FindObjectForCode("srcompleted").Active = value
		elseif key == "Armogohma Defeated" then
			Tracker:FindObjectForCode("ttcompleted").Active = value
		elseif key == "Current Region" and Tracker:FindObjectForCode("autotab").CurrentStage == 0 then
			Tracker:UiHint("ActivateTab", REGION[value])
			if REGION[value] == "Ordon" or
			REGION[value] == "Sacred Grove" or
			REGION[value] == "Snowpeak Mountain" or
			REGION[value] == "Castle Town" or
			REGION[value] == "Gerudo Desert" or
			REGION[value] == "Main Map" then
				if REGION[value] == "Faron Woods" then
					Tracker:UiHint("ActivateTab", "Faron")
				end
				Tracker:UiHint("ActivateTab", "Overworld")
			end
		end
	end
end

function onNotifyLaunch(key, value)
	debugAP(string.format("called onNotifyLaunch: key:'%s', value:'%s'", key, value))
	onNotify(key, value)
end

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddScoutHandler("scout handler", onScout)
Archipelago:AddBouncedHandler("bounce handler", onBounce)
Archipelago:AddSetReplyHandler("notify handler", onNotify)
Archipelago:AddRetrievedHandler("notify launch handler", onNotifyLaunch)