-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Module = {
    Function = {},
    Added = {},

    Game = {
        Vehicles = Workspace:FindFirstChild("Vehicles"),
    },
    
    Stored = {
        Vehicles = {},
        --[[
        Original = {
            Penetration = setmetatable({}, { __mode = "k" }),
            Speed = setmetatable({}, { __mode = "k" })
        }
        ]]
    }
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()
local Bounding = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/Severe/refs/heads/main/Modules/Bounding.lua"))()

-- // Convex Buffers & Locals \\ --

local Vector2New = Vector2.new
local Vector3New = Vector3.new
local MathMax = math.max
local TableSort = table.sort
local FilledTriangle = DrawingImmediate.FilledTriangle
local Polyline = DrawingImmediate.Polyline

local Convex = {
    Scratch = {
        Points = {},
        Hull = {},
        Verts = {}
    },

    Static = {
        HWMPoints = 0,
        HWMVerts = 0
    }
}

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
TankSection:Toggle({Name = "Render Turret Ammo", Flag = "Render Turret Ammo", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Turret Ammo", Flag = "Turret Ammo Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 0.5, Callback = function(Color) end})
TankSection:Toggle({Name = "Render Hull Ammo", Flag = "Render Hull Ammo", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Hull Ammo", Flag = "Hull Ammo Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 0.5, Callback = function(Color) end})

--[[

TankSection:Separator()

TankSection:Toggle({Name = "Force Penetration", Flag = "Force Penetration", Default = false, Callback = function(Value) end})
TankSection:Slider({Name = "Penetration Multiplier", Flag = "Penetration", Min = 0, Max = 3.6, Default = 1, Decimals = 0.1, Callback = function(Value) end})
TankSection:Slider({Name = "Secondary Penetration Multiplier", Flag = "Secondary Penetration", Min = 0, Max = 100, Default = 1, Decimals = 0.1, Callback = function(Value) end})

TankSection:Toggle({Name = "Force Speed", Flag = "Force Speed", Default = false, Callback = function(Value) end})
TankSection:Slider({Name = "Shell Speed Multiplier", Flag = "Shell Speed", Min = 0, Max = 3.6, Default = 1, Decimals = 0.1, Callback = function(Value) end})
TankSection:Slider({Name = "Secondary Speed Multiplier", Flag = "Secondary Speed", Min = 0, Max = 3.6, Default = 1, Decimals = 0.1, Callback = function(Value) end})

]]

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
    local FullName = Vehicle.Name

    local Player = Players:FindFirstChild(string.sub(FullName, 8))
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

--[[
function Module.Function:ApplyShells(Shells, Enabled, Flag, Value, OriginalStore)
    for _, Shell in Shells:GetChildren() do
        local ValueObject = Shell:FindFirstChild(Value)

        if ValueObject and ValueObject:IsA("ValueBase") then
            if Library.Flags[Enabled] then
                local Base = OriginalStore[ValueObject]
                if Base == nil then
                    Base = ValueObject.Value
                    OriginalStore[ValueObject] = Base
                end

                if type(Base) == "number" then
                    local NewValue = Base * Library.Flags[Flag].Value

                    ValueObject.Value = NewValue
                    ValueObject:SetAttribute("Orig", NewValue)
                end
            elseif OriginalStore[ValueObject] ~= nil then
                local Original = OriginalStore[ValueObject]

                ValueObject.Value = Original
                ValueObject:SetAttribute("Orig", Original)
            end
        end
    end
end

function Module.Function:SetValues(Vehicle)
    if not Vehicle then return nil end
    if not Vehicle:FindFirstChild("Gun") then return nil end

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
]]

-- // Convex Hull \\ --

function Module.Function:TruncateBuffer(Buffer, NewSize, HighWaterMark)
    for Index = NewSize + 1, HighWaterMark do
        Buffer[Index] = nil
    end
    return MathMax(NewSize, HighWaterMark)
end

local function PointSort(PointA, PointB)
    return PointA.X < PointB.X or (PointA.X == PointB.X and PointA.Y < PointB.Y)
end

function Module.Function:CalculateConvexHull(Points, PointCount, Outer)
    if PointCount == 0 then return 0 end
    if PointCount == 1 then Outer[1] = Points[1]; return 1 end
    if PointCount == 2 then Outer[1] = Points[1]; Outer[2] = Points[2]; return 2 end

    TableSort(Points, PointSort)

    local Size = 0

    for Index = 1, PointCount do
        local Point = Points[Index]
        local PX, PY = Point.X, Point.Y
        while Size >= 2 do
            local O = Outer[Size - 1]
            local A = Outer[Size]
            if (A.X - O.X) * (PY - O.Y) - (A.Y - O.Y) * (PX - O.X) > 0 then break end
            Size = Size - 1
        end
        Size = Size + 1
        Outer[Size] = Point
    end

    local LowerHullSize = Size
    for Index = PointCount - 1, 1, -1 do
        local Point = Points[Index]
        local PX, PY = Point.X, Point.Y
        while Size > LowerHullSize do
            local O = Outer[Size - 1]
            local A = Outer[Size]
            if (A.X - O.X) * (PY - O.Y) - (A.Y - O.Y) * (PX - O.X) > 0 then break end
            Size = Size - 1
        end
        Size = Size + 1
        Outer[Size] = Point
    end

    return Size - 1
end

function Module.Function:ProjectPartCorners(Part, WriteOffset)
    if not (Part and Part:IsA("BasePart")) then
        return WriteOffset
    end

    local PartCFrame = Part.CFrame
    local Position = PartCFrame.Position
    local Size = Part.Size

    local PositionX = Position.X
    local PositionY = Position.Y
    local PositionZ = Position.Z

    local HalfSizeX = Size.X * 0.5
    local HalfSizeY = Size.Y * 0.5
    local HalfSizeZ = Size.Z * 0.5

    local RightVector = PartCFrame.RightVector
    local UpVector = PartCFrame.UpVector
    local LookVector = PartCFrame.LookVector

    local RightX = RightVector.X * HalfSizeX
    local RightY = RightVector.Y * HalfSizeX
    local RightZ = RightVector.Z * HalfSizeX

    local UpX = UpVector.X * HalfSizeY
    local UpY = UpVector.Y * HalfSizeY
    local UpZ = UpVector.Z * HalfSizeY

    local LookX = LookVector.X * HalfSizeZ
    local LookY = LookVector.Y * HalfSizeZ
    local LookZ = LookVector.Z * HalfSizeZ

    local SignR = 1
    for _ = 1, 2 do
        local SignU = 1
        for _ = 1, 2 do
            local SignL = 1
            for _ = 1, 2 do
                local WorldPoint = Vector3New(
                    PositionX + SignR * RightX + SignU * UpX + SignL * LookX,
                    PositionY + SignR * RightY + SignU * UpY + SignL * LookY,
                    PositionZ + SignR * RightZ + SignU * UpZ + SignL * LookZ
                )

                local ScreenPoint, OnScreen = Camera:WorldToScreenPoint(WorldPoint)
                if OnScreen then
                    WriteOffset = WriteOffset + 1
                    local Slot = Convex.Scratch.Points[WriteOffset]
                    if Slot then
                        Slot.X = ScreenPoint.X
                        Slot.Y = ScreenPoint.Y
                    else
                        Convex.Scratch.Points[WriteOffset] = {X = ScreenPoint.X, Y = ScreenPoint.Y}
                    end
                end

                SignL = -1
            end
            SignU = -1
        end
        SignR = -1
    end

    return WriteOffset
end

function Module.Function:BuildHullVerts(Hull, Size)
    local Verts = Convex.Scratch.Verts
    for Index = 1, Size do
        local Point = Hull[Index]
        Verts[Index] = Vector2New(Point.X, Point.Y)
    end
    return Verts
end

function Module.Function:DrawPolygon(Verts, Size, Color, Opacity)
    if Size < 3 then return end

    local Pivot = Verts[1]
    for Index = 2, Size - 1 do
        FilledTriangle(Pivot, Verts[Index], Verts[Index + 1], Color, Opacity)
    end
end

function Module.Function:DrawOutline(Verts, Size, Color, Opacity, Thickness)
    if Size < 2 then return end

    Verts[Size + 1] = Verts[1]

    if Size + 1 < Convex.Static.HWMVerts then
        for Index = Size + 2, Convex.Static.HWMVerts do
            Verts[Index] = nil
        end
    end

    Convex.Static.HWMVerts = MathMax(Convex.Static.HWMVerts, Size + 1)

    Polyline(Verts, Color, Opacity, Thickness)
end

function Module.Function:DrawAmmoHull(Parts, Color)
    local PointCount = 0
    for _, Part in ipairs(Parts) do
        if Part and Part.Parent then
            PointCount = self:ProjectPartCorners(Part, PointCount)
        end
    end

    if PointCount == 0 then return end
    Convex.Static.HWMPoints = self:TruncateBuffer(Convex.Scratch.Points, PointCount, Convex.Static.HWMPoints)

    local Size = self:CalculateConvexHull(Convex.Scratch.Points, PointCount, Convex.Scratch.Hull)
    if Size == 0 then return end

    local Verts = self:BuildHullVerts(Convex.Scratch.Hull, Size)
    self:DrawPolygon(Verts, Size, Color.Color, Color.Alpha)
    self:DrawOutline(Verts, Size, Color.Color, Color.Alpha, 1)
end

function Module.Function:GetAmmunition(Vehicle)
    if Vehicle:FindFirstChild("Fuselage") then
        return nil
    end

    local HullAmmo, TurretAmmo

    local Hull = Vehicle:FindFirstChild("Hull")
    local HullModel = Hull and Hull:FindFirstChildOfClass("Model")
    local TrueHull = HullModel and HullModel:FindFirstChild("Hull")
    if TrueHull then
        for _, Part in TrueHull:GetChildren() do
            if Part:IsA("MeshPart") and Part.Name == "Ammunition" then
                HullAmmo = HullAmmo or {}
                HullAmmo[#HullAmmo + 1] = Part
            end
        end
    end

    local Turret = Vehicle:FindFirstChild("Turret")
    local TurretModel = Turret and Turret:FindFirstChildOfClass("Model")
    local TrueTurret = TurretModel and TurretModel:FindFirstChild("Turret")
    if TrueTurret then
        for _, Part in TrueTurret:GetChildren() do
            if Part:IsA("MeshPart") and Part.Name == "Ammunition" then
                TurretAmmo = TurretAmmo or {}
                TurretAmmo[#TurretAmmo + 1] = Part
            end
        end
    end

    return HullAmmo, TurretAmmo
end

function Module.Function:GetBoundingParts(Vehicle)
    if not Vehicle:FindFirstChild("Turret") and not Vehicle:FindFirstChild("Gun") then
        local Fuselage = Vehicle:FindFirstChild("Fuselage")
        local Box = Fuselage and Fuselage:FindFirstChild("Bounding Box")
        if Box and Box:IsA("BasePart") then
            return { Box }
        end
        return {}
    end

    local Parts = {}

    local Turret = Vehicle:FindFirstChild("Turret")
    local TurretModel = Turret and Turret:FindFirstChildOfClass("Model")
    local TrueTurret = TurretModel and TurretModel:FindFirstChild("Turret")
    local TurretBox = TrueTurret and TrueTurret:FindFirstChild("Bounding Box")
    if TurretBox and TurretBox:IsA("BasePart") then
        Parts[#Parts + 1] = TurretBox
    end

    local Hull = Vehicle:FindFirstChild("Hull")
    local HullModel = Hull and Hull:FindFirstChildOfClass("Model")
    local TrueHull = HullModel and HullModel:FindFirstChild("Hull")
    local HullBox = TrueHull and TrueHull:FindFirstChild("Bounding Box")
    if HullBox and HullBox:IsA("BasePart") then
        Parts[#Parts + 1] = HullBox
    end

    return Parts
end

function Module.Function:Render()
    if not Library.Flags["Enabled"] then return end
    if not (Library.Flags["Render Names"] or Library.Flags["Render Box"] or Library.Flags["Render Turret Ammo"] or Library.Flags["Render Hull Ammo"]) then return end

    for _, Tank in Module.Stored.Vehicles do
        if not Tank or not Tank.Parent then continue end

        local Name = Module.Function:GetRealName(Tank)
        local Team = Module.Function:GetPlayerTeam(Name)
        if Team == LocalPlayer.Team.Name then continue end

        if Library.Flags["Render Turret Ammo"] or Library.Flags["Render Hull Ammo"] then
            local HullAmmo, TurretAmmo = Module.Function:GetAmmunition(Tank)

            if Library.Flags["Render Turret Ammo"] and TurretAmmo then
                Module.Function:DrawAmmoHull(TurretAmmo, Library.Flags["Turret Ammo Color"])
            end

            if Library.Flags["Render Hull Ammo"] and HullAmmo then
                Module.Function:DrawAmmoHull(HullAmmo, Library.Flags["Hull Ammo Color"])
            end
        end

        if Library.Flags["Render Box"] or Library.Flags["Render Names"] then
            local BoxParts = Module.Function:GetBoundingParts(Tank)
            local BoundingBox = #BoxParts > 0 and Bounding.GetBoundingBox(BoxParts) or nil

            if BoundingBox then
                local Position = Vector2.new(BoundingBox.Position.X, BoundingBox.Position.Y)
                local Size = Vector2.new(BoundingBox.Size.X, BoundingBox.Size.Y)

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
    end
end

-- // Initialize \\ --

Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())

task.spawn(function()
    while true do
        task.wait(0.8)
        Module.Function:Cache()
    end
end)

--[[
RunService.PostLocal:Connect(function()
    if Library.Flags["Force Penetration"] or Library.Flags["Force Speed"] then
        local LocalHull = Module.Function:GetLocalHull()
        if LocalHull then
            Module.Function:SetValues(LocalHull)
        end
    end 
end)
]]

RunService.Render:Connect(function() Module.Function:Render() end)
