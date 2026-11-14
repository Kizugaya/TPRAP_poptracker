ER_EDGES = {
	-- DUNGEONS
	-- Arbiter's Grounds
	ArbitersGroundsEntrance__DUN_B__OutsideArbitersGrounds = {},
	ArbitersGroundsEntrance__TO__ArbitersGroundsLobby = {
		{
			function()
				return hasAll({
					hasAmount("agsmallkey", 1),
					"lantern"
				})
			end
		}
	},
	ArbitersGroundsLobby__TO__ArbitersGroundsEntrance = {},
	ArbitersGroundsLobby__TO__ArbitersGroundsEastWing = {},
	ArbitersGroundsLobby__TO__ArbitersGroundsWestWing = {},
	ArbitersGroundsLobby__TO__ArbitersGroundsAfterPoeGate = {
		{
			function()
				return hasAll({
					canDefeatPoe(),
					"shadowcrystal",
					"clawshot",
					canDefeatRedeadKnight(),
					canDefeatStalchild(),
					canDefeatBubble(),
					canDefeatGhoulRat(),
					canDefeatStalfos(),
					hasAmount("agsmallkey", 4)
				})
			end
		}
	},
	ArbitersGroundsEastWing__TO__ArbitersGroundsLobby = {},
	ArbitersGroundsWestWing__TO__ArbitersGroundsLobby = {},
	ArbitersGroundsAfterPoeGate__TO__ArbitersGroundsLobby = {},
	ArbitersGroundsAfterPoeGate__BOS__ArbitersGroundsBossRoom = {
		{
			function()
				return hasAll({
					"spinner",
					"agbigkey"
				})
			end
		}
	},
	ArbitersGroundsBossRoom__BRE_A__MirrorChamberLower = {
		{
			function()
				return hasAll({
					canDefeatStallord()
				})
			end
		}
	},
	-- City in The Sky
	CityinTheSkyBossRoom__BRE__CityinTheSkyEntrance = {
		{
			function()
				return hasAll({
					canDefeatArgorok()
				})
			end
		}
	},
	CityinTheSkyCentralTowerSecondFloor__TO__CityinTheSkyWestWing = {
		{
			function()
				return hasAll({
					"dclawshot"
				})
			end
		}
	},
	CityinTheSkyCentralTowerSecondFloor__TO__CityinTheSkyLobby = {
		{
			function()
				return hasAll({
					"clawshot",
					"boots",
					"shadowcrystal",
					Not("ohko")
				})
			end
		},
		{
			function()
				return hasAll({
					"clawshot",
					"boots",
					hasAny({
						"shadowcrystal",
						canDoLJA()
					}),
					Not("ohko")
				})
			end
		}
	},
	CityinTheSkyEastWing__TO__CityinTheSkyLobby = {},
	CityinTheSkyEntrance__DUN_B__LakeHylia = {},
	CityinTheSkyEntrance__TO__CityinTheSkyLobby = {
		{
			function()
				return hasAll({
					"clawshot"
				})
			end
		},
		{
			function()
				return hasAll({
					"clawshot",
					hasAny({
						"shadowcrystal",
						canDoLJA()
					})
				})
			end
		}
	},
	CityinTheSkyLobby__TO__CityinTheSkyEntrance = {},
	CityinTheSkyLobby__TO__CityinTheSkyEastWing = {
		{
			function()
				return hasAll({
					"spinner",
					hasAmount("cssmallkey", 1)
				})
			end
		}
	},
	CityinTheSkyLobby__TO__CityinTheSkyWestWing = {
		{
			function()
				return hasAny({
					hasAll({
						"spinner",
						"clawshot"
					}),
					"dclawshot"
				})
			end
		},
		{
			function()
				return hasAll({
					hasAny({
						"clawshot",
						canDoLJA()
					}),
					"spinner"
				})
			end
		}
	},
	CityinTheSkyLobby__TO__CityinTheSkyNorthWing = {
		{
			function()
				return hasAll({
					"dclawshot",
					canDefeatBabaSerpent(),
					canDefeatKargorok(),
					"shadowcrystal",
					"boots"
				})
			end
		},
		{
			function()
				return hasAll({
					"dclawshot"
				})
			end
		}
	},
	CityinTheSkyLobby__TO__CityinTheSkyCentralTowerSecondFloor = {
		{
			function()
				return hasAll({
					canAccess("CityinTheSkyCentralTowerSecondFloor", "CityinTheSkyLobby__TO__CityinTheSkyCentralTowerSecondFloor"),
					"clawshot",
					"boots"
				})
			end
		},
		{
			function()
				return hasAll({
					"clawshot",
					"shadowcrystal"
				})
			end
		}
	},
	CityinTheSkyNorthWing__TO__CityinTheSkyLobby = {},
	CityinTheSkyNorthWing__BOS__CityinTheSkyBossRoom = {
		{
			function()
				return hasAll({
					"dclawshot",
					canDefeatAeralfos(),
					"csbigkey"
				})
			end
		}
	},
	CityinTheSkyWestWing__TO__CityinTheSkyLobby = {
		{
			function()
				return hasAll({
					"dclawshot"
				})
			end
		}
	},
	CityinTheSkyWestWing__TO__CityinTheSkyCentralTowerSecondFloor = {
		{
			function()
				return hasAll({
					"dclawshot"
				})
			end
		}
	},
	-- Forest Teple
	ForestTempleBossRoom__BRE__SouthFaronWoods = {
		{
			function()
				return hasAll({
					canDefeatDiababa()
				})
			end
		}
	},
	ForestTempleEastWing__TO__ForestTempleLobby = {},
	ForestTempleEastWing__TO__ForestTempleNorthWing = {},
	ForestTempleEntrance__DUN_B__NorthFaronWoods = {},
	ForestTempleEntrance__TO__ForestTempleLobby = {
		{
			function()
				return hasAll({
					canDefeatWalltula(),
					canDefeatBokoblin(),
					canBreakMonkeyCage()
				})
			end
		}
	},
	ForestTempleLobby__TO__ForestTempleEntrance = {},
	ForestTempleLobby__TO__ForestTempleEastWing = {},
	ForestTempleLobby__TO__ForestTempleWestWing = {
		{
			function()
				return hasAll({
					canBurnWebs(),
					hasAny({
						hasAll({
							hasAmount("ftsmallkey", 2),
							canDefeatBokoblin()
						}),
						"clawshot"
					})
				})
			end
		},
		{
			function()
				return hasAll({
					canBurnWebs(),
					hasAny({
						hasAll({
							hasAmount("ftsmallkey", 2),
							canDefeatBokoblin()
						}),
						"clawshot",
						canDoLJA()
					})
				})
			end
		}
	},
	ForestTempleLobby__TO__Ook = {
		{
			function()
				return hasAll({
					"lantern",
					canDefeatWalltula(),
					canDefeatBokoblin(),
					canBreakMonkeyCage(),
					hasAmount("ftsmallkey", 4)
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						canAccess("ForestTempleWestWing"),
						canDoLJA()
					}),
					hasAll({
						"lantern",
						canDefeatBombling(),
						canDefeatWalltula(),
						canDefeatBigBaba(),
						canDefeatBokoblin(),
						canBreakMonkeyCage(),
						hasAmount("ftsmallkey", 4)
					})
				})
			end
		}
	},
	ForestTempleNorthWing__TO__ForestTempleEastWing = {},
	ForestTempleNorthWing__BOS__ForestTempleBossRoom = {
		{
			function()
				return hasAll({
					"ftbigkey",
					"boomerang",
					hasAny({
						canFreeAllMonkeys(),
						"clawshot"
					})
				})
			end
		},
		{
			function()
				return hasAll({
					"ftbigkey",
					hasAny({
						canDoLJA(),
						hasAll({
							"boomerang",
							hasAny({
								canFreeAllMonkeys(),
								"clawshot"
							})
						})
					})
				})
			end
		}
	},
	ForestTempleWestWing__TO__ForestTempleLobby = {},
	ForestTempleWestWing__TO__Ook = {
		{
			function()
				return hasAll({
					"boomerang"
				})
			end
		},
		{
			function()
				return hasAll({
					"boomerang",
					"shadowcrystal",
					"sword",
					hasBombs()
				})
			end
		}
	},
	Ook__TO__ForestTempleWestWing = {
		{
			function()
				return hasAll({
					canDefeatOok(),
					"boomerang"
				})
			end
		}
	},
	-- Goron Mines
	GoronMinesBossRoom__BRE__LowerKakarikoVillage = {
		{
			function()
				return hasAll({
					canDefeatFyrus()
				})
			end
		}
	},
	GoronMinesCrystalSwitchRoom__TO__GoronMinesMagnetRoom = {},
	GoronMinesCrystalSwitchRoom__TO__GoronMinesNorthWing = {
		{
			function()
				return hasAll({
					hasAny({
						hasAll({
							"boots",
							"sword"
						}),
						"bow"
					}),
					hasAmount("gmsmallkey", 2)
				})
			end
		},
		{
			function()
				return hasAll({
					hasAmount("gmsmallkey", 2),
					hasAny({
						"bow",
						hasAll({
							"boots",
							"sword"
						}),
						hasAll({
							hasAny({
								canDoLJA(),
								hasAll({
									"sword",
									hasBombs()
								})
							}),
							hasAny({
								"clawshot",
								"ballchain",
								hasBombs()
							})
						})
					})
				})
			end
		}
	},
	GoronMinesEntrance__DUN_B__DeathMountainSumoHallGoronMinesTunnel = {},
	GoronMinesEntrance__TO__GoronMinesMagnetRoom = {
		{
			function()
				return hasAll({
					"boots",
					canBreakWoodenDoor()
				})
			end
		},
		{
			function()
				return hasAll({
					hasAny({
						"boots",
						"shadowcrystal"
					}),
					hasAny({
						canBreakWoodenDoor(),
						canDoBSMoonBoots()
					})
				})
			end
		}
	},
	GoronMinesLowerWestWing__TO__GoronMinesMagnetRoom = {},
	GoronMinesMagnetRoom__TO__GoronMinesEntrance = {},
	GoronMinesMagnetRoom__TO__GoronMinesLowerWestWing = {
		{
			function()
				return hasAny({
					hasAmount("gmsmallkey", 1),
					hasAll({
						"gmshortcuton",
						"boots"
					})
				})
			end
		},
		{
			function()
				return hasAny({
					hasAmount("gmsmallkey", 1),
					hasAll({
						hasAny({
							"gmshortcuton",
							"sword"
						}),
						"boots"
					})
				})
			end
		}
	},
	GoronMinesMagnetRoom__TO__GoronMinesCrystalSwitchRoom = {
		{
			function ()
				return hasAll({
					hasAny({
						hasAmount("gmsmallkey", 1),
						"gmshortcuton"
					}),
					"boots"
				})
			end
		},
		{
			function ()
				return hasAll({
					hasAny({
						hasAmount("gmsmallkey", 1),
						"gmshortcuton",
						"sword"
					}),
					"boots"
				})
			end
		}
	},
	GoronMinesNorthWing__TO__GoronMinesCrystalSwitchRoom = {},
	GoronMinesNorthWing__TO__GoronMinesUpperEastWing = {
		{
			function()
				return hasAll({
					hasAmount("gmsmallkey", 3)
				})
			end
		}
	},
	GoronMinesNorthWing__BOS__GoronMinesBossRoom = {
		{
			function()
				return hasAll({
					"bow",
					"boots",
					canDefeatBulblin(),
					hasAmount("gmbigkey", 3)
				})
			end
		},
		{
			function()
				return hasAll({
					hasAmount("gmbigkey", 3),
					"bow",
					hasAny({
						hasAll({
							"boots",
							canDefeatBulblin()
						}),
						"clawshot",
						canDoLJA()
					})
				})
			end
		}
	},
	GoronMinesUpperEastWing__TO__GoronMinesNorthWing = {},
	GoronMinesUpperEastWing__TO__GoronMinesMagnetRoom = {
		{
			function()
				return hasAll({
					"boots",
					canDefeatDangoro(),
					"bow"
				})
			end
		},
		{
			
			function()
				return hasAll({
					"boots",
					canDefeatDangoro(),
					hasAny({
						"bow",
						canDefeatBeamos()
					})
				})
			end
		}
	},
	-- Hyrule Castle
	GanondorfCastle__TO__HyruleCastleTowerClimb = {},
	HyruleCastleEntrance__DHC_B__CastleTownNorthInsideBarrier = {},
	HyruleCastleEntrance__TO__HyruleCastleMainHall = {
		{
			function()
				return hasAll({
					hasAmount("hcsmallkey", 1)
				})
			end
		}
	},
	HyruleCastleEntrance__TO__HyruleCastleOutsideWestWing = {
		{
			function()
				return hasAll({
					canDefeatBokoblinRed()
				})
			end
		}
	},
	HyruleCastleEntrance__TO__HyruleCastleOutsideEastWing = {
		{
			function()
				return hasAll({
					canDefeatBokoblinRed()
				})
			end
		}
	},
	HyruleCastleGraveyard__TO__HyruleCastleOutsideEastWing = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	HyruleCastleMainHall__TO__HyruleCastleEntrance = {},
	HyruleCastleMainHall__TO__HyruleCastleAboveLanternStaircase = {
		{
			function()
				return hasAll({
					canDefeatBokoblin(),
					canDefeatLizalfos(),
					"dclawshot",
					canDefeatDarknut(),
					"boomerang"
				})
			end
		},
		{
			function()
				return hasAll({
					canDefeatBokoblin(),
					canDefeatLizalfos(),
					"clawshot",
					canDefeatDarknut(),
					"boomerang"
				})
			end
		}
	},
	HyruleCastleMainHall__TO__HyruleCastleAfterDoubleDinalfos = {
		{
			function()
				return hasAll({
					canDefeatBokoblin(),
					canDefeatLizalfos(),
					"hcshortcuton",
					"dclawshot"
				})
			end
		}
	},
	HyruleCastleOutsideEastWing__TO__HyruleCastleEntrance = {},
	HyruleCastleOutsideEastWing__TO__HyruleCastleGraveyard = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	HyruleCastleOutsideWestWing__TO__HyruleCastleEntrance = {},
	HyruleCastleAboveLanternStaircase__TO__HyruleCastleMainHall = {
		{
			function()
				return hasAll({
					canDefeatDarknut()
				})
			end
		}
	},
	HyruleCastleAboveLanternStaircase__TO__HyruleCastleAfterDoubleDinalfos = {
		{
			function()
				return hasAll({
					"lantern",
					canDefeatDinalfos()
				})
			end
		}
	},
	HyruleCastleAboveLanternStaircase__TO__HyruleCastleAfterDoubleDarknuts = {
		{
			function()
				return hasAll({
					canKnockDownHCPainting(),
					canDefeatLizalfos(),
					canDefeatDarknut()
				})
			end
		}
	},
	HyruleCastleAfterDoubleDinalfos__TO__HyruleCastleMainHall = {},
	HyruleCastleAfterDoubleDinalfos__TO__HyruleCastleAboveLanternStaircase = {},
	HyruleCastleAfterDoubleDinalfos__TO__HyruleCastleThirdFloorBalcony = {},
	HyruleCastleAfterDoubleDarknuts__TO__HyruleCastleMainHall = {},
	HyruleCastleAfterDoubleDarknuts__TO__HyruleCastleAboveLanternStaircase = {},
	HyruleCastleAfterDoubleDarknuts__TO__HyruleCastleThirdFloorBalcony = {},
	HyruleCastleThirdFloorBalcony__TO__HyruleCastleAfterDoubleDinalfos = {
		{
			function()
				return hasAny({
					hasAll({
						"lantern",
						canDefeatDinalfos()
					}),
					"hcshortcuton"
				})
			end
		}
	},
	HyruleCastleThirdFloorBalcony__TO__HyruleCastleAfterDoubleDarknuts = {
		{
			function()
				return hasAll({
					canDefeatDarknut(),
					canDefeatLizalfos(),
					canKnockDownHCPainting()
				})
			end
		}
	},
	HyruleCastleThirdFloorBalcony__TO__HyruleCastleTowerClimb = {
		{
			function()
				return hasAll({
					hasAmount("hcsmallkey", 2)
				})
			end
		}
	},
	HyruleCastleTowerClimb__TO__HyruleCastleThirdFloorBalcony = {},
	HyruleCastleTowerClimb__TO__HyruleCastleTreasureRoom = {
		{
			function()
				return hasAll({
					hasAmount("hcsmallkey", 3),
					"spinner",
					"dclawshot",
					canDefeatDarknut(),
					canDefeatLizalfos()
				})
			end
		},
		{
			function()
				return hasAll({
					hasAmount("hcsmallkey", 3),
					hasAny({
						"spinner",
						canDoJSLJA()
					}),
					"clawshot",
					canDefeatDarknut(),
					canDefeatLizalfos()
				})
			end
		}
	},
	HyruleCastleTowerClimb__TO__GanondorfCastle = {
		{
			function()
				return hasAll({
					"spinner",
					"dclawshot",
					canDefeatDarknut(),
					canDefeatLizalfos(),
					"hcbigkey",
					canDefeatGanondorf()
				})
			end
		},
		{
			function ()
				return hasAll({
					hasAny({
						"spinner",
						canDoJSLJA()
					}),
					"clawshot",
					canDefeatDarknut(),
					canDefeatLizalfos(),
					"hcbigkey",
					canDefeatGanondorf()
				})
			end
		}
	},
	HyruleCastleTreasureRoom__TO__HyruleCastleTowerClimb = {},
	-- Lakebed Temple
	LakebedTempleBossRoom__BRE__LakeHyliaLanayruSpring = {
		{
			function()
				return hasAll({
					canDefeatMorpheel()
				})
			end
		}
	},
	LakebedTempleCentralRoom__TO__LakebedTempleEntrance = {},
	LakebedTempleCentralRoom__TO__LakebedTempleEastWingSecondFloor = {
		{
			function()
				return hasAll({
					hasAmount("ltsmallkey", 1)
				})
			end
		}
	},
	LakebedTempleCentralRoom__TO__LakebedTempleEastWingFirstFloor = {},
	LakebedTempleCentralRoom__TO__LakebedTempleWestWing = {
		{
			function()
				return hasAll({
					hasAmount("ltsmallkey", 3),
					canSmash(),
					"clawshot"
				})
			end
		}
	},
	LakebedTempleCentralRoom__BOS__LakebedTempleBossRoom = {
		{
			function()
				return hasAll({
					hasAmount("ltsmallkey", 3),
					canLaunchBombs(),
					"clawshot",
					"ltbigkey"
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						"clawshot",
						hasAny({
							"sword",
							"ltbigkey"
						})
					}),
					canDoLJA()
				})
			end
		}
	},
	LakebedTempleEastWingFirstFloor__TO__LakebedTempleCentralRoom = {},
	LakebedTempleEastWingSecondFloor__TO__LakebedTempleCentralRoom = {},
	LakebedTempleEastWingSecondFloor__TO__LakebedTempleEastWingFirstFloor = {
		{
			function()
				return hasAny({
					canLaunchBombs(),
					"clawshot"
				})
			end
		}
	},
	LakebedTempleEntrance__DUN_B__LakeHyliaLakebedTempleEntrance = {},
	LakebedTempleEntrance__TO__LakebedTempleCentralRoom = {
		{
			function()
				return hasAll({
					"zoraarmor",
					canLaunchBombs()
				})
			end
		},
		{
			function()
				return hasAll({
					hasAny({
						"zoraarmor",
						canDoAirRefill()
					}),
					hasAny({
						canLaunchBombs(),
						canStepClip()
					})
				})
			end
		}
	},
	LakebedTempleWestWing__TO__LakebedTempleCentralRoom = {},
	-- Palace of Twilight
	PalaceofTwilightEntrance__DUN_B__MirrorChamberUpper = {},
	PalaceofTwilightEntrance__TO__PalaceofTwilightWestWing = {},
	PalaceofTwilightEntrance__TO__PalaceofTwilightEastWing = {},
	PalaceofTwilightEntrance__TO__PalaceofTwilightCentralFirstRoom = {
		{
			function()
				return hasAll({
					"glowingmastersword"
				})
			end
		}
	},
	PalaceofTwilightWestWing__TO__PalaceofTwilightEntrance = {},
	PalaceofTwilightEastWing__TO__PalaceofTwilightEntrance = {},
	PalaceofTwilightCentralFirstRoom__TO__PalaceofTwilightEntrance = {},
	PalaceofTwilightCentralFirstRoom__TO__PalaceofTwilightOutsideRoom = {
		{
			function()
				return hasAll({
					hasAmount("ptsmallkey", 5),
					"glowingmastersword"
				})
			end
		}
	},
	PalaceofTwilightOutsideRoom__TO__PalaceofTwilightCentralFirstRoom = {},
	PalaceofTwilightOutsideRoom__TO__PalaceofTwilightNorthTower = {
		{
			function()
				return hasAll({
					hasAmount("ptsmallkey", 6)
				})
			end
		}
	},
	PalaceofTwilightNorthTower__TO__PalaceofTwilightOutsideRoom = {},
	PalaceofTwilightNorthTower__BOS__PalaceofTwilightBossRoom = {
		{
			function()
				return hasAll({
					canDefeatZantHead(),
					"glowingmastersword",
					"ptbigkey",
					canDefeatShadowBeast(),
					"clawshot",
					hasAmount("ptsmallkey", 7)
				})
			end
		}
	},
	PalaceofTwilightBossRoom__BRE__PalaceofTwilightEntrance = {
		{
			function()
				return hasAll({
					canDefeatZant()
				})
			end
		}
	},
	-- Snowpeak Ruins
	SnowpeakRuinsLeftDoor__TO__SnowpeakRuinsEntrance = {},
	SnowpeakRuinsLeftDoor__DUN_B__SnowpeakSummitLowerLeftDoor = {},
	SnowpeakRuinsRightDoor__TO__SnowpeakRuinsEntrance = {},
	SnowpeakRuinsRightDoor__DUN_B__SnowpeakSummitLowerRightDoor = {},
	SnowpeakRuinsBossRoom__BRE__SnowpeakSummitLower = {
		{
			function()
				return hasAll({
					canDefeatBlizzeta()
				})
			end
		}
	},
	SnowpeakRuinsCagedFreezardRoom__TO__SnowpeakRuinsYetoandYeta = {},
	SnowpeakRuinsCagedFreezardRoom__TO__SnowpeakRuinsSecondFloorMiniFreezardRoom = {
		{
			function()
				return hasAll({
					"ballchain",
					hasAmount("srsmallkey", 3)
				})
			end
		},
		{
			function()
				return hasAll({
					"ballchain",
					hasAny({
						hasAmount("srsmallkey", 4),
						"clawshot"
					})
				})
			end
		}
	},
	SnowpeakRuinsCagedFreezardRoom__TO__SnowpeakRuinsWoodenBeamRoom = {
		{
			function()
				return hasAll({
					"ballchain"
				})
			end
		}
	},
	SnowpeakRuinsCagedFreezardRoom__TO__SnowpeakRuinsWestCourtyard = {
		{
			function()
				return hasAll({
					hasAmount("srsmallkey", 2)
				})
			end
		},
		{}
	},
	SnowpeakRuinsCagedFreezardRoom__TO__SnowpeakRuinsChapel = {
		{
			function ()
				return false
			end
		},
		{}
	},
	SnowpeakRuinsCagedFreezardRoom__TO__SnowpeakRuinsCagedFreezardRoomLower = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	SnowpeakRuinsCagedFreezardRoomLower__TO__SnowpeakRuinsCagedFreezardRoom = {
		{
			function()
				return hasAll({
					"clawshot"
				})
			end
		}
	},
	SnowpeakRuinsCagedFreezardRoomLower__TO__SnowpeakRuinsEntrance = {
		{
			function ()
				return false
			end
		},
		{
			function()
				return hasAll({
					canDoLJA()
				})
			end
		}
	},
	SnowpeakRuinsChapel__TO__SnowpeakRuinsWestCourtyard = {
		{
			function()
				return hasAll({
					canDefeatChilfos()
				})
			end
		}
	},
	SnowpeakRuinsChapel__BOS__SnowpeakRuinsBossRoom = {
		{
			function()
				return hasAll({
					"srbigkey"
				})
			end
		}
	},
	SnowpeakRuinsDarkhammerRoom__TO__SnowpeakRuinsWestCourtyard = {
		{
			function()
				return hasAll({
					canDefeatDarkhammer()
				})
			end
		}
	},
	SnowpeakRuinsEastCourtyard__TO__SnowpeakRuinsYetoandYeta = {
		{
			function()
				return hasAny({
					"shadowcrystal",
					"ballchain"
				})
			end
		}
	},
	SnowpeakRuinsEastCourtyard__TO__SnowpeakRuinsWestCourtyard = {
		{
			function()
				return hasAll({
					"ballchain"
				})
			end
		}
	},
	SnowpeakRuinsEastCourtyard__TO__SnowpeakRuinsNortheastChilfosRoomFirstFloor = {
		{
			function()
				return hasAny({
					hasAll({
						hasAmount("srsmallkey", 4),
						canDefeatMiniFreezard()
					}),
					hasAll({
						hasAmount("srsmallkey", 2),
						"clawshot",
						canDefeatMiniFreezard()
					})
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						hasAmount("srsmallkey", 4),
						canDefeatMiniFreezard()
					}),
					hasAll({
						"ballchain",
						"clawshot"
					})
				})
			end
		}
	},
	SnowpeakRuinsEntrance__TO__SnowpeakRuinsLeftDoor = {},
	SnowpeakRuinsEntrance__TO__SnowpeakRuinsRightDoor = {},
	SnowpeakRuinsEntrance__TO__SnowpeakRuinsYetoandYeta = {},
	SnowpeakRuinsEntrance__TO__SnowpeakRuinsCagedFreezardRoomLower = {
		{
			function ()
				return false
			end
		},
		{
			function()
				return hasAll({
					canDoLJA()
				})
			end
		}
	},
	SnowpeakRuinsNortheastChilfosRoomFirstFloor__TO__SnowpeakRuinsEastCourtyard	= {
		{
			function()
				return hasAll({
					hasAmount("srsmallkey", 4)
				})
			end
		}
	},
	SnowpeakRuinsNortheastChilfosRoomFirstFloor__TO__SnowpeakRuinsYetoandYeta = {
		{
			function()
				return hasAll({
					canDefeatChilfos()
				})
			end
		}
	},
	SnowpeakRuinsNortheastChilfosRoomFirstFloor__TO__SnowpeakRuinsNortheastChilfosRoomSecondFloor = {
		{
			function ()
				return false
			end
		},
		{
			function()
				return hasAll({
					canDoLJA()
				})
			end
		}
	},
	SnowpeakRuinsNortheastChilfosRoomSecondFloor__TO__SnowpeakRuinsNortheastChilfosRoomFirstFloor = {},
	SnowpeakRuinsNortheastChilfosRoomSecondFloor__TO__SnowpeakRuinsYetoandYeta = {
		{
			function()
				return hasAll({
					"ballchain"
				})
			end
		}
	},
	SnowpeakRuinsSecondFloorMiniFreezardRoom__TO__SnowpeakRuinsEntrance	= {},
	SnowpeakRuinsSecondFloorMiniFreezardRoom__TO__SnowpeakRuinsYetoandYeta = {},
	SnowpeakRuinsSecondFloorMiniFreezardRoom__TO__SnowpeakRuinsNortheastChilfosRoomSecondFloor = {
		{
			function()
				return hasAll({
					"ballchain",
					"clawshot",
					canDefeatChilfos()
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						"ballchain",
						"clawshot",
						canDefeatChilfos()
					}),
					canDoLJA()
				})
			end
		}
	},
	SnowpeakRuinsSecondFloorMiniFreezardRoom__TO__SnowpeakRuinsCagedFreezardRoom = {
		{
			function()
				return hasAll({
					hasAmount("srsmallkey", 4)
				})
			end
		},
		{
			function()
				return hasAny({
					hasAmount("srsmallkey", 4),
					hasAll({
						"ballchain",
						"clawshot"
					})
				})
			end
		}
	},
	SnowpeakRuinsWestCannonRoom__TO__SnowpeakRuinsWestCourtyard = {},
	SnowpeakRuinsWestCannonRoom__TO__SnowpeakRuinsWoodenBeamRoom = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	SnowpeakRuinsWestCourtyard__TO__SnowpeakRuinsYetoandYeta = {},
	SnowpeakRuinsWestCourtyard__TO__SnowpeakRuinsEastCourtyard = {
		{
			function()
				return hasAll({
					"ballchain"
				})
			end
		},
		{
			function()
				return hasAny({
					"ballchain",
					hasAmount("srsmallkey", 4),
					"cheese"
				})
			end
		}
	},
	SnowpeakRuinsWestCourtyard__TO__SnowpeakRuinsWestCannonRoom = {},
	SnowpeakRuinsWestCourtyard__TO__SnowpeakRuinsChapel = {
		{
			function()
				return hasAll({
					hasAmount("srsmallkey", 4),
					"cheese",
					"ballchain",
					hasBombs()
				})
			end
		},
		{
			function()
				return hasAny({
					hasAmount("srsmallkey", 4),
					"cheese"
				})
			end
		}
	},
	SnowpeakRuinsWestCourtyard__TO__SnowpeakRuinsDarkhammerRoom = {
		{
			function()
				return hasAny({
					"ballchain",
					hasAll({
						hasAny({
							hasAmount("srsmallkey", 2),
							"cheese"
						}),
						hasBombs()
					})
				})
			end
		},
		{
			function()
				return hasAny({
					"ballchain",
					hasAll({
						hasAny({
							hasAmount("srsmallkey", 4),
							"cheese"
						}),
						hasBombs()
					}),
					hasAll({
						"shadowcrystal",
						Not("ohko")
					})
				})
			end
		}
	},
	SnowpeakRuinsWoodenBeamRoom__TO__SnowpeakRuinsWestCannonRoom = {
		{
			function()
				return hasAll({
					"ballchain"
				})
			end
		},
		{
			function()
				return hasAny({
					"ballchain",
					"shadowcrystal"
				})
			end
		}
	},
	SnowpeakRuinsYetoandYeta__TO__SnowpeakRuinsEntrance = {},
	SnowpeakRuinsYetoandYeta__TO__SnowpeakRuinsCagedFreezardRoom = {
		{
			function()
				return hasAll({
					"cheese"
				})
			end
		}
	},
	SnowpeakRuinsYetoandYeta__TO__SnowpeakRuinsWestCourtyard = {
		{
			function()
				return hasAll({
					"pumpkin"
				})
			end
		}
	},
	SnowpeakRuinsYetoandYeta__TO__SnowpeakRuinsEastCourtyard = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					"ballchain"
				})
			end
		}
	},
	-- Temple of Time
	TempleofTimeArmosAntechamber__TO__TempleofTimeCentralMechanicalPlatform = {},
	TempleofTimeBossRoom__BRE__SacredGrovePast = {
		{
			function()
				return hasAll({
					canDefeatArmogohma()
				})
			end
		}
	},
	TempleofTimeCentralMechanicalPlatform__TO__TempleofTimeConnectingCorridors = {},
	TempleofTimeCentralMechanicalPlatform__TO__TempleofTimeArmosAntechamber = {
		{
			function()
				return hasAll({
					"spinner"
				})
			end
		},
		{
			function()
				return hasAny({
					"spinner",
					canDoLJA()
				})
			end
		}
	},
	TempleofTimeCentralMechanicalPlatform__TO__TempleofTimeMovingWallHallways = {
		{
			function()
				return hasAll({
					"spinner",
					hasAmount("ttsmallkey", 2)
				})
			end
		},
		{
			function()
				return hasAll({
					hasAny({
						"spinner",
						canDoLJA()
					}),
					hasAmount("ttsmallkey", 2)
				})
			end
		}
	},
	TempleofTimeConnectingCorridors__TO__TempleofTimeEntrance = {},
	TempleofTimeConnectingCorridors__TO__TempleofTimeCentralMechanicalPlatform = {
		{
			function()
				return hasAll({
					hasRangedItem(),
					canDefeatYoungGohma(),
					canDefeatLizalfos()
				})
			end
		}
	},
	TempleofTimeCrumblingCorridor__TO__TempleofTimeEntrance = {},
	TempleofTimeCrumblingCorridor__BOS__TempleofTimeBossRoom = {
		{
			function()
				return hasAll({
					"dominionrod",
					"ttbigkey"
				})
			end
		}
	},
	TempleofTimeDarknutArena__TO__TempleofTimeUpperSpikeTrapCorridor = {
		{
			function()
				return hasAll({
					canDefeatDarknut(),
					"dominionrod"
				})
			end
		}
	},
	TempleofTimeEntrance__DUN_B__SacredGrovePastBehindWindow = {},
	TempleofTimeEntrance__TO__TempleofTimeConnectingCorridors = {
		{
			function()
				return hasAll({
					hasAmount("ttsmallkey", 1)
				})
			end
		}
	},
	TempleofTimeEntrance__TO__TempleofTimeCrumblingCorridor = {
		{
			function()
				return hasAny({
					hasAll({
						"dominionrod",
						"bow",
						"spinner",
						canDefeatLizalfos(),
						canDefeatDinalfos(),
						canDefeatDarknut(),
						hasAmount("ttsmallkey", 3)
					}),
					"opendooroftimeon"
				})
			end
		},
		{
			function()
				return hasAny({
					"dominionrod",
					"opendooroftimeon"
				})
			end
		}
	},
	TempleofTimeFloorSwitchPuzzleRoom__TO__TempleofTimeScalesofTime = {},
	TempleofTimeMovingWallHallways__TO__TempleofTimeCentralMechanicalPlatform = {},
	TempleofTimeMovingWallHallways__TO__TempleofTimeScalesofTime = {
		{
			function()
				return hasAll({
					"bow",
					canDefeatLizalfos(),
					canDefeatDinalfos()
				})
			end
		}
	},
	TempleofTimeScalesofTime__TO__TempleofTimeMovingWallHallways = {},
	TempleofTimeScalesofTime__TO__TempleofTimeFloorSwitchPuzzleRoom = {
		{
			function()
				return hasAll({
					"clawshot",
					"spinner"
				})
			end
		}
	},
	TempleofTimeScalesofTime__TO__TempleofTimeUpperSpikeTrapCorridor = {},
	TempleofTimeUpperSpikeTrapCorridor__TO__TempleofTimeScalesofTime = {},
	TempleofTimeUpperSpikeTrapCorridor__TO__TempleofTimeDarknutArena = {
		{
			function()
				return hasAll({
					canDefeatLizalfos(),
					canDefeatBabyGohma(),
					canDefeatYoungGohma(),
					canDefeatArmos(),
					hasAmount("ttsmallkey", 3)
				})
			end
		}
	},
	-- OVERWORLD
	-- Eldin Province
	-- Death Mountain
	DeathMountainNearKakariko__EXT_B__LowerKakarikoVillage = {},
	DeathMountainNearKakariko__TO__DeathMountainTrail = {
		{
			function()
				return hasAny({
					"boots",
					"gmcompleted"
				})
			end
		}
	},
	DeathMountainTrail__TO__DeathMountainNearKakariko = {},
	DeathMountainTrail__TO__DeathMountainVolcano = {},
	DeathMountainVolcano__TO__DeathMountainTrail = {},
	DeathMountainVolcano__TO__DeathMountainOutsideSumoHall = {
		{
			function()
				return hasAll({
					"boots",
					hasAny({
						canDefeatGoron(),
						"gmcompleted"
					}),
					canCompleteEldinTwilight()
				})
			end
		},
		{
			function()
				return hasAll({
					hasAny({
						"boots",
						hasShield()
					}),
					hasAny({
						canDefeatGoron(),
						"gmcompleted"
					}),
					canCompleteEldinTwilight()
				})
			end
		}
	},
	DeathMountainVolcano__TO__DeathMountainElevatorLower = {
		{
			function()
				return hasAny({
					canAccess("DeathMountainElevatorLower", "DeathMountainVolcano__TO__DeathMountainElevatorLower"),
					"gmopen"
				})
			end
		},
		{
			function()
				return hasAny({
					canAccess("DeathMountainElevatorLower", "DeathMountainVolcano__TO__DeathMountainElevatorLower"),
					"gmopen",
					hasAll({
						"sword",
						hasAny({
							canDoLJA(),
							"shadowcrystal"
						})
					})
				})
			end
		}
	},
	DeathMountainVolcano__TO__DeathMountainHotSpring = {
		{
			function()
				return hasAll({
					canDefeatGoron()
				})
			end
		}
	},
	DeathMountainHotSpring__TO__DeathMountainVolcano = {},
	DeathMountainHotSpring__TO__DeathMountainElevatorLower = {
		{
			function()
				return hasAny({
					canAccess("DeathMountainElevatorLower", "DeathMountainHotSpring__TO__DeathMountainElevatorLower"),
					"gmopen"
				})
			end
		}
	},
	DeathMountainOutsideSumoHall__TO__DeathMountainVolcano = {},
	DeathMountainOutsideSumoHall__INT_A__DeathMountainSumoHall = {},
	DeathMountainElevatorLower__TO__DeathMountainVolcano = {},
	DeathMountainElevatorLower__TO__DeathMountainHotSpring = {},
	DeathMountainElevatorLower__INT_A__DeathMountainSumoHallElevator = {
		{
			function()
				return hasAny({
					"boots"
				})
			end
		}
	},
	DeathMountainSumoHall__INT_B__DeathMountainOutsideSumoHall = {},
	DeathMountainSumoHall__TO__DeathMountainSumoHallElevator = {
		{
			function()
				return hasAny({
					"boots",
					"gmnowrestling",
					"gmopen"
				})
			end
		}
	},
	DeathMountainSumoHall__TO__DeathMountainSumoHallGoronMinesTunnel = {
		{
			function()
				return hasAny({
					"boots",
					"gmnowrestling",
					"gmopen"
				})
			end
		}
	},
	DeathMountainSumoHallElevator__INT_B__DeathMountainElevatorLower = {
		{
			function()
				return hasAll({
					"boots"
				})
			end
		}
	},
	DeathMountainSumoHallElevator__TO__DeathMountainSumoHall = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("DeathMountainSumoHall", "DeathMountainSumoHallElevator__TO__DeathMountainSumoHall"),
						"boots"
					}),
					"gmnowrestling",
					"gmopen"
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						canAccess("DeathMountainSumoHall", "DeathMountainSumoHallElevator__TO__DeathMountainSumoHall"),
						"boots"
					}),
					"gmnowrestling",
					"gmopen",
					"spinner",
					"shadowcrystal"
				})
			end
		}
	},
	DeathMountainSumoHallGoronMinesTunnel__TO__DeathMountainSumoHall = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("DeathMountainSumoHall", "DeathMountainSumoHallGoronMinesTunnel__TO__DeathMountainSumoHall"),
						"boots"
					}),
					"gmnowrestling",
					"gmopen"
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						canAccess("DeathMountainSumoHall", "DeathMountainSumoHallGoronMinesTunnel__TO__DeathMountainSumoHall"),
						"boots"
					}),
					"gmnowrestling",
					"gmopen",
					"spinner"
				})
			end
		}
	},
	DeathMountainSumoHallGoronMinesTunnel__DUN_A__GoronMinesEntrance = {},
	-- Hidden Village
	HiddenVillage__EXT_B__EldinFieldOutsideHiddenVillage = {},
	HiddenVillage__INT_A__HiddenVillageImpazHouse = {
		{
			function()
				return hasAll({
					"bow"
				})
			end
		}
	},
	HiddenVillageImpazHouse__INT_B__HiddenVillage = {},
	-- Hyrule Field - Eldin
	KakarikoGorge__TO__KakarikoGorgeCaveEntrance = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	KakarikoGorge__TO__KakarikoGorgeBehindGate = {
		{
			function()
				return hasAny({
					canCompleteEldinTwilight(),
					canAccess("FaronField"),
					"shadowcrystal"
				})
			end
		}
	},
	KakarikoGorge__TO__FaronField = {
		{
			function()
				return hasAll({
					canCompleteEldinTwilight()
				})
			end
		}
	},
	KakarikoGorge__TO__EldinField = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	KakarikoGorge__GRO_A__KakarikoGorgeKeeseGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					canCompleteEldinTwilight()
				})
			end
		}
	},
	KakarikoGorgeCaveEntrance__TO__KakarikoGorge = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	KakarikoGorgeCaveEntrance__CAV_A__EldinLanternCave = {},
	KakarikoGorgeBehindGate__TO__KakarikoGorge = {
		{
			function()
				return hasAny({
					"shadowcrystal",
					"gatekeys"
				})
			end
		}
	},
	KakarikoGorgeBehindGate__EXT_A__LowerKakarikoVillage = {},
	EldinLanternCave__CAV_B__KakarikoGorgeCaveEntrance = {},
	KakarikoGorgeKeeseGrotto__GRO_B__KakarikoGorge = {},
	EldinField__TO__EldinFieldNearCastleTown = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("EldinFieldNearCastleTown", "EldinField__TO__EldinFieldNearCastleTown"),
						canCompleteEldinTwilight(),
						canCompleteLanayruTwilight(),
						canAccess("KakarikoMaloMart")
					}),
					"skipbridgedonationon"
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						hasAny({
							canAccess("KakarikoMaloMart"),
							"shadowcrystal"
						}),
						canCompleteEldinTwilight()
					}),
					"skipbridgedonationon"
				})
			end
		}
	},
	EldinField__TO__EldinFieldLavaCaveLedge = {
		{
			function()
				return hasAll({
					"clawshot"
				})
			end
		},
		{
			function()
				return hasAny({
					"clawshot",
					"shadowcrystal"
				})
			end
		}
	},
	EldinField__TO__EldinFieldFromLavaCaveLower = {
		{
			function ()
				return false
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						"shadowcrystal",
						canCompleteEldinTwilight()
					}),
					canDoLJA()
				})
			end
		}
	},
	EldinField__TO__KakarikoGorge = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	EldinField__EXT_B__KakarikoVillageBehindGate = {},
	EldinField__TO__NorthEldinField = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		},
		{
			function()
				return hasAny({
					canSmash(),
					hasAll({
						"shadowcrystal",
						canCompleteEldinTwilight()
					})
				})
			end
		}
	},
	EldinField__GRO_A__EldinFieldBomskitGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	EldinField__GRO_A__EldinFieldWaterBombFishGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	EldinFieldNearCastleTown__TO__EldinField = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("KakarikoMaloMart"),
						canCompleteEldinTwilight(),
						canCompleteLanayruTwilight()
					}),
					"skipbridgedonationon"
				})
			end
		}
	},
	EldinFieldNearCastleTown__EXT_A__OutsideCastleTownEast = {},
	EldinFieldLavaCaveLedge__TO__EldinField = {},
	EldinFieldLavaCaveLedge__CAV_A__EldinFieldLavaCaveUpper = {},
	EldinFieldFromLavaCaveLower__TO__EldinField = {
		{
			function()
				return hasAll({
					"clawshot"
				})
			end
		}
	},
	EldinFieldFromLavaCaveLower__CAV_A__EldinFieldLavaCaveLower = {},
	NorthEldinField__TO__EldinField = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		},
		{
			function()
				return hasAny({
					canSmash(),
					hasAll({
						canDoMapGlitch(),
						canCompleteEldinTwilight(),
						hasAny({
							canCompleteLanayruTwilight(),
							"horsecall"
						})
					})
				})
			end
		}
	},
	NorthEldinField__TO__EldinFieldOutsideHiddenVillage = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("KakarikoRenadosSanctuary"),
						"woodenstatue"
					}),
					"iliaquestcharm"
				})
			end
		}
	},
	NorthEldinField__TO__EldinFieldGrottoPlatform = {
		{
			function()
				return hasAll({
					"spinner"
				})
			end
		}
	},
	NorthEldinField__TO__LanayruField = {
		{
			function()
				return hasAll({
					canCompleteEldinTwilight()
				})
			end
		}
	},
	EldinFieldOutsideHiddenVillage__TO__NorthEldinField = {
		{
			function()
				return hasAll({
					canAccess("KakarikoRenadosSanctuary"),
					"woodenstatue"
				})
			end
		}
	},
	EldinFieldOutsideHiddenVillage__EXT_A__HiddenVillage = {},
	EldinFieldGrottoPlatform__TO__NorthEldinField = {
		{
			function()
				return hasAll({
					"spinner"
				})
			end
		}
	},
	EldinFieldGrottoPlatform__GRO_A__EldinFieldStalfosGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	EldinFieldLavaCaveUpper__CAV_B__EldinFieldLavaCaveLedge = {},
	EldinFieldLavaCaveUpper__TO__EldinFieldLavaCaveLower = {
		{
			function()
				return hasAll({
					"boots"
				})
			end
		},
		{
			function()
				return hasAny({
					"boots",
					"shadowcrystal"
				})
			end
		}
	},
	EldinFieldLavaCaveLower__CAV_B__EldinFieldFromLavaCaveLower = {},
	EldinFieldBomskitGrotto__GRO_B__EldinField = {},
	EldinFieldWaterBombFishGrotto__GRO_B__EldinField = {},
	EldinFieldStalfosGrotto__GRO_B__EldinFieldGrottoPlatform = {},
	-- Kakariko Village
	LowerKakarikoVillage__TO__UpperKakarikoVillage = {
		{
			function()
				return hasAll({
					hasAny({
						"gmcompleted",
						canSmash()
					}),
					canCompleteEldinTwilight()
				})
			end
		}
	},
	LowerKakarikoVillage__TO__KakarikoVillageBehindGate = {
		{
			function()
				return hasAll({
					canCompleteEldinTwilight()
				})
			end
		}
	},
	LowerKakarikoVillage__EXT_B__KakarikoGorgeBehindGate = {},
	LowerKakarikoVillage__EXT_A__KakarikoGraveyard = {},
	LowerKakarikoVillage__EXT_A__DeathMountainNearKakariko = {},
	LowerKakarikoVillage__INT_A__KakarikoRenadosSanctuaryFrontLeftDoor = {},
	LowerKakarikoVillage__INT_A__KakarikoRenadosSanctuaryFrontRightDoor = {},
	LowerKakarikoVillage__INT_A__KakarikoRenadosSanctuaryBackLeftDoor = {},
	LowerKakarikoVillage__INT_A__KakarikoRenadosSanctuaryBackRightDoor = {},
	LowerKakarikoVillage__INT_A__KakarikoMaloMart = {},
	LowerKakarikoVillage__INT_A__KakarikoEldeInnLeftDoor = {},
	LowerKakarikoVillage__INT_A__KakarikoEldeInnRightDoor = {},
	LowerKakarikoVillage__INT_A__KakarikoBugHouseDoor = {},
	LowerKakarikoVillage__INT_A__KakarikoBugHouseCeilingHole = {},
	LowerKakarikoVillage__INT_A__KakarikoBarnesBombShopLower = {},
	UpperKakarikoVillage__TO__LowerKakarikoVillage = {},
	UpperKakarikoVillage__TO__KakarikoTopofWatchtower = {
		{
			function()
				return hasAll({
					"gmcompleted",
					canCompleteEldinTwilight()
				})
			end
		}
	},
	UpperKakarikoVillage__INT_A__KakarikoBarnesBombShopUpper = {},
	UpperKakarikoVillage__INT_A__KakarikoWatchtowerLowerDoor = {},
	UpperKakarikoVillage__INT_A__KakarikoWatchtowerDigSpot = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	KakarikoTopofWatchtower__TO__UpperKakarikoVillage = {},
	KakarikoTopofWatchtower__INT_A__KakarikoWatchtowerUpperDoor = {},
	KakarikoVillageBehindGate__TO__LowerKakarikoVillage = {
		{
			function()
				return hasAny({
					"gatekeys",
					canCompleteEldinTwilight()
				})
			end
		}
	},
	KakarikoVillageBehindGate__EXT_A__EldinField = {},
	KakarikoRenadosSanctuaryFrontLeftDoor__INT_B__LowerKakarikoVillage = {},
	KakarikoRenadosSanctuaryFrontLeftDoor__TO__KakarikoRenadosSanctuary = {},
	KakarikoRenadosSanctuaryFrontRightDoor__INT_B__LowerKakarikoVillage = {},
	KakarikoRenadosSanctuaryFrontRightDoor__TO__KakarikoRenadosSanctuary = {},
	KakarikoRenadosSanctuaryBackLeftDoor__INT_B__LowerKakarikoVillage = {},
	KakarikoRenadosSanctuaryBackLeftDoor__TO__KakarikoRenadosSanctuary = {},
	KakarikoRenadosSanctuaryBackRightDoor__INT_B__LowerKakarikoVillage = {},
	KakarikoRenadosSanctuaryBackRightDoor__TO__KakarikoRenadosSanctuary = {},
	KakarikoRenadosSanctuary__TO__KakarikoRenadosSanctuaryFrontLeftDoor = {},
	KakarikoRenadosSanctuary__TO__KakarikoRenadosSanctuaryFrontRightDoor = {},
	KakarikoRenadosSanctuary__TO__KakarikoRenadosSanctuaryBackLeftDoor = {},
	KakarikoRenadosSanctuary__TO__KakarikoRenadosSanctuaryBackRightDoor = {},
	KakarikoRenadosSanctuary__INT_A__KakarikoRenadosSanctuaryBasement = {},
	KakarikoRenadosSanctuaryBasement__INT_B__KakarikoRenadosSanctuary = {},
	KakarikoMaloMart__INT_B__LowerKakarikoVillage = {},
	KakarikoEldeInnLeftDoor__INT_B__LowerKakarikoVillage = {},
	KakarikoEldeInnLeftDoor__TO__KakarikoEldeInn = {},
	KakarikoEldeInnRightDoor__INT_B__LowerKakarikoVillage = {},
	KakarikoEldeInnRightDoor__TO__KakarikoEldeInn = {},
	KakarikoEldeInn__TO__KakarikoEldeInnLeftDoor = {},
	KakarikoEldeInn__TO__KakarikoEldeInnRightDoor = {},
	KakarikoBugHouseDoor__INT_B__LowerKakarikoVillage = {},
	KakarikoBugHouseDoor__TO__KakarikoBugHouse = {},
	KakarikoBugHouseCeilingHole__TO__KakarikoBugHouse = {},
	KakarikoBugHouseCeilingHole__INT_B__LowerKakarikoVillage = {},
	KakarikoBugHouse__TO__KakarikoBugHouseDoor = {},
	KakarikoBugHouse__TO__KakarikoBugHouseCeilingHole = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	KakarikoBarnesBombShopLower__INT_B__LowerKakarikoVillage = {},
	KakarikoBarnesBombShopLower__TO__KakarikoBarnesBombShopUpper = {},
	KakarikoBarnesBombShopUpper__INT_B__UpperKakarikoVillage = {},
	KakarikoBarnesBombShopUpper__TO__KakarikoBarnesBombShopLower = {},
	KakarikoWatchtowerLowerDoor__INT_B__UpperKakarikoVillage = {},
	KakarikoWatchtowerLowerDoor__TO__KakarikoWatchtower = {},
	KakarikoWatchtowerDigSpot__INT_B__UpperKakarikoVillage = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	KakarikoWatchtowerDigSpot__TO__KakarikoWatchtower = {},
	KakarikoWatchtowerUpperDoor__INT_B__KakarikoTopofWatchtower = {},
	KakarikoWatchtowerUpperDoor__TO__KakarikoWatchtower = {},
	KakarikoWatchtower__TO__KakarikoWatchtowerLowerDoor = {},
	KakarikoWatchtower__TO__KakarikoWatchtowerDigSpot = {},
	KakarikoWatchtower__TO__KakarikoWatchtowerUpperDoor = {},
	KakarikoGraveyard__EXT_B__LowerKakarikoVillage = {},
	KakarikoGraveyard__OOW__LakeHylia = {
		{
			function()
				return hasAll({
					"gatekeys",
					hasAny({
						"boots",
						"zoraarmor"
					}),
					hasWaterBombs(),
					canCompleteEldinTwilight()
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						hasHeavyMod(),
						hasWaterBombs(),
						"gatekeys",
						canCompleteEldinTwilight()
					}),
					hasAll({
						hasAny({
							hasHeavyMod(),
							"zoraarmor"
						}),
						hasAny({
							hasAll({
								hasBombs(),
								hasAny({
									"sword",
									"spinner"
								})
							}),
							canDoLJA(),
							canDoMoonBoots()
						})
					})
				})
			end
		}
	},
	-- Faron Province
	-- Faron Woods
	SouthFaronWoods__TO__SouthFaronWoodsBehindGate = {
		{
			function()
				return hasAny({
					"corokey",
					"shadowcrystal"
				})
			end
		}
	},
	SouthFaronWoods__TO__SouthFaronWoodsOwlStatueArea = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	SouthFaronWoods__EXT_B__OrdonBridge = {
		{
			function()
				return hasAll({
					canCompletePrologue(),
					canCompleteFaronTwilight()
				})
			end
		}
	},
	SouthFaronWoods__EXT_A__FaronField = {
		{
			function()
				return hasAll({
					canClearForest(),
					canCompleteFaronTwilight(),
					canCompletePrologue()
				})
			end
		},
		{
			function()
				return hasAll({
					canClearForestGlitched(),
					canCompleteFaronTwilight()
				})
			end
		}
	},
	SouthFaronWoods__INT_A__FaronWoodsCorosHouseLower = {},
	SouthFaronWoodsBehindGate__TO__SouthFaronWoods = {
		{
			function()
				return hasAny({
					"corokey",
					"shadowcrystal"
				})
			end
		}
	},
	SouthFaronWoodsBehindGate__CAV_A__FaronWoodsCaveSouthernEntrance = {},
	SouthFaronWoodsCorosLedge__TO__SouthFaronWoods = {},
	SouthFaronWoodsCorosLedge__INT_A__FaronWoodsCorosHouseUpper = {},
	SouthFaronWoodsOwlStatueArea__TO__SouthFaronWoods = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	SouthFaronWoodsOwlStatueArea__TO__SouthFaronWoodsAboveOwlStatue = {
		{
			function()
				return hasAll({
					canClearForest(),
					"powereddominionrod",
					"shadowcrystal",
					canCompleteFaronTwilight()
				})
			end
		},
		{
			function()
				return hasAll({
					canClearForestGlitched(),
					"powereddominionrod",
					"shadowcrystal",
					canCompleteFaronTwilight()
				})
			end
		}
	},
	SouthFaronWoodsAboveOwlStatue__TO__SouthFaronWoodsOwlStatueArea = {},
	SouthFaronWoodsAboveOwlStatue__EXT_A__MistAreaNearOwlStatueChest = {},
	FaronWoodsCorosHouseLower__TO__FaronWoodsCorosHouseUpper = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	FaronWoodsCorosHouseLower__INT_B__SouthFaronWoods = {},
	FaronWoodsCorosHouseUpper__TO__FaronWoodsCorosHouseLower = {},
	FaronWoodsCorosHouseUpper__INT_B__SouthFaronWoodsCorosLedge = {},
	FaronWoodsCaveSouthernEntrance__CAV_B__SouthFaronWoodsBehindGate = {},
	FaronWoodsCaveSouthernEntrance__TO__FaronWoodsCave = {},
	FaronWoodsCave__TO__FaronWoodsCaveSouthernEntrance = {},
	FaronWoodsCave__TO__FaronWoodsCaveNorthernEntrance = {},
	MistAreaNearFaronWoodsCave__TO__MistAreaInsideMist = {
		{
			function()
				return hasAll({
					"lantern"
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					canDoMapGlitch()
				})
			end
		}
	},
	MistAreaNearFaronWoodsCave__TO__MistAreaUnderOwlStatueChest = {
		{
			function()
				return hasAny({
					"lantern",
					"shadowcrystal"
				})
			end
		}
	},
	MistAreaNearFaronWoodsCave__CAV_A__FaronWoodsCaveNorthernEntrance = {},
	MistAreaInsideMist__TO__MistAreaNearFaronWoodsCave = {
		{
			function()
				return hasAll({
					"lantern"
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					hasAll({
						canAccess("SouthFaronWoods"),
						canDoMapGlitch()
					})
				})
			end
		}
	},
	MistAreaInsideMist__TO__MistAreaUnderOwlStatueChest = {
		{
			function()
				return hasAny({
					"lantern"
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					canDoMapGlitch()
				})
			end
		}
	},
	MistAreaInsideMist__TO__MistAreaOutsideFaronMistCave = {
		{
			function()
				return hasAll({
					"lantern",
					hasAny({
						canCompleteFaronTwilight(),
						"shadowcrystal"
					})
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					hasAll({
						canAccess("SouthFaronWoods"),
						canDoMapGlitch()
					})
				})
			end
		}
	},
	MistAreaInsideMist__TO__MistAreaNearNorthFaronWoods = {
		{
			function()
				return hasAll({
					"lantern"
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					hasAll({
						canAccess("SouthFaronWoods"),
						canDoMapGlitch()
					})
				})
			end
		}
	},
	MistAreaUnderOwlStatueChest__TO__MistAreaInsideMist = {
		{
			function()
				return hasAll({
					"lantern"
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					canDoMapGlitch()
				})
			end
		}
	},
	MistAreaUnderOwlStatueChest__TO__MistAreaCenterStump = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	MistAreaNearOwlStatueChest__TO__MistAreaUnderOwlStatueChest = {},
	MistAreaNearOwlStatueChest__EXT_B__SouthFaronWoodsAboveOwlStatue = {},
	MistAreaCenterStump__TO__MistAreaInsideMist = {
		{
			function()
				return hasAll({
					"lantern"
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					canDoMapGlitch()
				})
			end
		}
	},
	MistAreaCenterStump__TO__MistAreaNearNorthFaronWoods = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	MistAreaOutsideFaronMistCave__TO__MistAreaInsideMist = {
		{
			function()
				return hasAll({
					"lantern"
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					canDoMapGlitch()
				})
			end
		}
	},
	MistAreaOutsideFaronMistCave__CAV_A__MistAreaFaronMistCave = {},
	MistAreaNearNorthFaronWoods__TO__MistAreaInsideMist = {
		{
			function()
				return hasAll({
					"lantern"
				})
			end
		},
		{
			function()
				return hasAny({
					"lantern",
					canDoMapGlitch()
				})
			end
		}
	},
	MistAreaNearNorthFaronWoods__TO__MistAreaNearFaronWoodsCave = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	MistAreaNearNorthFaronWoods__TO__MistAreaNearNorthFaronWoodsBehindGate = {
		{
			function()
				return hasAll({
					"faronwoodskey"
				})
			end
		}
	},
	MistAreaNearNorthFaronWoodsBehindGate__TO__MistAreaNearNorthFaronWoods = {
		{
			function()
				return hasAll({
					"faronwoodskey"
				})
			end
		}
	},
	MistAreaNearNorthFaronWoodsBehindGate__EXT_A__NorthFaronWoods = {},
	FaronWoodsCaveNorthernEntrance__CAV_B__MistAreaNearFaronWoodsCave = {},
	FaronWoodsCaveNorthernEntrance__TO__FaronWoodsCave = {},
	MistAreaFaronMistCave__CAV_B__MistAreaOutsideFaronMistCave = {},
	NorthFaronWoods__EXT_B__MistAreaNearNorthFaronWoodsBehindGate = {},
	NorthFaronWoods__TO__NorthFaronLostWoodsEntrance = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					canCompleteFaronTwilight()
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						"shadowcrystal",
						canCompleteFaronTwilight()
					}),
					hasAll({
						hasBombs(),
						canDoLJA()
					})
				})
			end
		}
	},
	NorthFaronWoods__DUN_A__ForestTempleEntrance = {},
	NorthFaronLostWoodsEntrance__EXT_A__LostWoods = {},
	-- Hyrule Field - Faron
	FaronField__EXT_A__OutsideCastleTownSouth = {
		{
			function()
				return hasAll({
					canGetHotSpringWater(),
					canAccess("OutsideCastleTownSouth", "FaronField__EXT_A__OutsideCastleTownSouth")
				})
			end
		},
		{
			function()
				return hasAll({
					canAccess("CastleTownSouth"),
					hasBottle(),
					canAccess("OutsideCastleTownSouth", "FaronField__EXT_A__OutsideCastleTownSouth")
				})
			end
		}
	},
	FaronField__EXT_B__SouthFaronWoods = {},
	FaronField__TO__KakarikoGorge = {},
	FaronField__TO__LakeHyliaBridge = {
		{
			function()
				return hasAll({
					"gatekeys"
				})
			end
		},
		{
			function()
				return hasAny({
					"gatekeys",
					"shadowcrystal"
				})
			end
		}
	},
	FaronField__GRO_A__FaronFieldCornerGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	FaronField__GRO_A__FaronFieldFishingGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	FaronFieldCornerGrotto__GRO_B__FaronField = {},
	FaronFieldFishingGrotto__GRO_B__FaronField = {},
	-- Sacred Grove
	LostWoods__TO__LostWoodsLowerBattleArena = {
		{
			function()
				return hasAny({
					hasAll({
						canDefeatSkullKid(),
						"shadowcrystal"
					}),
					"skipsacredgroveentranceon"
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						canDefeatSkullKid(),
						"shadowcrystal"
					}),
					"skipsacredgroveentranceon",
					canDoJSMoonBoots()
				})
			end
		}
	},
	LostWoods__TO__LostWoodsUpperBattleArena = {
		{
			function()
				return hasAny({
					hasAll({
						canDefeatSkullKid(),
						"shadowcrystal"
					}),
					"skipsacredgroveentranceon"
				})
			end
		}
	},
	LostWoods__EXT_B__NorthFaronLostWoodsEntrance = {},
	LostWoodsLowerBattleArena__TO__LostWoods = {},
	LostWoodsLowerBattleArena__EXT_A__SacredGroveLower = {
		{
			function()
				return hasAny({
					canDefeatSkullKid(),
					"skipsacredgroveentranceon"
				})
			end
		}
	},
	LostWoodsLowerBattleArena__GRO_A__LostWoodsBabaSerpentGrotto = {
		{
			function()
				return hasAll({
					canSmash(),
					"shadowcrystal"
				})
			end
		}
	},
	LostWoodsUpperBattleArena__EXT_A__SacredGroveBeforeBlock = {
		{
			function()
				return hasAny({
					canDefeatSkullKid(),
					"skipsacredgroveentranceon"
				})
			end
		}
	},
	LostWoodsBabaSerpentGrotto__GRO_B__LostWoodsLowerBattleArena = {},
	SacredGroveBeforeBlock__EXT_B__LostWoodsUpperBattleArena = {},
	SacredGroveBeforeBlock__TO__SacredGroveUpper = {},
	SacredGroveUpper__TO__SacredGroveLower = {},
	SacredGroveUpper__EXT_A__SacredGrovePast = {
		{
			function()
				return hasAll({
					canStrikePedestal()
				})
			end
		}
	},
	SacredGroveLower__EXT_B__LostWoodsLowerBattleArena = {},
	SacredGroveLower__TO__SacredGroveUpper = {
		{
			function()
				return hasAny({
					canAccess("SacredGroveBeforeBlock"),
					"skipsacredgroveentranceon"
				})
			end
		},
		{
			function()
				return hasAny({
					canAccess("SacredGroveBeforeBlock"),
					"skipsacredgroveentranceon",
					canDoJSMoonBoots()
				})
			end
		}
	},
	SacredGrovePast__TO__SacredGrovePastBehindWindow = {
		{
			function()
				return hasAll({
					canStrikePedestal()
				})
			end
		}
	},
	SacredGrovePast__EXT_B__SacredGroveUpper = {},
	SacredGrovePastBehindWindow__TO__SacredGrovePast = {},
	SacredGrovePastBehindWindow__DUN_A__TempleofTimeEntrance = {},
	-- Gerudo Province
	-- Cave of Ordeals
	GerudoDesertCaveofOrdealsFloors0111__CAV_B__GerudoDesertCaveofOrdealsPlateau = {
		{
			function()
				return hasAll({
					"clawshot"
				})
			end
		}
	},
	GerudoDesertCaveofOrdealsFloors0111__TO__GerudoDesertCaveofOrdealsFloors1221 = {
		{
			function()
				return hasAll({
					"spinner",
					canDefeatBokoblin(),
					canDefeatKeese(),
					canDefeatRat(),
					canDefeatHangingBabaSerpent(),
					canDefeatSkulltula(),
					canDefeatBulblin(),
					canDefeatTorchSlug(),
					canDefeatFireKeese(),
					canDefeatDodongo(),
					canDefeatTektite(),
					canDefeatLizalfos()
				})
			end
		},
		{
			function()
				return hasAll({
					hasAny({
						"spinner",
						canDoLJA()
					}),
					canDefeatBokoblin(),
					canDefeatKeese(),
					canDefeatRat(),
					canDefeatHangingBabaSerpent(),
					canDefeatSkulltula(),
					canDefeatBulblin(),
					canDefeatTorchSlug(),
					canDefeatFireKeese(),
					canDefeatDodongo(),
					canDefeatTektite(),
					canDefeatLizalfos()
				})
			end
		}
	},
	GerudoDesertCaveofOrdealsFloors1221__TO__GerudoDesertCaveofOrdealsFloors2231 = {
		{
			function()
				return hasAll({
					canDefeatHelmasaur(),
					canDefeatRat(),
					"ballchain",
					canDefeatChu(),
					canDefeatChuWorm(),
					canDefeatBubble(),
					canDefeatBulblin(),
					canDefeatKeese(),
					canDefeatRat(),
					canDefeatStalhound(),
					canDefeatPoe(),
					canDefeatLeever()
				})
			end
		}
	},
	GerudoDesertCaveofOrdealsFloors2231__TO__GerudoDesertCaveofOrdealsFloors3241 = {
		{
			function()
				return hasAll({
					canDefeatBokoblin(),
					canDefeatIceKeese(),
					"powereddominionrod",
					canDefeatKeese(),
					canDefeatRat(),
					canDefeatGhoulRat(),
					canDefeatStalchild(),
					canDefeatRedeadKnight(),
					canDefeatBulblin(),
					canDefeatStalfos(),
					canDefeatSkulltula(),
					canDefeatBubble(),
					canDefeatLizalfos(),
					canDefeatFireBubble()
				})
			end
		}
	},
	GerudoDesertCaveofOrdealsFloors3241__TO__GerudoDesertCaveofOrdealsFloors4250 = {
		{
			function()
				return hasAll({
					canDefeatBeamos(),
					canDefeatKeese(),
					"dclawshot",
					canDefeatTorchSlug(),
					canDefeatFireKeese(),
					canDefeatDodongo(),
					canDefeatFireBubble(),
					canDefeatRedeadKnight(),
					canDefeatPoe(),
					canDefeatGhoulRat(),
					canDefeatChu(),
					canDefeatIceKeese(),
					canDefeatFreezard(),
					canDefeatChilfos(),
					canDefeatIceBubble(),
					canDefeatLeever(),
					canDefeatDarknut()
				})
			end
		},
		{
			function()
				return hasAll({
					canDefeatBeamos(),
					canDefeatKeese(),
					hasAny({
						"dclawshot",
						canDoLJA()
					}),
					canDefeatTorchSlug(),
					canDefeatFireKeese(),
					canDefeatDodongo(),
					canDefeatFireBubble(),
					canDefeatRedeadKnight(),
					canDefeatPoe(),
					canDefeatGhoulRat(),
					canDefeatChu(),
					canDefeatIceKeese(),
					canDefeatFreezard(),
					canDefeatChilfos(),
					canDefeatIceBubble(),
					canDefeatLeever(),
					canDefeatDarknut()
				})
			end
		}
	},
	-- Gerudo Desert
	GerudoDesert__TO__GerudoDesertCaveofOrdealsPlateau = {
		{
			function()
				return hasAll({
					"clawshot",
					canDefeatShadowBeast()
				})
			end
		}
	},
	GerudoDesert__TO__GerudoDesertBasin = {},
	GerudoDesert__GRO_A__GerudoDesertSkulltulaGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	GerudoDesertCaveofOrdealsPlateau__TO__GerudoDesert = {},
	GerudoDesertCaveofOrdealsPlateau__CAV_A__GerudoDesertCaveofOrdealsFloors0111 = {},
	GerudoDesertBasin__TO__GerudoDesert = {
		{
			function()
				return hasAll({
					canDefeatBulblin()
				})
			end
		}
	},
	GerudoDesertBasin__TO__GerudoDesertNorthEastLedge = {
		{
			function()
				return hasAll({
					"clawshot"
				})
			end
		}
	},
	GerudoDesertBasin__TO__GerudoDesertOutsideBulblinCamp = {
		{
			function()
				return hasAll({
					canDefeatBulblin()
				})
			end
		}
	},
	GerudoDesertBasin__GRO_A__GerudoDesertChuGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	GerudoDesertNorthEastLedge__TO__GerudoDesertBasin = {},
	GerudoDesertNorthEastLedge__GRO_A__GerudoDesertRockGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	GerudoDesertOutsideBulblinCamp__TO__GerudoDesertBasin = {
		{
			function()
				return hasAll({
					canAccess("GerudoDesertBasin", "GerudoDesertOutsideBulblinCamp__TO__GerudoDesertBasin"),
					canDefeatBulblin()
				})
			end
		}
	},
	GerudoDesertOutsideBulblinCamp__EXT_A__BulblinCamp = {},
	GerudoDesertSkulltulaGrotto__GRO_B__GerudoDesert = {},
	GerudoDesertChuGrotto__GRO_B__GerudoDesertBasin = {},
	GerudoDesertRockGrotto__GRO_B__GerudoDesertNorthEastLedge = {},
	BulblinCamp__EXT_B__GerudoDesertOutsideBulblinCamp = {},
	BulblinCamp__EXT_A__OutsideArbitersGrounds = {
		{
			function()
				return hasAny({
					hasAll({
						"bckey",
						canDefeatKingBulblinDesert()
					}),
					"skiparbitersentranceon"
				})
			end
		},
		{
			function()
				return hasAny({
					hasAll({
						canDefeatKingBulblinDesert(),
						hasAny({
							"bckey",
							hasAll({
								canDoMapGlitch(),
								"sword"
							})
						})
					}),
					"skiparbitersentranceon"
				})
			end
		}
	},
	OutsideArbitersGrounds__EXT_B__BulblinCamp = {},
	OutsideArbitersGrounds__DUN_A__ArbitersGroundsEntrance = {},
	MirrorChamberLower__BRE_B__ArbitersGroundsBossRoom = {
		{
			function()
				return hasAll({
					canAccess("ArbitersGroundsBossRoom", "MirrorChamberLower__BRE_B__ArbitersGroundsBossRoom"),
					canDefeatStallord()
				})
			end
		}
	},
	MirrorChamberLower__TO__MirrorChamberUpper = {},
	MirrorChamberUpper__TO__MirrorChamberLower = {
		{
			function()
				return hasAny({
					canDefeatShadowBeast(),
					hasAll({
						"shadowcrystal",
						"mcportalactive"
					})
				})
			end
		}
	},
	MirrorChamberUpper__TO__MirrorChamberPortal = {
		{
			function()
				return hasAll({
					hasAny({
						canDefeatShadowBeast(),
						hasAll({
							"shadowcrystal",
							"mcportalactive"
						})
					}),
					hasAny({
						"ptopen",
						hasAll({
							"ptfusedshadows",
							hasAmount("fusedshadow", 3)
						}),
						hasAll({
							"ptmirrorshards",
							hasAmount("mirrorshard", 4)
						}),
						hasAll({
							"ptvanilla",
							"cscompleted"
						})
					})
				})
			end
		}
	},
	MirrorChamberPortal__TO__MirrorChamberUpper = {
		{
			function()
				return hasAny({
					canDefeatShadowBeast(),
					hasAll({
						"shadowcrystal",
						"mcportalactive"
					})
				})
			end
		}
	},
	MirrorChamberPortal__DUN_A__PalaceofTwilightEntrance = {},
	-- Lanayru Province
	-- Castle Town
	CastleTownWest__EXT_B__OutsideCastleTownWest = {},
	CastleTownWest__EXT_A__CastleTownCenter = {},
	CastleTownWest__EXT_A__CastleTownSouth = {},
	CastleTownWest__INT_A__CastleTownSTARGame = {
		{
			function()
				return hasAll({
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	CastleTownSTARGame__INT_B__CastleTownWest = {},
	CastleTownCenter__EXT_B__CastleTownWest = {},
	CastleTownCenter__EXT_A__CastleTownNorth = {},
	CastleTownCenter__EXT_A__CastleTownEast = {},
	CastleTownCenter__EXT_A__CastleTownSouth = {},
	CastleTownCenter__INT_A__CastleTownGoronHouseLeftDoor = {},
	CastleTownCenter__INT_A__CastleTownGoronHouseRightDoor = {},
	CastleTownCenter__INT_A__CastleTownMaloMart = {
		{
			function()
				return hasAll({
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	CastleTownGoronHouseLeftDoor__INT_B__CastleTownCenter = {},
	CastleTownGoronHouseLeftDoor__TO__CastleTownGoronHouse = {},
	CastleTownGoronHouseRightDoor__INT_B__CastleTownCenter = {},
	CastleTownGoronHouseRightDoor__TO__CastleTownGoronHouse = {},
	CastleTownGoronHouse__TO__CastleTownGoronHouseLeftDoor = {},
	CastleTownGoronHouse__TO__CastleTownGoronHouseRightDoor = {},
	CastleTownGoronHouse__TO__CastleTownGoronHouseBalcony = {},
	CastleTownGoronHouseBalcony__TO__CastleTownGoronHouse = {},
	CastleTownMaloMart__INT_B__CastleTownCenter = {},
	CastleTownNorth__TO__CastleTownNorthBehindFirstDoor = {
		{
			function()
				return hasAll({
					canCompleteMDH()
				})
			end
		}
	},
	CastleTownNorth__EXT_B__CastleTownCenter = {},
	CastleTownNorthBehindFirstDoor__TO__CastleTownNorth = {
		{
			function()
				return hasAll({
					canCompleteMDH()
				})
			end
		}
	},
	CastleTownNorthBehindFirstDoor__TO__CastleTownNorthInsideBarrier = {
		{
			function()
				return hasAll({
					canBreakHCBarrier()
				})
			end
		}
	},
	CastleTownNorthInsideBarrier__TO__CastleTownNorthBehindFirstDoor = {},
	CastleTownNorthInsideBarrier__DHC_A__HyruleCastleEntrance = {},
	CastleTownEast__EXT_B__CastleTownCenter = {},
	CastleTownEast__EXT_A__OutsideCastleTownEast = {
		{
			function()
				return hasAll({
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	CastleTownEast__EXT_A__CastleTownSouth = {},
	CastleTownEast__INT_A__CastleTownDoctorsOfficeLeftDoor = {},
	CastleTownEast__INT_A__CastleTownDoctorsOfficeRightDoor = {},
	CastleTownDoctorsOfficeBalcony__TO__CastleTownEast = {},
	CastleTownDoctorsOfficeBalcony__INT_A__CastleTownDoctorsOfficeUpper = {},
	CastleTownDoctorsOfficeLeftDoor__INT_B__CastleTownEast = {},
	CastleTownDoctorsOfficeLeftDoor__TO__CastleTownDoctorsOfficeEntrance = {},
	CastleTownDoctorsOfficeRightDoor__INT_B__CastleTownEast = {},
	CastleTownDoctorsOfficeRightDoor__TO__CastleTownDoctorsOfficeEntrance = {},
	CastleTownDoctorsOfficeEntrance__TO__CastleTownDoctorsOfficeLeftDoor = {},
	CastleTownDoctorsOfficeEntrance__TO__CastleTownDoctorsOfficeRightDoor = {},
	CastleTownDoctorsOfficeEntrance__TO__CastleTownDoctorsOfficeLower = {
		{
			function()
				return hasAny({
					"invoice",
					"iliaqueststatue",
					"iliaquestcharm"
				})
			end
		}
	},
	CastleTownDoctorsOfficeLower__TO__CastleTownDoctorsOfficeEntrance = {
		{
			function()
				return hasAny({
					"invoice",
					"iliaqueststatue",
					"iliaquestcharm"
				})
			end
		}
	},
	CastleTownDoctorsOfficeLower__TO__CastleTownDoctorsOfficeUpper = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	CastleTownDoctorsOfficeUpper__TO__CastleTownDoctorsOfficeLower = {},
	CastleTownDoctorsOfficeUpper__INT_B__CastleTownDoctorsOfficeBalcony = {},
	CastleTownSouth__EXT_B__CastleTownWest = {},
	CastleTownSouth__EXT_B__CastleTownCenter = {},
	CastleTownSouth__EXT_B__CastleTownEast = {},
	CastleTownSouth__TO__SouthCastleTownDoors = {
		{
			function()
				return hasAll({
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	CastleTownSouth__INT_A__CastleTownAgithasHouse = {},
	CastleTownSouth__INT_A__CastleTownSeerHouse = {},
	CastleTownSouth__INT_A__CastleTownJovanisHouse = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	CastleTownSouth__INT_A__CastleTownTelmasBar = {},
	SouthCastleTownDoors__TO__CastleTownSouth = {},
	SouthCastleTownDoors__EXT_A__OutsideCastleTownSouth = {},
	CastleTownAgithasHouse__INT_B__CastleTownSouth = {},
	CastleTownSeerHouse__INT_B__CastleTownSouth = {},
	CastleTownJovanisHouse__INT_B__CastleTownSouth = {},
	CastleTownTelmasBar__INT_B__CastleTownSouth = {},
	-- Hyrule Field - Lanayru
	LanayruField__TO__LanayruFieldCaveEntrance = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	LanayruField__TO__LanayruFieldBehindBoulder = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		},
		{
			function()
				return hasAny({
					canSmash(),
					canDoMapGlitch()
				})
			end
		}
	},
	LanayruField__TO__HyruleFieldNearSpinnerRails = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		},
		{
			function()
				return hasAny({
					canSmash(),
					hasAll({
						canDoMapGlitch(),
						canCompleteLanayruTwilight()
					})
				})
			end
		}
	},
	LanayruField__TO__NorthEldinField = {
		{
			function()
				return hasAll({
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LanayruField__EXT_A__OutsideCastleTownWest = {},
	LanayruField__GRO_A__LanayruFieldChuGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LanayruField__GRO_A__LanayruFieldSkulltulaGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LanayruField__GRO_A__LanayruFieldPoeGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LanayruFieldCaveEntrance__TO__LanayruField = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	LanayruFieldCaveEntrance__CAV_A__LanayruIcePuzzleCave = {},
	LanayruFieldBehindBoulder__TO__LanayruField = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	LanayruFieldBehindBoulder__EXT_A__ZorasDomainWestLedge = {},
	HyruleFieldNearSpinnerRails__TO__LanayruField = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	HyruleFieldNearSpinnerRails__TO__LakeHyliaBridge = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	LanayruIcePuzzleCave__CAV_B__LanayruFieldCaveEntrance = {},
	LanayruFieldChuGrotto__GRO_B__LanayruField = {},
	LanayruFieldSkulltulaGrotto__GRO_B__LanayruField = {},
	LanayruFieldPoeGrotto__GRO_B__LanayruField = {},
	OutsideCastleTownWest__TO__OutsideCastleTownWestGrottoLedge = {
		{
			function()
				return hasAll({
					"clawshot"
				})
			end
		},
		{
			function()
				return hasAll({
					"shadowcrystal",
					hasAny({
						"clawshot",
						canDoMapGlitch()
					})
				})
			end
		}
	},
	OutsideCastleTownWest__EXT_B__LanayruField = {},
	OutsideCastleTownWest__EXT_A__CastleTownWest = {},
	OutsideCastleTownWest__EXT_A__LakeHyliaBridge = {},
	OutsideCastleTownWestGrottoLedge__TO__OutsideCastleTownWest = {},
	OutsideCastleTownWestGrottoLedge__GRO_A__OutsideCastleTownWestHelmasaurGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	OutsideCastleTownWestHelmasaurGrotto__GRO_B__OutsideCastleTownWestGrottoLedge = {},
	OutsideCastleTownEast__EXT_B__EldinFieldNearCastleTown = {},
	OutsideCastleTownEast__EXT_B__CastleTownEast = {},
	OutsideCastleTownSouth__EXT_B__SouthCastleTownDoors = {},
	OutsideCastleTownSouth__EXT_B__FaronField = {
		{
			function()
				return hasAll({
					canGetHotSpringWater()
				})
			end
		}
	},
	OutsideCastleTownSouth__OOW__LakeHylia = {},
	OutsideCastleTownSouth__GRO_A__OutsideCastleTownSouthTektiteGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	OutsideCastleTownSouthTektiteGrotto__GRO_B__OutsideCastleTownSouth = {},
	LakeHyliaBridge__TO__LakeHyliaBridgeGrottoLedge = {
		{
			function()
				return hasAll({
					canLaunchBombs(),
					"clawshot"
				})
			end
		}
	},
	LakeHyliaBridge__TO__HyruleFieldNearSpinnerRails = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		},
		{
			function()
				return hasAny({
					canSmash(),
					canDoMapGlitch()
				})
			end
		}
	},
	LakeHyliaBridge__EXT_B__OutsideCastleTownWest = {},
	LakeHyliaBridge__EXT_A__LakeHyliaFlightByFowl = {},
	LakeHyliaBridge__TO__FaronField = {
		{
			function()
				return hasAll({
					"gatekeys",
					canCompleteLanayruTwilight()
				})
			end
		},
		{
			function()
				return hasAll({
					hasAny({
						"gatekeys",
						"shadowcrystal"
					}),
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LakeHyliaBridgeGrottoLedge__TO__LakeHyliaBridge = {},
	LakeHyliaBridgeGrottoLedge__GRO_A__LakeHyliaBridgeBubbleGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	LakeHyliaBridgeBubbleGrotto__GRO_B__LakeHyliaBridgeGrottoLedge = {},
	-- Lake Hylia
	LakeHylia__TO__LakeHyliaCaveEntrance = {
		{
			function()
				return hasAll({
					canSmash(),
					canWarpMeteor()
				})
			end
		}
	},
	LakeHylia__TO__LakeHyliaLakebedTempleEntrance = {
		{
			function()
				return hasAll({
					"zoraarmor",
					hasAny({
						"skiplakebedentranceon",
						hasAll({
							"boots",
							hasWaterBombs()
						})
					})
				})
			end
		},
		{
			function()
				return hasAny({
					"zoraarmor",
					canDoAirRefill()
				})
			end
		}
	},
	LakeHylia__OOW__LakeHyliaFlightByFowl = {
		{
			function()
				return hasAll({
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LakeHylia__OOW__GerudoDesert = {
		{
			function()
				return hasAll({
					"aurusmemo",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LakeHylia__TO__UpperZorasRiver = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	LakeHylia__CAV_A__LakeHyliaLanayruSpring = {
		{
			function()
				return hasAll({
					canWarpMeteor()
				})
			end
		}
	},
	LakeHylia__GRO_A__LakeHyliaWaterToadpoliGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LakeHylia__DUN_A__CityinTheSkyEntrance = {
		{
			function()
				return hasAll({
					hasAny({
						hasAmount("skybook", 7),
						"skipcityintheskyentranceon"
					}),
					"clawshot",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LakeHyliaFlightByFowl__TO__LakeHylia = {
		{
			function()
				return hasAll({
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LakeHyliaFlightByFowl__EXT_B__LakeHyliaBridge = {
		{
			function()
				return hasAll({
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LakeHyliaFlightByFowl__GRO_A__LakeHyliaShellBladeGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	LakeHyliaCaveEntrance__TO__LakeHylia = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	LakeHyliaCaveEntrance__CAV_A__LakeHyliaLongCave = {},
	LakeHyliaLakebedTempleEntrance__TO__LakeHylia = {
		{
			function()
				return hasAll({
					"zoraarmor",
					hasAny({
						"skiplakebedentranceon",
						hasAll({
							"boots",
							hasWaterBombs()
						})
					})
				})
			end
		}
	},
	LakeHyliaLakebedTempleEntrance__DUN_A__LakebedTempleEntrance = {},
	LakeHyliaLanayruSpring__CAV_B__LakeHylia = {},
	LakeHyliaLongCave__CAV_B__LakeHyliaCaveEntrance = {},
	LakeHyliaShellBladeGrotto__GRO_B__LakeHyliaFlightByFowl = {},
	LakeHyliaWaterToadpoliGrotto__GRO_B__LakeHylia = {},
	-- Zora's Domain
	UpperZorasRiver__OOW__LanayruField = {},
	UpperZorasRiver__EXT_A__FishingHole = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("ZorasDomainThroneRoom"),
						canCompleteEldinTwilight()
					}),
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	UpperZorasRiver__EXT_A__ZorasDomain = {},
	UpperZorasRiver__INT_A__UpperZorasRiverIzasHouse = {
		{
			function()
				return hasAll({
					hasAny({
						"sword",
						hasAll({
							canDefeatShadowBeast(),
							"transformanywhereon"
						}),
						"uzrportalactive"
					}),
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	UpperZorasRiverIzasHouse__INT_B__UpperZorasRiver = {},
	UpperZorasRiverIzasHouse__TO__LakeHylia = {
		{
			function()
				return hasAll({
					"bow"
				})
			end
		}
	},
	FishingHole__EXT_B__UpperZorasRiver = {},
	FishingHole__INT_A__FishingHoleHouse = {},
	FishingHole__TO__FishingHolePieceofHeart = {
		{
			function()
				return hasAll({
					"clawshot"
				})
			end
		}
	},
	FishingHoleHouse__INT_B__FishingHole = {},
	FishingHoleHouse__TO__FishingHolePieceofHeart = {},
	ZorasDomain__TO__ZorasDomainWestLedge = {
		{
			function()
				return hasAny({
					"clawshot",
					"shadowcrystal",
					canSmash()
				})
			end
		}
	},
	ZorasDomain__EXT_B__UpperZorasRiver = {},
	ZorasDomain__TO__ZorasDomainTopofWaterfall = {
		{
			function()
				return hasAny({
					canWarpMeteor(),
					"shadowcrystal"
				})
			end
		}
	},
	ZorasDomain__TO__ZorasDomainSnowpeakEntrance = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("ZorasDomainThroneRoom"),
						canCompleteEldinTwilight(),
						"ballchain"
					}),
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	ZorasDomainSnowpeakEntrance__TO__ZorasDomain = {
		{
			function()
				return hasAny({
					"ballchain",
					canCompleteLanayruTwilight()
				})
			end
		}
	},
	ZorasDomainSnowpeakEntrance__EXT_A__SnowpeakClimbLower = {},
	ZorasDomainWestLedge__TO__ZorasDomain = {},
	ZorasDomainWestLedge__TO__ZorasDomainTopofWaterfall = {
		{
			function()
				return hasAll({
					canSmash()
				})
			end
		}
	},
	ZorasDomainWestLedge__EXT_B__LanayruFieldBehindBoulder = {},
	ZorasDomainThroneRoom__EXT_B__ZorasDomainTopofWaterfall = {},
	ZorasDomainTopofWaterfall__TO__ZorasDomain = {},
	ZorasDomainTopofWaterfall__EXT_A__ZorasDomainThroneRoom = {},
	-- Ordona Province
	-- Ordon
	OutsideLinksHouse__EXT_A__OrdonVillage = {},
	OutsideLinksHouse__EXT_A__OrdonSpring = {},
	OutsideLinksHouse__INT_A__OrdonLinksHouse = {},
	OrdonLinksHouse__INT_B__OutsideLinksHouse = {},
	OrdonVillage__EXT_B__OutsideLinksHouse = {},
	OrdonVillage__EXT_A__OrdonRanchEntrance = {},
	OrdonVillage__INT_A__OrdonSerasShop = {},
	OrdonVillage__INT_A__OrdonShieldHouseLower = {},
	OrdonVillage__INT_A__OrdonSwordHouse = {},
	OrdonVillage__INT_A__OrdonBosHouseLeftDoor = {},
	OrdonVillage__INT_A__OrdonBosHouseRightDoor = {},
	OrdonSerasShop__INT_B__OrdonVillage = {},
	OrdonShieldHouseLower__INT_B__OrdonVillage = {},
	OrdonShieldHouseLower__TO__OrdonShieldHouseUpper = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	OrdonShieldHouseUpper__TO__OrdonShieldHouseLower = {},
	OrdonShieldHouseUpper__OOW__OrdonVillage = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	OrdonSwordHouse__INT_B__OrdonVillage = {},
	OrdonBosHouseLeftDoor__INT_B__OrdonVillage = {},
	OrdonBosHouseLeftDoor__TO__OrdonBosHouse = {},
	OrdonBosHouseRightDoor__INT_B__OrdonVillage = {},
	OrdonBosHouseRightDoor__TO__OrdonBosHouse = {},
	OrdonBosHouse__TO__OrdonBosHouseLeftDoor = {},
	OrdonBosHouse__TO__OrdonBosHouseRightDoor = {},
	OrdonRanchEntrance__TO__OrdonRanch = {},
	OrdonRanchEntrance__EXT_B__OrdonVillage = {},
	OrdonRanch__TO__OrdonRanchEntrance = {},
	OrdonRanch__TO__OrdonRanchStable = {},
	OrdonRanchStable__TO__OrdonRanch = {},
	OrdonRanchStable__GRO_A__OrdonRanchGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	OrdonRanchGrotto__GRO_B__OrdonRanchStable = {},
	OrdonSpring__EXT_B__OutsideLinksHouse = {},
	OrdonSpring__TO__OrdonBridge = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("OutsideLinksHouse"),
						"sword",
						"slingshot"
					}),
					canCompletePrologue()
				})
			end
		},
		{}
	},
	OrdonBridge__TO__OrdonSpring = {
		{
			function()
				return hasAny({
					hasAll({
						canAccess("OutsideLinksHouse"),
						"sword",
						"slingshot"
					}),
					canCompletePrologue()
				})
			end
		}
	},
	OrdonBridge__EXT_A__SouthFaronWoods = {},
	-- Snowpeak Province
	-- Snowpeak
	SnowpeakClimbLower__TO__SnowpeakClimbUpper = {
		{
			function()
				return hasAll({
					hasAny({
						"skipsnowpeakentranceon",
						hasAll({
							canAccess("ZorasDomain"),
							"hook"
						})
					}),
					"shadowcrystal"
				})
			end
		},
		{
			function()
				return hasAny({
					"skipsnowpeakentranceon",
					hasAll({
						canAccess("ZorasDomain"),
						"hook"
					}),
					"shadowcrystal"
				})
			end
		}
	},
	SnowpeakClimbLower__EXT_B__ZorasDomainSnowpeakEntrance = {},
	SnowpeakClimbUpper__TO__SnowpeakClimbLower = {},
	SnowpeakClimbUpper__EXT_A__SnowpeakSummitUpper = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	SnowpeakClimbUpper__GRO_A__SnowpeakIceKeeseGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	SnowpeakClimbUpper__GRO_A__SnowpeakFreezardGrotto = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	SnowpeakIceKeeseGrotto__GRO_B__SnowpeakClimbUpper = {},
	SnowpeakFreezardGrotto__GRO_B__SnowpeakClimbUpper = {},
	SnowpeakSummitUpper__TO__SnowpeakSummitLower = {
		{
			function()
				return hasAll({
					hasAny({
						"stportalactive",
						canDefeatShadowBeast()
					}),
					hasAny({
						"bonksdodamageoff",
						hasAll({
							"bonksdodamageon",
							hasAny({
								Not("ohko"),
								canUseBottledFairy()
							})
						}),
						"srcompleted"
					})
				})
			end
		}
	},
	SnowpeakSummitUpper__EXT_B__SnowpeakClimbUpper = {
		{
			function()
				return hasAll({
					"shadowcrystal"
				})
			end
		}
	},
	SnowpeakSummitLower__TO__SnowpeakSummitLowerLeftDoor = {},
	SnowpeakSummitLower__TO__SnowpeakSummitLowerRightDoor = {},
	SnowpeakSummitLowerLeftDoor__DUN_A__SnowpeakRuinsLeftDoor = {},
	SnowpeakSummitLowerLeftDoor__TO__SnowpeakSummitLower = {},
	SnowpeakSummitLowerRightDoor__DUN_A__SnowpeakRuinsRightDoor = {},
	SnowpeakSummitLowerRightDoor__TO__SnowpeakSummitLower = {}
}

ER_NODES = {}
function initNodes()
	for edge in pairs(ER_EDGES) do
		local from, flags, to = edge:match("(.*)__(.*)__(.*)")
		ER_NODES[from] = {}
		ER_NODES[to] = {}
	end
	ER_NODES["OutsideLinksHouse"]["spawn"] = true
end