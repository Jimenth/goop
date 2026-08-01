-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Module = {
    Function = {},
    Added = {},

    Game = {
        Vehicles = Workspace:FindFirstChild("Vehicles"),
    },
    
    Stored = {
        Vehicles = {},
        Original = {
            Penetration = setmetatable({}, { __mode = "k" }),
            Speed = setmetatable({}, { __mode = "k" })
        }
    }
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()
local Bounding = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/Severe/refs/heads/main/Modules/Bounding.lua"))()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Cursed Tank Simulator", Size = Vector2.new(450, 450)})

local MainTab = Window:Page({Name = "Main", Columns = 1})
local TankSection = MainTab:Section({Name = "Tanks", Side = 1})

TankSection:Toggle({Name = "Enabled", Flag = "Enabled", Default = false, Callback = function(Value) end})
TankSection:Toggle({Name = "Render Names", Flag = "Render Names", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Name", Flag = "Name Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
TankSection:Toggle({Name = "Render Box", Flag = "Render Box", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Box", Flag = "Box Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
TankSection:Toggle({Name = "Box Outline", Flag = "Box Outline", Default = false, Callback = function(Value) end})
TankSection:Separator()
TankSection:Slider({Name = nil, Flag = "Box Size X", Min = 1, Max = 4, Default = 2, Decimals = .25, Suffix = "x", Callback = function(Value) end})
TankSection:Slider({Name = nil, Flag = "Box Size Y", Min = 1, Max = 4, Default = 2.5, Decimals = .25, Suffix = "y", Callback = function(Value) end})

TankSection:Separator()

TankSection:Toggle({Name = "Force Penetration", Flag = "Force Penetration", Default = false, Callback = function(Value) end})
TankSection:Slider({Name = "Penetration Multiplier", Flag = "Penetration", Min = 0, Max = 3.6, Default = 1, Decimals = 0.1, Callback = function(Value) end})
TankSection:Slider({Name = "Secondary Penetration Multiplier", Flag = "Secondary Penetration", Min = 0, Max = 100, Default = 1, Decimals = 0.1, Callback = function(Value) end})

TankSection:Toggle({Name = "Force Speed", Flag = "Force Speed", Default = false, Callback = function(Value) end})
TankSection:Slider({Name = "Shell Speed Multiplier", Flag = "Shell Speed", Min = 0, Max = 3.6, Default = 1, Decimals = 0.1, Callback = function(Value) end})
TankSection:Slider({Name = "Secondary Speed Multiplier", Flag = "Secondary Speed", Min = 0, Max = 3.6, Default = 1, Decimals = 0.1, Callback = function(Value) end})

-- // Function \\ --

function Module.Function:Cache()
    local Stored = Module.Stored.Vehicles

    for Identifier, Entry in Stored do
        if not Entry or not Entry.Parent or not Library.Flags["Enabled"] then
            Stored[Identifier] = nil
        end
    end

    if Library.Flags["Enabled"] then
        for _, Vehicle in Module.Game.Vehicles:GetChildren() do
            if Vehicle and Vehicle.Name ~= "Chassis".. LocalPlayer.Name then
                local Identifier = tostring(Vehicle)

                if not Stored[Identifier] then
                    Stored[Identifier] = Vehicle
                end
            end
        end
    end
end

function Module.Function:GetRealName(Vehicle)
    local Player = Players:FindFirstChild(string.sub(Vehicle.Name, 8))
    if not Player then return "NPC" end

    return Player.Name
end

function Module.Function:GetHullName(Vehicle)
    local HullString = Vehicle:FindFirstChild("HullStr")
    if not HullString then return nil end

    return HullString and HullString.Value or nil
end

function Module.Function:GetPlayerTeam(Name)
    if typeof(Name) ~= "string" then return nil end
    if not Players:FindFirstChild(Name) then return "NPC" end

    return Players:FindFirstChild(Name).Team.Name or nil
end

function Module.Function:GetLocalHull()
    for _, Vehicle in Module.Game.Vehicles:GetChildren() do
        if Vehicle and Vehicle.Name == "Chassis".. LocalPlayer.Name then
            return Vehicle
        end
    end
end
function Module.Function:ApplyShells(Shells, Enabled, Flag, Value, OriginalStore)
    for _, Shell in Shells:GetChildren() do
        local ValueObject = Shell:FindFirstChild(Value)
        if ValueObject then
            if Library.Flags[Enabled] then
                if not OriginalStore[ValueObject] then
                    OriginalStore[ValueObject] = ValueObject.Value
                end

                local NewValue = OriginalStore[ValueObject] * Library.Flags[Flag].Value

                ValueObject.Value = NewValue
                ValueObject:SetAttribute("Orig", NewValue)
            elseif OriginalStore[ValueObject] then
                local Original = OriginalStore[ValueObject]

                ValueObject.Value = Original
                ValueObject:SetAttribute("Orig", Original)
            end
        end
    end
end

function Module.Function:SetValues(Vehicle)
    if not Vehicle then return nil end

    local Penetration = Module.Stored.Original.Penetration
    local Speed = Module.Stored.Original.Speed

    local Gun = Vehicle:FindFirstChild("Gun")
    local GunModel = Gun and Gun:FindFirstChildOfClass("Model")
    local GunConfig = GunModel and GunModel:FindFirstChild("Config")
    local GunShells = GunConfig and GunConfig:FindFirstChild("Shells")
    if GunShells then
        Module.Function:ApplyShells(GunShells, "Force Penetration", "Penetration", "Penetration", Penetration)
        Module.Function:ApplyShells(GunShells, "Force Speed", "Shell Speed", "ShellSpeed", Speed)
    end

    local Turret = Vehicle:FindFirstChild("Turret")
    local TurretModel = Turret and Turret:FindFirstChildOfClass("Model")
    local TrueTurret = TurretModel and TurretModel:FindFirstChild("Turret")
    if TrueTurret then
        for _, Part in TrueTurret:GetChildren() do
            if Part:IsA("MeshPart") and Part.Name == "Secondary" then
                local Config = Part:FindFirstChild("Config")
                local Shells = Config and Config:FindFirstChild("Shells")
                if Shells then
                    Module.Function:ApplyShells(Shells, "Force Penetration", "Secondary Penetration", "Penetration", Penetration)
                    Module.Function:ApplyShells(Shells, "Force Speed", "Secondary Speed", "ShellSpeed", Speed)
                end
            end
        end
    end
end

function Module.Function:Render()
    if not Library.Flags["Enabled"] then return end
    if not (Library.Flags["Render Names"] or Library.Flags["Render Box"]) then return end

    for _, Tank in Module.Stored.Vehicles do
        if not Tank then continue end

        local Primary = Tank:FindFirstChild("HullNode")
        if not Primary then continue end

        local Name = Module.Function:GetRealName(Tank)
        local Team = Module.Function:GetPlayerTeam(Name)
        if Team == LocalPlayer.Team.Name then continue end

        local BoundingBox = Bounding.GetBoundingBox(Primary)
        if not BoundingBox then continue end

        local Size = Vector2.new(BoundingBox.Size.X * Library.Flags["Box Size X"].Value, BoundingBox.Size.Y * Library.Flags["Box Size Y"].Value)
        local Position = Vector2.new(BoundingBox.Position.X + BoundingBox.Size.X * 0.5 - Size.X * 0.5, BoundingBox.Position.Y + BoundingBox.Size.Y * 0.5 - Size.Y * 0.5)

        if Library.Flags["Render Box"] then
            local BoxColor = Library.Flags["Box Color"].Color
            local BoxAlpha = Library.Flags["Box Color"].Alpha

            if Library.Flags["Box Outline"] then
                local Thickness = 1
                DrawingImmediate.Rectangle(Vector2.new(Position.X - Thickness, Position.Y - Thickness), Vector2.new(Size.X + Thickness * 2, Size.Y + Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                DrawingImmediate.Rectangle(Vector2.new(Position.X + Thickness, Position.Y + Thickness), Vector2.new(Size.X - Thickness * 2, Size.Y - Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                DrawingImmediate.Rectangle(Position, Size, BoxColor, BoxAlpha, 1)
            else
                DrawingImmediate.Rectangle(Position, Size, BoxColor, BoxAlpha)
            end
        end

        if Library.Flags["Render Names"] then
            local NamePosition = Vector2.new(Position.X + Size.X * 0.5, Position.Y - 15)
            DrawingImmediate.OutlinedText(NamePosition, 13, Library.Flags["Name Color"].Color, Library.Flags["Name Color"].Alpha, Name, true, "Verdana")
        end
    end
end

-- // Initialize \\ --

Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())

task.spawn(function()
    while true do
        task.wait(0.8)
        Module.Function:Cache()

        if Library.Flags["Force Penetration"] or Library.Flags["Force Speed"] then
            local LocalHull = Module.Function:GetLocalHull()
            if LocalHull then
                Module.Function:SetValues(LocalHull)
            end
        end 
    end
end)

RunService.Render:Connect(function() Module.Function:Render() end)
