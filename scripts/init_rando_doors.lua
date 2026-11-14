START_ROOM_ITEMS = {}
for edge in pairs(ER_EDGES) do
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags ~= "TO" then
        if not START_ROOM_ITEMS[from.."_"..to] then
            local start_room = ScriptHost:CreateLuaItem()
            start_room.PotentialCodes = {"START_"..from.."_"..to}
            start_room.ItemState = {
                Active = true
            }
            start_room.OnLeftClickFunc = function(self)
                self.ItemState.Active = not self.ItemState.Active
            end
            start_room.OnRightClickFunc = start_room.OnLeftClickFunc
            START_ROOM_ITEMS[from.."_"..to] = start_room
        end
    end
end


EXT_A = {}
EXT_B = {}
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "EXT" then
        if direction == "A" then
            table.insert(EXT_A, edge)
        elseif direction == "B" then
            table.insert(EXT_B, edge)
        end
    end
end
EXT_ER_ITEMS_A = {}
for _, edge in pairs(EXT_A) do
    for _, edge2 in pairs(EXT_A) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local ext_item = ScriptHost:CreateLuaItem()
        ext_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        ext_item.ItemState = {
            Active = false
        }
        ext_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        ext_item.OnRightClickFunc = ext_item.OnLeftClickFunc
        EXT_ER_ITEMS_A[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = ext_item
    end
end
EXT_ER_ITEMS_B = {}
for _, edge in pairs(EXT_B) do
    for _, edge2 in pairs(EXT_B) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local ext_item = ScriptHost:CreateLuaItem()
        ext_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        ext_item.ItemState = {
            Active = false
        }
        ext_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        ext_item.OnRightClickFunc = ext_item.OnLeftClickFunc
        EXT_ER_ITEMS_B[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = ext_item
    end
end

INT_A = {}
INT_B = {}
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "INT" then
        if direction == "A" then
            table.insert(INT_A, edge)
        elseif direction == "B" then
            table.insert(INT_B, edge)
        end
    end
end
INT_ER_ITEMS_A = {}
for _, edge in pairs(INT_A) do
    for _, edge2 in pairs(INT_A) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local int_item = ScriptHost:CreateLuaItem()
        int_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        int_item.ItemState = {
            Active = false
        }
        int_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        int_item.OnRightClickFunc = int_item.OnLeftClickFunc
        INT_ER_ITEMS_A[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = int_item
    end
end
INT_ER_ITEMS_B = {}
for _, edge in pairs(INT_B) do
    for _, edge2 in pairs(INT_B) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local int_item = ScriptHost:CreateLuaItem()
        int_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        int_item.ItemState = {
            Active = false
        }
        int_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        int_item.OnRightClickFunc = int_item.OnLeftClickFunc
        INT_ER_ITEMS_B[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = int_item
    end
end

OOW = {}
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "OOW" then
        table.insert(OOW, edge)
    end
end
OOW_ER_ITEMS = {}
for _, edge in pairs(OOW) do
    for _, edge2 in pairs(OOW) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local oow_item = ScriptHost:CreateLuaItem()
        oow_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        oow_item.ItemState = {
            Active = false
        }
        oow_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        oow_item.OnRightClickFunc = oow_item.OnLeftClickFunc
        OOW_ER_ITEMS[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = oow_item
    end
end

CAV_A = {}
CAV_B = {}
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "CAV" then
        if direction == "A" then
            table.insert(CAV_A, edge)
        elseif direction == "B" then
            table.insert(CAV_B, edge)
        end
    end
end
CAV_ER_ITEMS_A = {}
for _, edge in pairs(CAV_A) do
    for _, edge2 in pairs(CAV_A) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local cav_item = ScriptHost:CreateLuaItem()
        cav_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        cav_item.ItemState = {
            Active = false
        }
        cav_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        cav_item.OnRightClickFunc = cav_item.OnLeftClickFunc
        CAV_ER_ITEMS_A[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = cav_item
    end
end
CAV_ER_ITEMS_B = {}
for _, edge in pairs(CAV_B) do
    for _, edge2 in pairs(CAV_B) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local cav_item = ScriptHost:CreateLuaItem()
        cav_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        cav_item.ItemState = {
            Active = false
        }
        cav_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        cav_item.OnRightClickFunc = cav_item.OnLeftClickFunc
        CAV_ER_ITEMS_B[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = cav_item
    end
end

GRO_A = {}
GRO_B = {}
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "GRO" then
        if direction == "A" then
            table.insert(GRO_A, edge)
        elseif direction == "B" then
            table.insert(GRO_B, edge)
        end
    end
end
GRO_ER_ITEMS_A = {}
for _, edge in pairs(GRO_A) do
    for _, edge2 in pairs(GRO_A) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local gro_item = ScriptHost:CreateLuaItem()
        gro_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        gro_item.ItemState = {
            Active = false
        }
        gro_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        gro_item.OnRightClickFunc = gro_item.OnLeftClickFunc
        GRO_ER_ITEMS_A[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = gro_item
    end
end
GRO_ER_ITEMS_B = {}
for _, edge in pairs(GRO_B) do
    for _, edge2 in pairs(GRO_B) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local gro_item = ScriptHost:CreateLuaItem()
        gro_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        gro_item.ItemState = {
            Active = false
        }
        gro_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        gro_item.OnRightClickFunc = gro_item.OnLeftClickFunc
        GRO_ER_ITEMS_B[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = gro_item
    end
end

DUN_A = {}
DUN_B = {}
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "DUN" then
        if direction == "A" then
            table.insert(DUN_A, edge)
        elseif direction == "B" then
            table.insert(DUN_B, edge)
        end
    end
end
DUN_ER_ITEMS_A = {}
for _, edge in pairs(DUN_A) do
    for _, edge2 in pairs(DUN_A) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local dun_item = ScriptHost:CreateLuaItem()
        dun_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        dun_item.ItemState = {
            Active = false
        }
        dun_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        dun_item.OnRightClickFunc = dun_item.OnLeftClickFunc
        DUN_ER_ITEMS_A[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = dun_item
    end
end
DUN_ER_ITEMS_B = {}
for _, edge in pairs(DUN_B) do
    for _, edge2 in pairs(DUN_B) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local dun_item = ScriptHost:CreateLuaItem()
        dun_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        dun_item.ItemState = {
            Active = false
        }
        dun_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        dun_item.OnRightClickFunc = dun_item.OnLeftClickFunc
        DUN_ER_ITEMS_B[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = dun_item
    end
end

DHC_A = DUN_A
DHC_B = DUN_B
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "DHC" then
        if direction == "A" then
            table.insert(DHC_A, edge)
        elseif direction == "B" then
            table.insert(DHC_B, edge)
        end
    end
end
DHC_ER_ITEMS_A = {}
for _, edge in pairs(DHC_A) do
    for _, edge2 in pairs(DHC_A) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local dhc_item = ScriptHost:CreateLuaItem()
        dhc_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        dhc_item.ItemState = {
            Active = false
        }
        dhc_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        dhc_item.OnRightClickFunc = dhc_item.OnLeftClickFunc
        DHC_ER_ITEMS_A[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = dhc_item
    end
end
DHC_ER_ITEMS_B = {}
for _, edge in pairs(DHC_B) do
    for _, edge2 in pairs(DHC_B) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local dhc_item = ScriptHost:CreateLuaItem()
        dhc_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        dhc_item.ItemState = {
            Active = false
        }
        dhc_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        dhc_item.OnRightClickFunc = dhc_item.OnLeftClickFunc
        DHC_ER_ITEMS_B[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = dhc_item
    end
end

BRE_A = {}
BRE_B = {}
BRE = {}
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "BRE" then
        if direction == "A" then
            table.insert(BRE_A, edge)
        elseif direction == "B" then
            table.insert(BRE_B, edge)
        else
            table.insert(BRE, edge)
        end
    end
end
BRE_ER_ITEMS_A = {}
for _, edge in pairs(BRE_A) do
    for _, edge2 in pairs(BRE_A) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local bre_item = ScriptHost:CreateLuaItem()
        bre_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        bre_item.ItemState = {
            Active = false
        }
        bre_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        bre_item.OnRightClickFunc = bre_item.OnLeftClickFunc
        BRE_ER_ITEMS_A[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = bre_item
    end
end
BRE_ER_ITEMS_B = {}
for _, edge in pairs(BRE_B) do
    for _, edge2 in pairs(BRE_B) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local bre_item = ScriptHost:CreateLuaItem()
        bre_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        bre_item.ItemState = {
            Active = false
        }
        bre_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        bre_item.OnRightClickFunc = bre_item.OnLeftClickFunc
        BRE_ER_ITEMS_B[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = bre_item
    end
end
BRE_ER_ITEMS = {}
for _, edge in pairs(BRE) do
    for _, edge2 in pairs(BRE) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local bre_item = ScriptHost:CreateLuaItem()
        bre_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        bre_item.ItemState = {
            Active = false
        }
        bre_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        bre_item.OnRightClickFunc = bre_item.OnLeftClickFunc
        BRE_ER_ITEMS[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = bre_item
    end
end

BOS_A = {}
BOS_B = {}
for edge in pairs(ER_EDGES) do
    local flag, direction
 	local from, flags, to = edge:match("(.*)__(.*)__(.*)")
    if flags:find("_") then
        flag, direction = flags:match("(.*)_(.*)")
    else
        flag = flags
    end
    if flag == "BOS" then
        if direction == "A" then
            table.insert(BOS_A, edge)
        elseif direction == "B" then
            table.insert(BOS_B, edge)
        end
    end
end
BOS_ER_ITEMS_A = {}
for _, edge in pairs(BOS_A) do
    for _, edge2 in pairs(BOS_A) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local bos_item = ScriptHost:CreateLuaItem()
        bos_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        bos_item.ItemState = {
            Active = false
        }
        bos_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        bos_item.OnRightClickFunc = bos_item.OnLeftClickFunc
        BOS_ER_ITEMS_A[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = bos_item
    end
end
BOS_ER_ITEMS_B = {}
for _, edge in pairs(BOS_B) do
    for _, edge2 in pairs(BOS_B) do
        local from, flags, to = edge:match("(.*)__(.*)__(.*)")
        local from2, flags2, to2 = edge2:match("(.*)__(.*)__(.*)")
        local bos_item = ScriptHost:CreateLuaItem()
        bos_item.PotentialCodes = {from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2}
        bos_item.ItemState = {
            Active = false
        }
        bos_item.OnLeftClickFunc = function(self)
            self.ItemState.Active = not self.ItemState.Active
            occupyRoomSetting()
        end
        bos_item.OnRightClickFunc = bos_item.OnLeftClickFunc
        BOS_ER_ITEMS_B[from.."_TO_"..to.."_LEADS_"..from2.."_TO_"..to2] = bos_item
    end
end