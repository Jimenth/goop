local Library = loadfile("Source.lua")()
local Window = Library:Window({Name = "Example", Size = Vector2.new(550, 600)})

local MainTab = Window:Page({Name = "Main", Columns = 2})
local StyleWin = Library:StyleWindow()
local ConfigWin = Library:ConfigWindow()
Library:NavBar(Library.Windows[1], StyleWin, ConfigWin)

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
    Callback = function(Color) end
})

MyToggle:ColorPicker({
    Name = "ESP Fill",
    Flag = "ESPFill",
    Default = Color3.fromRGB(255, 255, 255),
    Alpha = 0.5,
    Callback = function(Color) end
})
 
MyToggle:KeyPicker({
    Flag = "ESPKey",
    Default = "F",
    Callback = function() end
})

MainSection:Slider({
    Name = "ESP Distance",
    Flag = "ESPDistance",
    Min = 0,
    Max = 1000,
    Decimals = 0.1,
    Suffix = "s",
    Default = 500,
    Callback = function(Value) end
})

MainSection:Dropdown({
    Name = "ESP Mode",
    Flag = "ESPMode",
    Options = {"Box", "Skeleton", "Filled"},
    Multi = true,
    Default = {1, 3},
    Callback = function(Value)
        -- Value is a table e.g. {"Box", "Filled"}
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
    Callback = function(Value) end
})

MainSection:Button({
    Name = "Refresh",
    Callback = function()
        Window:Notify("Refreshed!", 2)
    end
})

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
    Callback = function() end
})

CombatSection:Slider({
    Name = "FOV",
    Flag = "AimbotFOV",
    Min = 1,
    Max = 360,
    Default = 90,
    Callback = function(Value) end
})

CombatSection:Slider({
    Name = "Smoothness",
    Flag = "AimbotSmooth",
    Min = 1,
    Max = 100,
    Default = 50,
    Callback = function(Value) end
})

CombatSection:Dropdown({
    Name = "Target Bone",
    Flag = "AimbotBone",
    Options = {"Head", "Neck", "Chest"},
    Default = 1,
    Callback = function(Value)
        -- Value is a string e.g. "Head"
    end
})

CombatSection:Separator()
CombatSection:Label({Name = "Prediction"})

CombatSection:Toggle({
    Name = "Silent Aim",
    Flag = "SilentAim",
    Default = false,
    Callback = function(Value) end
})

-- Flag reference:
-- Library.Flags["ESP"]                 -> boolean
-- Library.Flags["ESPColor"].Color      -> Color3
-- Library.Flags["ESPColor"].Alpha      -> number (0-1)
-- Library.Flags["ESPDistance"].Value   -> number
-- Library.Flags["ESPMode"].Value       -> table e.g. {"Box", "Filled"}
-- Library.Flags["ESPTag"]              -> string
-- Library.Flags["ESPKey"].Key          -> string
-- Library.Flags["ESPKey"].Mode         -> "Toggle" or "Hold"
-- Library.Flags["AimbotBone"].Value    -> string e.g. "Head"
