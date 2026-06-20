local Library = loadfile("Source.lua")()
local Window = Library:Window({Name = "Example", Size = Vector2.new(550, 600)})

local MainTab = Window:Page({Name = "Main", Columns = 2})
local SettingsTab = Library:Settings()

-- Left column
local MainSection = MainTab:Section({Name = "Main", Side = 1})

local MyToggle = MainSection:Toggle({
    Name = "Enable ESP",
    Flag = "ESP",
    Default = false,
    Callback = function(Value)
        Window:Notify(Value and "ESP Enabled" or "ESP Disabled", 2)
    end
})

MyToggle:ColorPicker({
    Name = "ESP Color",
    Flag = "ESPColor",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Color)
        -- Color3 value
    end
})

MyToggle:ColorPicker({
    Name = "ESP Fill",
    Flag = "ESPFill",
    Default = Color3.fromRGB(255, 255, 255),
    DefaultAlpha = 0.5,
    Callback = function(Color)
        -- Color3 value
    end
})

MyToggle:KeyPicker({
    Flag = "ESPKey",
    Default = "F",
})

MainSection:Slider({
    Name = "ESP Distance",
    Flag = "ESPDistance",
    Min = 0,
    Max = 1000,
    Default = 500,
    Callback = function(Value)
        -- number value
    end
})

MainSection:Dropdown({
    Name = "ESP Mode",
    Flag = "ESPMode",
    Options = {"Box", "Skeleton", "Filled"},
    Default = 1,
    Callback = function(Value)
        -- string value
    end
})

MainSection:Separator()
MainSection:Label({Name = "Misc Options"})

MainSection:Textbox({
    Name = "Custom Tag",
    Flag = "ESPTag",
    Default = "",
    Placeholder = "Enter tag...",
    MaxLength = 32,
    Callback = function(Value)
        -- string value
    end
})

MainSection:Button({
    Name = "Refresh",
    Callback = function()
        Window:Notify("Refreshed!", 2)
    end
})

-- Right column
local CombatSection = MainTab:Section({Name = "Combat", Side = 2})

local AimbotToggle = CombatSection:Toggle({
    Name = "Aimbot",
    Flag = "Aimbot",
    Default = false,
    Callback = function(Value)
        Window:Notify(Value and "Aimbot On" or "Aimbot Off", 2)
    end
})

AimbotToggle:KeyPicker({
    Flag = "AimbotKey",
    Default = "None",
})

CombatSection:Slider({
    Name = "FOV",
    Flag = "AimbotFOV",
    Min = 1,
    Max = 360,
    Default = 90,
    Callback = function(Value)
        -- number value
    end
})

CombatSection:Slider({
    Name = "Smoothness",
    Flag = "AimbotSmooth",
    Min = 1,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        -- number value
    end
})

CombatSection:Dropdown({
    Name = "Target Bone",
    Flag = "AimbotBone",
    Options = {"Head", "Neck", "Chest"},
    Default = 1,
    Callback = function(Value)
        -- string value
    end
})

CombatSection:Separator()
CombatSection:Label({Name = "Prediction"})

CombatSection:Toggle({
    Name = "Silent Aim",
    Flag = "SilentAim",
    Default = false,
    Callback = function(Value)
        -- bool value
    end
})

-- Accessing flags elsewhere
-- Library.Flags["ESP"]            -> boolean
-- Library.Flags["ESPColor"].Color -> Color3
-- Library.Flags["ESPColor"].Alpha -> 0-1
-- Library.Flags["ESPDistance"].Value -> number
-- Library.Flags["ESPMode"].Value  -> string
-- Library.Flags["ESPTag"]         -> string
-- Library.Flags["ESPKey"].Key     -> string
-- Library.Flags["ESPKey"].Mode    -> "Toggle" or "Hold"
