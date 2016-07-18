-- Author: Ketho (EU-Boulderfist)
-- License: Public Domain

local NAME = ...
local db

-- TalentMicroButton:EvaluateAlertVisibility() doesnt work the way we want it to
-- its mostly the talents that show a popup, leave the rest alone
local buttons = {
	TalentMicroButton = true,
	--CollectionsMicroButton = true, -- already gets remembered
	--LFDMicroMicroButton = true,
	--EJMicroMicroButton = true,
}

local f = CreateFrame("Frame")

function f:OnEvent(event, addon)
	if event == "ADDON_LOADED" then
		if addon ~= NAME then return end
		
		-- init savedvariables per character
		HideTalentAlertDB = HideTalentAlertDB or {}
		db = HideTalentAlertDB
		
		-- onclick alert closebutton
		for k in pairs(buttons) do
			_G[k.."Alert"].CloseButton:HookScript("OnClick", function()
				db[k] = true -- remember it
				MicroButtonPulseStop(_G[k]) -- simultaneously stop the button from pulsing, once you press the closebutton
			end)
		end
		
		-- showed talentframe
		hooksecurefunc("ToggleTalentFrame", function()
			db.TalentMicroButton = true -- remember it
		end)
		
		-- hide alert
		hooksecurefunc("MainMenuMicroButton_ShowAlert", function(alert)
			if db[alert.MicroButton:GetName()] then
				alert:Hide() -- hide it
			end
		end)
		
		-- hide pulse
		hooksecurefunc("MicroButtonPulse", function(self)
			if db[self:GetName()] then
				MicroButtonPulseStop(self) -- stop it
			end
		end)
		
		self:UnregisterEvent(event)
		
	elseif event == "PLAYER_LEVEL_UP" then
		-- player might have a new talent; not sure how honor talents work though
		wipe(db)
	end
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LEVEL_UP")
f:SetScript("OnEvent", f.OnEvent)
