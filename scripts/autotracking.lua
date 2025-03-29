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
	
	Tracker:UiHint("ActivateTab", "Full Map")
	Tracker:UiHint("ActivateTab", "Overworld")
	Tracker:UiHint("ActivateTab", "Main Map")
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