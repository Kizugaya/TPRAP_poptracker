function settings()
	if Tracker:FindObjectForCode("devsettings").CurrentStage == 1 then
		Tracker:AddLayouts("layouts/1.3settings.json")
	elseif Tracker:FindObjectForCode("devsettings").CurrentStage == 0 then
		Tracker:AddLayouts("layouts/settings.json")
	end
end

ScriptHost:AddWatchForCode("1.3 Settings", "devsettings", settings)