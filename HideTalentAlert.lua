-- License: Public Domain

-- Function to hide talent alerts
local function HideAlert(microButton)
    -- Only hide alerts for the PlayerSpellsMicroButton
    if microButton == PlayerSpellsMicroButton then
        MainMenuMicroButton_HideAlert(microButton)
    end
end

-- Function to stop pulse animations on the talent button
local function HidePulse(microButton)
    -- Only stop pulse for the PlayerSpellsMicroButton
    if microButton == PlayerSpellsMicroButton then
        MicroButtonPulseStop(microButton)
    end
end

-- Hook the alert and pulse functions securely to avoid taint
hooksecurefunc("MainMenuMicroButton_ShowAlert", HideAlert)
hooksecurefunc("MicroButtonPulse", HidePulse)

-- Hides TutorialPointerFrame
SetCVar("showTutorials", 0)
