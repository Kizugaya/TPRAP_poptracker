-- ITEM LOGIC
-- Check if player has at least 1 of following item
function has(item)
	if type(item) == "boolean" then return item end
	if item == "lantern" or item == "lamp" then
		return hasAll({"lantern", canRefillOil()})
	elseif item == "p_bow" or item == "bow" or item == "smallquiver" or item == "mediumquiver" or item == "largequiver" then
		if not canGetArrows() then return false end
	end
	return Tracker:ProviderCountForCode(item) >= 1
end

-- Check if player has any of following items
function hasAny(items)
	local level = AccessibilityLevel.None
	for _, item in ipairs(items) do
		if type(item) == "table" then
			level = math.max(level, hasAny(item))
		elseif type(item) == "string" then
			if has(item) then
				level = math.max(level, AccessibilityLevel.Normal)
			end
		elseif type(item) == "boolean" then
			if item then
				level = math.max(level, AccessibilityLevel.Normal)
			end
		else
			level = math.max(level, item)
		end
	end
	if  level == AccessibilityLevel.SequenceBreak and Tracker:FindObjectForCode("glitcheson") then
		level = AccessibilityLevel.Normal
	end
	return level
end

-- Check if player has all following items
function hasAll(items)
	local level = AccessibilityLevel.Normal
	for _, item in ipairs(items) do
		if type(item) == "table" then
			level = math.min(level, hasAll(item))
		elseif type(item) == "string" then
			if not has(item) then
				level = AccessibilityLevel.None
			end
		elseif type(item) == "boolean" then
			if not item then
				level = AccessibilityLevel.None
			end
		else
			level = math.min(level, item)
		end
	end
	if  level == AccessibilityLevel.SequenceBreak and Tracker:FindObjectForCode("glitcheson") then
		level = AccessibilityLevel.Normal
	end
	return level
end

-- Check if player has at least X items
function hasAmount(item, amount)
	return Tracker:ProviderCountForCode(item) >= amount
end

-- Check if player does not have item
function Not(code)
	return not Tracker:ProviderCountForCode(code)
end

-- Helper function to return AccessibilityLevel.SequenceBreak or
-- AccessibilityLevel.Normal if player can reach a specific area
function map(items, func)
	local result = {}
	for _, item in ipairs(items) do
		table.insert(result, func(item))
	end
	return result
end


CANACCESS_ACTIVE = {count = 0}
function canAccess(targetnode, exclude)
	if CANACCESS_ACTIVE[targetnode] then
		return AccessibilityLevel.None
	end
	CANACCESS_ACTIVE[targetnode] = 1
	CANACCESS_ACTIVE.count = CANACCESS_ACTIVE.count + 1
	local function finish(result)
		CANACCESS_ACTIVE.count = CANACCESS_ACTIVE.count - 1
		if CANACCESS_ACTIVE.count == 0 then
			CANACCESS_ACTIVE = {count = 0}
		end
		return result
	end
	print(CANACCESS_ACTIVE.count.." "..targetnode)
	local queue = {targetnode}
	local queueseq = {}
	local visited = {}
	while #queue > 0 do
		local current = table.remove(queue, 1)
		local edges = ER_NODES[current]
		if edges["spawn"] then
			return finish(AccessibilityLevel.Normal)
		end
		if not visited[current] then
			visited[current] = true
			for _, edge in pairs(edges) do
				local from, flags, to = edge:match("(.*)__(.*)__(.*)")
				local accessrules = ER_EDGES[edge]
				if edge == exclude then
					--skip
				elseif not accessrules[1] or not accessrules[1][1] or accessrules[1][1]() then
					table.insert(queue, from)
				elseif accessrules[2] and (not accessrules[2][1] or accessrules[2][1]()) then
					table.insert(queueseq, from)
				end
			end
		end
	end
	while #queueseq > 0 do
		local current = table.remove(queueseq, 1)
		local edges = ER_NODES[current]
		if edges["spawn"] then
			return finish(AccessibilityLevel.SequenceBreak)
		end
		if not visited[current] then
			visited[current] = true
			for _, edge in pairs(edges) do
				local from, flags, to = edge:match("(.*)__(.*)__(.*)")
				local accessrules = ER_EDGES[edge]
				if edge == exclude then
					--skip
				elseif not accessrules[1] or not accessrules[1][1] or accessrules[1][1]()
				or (accessrules[2] and (not accessrules[2][1] or accessrules[2][1]())) then
					table.insert(queueseq, from)
				end
			end
		end
	end
	return finish(AccessibilityLevel.None)
end

function occupyRoomSetting()
	ER_NODES = {}
	initNodes()
	vanillaRoomAlways()
	print(Tracker:FindObjectForCode("exteriorshuffledoff"))
	if Tracker:FindObjectForCode("exteriorshuffledoff") then
		vanillaRoomExterior()
	else
		for item in pairs(EXT_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__EXT_A__"..to)
			end
		end
		for item in pairs(EXT_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__EXT_B__"..to)
			end
		end
	end
	if Tracker:FindObjectForCode("interiorshuffledoff") then
		vanillaRoomInterior()
	else
		for item in pairs(INT_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__INT_A__"..to)
			end
		end
		for item in pairs(INT_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__INT_B__"..to)
			end
		end
	end
	if Tracker:FindObjectForCode("onewayshuffledoff") then
		vanillaRoomOneway()
	else
		for item in pairs(OOW_ER_ITEMS) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__OOW_A__"..to)
			end
		end
	end
	if Tracker:FindObjectForCode("caveshuffledoff") then
		vanillaRoomCave()
	else
		for item in pairs(CAV_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__CAV_A__"..to)
			end
		end
		for item in pairs(CAV_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__CAV_B__"..to)
			end
		end
	end
	if Tracker:FindObjectForCode("grottoshuffledoff") then
		vanillaRoomGrotto()
	else
		for item in pairs(GRO_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__GRO_A__"..to)
			end
		end
		for item in pairs(GRO_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__GRO_B__"..to)
			end
		end
	end
	if Tracker:FindObjectForCode("dungeonshuffledoff") then
		vanillaRoomDungeon()
		vanillaRoomDungeonHyruleCastle()
		vanillaRoomBossexit()
	elseif Tracker:FindObjectForCode("dungeonshuffledon") then
		vanillaRoomDungeonHyruleCastle()
		for item in pairs(DUN_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__DUN_A__"..to)
			end
		end
		for item in pairs(DUN_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__DUN_B__"..to)
			end
		end
		for item in pairs(BRE_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__BRE_A__"..to)
			end
		end
		for item in pairs(BRE_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__BRE_B__"..to)
			end
		end
		for item in pairs(BRE_ER_ITEMS) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__BRE__"..to)
			end
		end
	elseif Tracker:FindObjectForCode("dungeonshuffledhc") then
		for item in pairs(DHC_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__DHC_A__"..to)
			end
		end
		for item in pairs(DHC_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__DHC_B__"..to)
			end
		end
		for item in pairs(BRE_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__BRE_A__"..to)
			end
		end
		for item in pairs(BRE_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__BRE_B__"..to)
			end
		end
		for item in pairs(BRE_ER_ITEMS) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__BRE__"..to)
			end
		end
	end
	if Tracker:FindObjectForCode("bossshuffledoff") then
		vanillaRoomBoss()
	else
		for item in pairs(BOS_ER_ITEMS_A) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__BOS_A__"..to)
			end
		end
		for item in pairs(BOS_ER_ITEMS_B) do
			if item.ItemState.Active then
				local from, to, from2, to2 = item:match("(.*)_TO_(.*)_LEADS_(.*)_TO_(.*)")
				table.insert(ER_NODES[to2], from.."__BOS_B__"..to)
			end
		end
	end
end

function vanillaRoomAlways()
	for edge in pairs(ER_EDGES) do
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags == "TO" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomExterior()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "EXT" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomInterior()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "INT" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomOneway()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "OOW" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomCave()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "CAV" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomGrotto()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "GRO" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomDungeon()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "DUN" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomDungeonHyruleCastle()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "DHC" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomBossexit()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "BRE" then
			table.insert(ER_NODES[to], edge)
		end
	end
end
function vanillaRoomBoss()
	for edge in pairs(ER_EDGES) do
		local flag, direction
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		if flags:match("_") then
			flag, direction = flags:match("(.*)_(.*)")
		else
			flag = flags
		end
		if flag == "BOS" then
			table.insert(ER_NODES[to], edge)
		end
	end
end




function canWarp()
	if has("shadowcrystal") then
		for k in pairs(WARPABLE_STAGES) do
			if canAccess(k) then
				return AccessibilityLevel.Normal
			end
		end
	end
	return AccessibilityLevel.None
end

function canGetHotSpringWater()
	return hasAll({
		hasAny({
			canAccess("LowerKakarikoVillage"),
			hasAll({
				canAccess("DeathMountainElevatorLower"),
				canDefeatGoron()
			})
		}),
		hasBottle()
	})
end

function hasDamagingItem()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		hasBombs(),
		"boots",
		"shadowcrystal",
		"spinner"
	})
end

function canSmash()
	return hasAny({
		"ballchain",
		hasBombs()
	})
end

function canBurnWebs()
	return hasAny({
		"lantern",
		hasBombs(),
		"ballchain"
	})
end

function canDestroyWebsWithoutLantern()
	return hasAny({
		hasBombs(),
		"ballchain"
	})
end

function hasRangedItem()
	return hasAny({
		"ballchain",
		"slingshot",
		"bow",
		"clawshot",
		"boomerang"
	})
end

function hasShield()
	return hasAny({
		"hylianshield",
		hasAll({
			canAccess("KakarikoMaloMart"),
			"shuffleshopsoff"
		}),
		hasAll({
			canAccess("CastleTownGoronHouse"),
			"shuffleshopsoff"
		}),
		canAccess("DeathMountainHotSpring")
	})
end

function canUseBottledFairy()
	return hasAll({
		hasBottle(),
		canAccess("LakeHylia")
	})
end

function canUseBottledFairies()
	return hasAll({
		hasBottles(),
		canAccess("LakeHylia")
	})
end

function canUseOilBottle()
	return hasAll({
		"lantern",
		hasAmount("bottle", 3),
	})
end

function canLaunchBombs()
	return hasAll({
		hasAny({
			"boomerang",
			"bow"
		}),
		hasBombs()
	})
end

function canCutHangingWeb()
	return hasAny({
		"clawshot",
		"bow",
		"boomerang",
		"ballchain"
	})
end

function getPlayerHealth()
	local playerHealth = 3
	playerHealth = playerHealth + (Tracker:ProviderCountForCode("heartpiece") * 0.2)
	playerHealth = playerHealth + Tracker:ProviderCountForCode("heartcontainer")
	return playerHealth
end

function canKnockDownHCPainting()
	return hasAny({
		hasAll({
			"bow"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					hasAny({
						hasBombs(),
						hasAll({
							"sword",
							hasAmount("hiddenskill", 6)
						})
					})
				}),
				hasAll({
					"glitcheson",
					hasAny({
						hasAll({
							"sword",
							canDoMoonBoots()
						}),
						canDoBSMoonBoots()
					})
				})
			})
		}),
	})
end

function canBreakMonkeyCage()
	return hasAny({
		"sword",
		"boots",
		"spinner",
		"ballchain",
		"shadowcrystal",
		hasBombs(),
		"bow",
		"clawshot",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			hasShield(),
			hasAmount("hiddenskill", 2)
		})
	})
end

function canPressMinesSwitch()
	return hasAny({
		hasAll({
			"boots"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			"ballchain"
		})
	})
end

function canFreeAllMonkeys()
	return hasAll({
		canBreakMonkeyCage(),
		hasAny({
			"lantern",
			hasAll({
				hasAmount("ftsmallkey", 4),
				hasAny({
					hasBombs(),
					"boots"
				})
			})
		}),
		canBurnWebs(),
		"boomerang",
		canDefeatBokoblin(),
		hasAmount("ftsmallkey", 4)
	})
end

function canKnockDownHangingBaba()
	return hasAny({
		"bow",
		"clawshot",
		"boomerang",
		"slingshot"
	})
end

function canBreakWoodenDoor()
	return hasAny({
		"shadowcrystal",
		"sword",
		canSmash(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canUseBacksliceAsSword()
		})
	})
end

function hasBombs()
	return hasAll({
		"bombbag",
		hasAny({
			canAccess("KakarikoBarnesBombShopLower"),
			hasAll({
				canAccess("EldinFieldWaterBombFishGrotto"),
				"fishingrod"
			}),
			canAccess("CityinTheSkyEntrance")
		})
	})
end

function hasWaterBombs()
	return hasAll({
		"waterbomb",
		"bombbag",
		hasAny({
			canAccess("KakarikoBarnesBombShopLower"),
			hasAll({
				canAccess("EldinFieldWaterBombFishGrotto"),
				"fishingrod"
			}),
			hasAll({
				canAccess("KakarikoBarnesBombShopLower"),
				canAccess("CastleTownMaloMart")
			})
		})
	})
end
function canUseWaterBombs()
	return hasWaterBombs()
end

function canGetArrows()
	return hasAny({
		canAccess("LostWoods"),
		hasAll({
			"gmcompleted",
			canAccess("KakarikoMaloMart")
		}),
		hasAll({
			canAccess("CastleTownGoronHouseBalcony"),
			"shuffleshopsoff"
		})
	})
end

function canRefillOil()
	return hasAny({
		canAccess("NorthFaronWoods"),
		canAccess("SouthFaronWoods"),
		canAccess("ArbitersGroundsEntrance"),
		hasAll({
			canAccess("LakeHyliaLongCave"),
			canSmash()
		}),
		canAccess("OrdonSerasShop"),
		hasAll({
			"gmcompleted",
			canAccess("LowerKakarikoVillage")
		}),
		hasAll({
			canAccess("CastleTownGoronHouse"),
			"shuffleshopsoff"
		}),
		canAccess("DeathMountainHotSpring"),
		canAccess("CityinTheSkyEntrance"),
		hasAll({
			canAccess("HyruleCastleMainHall"),
			canDefeatBokoblin(),
			canDefeatLizalfos(),
			"dclawshot",
			canDefeatDarknut()
		}),
		hasAll({
			canAccess("EldinLanternCave"),
			canDestroyWebsWithoutLantern(),
			canDefeatChu()
		}),
		hasAll({
			canAccess("HyruleCastleGraveyard"),
			canSmash()
		})
	})
end

function canCompletePrologue()
	return hasAny({
		hasAll({
			canAccess("NorthFaronWoods"),
			canDefeatBokoblin()
		}),
		"skipprologueon"
	})
end

function canCompleteGoats1()
	return hasAny({
		canAccess("OrdonRanch"),
		"skipprologueon"
	})
end

function canCompleteMDH()
	return hasAny({
		"skipmdhon",
		hasAll({
			"ltcompleted",
			canAccess("CastleTownSouth")
		})
	})
end

function canMidnaCharge()
	return hasAny({
		canCompleteMDH(),
		allTwilightCleared()
	})
end

function canStrikePedestal()
	return hasAny({
		hasAll({
			"woodensword",
			"ttwooden"
		}),
		hasAll({
			"ordonsword",
			"ttordon"
		}),
		hasAll({
			"mastersword",
			"ttmaster"
		}),
		hasAll({
			"glowingmastersword",
			"ttlight"
		}),
	})
end

function canClearForest()
	return hasAll({
		hasAny({
			"ftcompleted",
			"faronwoodsopenon"
		}),
		canCompletePrologue(),
		faronTwilightCleared()
	})
end

function faronTwilightCleared()
	return hasAny({
		"farontwilightclearedon",
		hasAll({
			canCompletePrologue(),
			canAccess("SouthFaronWoods"),
			canAccess("FaronWoodsCorosHouseLower"),
			canAccess("MistAreaNearFaronWoodsCave"),
			canAccess("NorthFaronWoods"),
			canAccess("OrdonSpring"),
			hasAny({
				"bonksdodamageoff",
				hasAll({
					"bonksdodamageon",
					hasAny({
						Not("ohko"),
						canUseBottledFairies()
					})
				}),
			})
		})
	})
end
function canCompleteFaronTwilight()
	return faronTwilightCleared()
end

function eldinTwilightCleared()
	return hasAny({
		"eldintwilightclearedon",
		hasAll({
			canAccess("FaronField"),
			canAccess("LowerKakarikoVillage"),
			canAccess("KakarikoGraveyard"),
			canAccess("KakarikoMaloMart"),
			canAccess("KakarikoBarnesBombShopUpper"),
			canAccess("KakarikoRenadosSanctuaryBasement"),
			canAccess("KakarikoEldeInn"),
			canAccess("KakarikoBugHouse"),
			canAccess("UpperKakarikoVillage"),
			canAccess("KakarikoWatchtower"),
			canAccess("DeathMountainVolcano"),
			hasAny({
				"bonksdodamageoff",
				hasAll({
					"bonksdodamageon",
					hasAny({
						Not("ohko"),
						canUseBottledFairies()
					})
				}),
			})
		})
	})
end
function canCompleteEldinTwilight()
	return eldinTwilightCleared()
end

function lanayruTwilightCleared()
	return hasAny({
		"lanayrutwilightclearedon",
		hasAll({
			hasAny({
				canAccess("NorthEldinField"),
				"shadowcrystal"
			}),
			canAccess("ZorasDomain"),
			canAccess("ZorasDomainThroneRoom"),
			canAccess("UpperZorasRiver"),
			canAccess("LakeHylia"),
			canAccess("LakeHyliaLanayruSpring"),
			canAccess("CastleTownSouth"),
			hasAny({
				"bonksdodamageoff",
				hasAll({
					"bonksdodamageon",
					hasAny({
						Not("ohko"),
						canUseBottledFairies()
					})
				}),
			})
		})
	})
end
function canCompleteLanayruTwilight()
	return lanayruTwilightCleared()
end

function canWarpMeteor()
	return hasAny({
		lanayruTwilightCleared(),
		hasAll({
			eldinTwilightCleared(),
			canAccess("ZorasDomainThroneRoom"),
			"shadowcrystal"
		})
	})
end

function allTwilightCleared()
	return hasAll({
		faronTwilightCleared(),
		eldinTwilightCleared(),
		lanayruTwilightCleared()
	})
end
function canCompleteAllTwilight()
	return allTwilightCleared()
end

function hasCompletedAllDungeons()
	return hasAll({
		"ftcompleted",
		"gmcompleted",
		"ltcompleted",
		"agcompleted",
		"srcompleted",
		"ttcompleted",
		"cscompleted",
		"ptcompleted"
	})
end
-- HELP
function canUnlockOrdonaMap()
	return hasAny({
		hasAll({
			"openmapon",
			"skipprologueon"
		}),
		map(ORDONA_MAP_ROOMS, canAccess)
	})
end

function canUnlockFaronMap()
	return hasAny({
		hasAll({
			"openmapon",
			"farontwilightclearedon"
		}),
		map(FARON_MAP_ROOMS, canAccess)
	})
end

function canUnlockEldinMap()
	return hasAny({
		hasAll({
			"openmapon",
			"eldintwilightclearedon"
		}),
		map(ELDIN_MAP_ROOMS, canAccess)
	})
end

function canUnlockLanayruMap()
	return hasAny({
		hasAll({
			"openmapon",
			"lanayrutwilightclearedon"
		}),
		map(LANAYRU_MAP_ROOMS, canAccess)
	})
end

function canUnlockSnowpeakMap()
	return hasAny({
		hasAll({
			"openmapon",
			"skipsnowpeakentranceon"
		}),
		map(SNOWPEAK_MAP_ROOMS, canAccess)
	})
end

function canUnlockGerudoMap()
	return hasAny({
		"openmapon",
		map(GERUDO_MAP_ROOMS, canAccess)
	})
end
-- HELP
function canDoDifficultCombat()
	return false
end

function canDoNicheStuff()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		"glitcheson"
	})
end

function canUseBacksliceAsSword()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		canDoNicheStuff(),
		hasAmount("hiddenskill", 3)
	})
end

function canGetBugWithLantern()
	return false
end

function canBreakHCBarrier()
	local dungeons = 0
	if has("ftcompleted") then dungeons = dungeons + 1 end
	if has("gmcompleted") then dungeons = dungeons + 1 end
	if has("ltcompleted") then dungeons = dungeons + 1 end
	if has("agcompleted") then dungeons = dungeons + 1 end
	if has("srcompleted") then dungeons = dungeons + 1 end
	if has("ttcompleted") then dungeons = dungeons + 1 end
	if has("cscompleted") then dungeons = dungeons + 1 end
	if has("ptcompleted") then dungeons = dungeons + 1 end
	return hasAny({
		"hcopen",
		hasAll({
			"hcfusedshadows",
			hasAmount("fusedshadow", Tracker:ProviderCountForCode("hcamount"))
		}),
		hasAll({
			"hcmirrorshards",
			hasAmount("mirrorshard", Tracker:ProviderCountForCode("hcamount"))
		}),
		hasAll({
			"hcdungeons",
			dungeons >= Tracker:ProviderCountForCode("hcamount")
		}),
		hasAll({
			"hcvanilla",
			"ptcompleted"
		}),
		hasAll({
			"hcpoesouls",
			hasAmount("poesoul", Tracker:ProviderCountForCode("hcamount"))
		}),
		hasAll({
			"hchearts",
			getPlayerHealth() >= Tracker:ProviderCountForCode("hcamount")
		})
	})
end

function canOpenHCBKGate()
	local dungeons = 0
	if has("ftcompleted") then dungeons = dungeons + 1 end
	if has("gmcompleted") then dungeons = dungeons + 1 end
	if has("ltcompleted") then dungeons = dungeons + 1 end
	if has("agcompleted") then dungeons = dungeons + 1 end
	if has("srcompleted") then dungeons = dungeons + 1 end
	if has("ttcompleted") then dungeons = dungeons + 1 end
	if has("cscompleted") then dungeons = dungeons + 1 end
	if has("ptcompleted") then dungeons = dungeons + 1 end
	return hasAny({
		"hcbknone",
		hasAll({
			"hcbkfusedshadows",
			hasAmount("fusedshadow", Tracker:ProviderCountForCode("hcbkamount"))
		}),
		hasAll({
			"hcbkmirrorshards",
			hasAmount("mirrorshard", Tracker:ProviderCountForCode("hcbkamount"))
		}),
		hasAll({
			"hcbkdungeons",
			dungeons >= Tracker:ProviderCountForCode("hcbkamount")
		}),
		hasAll({
			"hcbkpoesouls",
			hasAmount("poesoul", Tracker:ProviderCountForCode("hcbkamount"))
		}),
		hasAll({
			"hcbkhearts",
			getPlayerHealth() >= Tracker:ProviderCountForCode("hcbkamount")
		})
	})
end

function canBuyMagicArmor()
	return hasAny({
		"largewalletsize",
		hasAll({
			"reducedwalletsize",
			"largewallet"
		}),
		hasAll({
			"vanillawalletsize",
			"mediumwallet"
		}),
		hasAll({
			"hdwalletsize",
			"mediumwallet"
		})
	})
end

function hasSwordorBS()
	return hasAny({
		"sword",
		hasAmount("hiddenskill", 3)
	})
end

function hasBottle()
	return hasAll({
		"bottle",
		"lantern"
	})
end

function hasBottles()
	return hasAll({
		hasAmount("bottle", 2),
		"lantern"
	})
end

function hasHeavyMod()
	return hasAny({
		AccessibilityLevel.SequenceBreak,
		"boots",
		"magicarmor"
	})
end

function hasCutsceneItem()
	return hasAny({
		"skybook",
		hasBottle(),
		"horsecall"
	})
end

function canDoLJA()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		"sword",
		"boomerang"
	})
end

function canDoJSLJA()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		"sword",
		"boomerang",
		hasAmount("hiddenskill", 6)
	})
end

function canDoMapGlitch()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		"shadowcrystal",
		canAccess("KakarikoGorge")
	})
end

function canDoStorage()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		canDoMapGlitch(),
		hasOneHandedItem()
	})
end

function hasOneHandedItem()
	return hasAny({
		"sword",
		hasBottle(),
		"boomerang",
		"clawshot",
		"lantern",
		"bow",
		"slingshot",
		"dominionrod"
	})
end

function canDoMoonBoots()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		"sword",
		hasAny({
			"magicarmor",
			hasAll({
				"boots",
				getItemWheelSlotCount() >= 3
			})
		})
	})
end

function canDoJSMoonBoots()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		canDoMoonBoots(),
		hasAmount("hiddenskill", 6)
	})
end

function canDoBSMoonBoots()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		hasAmount("hiddenskill", 3),
		"magicarmor"
	})
end

function canDoEBMoonBoots()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		canDoMoonBoots(),
		"hiddenskill",
		"ordonsword"
	})
end

function canDoHSMoonBoots()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		canDoMoonBoots(),
		hasAmount("hiddenskill", 4),
		"sword",
		hasShield()
	})
end

function canDoFlyGlitch()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		"fishingrod",
		hasHeavyMod()
	})
end

function canDoAirRefill()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		hasWaterBombs(),
		hasAny({
			"magicarmor",
			hasAll({
				"boots",
				getItemWheelSlotCount() >= 3
			})
		})
	})
end

function canDoHiddenVillageGlitched()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		hasAny({
			"bow",
			"ballchain",
			hasAll({
				"slingshot",
				hasAny({
					"shadowcrystal",
					"sword",
					hasBombs(),
					"boots",
					"spinner"
				})
			})
		})
	})
end

function canDoFTWindlessBridgeRoom()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		hasAny({
			hasBombs(),
			canDoBSMoonBoots(),
			canDoJSMoonBoots()
		})
	})
end

function canClearForestGlitched()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		canCompletePrologue(),
		hasAny({
			"faronwoodsopenon",
			"ftcompleted",
			canDoLJA(),
			canDoMapGlitch()
		})
	})
end

function canCompleteEldinTwilightGlitched()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		hasAny({
			"eldintwilightclearedon",
			canClearForestGlitched()
		})
	})
end

function canSkipKeyToDekuToad()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		hasAny({
			hasAmount("ltsmallkey", 4),
			hasAmount("hiddenskill", 3),
			canDoBSMoonBoots(),
			canDoJSMoonBoots(),
			canDoLJA(),
			hasAll({
				hasBombs(),
				hasAny({
					hasHeavyMod(),
					hasAmount("hiddenskill", 6)
				})
			})
		})
	})
end

function getItemWheelSlotCount()
	local count = 0
	if has("clawshot") then count = count + 1 end
	if has("dominionrod") then count = count + 1 end
	if has("ballchain") then count = count + 1 end
	if has("spinner") then count = count + 1 end
	if has("bow") then count = count + 1 end
	if has("boots") then count = count + 1 end
	if has("boomerang") then count = count + 1 end
	if has("lantern") then count = count + 1 end
	if has("slingshot") then count = count + 1 end
	if has("fishingrod") then count = count + 1 end
	if has("hawkeye") then count = count + 1 end
	if has("bombbag") then count = count + 1 end
	if hasAmount("bombbag", 2) then count = count + 1 end
	if hasAmount("bombbag", 3) then count = count + 1 end
	if has("bottle") then count = count + 1 end
	if hasAmount("bottle", 2) then count = count + 1 end
	if hasAmount("bottle", 3) then count = count + 1 end
	if hasAmount("bottle", 4) then count = count + 1 end
	if has("aurusmemo") then count = count + 1 end
	if has("renadosletter") then count = count + 1 end
	if has("horsecall") then count = count + 1 end
	return count
end

function canStepClip()
	return hasAll({
		AccessibilityLevel.SequenceBreak,
		hasAny({
			"sword",
			"clawshot",
			"dominionrod",
			"ballchain",
			"bow",
			"boomerang",
			"lantern",
			"slingshot",
			"fishingrod",
			hasBombs(),
			hasBottle()
		})
	})
end

-- ENEMIES
function canDefeatAeralfos()
	return hasAny({
		hasAll({
			"clawshot",
			hasAny({
				"sword",
				"ballchain",
				"shadowcrystal"
			})
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			"clawshot",
			canDoNicheStuff(),
			"boots"
		})
	})
end

function canDefeatArmos()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		"clawshot",
		hasBombs(),
		"spinner",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatBabaSerpent()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatHangingBabaSerpent()
	return hasAll({
		hasAny({
			"boomerang",
			"bow"
		}),
		canDefeatBabaSerpent()
	})
end

function canDefeatBabyGohma()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"slingshot",
		"clawshot",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatBari()
	return hasAny({
		hasWaterBombs(),
		"clawshot"
	})
end

function canDefeatBeamos()
	return hasAny({
		"ballchain",
		"bow",
		hasBombs()
	})
end

function canDefeatBigBaba()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		"spinner",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatChu()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		"clawshot",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatBokoblin()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"slingshot",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatBokoblinRed()
	return hasAny({
		"sword",
		"ballchain",
		"largequiver",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				canUseBacksliceAsSword(),
				hasAll({
					canDoDifficultCombat(),
					hasAny({
						"boots",
						"spinner"
					})
				})
			})
		})
	})
end

function canDefeatBombfish()
	return hasAny({
		hasAll({
			"boots",
			hasAny({
				"sword",
				"clawshot",
				hasAll({
					"shield",
					hasAmount("hiddenskill", 2)
				})
			})
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			"magicarmor",
			hasAny({
				"sword",
				"clawshot",
				hasAll({
					"shield",
					hasAmount("hiddenskill", 2)
				})
			})
		})
	})
end

function canDefeatBombling()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		"clawshot",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			"boots"
		})
	})
end

function canDefeatBomskit()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				canUseBacksliceAsSword(),
				hasAll({
					canDoNicheStuff(),
					"boots"
				})
			})
		})
	})
end

function canDefeatBubble()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatBulblin()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatChilfos()
	return hasAny({
		"sword",
		"ballchain",
		"shadowcrystal",
		"spinner",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatChuWorm()
	return hasAny({
		hasAll({
			hasAny({
				"sword",
				"ballchain",
				"bow",
				"spinner",
				"shadowcrystal"
			}),
			hasAny({
				hasBombs(),
				"clawshot"
			})
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			}),
			hasAny({
				hasBombs(),
				"clawshot"
			})
		})
	})
end

function canDefeatDarknut()
	return hasAny({
		"sword",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoDifficultCombat(),
			hasAny({
				hasBombs(),
				"ballchain"
			})
		})
	})
end

function canDefeatDekuBaba()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		hasAll({
			hasShield(),
			hasAmount("hiddenskill", 2)
		}),
		"slingshot",
		"clawshot",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatDekuLike()
	return hasAll({
		hasBombs(),
	})
end

function canDefeatDodongo()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatDinalfos()
	return hasAny({
		"sword",
		"ballchain",
		"shadowcrystal"
	})
end

function canDefeatFireBubble()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatFireKeese()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"slingshot",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatFireToadpoli()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		hasAll({
			"hylianshield",
			hasAmount("hiddenskill", 2)
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoDifficultCombat(),
			"shadowcrystal"
		})
	})
end

function canDefeatFreezard()
	return hasAll({
		"ballchain"
	})
end

function canDefeatGoron()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		hasAll({
			hasShield(),
			hasAmount("hiddenskill", 2),
		}),
		"slingshot",
		"clawshot",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				hasAll({
					canDoDifficultCombat(),
					"lantern"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatGhoulRat()
	return hasAll({
		"shadowcrystal"
	})
end

function canDefeatGuay()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		"slingshot",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				hasAll({
					canDoDifficultCombat(),
					"spinner"
				})
			})
		})
	})
end

function canDefeatHelmasaur()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatHelmasaurus()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatIceBubble()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatIceKeese()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"slingshot",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatPoe()
	return hasAll({
		"shadowcrystal"
	})
end

function canDefeatKargorok()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatKeese()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"slingshot",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatLeever()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			"boots"
		})
	})
end

function canDefeatLizalfos()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatMiniFreezard()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatMoldorm()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			"boots"
		})
	})
end

function canDefeatPoisonMite()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"lantern",
		"spinner",
		"shadowcrystal"
	})
end

function  canDefeatPuppet()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatRat()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"slingshot",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatRedeadKnight()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatShadowBeast()
	return hasAny({
		"sword",
		hasAll({
			"shadowcrystal",
			canMidnaCharge()
		})
	})
end

function canDefeatShadowBulblin()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatShadowDekuBaba()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		hasAll({
			hasShield(),
			hasAmount("hiddenskill", 2)
		}),
		"slingshot",
		"clawshot",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatShadowInsect()
	return hasAll({
		"shadowcrystal"
	})
end

function canDefeatShadowKargorok()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatShadowKeese()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"slingshot",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatShadowVermin()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatShellBlade()
	return hasAny({
		hasWaterBombs(),
		hasAll({
			"sword",
			"boots"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			"sword",
			canDoNicheStuff(),
			"magicarmor"
		})
	})
end

function canDefeatSkullFish()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			"boots"
		})
	})
end

function canDefeatSkulltula()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatStalfos()
	return hasAll({
		canSmash()
	})
end

function canDefeatStalhound()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatStalchild()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatTektite()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatTileWorm()
	return hasAny({
		hasAll({
			hasAny({
				"sword",
				"ballchain",
				"bow",
				"shadowcrystal",
				"spinner",
				hasBombs()
			}),
			"boomerang"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			}),
			"boomerang"
		})
	})
end

function canDefeatToado()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal"
	})
end

function canDefeatWaterToadpoli()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		hasAll({
			hasShield(),
			hasAmount("hiddenskill", 2)
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoDifficultCombat(),
			"shadowcrystal"
		})
	})
end

function canDefeatTorchSlug()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		hasBombs()
	})
end

function canDefeatWalltula()
	return hasAny({
		"ballchain",
		"slingshot",
		"bow",
		"boomerang",
		"clawshot"
	})
end

function canDefeatWhiteWolfos()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			"boots"
		})
	})
end

function canDefeatYoungGohma()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"spinner",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			"boots"
		})
	})
end

function canDefeatZantHead()
	return hasAny({
		"shadowcrystal",
		"sword",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canUseBacksliceAsSword()
		})
	})
end

function canDefeatOok()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatDangoro()
	return hasAny({
		hasAll({
			hasAny({
				"sword",
				"shadowcrystal"
			}),
			"boots"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoDifficultCombat(),
			hasAny({
				"ballchain",
				hasAll({
					"bow",
					hasBombs()
				})
			}),
			"boots"
		})
	})
end

function canDefeatCarrierKargorok()
	return hasAll({
		"shadowcrystal"
	})
end

function canDefeatTwilitBloat()
	return hasAll({
		"shadowcrystal"
	})
end

function canDefeatDekuToad()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatSkullKid()
	return hasAll({
		"bow"
	})
end

function canDefeatKingBulblinBridge()
	return hasAll({
		"bow"
	})
end

function canDefeatKingBulblinDesert()
	return hasAny({
		"sword",
		"ballchain",
		"shadowcrystal",
		"largequiver",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				canUseBacksliceAsSword(),
				hasAll({
					canDoDifficultCombat(),
					hasAny({
						"spinner",
						"boots",
						hasBombs(),
						"mediumquiver"
					})
				})
			})
		})
	})
end

function canDefeatKingBulblinCastle()
	return hasAny({
		"sword",
		"ballchain",
		"shadowcrystal",
		"largequiver",
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoDifficultCombat(),
			hasAny({
				"spinner",
				"boots",
				hasBombs(),
				canUseBacksliceAsSword()
			})
		})
	})
end

function canDefeatDeathSword()
	return hasAll({
		"sword",
		hasAny({
			"boomerang",
			"bow",
			"clawshot"
		}),
		"shadowcrystal"
	})
end

function canDefeatDarkhammer()
	return hasAny({
		"sword",
		"ballchain",
		"bow",
		"shadowcrystal",
		hasBombs(),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				hasAll({
					canDoDifficultCombat(),
					canUseBacksliceAsSword()
				})
			})
		})
	})
end

function canDefeatPhantomZant()
	return hasAny({
		"shadowcrystal",
		"sword"
	})
end

function canDefeatDiababa()
	return hasAny({
		canLaunchBombs(),
		hasAll({
			"boomerang",
			hasAny({
				"sword",
				"ballchain",
				"shadowcrystal",
				hasBombs()
			})
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			"boomerang",
			hasAny({
				hasAll({
					canDoNicheStuff(),
					"boots"
				}),
				hasAll({
					canDoDifficultCombat(),
					canUseBacksliceAsSword()
				})
			})
		})
	})
end

function canDefeatFyrus()
	return hasAny({
		hasAll({
			"bow",
			"boots",
			"sword"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			"bow",
			"boots",
			canDoDifficultCombat(),
			canUseBacksliceAsSword()
		})
	})
end

function canDefeatMorpheel()
	return hasAny({
		hasAll({
			"zoraarmor",
			"boots",
			"sword",
			"clawshot"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoNicheStuff(),
			"clawshot",
			canDoAirRefill(),
			"sword"
		})
	})
end

function canDefeatStallord()
	return hasAny({
		hasAll({
			"spinner",
			"sword"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			canDoDifficultCombat(),
			"spinner"
		})
	})
end

function canDefeatBlizzeta()
	return hasAll({
		"ballchain"
	})
end

function canDefeatArmogohma()
	return hasAll({
		"bow",
		"dominionrod"
	})
end

function canDefeatArgorok()
	return hasAny({
		hasAll({
			"doubleclawshot",
			"ordonsword",
			"boots"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			"doubleclawshot",
			"ordonsword",
			canDoNicheStuff(),
			"magicarmor"
		})
	})
end

function canDefeatZant()
	return hasAny({
		hasAll({
			"mastersword",
			"boomerang",
			"clawshot",
			"ballchain",
			"boots",
			"zoraarmor"
		}),
		hasAll({
			AccessibilityLevel.SequenceBreak,
			"mastersword",
			"boomerang",
			"clawshot",
			"ballchain",
			hasAny({
				"boots",
				hasAll({
					canDoNicheStuff(),
					"magicarmor"
				})
			}),
			hasAny({
				"zoraarmor",
				canDoAirRefill()
			})
		})
	})
end

function canDefeatGanondorf()
	return hasAll({
		"shadowcrystal",
		"mastersword",
		"hiddenskill"
	})
end

-- Watch for code functions
function Splitmapchange()
	if Tracker:FindObjectForCode("splitmap").CurrentStage == 0 then
		Tracker:AddLayouts("layouts/layouts_maps.json")
	elseif Tracker:FindObjectForCode("splitmap").CurrentStage == 1 then
		Tracker:AddLayouts("layouts/split_layouts_maps.json")
	end
end
function Broadcastchange()
	if Tracker:FindObjectForCode("broadcast").CurrentStage == 0 then
		Tracker:AddLayouts("layouts/broadcast_items.json")
	elseif Tracker:FindObjectForCode("broadcast").CurrentStage == 1 then
		Tracker:AddLayouts("layouts/broadcast_map.json")
	elseif Tracker:FindObjectForCode("broadcast").CurrentStage == 2 then
		Tracker:AddLayouts("layouts/broadcast_both.json")
	end
end
function Hidefrommainmap()
	if Tracker:FindObjectForCode("hidelayout").CurrentStage == 0 then
		Tracker:AddLayouts("layouts/tracker.json")
	elseif Tracker:FindObjectForCode("hidelayout").CurrentStage == 1 then
		Tracker:AddLayouts("layouts/tracker_no_map.json")
	elseif Tracker:FindObjectForCode("hidelayout").CurrentStage == 2 then
		Tracker:AddLayouts("layouts/tracker_no_items.json")
	end
end
function APLayoutchange()
	if Tracker:FindObjectForCode("aplayout").CurrentStage == 0 then
		Tracker:AddLayouts("layouts/keys_bosses.json")
		Tracker:AddLayouts("layouts/item_grid.json")
	elseif Tracker:FindObjectForCode("aplayout").CurrentStage == 1 then
		Tracker:AddLayouts("layouts/archipelago_keys.json")
		Tracker:AddLayouts("layouts/archipelago_item_grid.json")
	end
end
function Bugsamountchange()
	local n = 0
	for _, v in pairs(BUGS_ARRAY) do
		if Tracker:FindObjectForCode(v[2]).Active and Tracker:FindObjectForCode(v[1]).AvailableChestCount == 1 then
			n = n + 1
		end
	end
	if Tracker:FindObjectForCode("bugsamount").AcquiredCount ~= n then
		Tracker:FindObjectForCode("bugsamount").AcquiredCount = n
	end
end
function TutorialChange()
	if Tracker:FindObjectForCode("tutorial").CurrentStage == 0 then
		Tracker:AddLayouts("layouts/layouts_maps.json")
	elseif Tracker:FindObjectForCode("tutorial").CurrentStage == 1 then
		Tracker:AddLayouts("layouts/tutorial.json")
	end
end
function ItemScaleChange()
	if Tracker:FindObjectForCode("itemscale").CurrentStage == 0 then
		Tracker:AddLayouts("layouts/archipelago_item_grid50.json")
		Tracker:AddLayouts("layouts/archipelago_keys50.json")
		Tracker:AddLayouts("layouts/bugs50.json")
		Tracker:AddLayouts("layouts/portals50.json")
	elseif Tracker:FindObjectForCode("itemscale").CurrentStage == 1 then
		Tracker:AddLayouts("layouts/archipelago_item_grid75.json")
		Tracker:AddLayouts("layouts/archipelago_keys75.json")
		Tracker:AddLayouts("layouts/bugs75.json")
		Tracker:AddLayouts("layouts/portals75.json")
	elseif Tracker:FindObjectForCode("itemscale").CurrentStage == 2 then
		Tracker:AddLayouts("layouts/archipelago_item_grid.json")
		Tracker:AddLayouts("layouts/archipelago_keys.json")
		Tracker:AddLayouts("layouts/bugs.json")
		Tracker:AddLayouts("layouts/portals.json")
	end
end