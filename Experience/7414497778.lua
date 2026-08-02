-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Module = {
    Function = {},

    Game = {
        Vehicles = Workspace:FindFirstChild("SpawnedVehicles"),
        Placed = Workspace:FindFirstChild("PlacedBuildings")
    },

    Stored = {
        Vehicles = {},
        Drones = {},
        Armor = {}
    }
}

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

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()

local Vector2New = Vector2.new
local Vector3New = Vector3.new
local MathMax = math.max
local MathAbs = math.abs
local TableSort = table.sort
local FilledTriangle = DrawingImmediate.FilledTriangle
local Polyline = DrawingImmediate.Polyline

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Multicrew Tank Combat", Size = Vector2.new(550, 600)})

local VisualsTab = Window:Page({Name = "Visuals", Columns = 2})
local ExploitsTab = Window:Page({Name = "Exploits", Columns = 2})

local VehiclesSection = VisualsTab:Section({Name = "Vehicles", Side = 1})
local ModulesSection = VisualsTab:Section({Name = "Modules", Side = 2})

local ExploitsSection = ExploitsTab:Section({Name = "Exploits", Side = 1})

-- // Vehicles Section \\ --

VehiclesSection:Toggle({Name = "Enabled", Flag = "Render Vehicles", Default = false, Callback = function(Value) end})
VehiclesSection:Toggle({Name = "Vehicle Names", Flag = "Vehicle Names", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Name", Flag = "Name Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
VehiclesSection:Toggle({Name = "Vehicle Distance", Flag = "Vehicle Distance", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Distance", Flag = "Distance Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
VehiclesSection:Separator()
VehiclesSection:Toggle({Name = "Use Occupied Color", Flag = "Use Occupied Color", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Occupied", Flag = "Occupied Color", Default = Color3.fromRGB(0, 255, 0), Callback = function(Color) end})

-- // Modules Section \\ --

ModulesSection:Toggle({Name = "Enabled", Flag = "Render Modules", Default = false, Callback = function(Value) end})
ModulesSection:Slider({Name = "Render View", Flag = "Field of View", Min = 0, Max = 1500, Default = 500, Callback = function(Value) end})
ModulesSection:Toggle({Name = "Render Ammo", Flag = "Vehicle Ammo", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Ammo", Flag = "Ammo Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 0.5, Callback = function(Color) end})
ModulesSection:Toggle({Name = "Render Engine", Flag = "Vehicle Engine", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Engine", Flag = "Engine Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 0.5, Callback = function(Color) end})

ModulesSection:Separator()

ModulesSection:Toggle({Name = "Render Drones", Flag = "Render Drones", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Drone", Flag = "Drone Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})

-- // Exploits Section \\ --

ExploitsSection:Toggle({Name = "Disable Armor", Flag = "Disable Armor", Default = false, Callback = function(Value)
    if Value then
        Module.Function:ScanArmor()
    else
        Module.Function:RestoreArmor()
    end
end})

-- // Functions \\ --

function Module.Function:TruncateBuffer(Buffer, NewSize, HighWaterMark)
    for Index = NewSize + 1, HighWaterMark do
        Buffer[Index] = nil
    end
    return math.max(NewSize, HighWaterMark)
end

function Module.Function:CrossDimension(OriginX, OriginY, PointAX, PointAY, PointBX, PointBY)
    return (PointAX - OriginX) * (PointBY - OriginY) - (PointAY - OriginY) * (PointBX - OriginX)
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

function Module.Function:NotNumerical(Name)
    return Name:match("%a") ~= nil
end

function Module.Function:GetPlayerTeam(Name)
    if typeof(Name) ~= "string" then return nil end

    local Player = Players:FindFirstChild(Name)
    if not Player then return nil end

    local Team = Player.Team
    if Team and Team.Parent then
        return Team.Name
    end

    return "Unknown Team"
end

function Module.Function:GetVehicleTeam(Vehicle)
    if not Vehicle then return nil end

    local OwnerName = Vehicle:GetAttribute("Requester")
    if typeof(OwnerName) ~= "string" then return nil end

    return Module.Function:GetPlayerTeam(OwnerName)
end

function Module.Function:VehicleCache()
    if not Module.Game.Vehicles then
        return
    end

    local Vehicles = Module.Stored.Vehicles

    for Identifier, Data in Vehicles do
        if not Data or not Data.Vehicle or not Data.Vehicle.Parent then
            Vehicles[Identifier] = nil
        end
    end

    for _, Vehicle in Module.Game.Vehicles:GetChildren() do
        if Vehicle.Name == "DONOT" or not Vehicle:IsA("Model") or not Vehicle.PrimaryPart then continue end

        local Identifier = tostring(Vehicle)

        if not Vehicles[Identifier] then
            local DamageModules = Vehicle:FindFirstChild("DamageModules")

            Vehicles[Identifier] = {
                Vehicle = Vehicle,
                PrimaryPart = Vehicle.PrimaryPart,
                Groups = nil,
                Occupied = false,
                Team = Module.Function:GetVehicleTeam(Vehicle)
            }

            task.delay(1, function()
                local Data = Vehicles[Identifier]
                if not Data or Data.Groups then
                    return
                end

                if not (DamageModules and DamageModules.Parent) then
                    return
                end

                local Groups = {}

                for _, DamageModule in DamageModules:GetChildren() do
                    if not (DamageModule:IsA("Model") or DamageModule:IsA("Folder")) then
                        continue
                    end

                    local ModuleName = DamageModule.Name:lower()

                    if ModuleName == "engine" then
                        local EnginePart = DamageModule:FindFirstChild("Engine")

                        if EnginePart then
                            Groups[#Groups + 1] = {
                                Type = "Engine",
                                Parts = {EnginePart}
                            }
                        end

                    elseif ModuleName:find("ammo") or ModuleName:find("atgm") then
                        local Parts = {}

                        for _, Child in DamageModule:GetChildren() do
                            if Child:IsA("BasePart")
                                and self:NotNumerical(Child.Name)
                                and not Child.Name:find("cube") then

                                Parts[#Parts + 1] = Child
                            end
                        end

                        if #Parts > 0 then
                            Groups[#Groups + 1] = {
                                Type = "Ammo",
                                Parts = Parts
                            }
                        end
                    end
                end

                Data.Groups = Groups
            end)
        end
    end
end

function Module.Function:OccupiedCache()
    for _, Data in Module.Stored.Vehicles do
        local Vehicle = Data.Vehicle

        if Vehicle and Vehicle.Parent then
            Data.Occupied = Vehicle:GetAttribute("Occupied") == "true"
        end
    end
end

function Module.Function:DroneCache()
    local Drones = Module.Stored.Drones

    for Identifier, Entry in Drones do
        if not Entry or not Entry.Model or not Entry.Model.Parent then
            Drones[Identifier] = nil
        end
    end

    for _, Drone in Module.Game.Placed:GetChildren() do
        if Library.Flags["Render Drones"] then
            if Drone:IsA("Model") and Drone.Name:lower():find("drone", 1, true) then
                local Identifier = tostring(Drone)

                if not Drones[Identifier] then
                    local DroneModel = Drone:FindFirstChild("Drone")
                    if not DroneModel then continue end

                    local DronePart = DroneModel:IsA("Model") and DroneModel:FindFirstChild("Drone")
                    if not DronePart or not DronePart:IsA("BasePart") then continue end

                    local OwnerTag = Drone:FindFirstChild("OwnershipTag")
                    if not OwnerTag then continue end

                    Drones[Identifier] = {
                        Model = Drone,
                        Part = DronePart,
                        OwnerTag = OwnerTag,
                        Name = Drone.Name,
                        Class = "Drone",
                        Occupied = Drone:GetAttribute("Occupied") == true
                    }
                end
            end
        end
    end
end

function Module.Function:ScanArmor()
    if not Library.Flags["Disable Armor"] then return end
    if not Module.Game.Vehicles then return end

    local Cache = Module.Stored.Armor

    for _, Vehicle in ipairs(Module.Game.Vehicles:GetChildren()) do
        if Vehicle.Name == "DONOT" or Vehicle.ClassName ~= "Model" then continue end

        local Values = Cache[Vehicle]
        if not Values then
            Values = {}
            for _, Item in ipairs(Vehicle:GetDescendants()) do
                if Item:IsA("NumberValue") and Item.Name == "ArmourValue" then
                    Values[Item] = Item.Value
                end
            end
            Cache[Vehicle] = Values
        end
        for ValueObject, _ in pairs(Values) do
            if ValueObject.Parent and ValueObject.Value ~= 0 then
                ValueObject.Value = 0
            end
        end
    end

    for Vehicle in pairs(Cache) do
        if not Vehicle.Parent then
            Cache[Vehicle] = nil
        end
    end
end

function Module.Function:RestoreArmor()
    local Cache = Module.Stored.Armor

    for Vehicle, Values in pairs(Cache) do
        for ValueObject, Original in pairs(Values) do
            if ValueObject and ValueObject.Parent then
                ValueObject.Value = Original
            end
        end
        Cache[Vehicle] = nil
    end
end

function Module.Function:Render()
    if not LocalPlayer then return end

    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if Library.Flags["Render Vehicles"] then
        local Viewport = Camera.ViewportSize
        local CenterX = Viewport.X * 0.5
        local CenterY = Viewport.Y * 0.5
        local Half = Library.Flags["Field of View"].Value * 0.5

        for _, Data in pairs(Module.Stored.Vehicles) do
            local Vehicle = Data.Vehicle
            local PrimaryPart = Data.PrimaryPart

            if not (Vehicle and Vehicle.Parent and PrimaryPart and PrimaryPart.Parent and PrimaryPart:IsA("BasePart")) then continue end

            if is_team_check_active() then
                if LocalPlayer.Team and LocalPlayer.Team.Parent and Data.Team == LocalPlayer.Team.Name then
                    continue
                end
            end

            local Position = PrimaryPart.CFrame.Position

            local Screen, OnScreen = Camera:WorldToScreenPoint(Position)
            if not OnScreen then continue end

            local Name = Library.Flags["Vehicle Names"] and Vehicle.Name
            local Distance 

            if HumanoidRootPart then
                Distance = Library.Flags["Vehicle Distance"] and HumanoidRootPart and string.format("[%.0f]", vector.magnitude(HumanoidRootPart.Position - Position) / 2.78125)
            else
                Distance = 0
            end

            local NameWidth = Name and DrawingImmediate.GetTextBounds("Verdana", 13, Name).X or 0
            local DistanceWidth = Distance and DrawingImmediate.GetTextBounds("Verdana", 13, Distance).X or 0
            local Padding = Name and Distance and 4 or 0

            local X = Screen.X - (NameWidth + Padding + DistanceWidth) / 2
            local Y = Screen.Y

            if Name then
                local NameColor = (Library.Flags["Use Occupied Color"] and Data.Occupied) and Library.Flags["Occupied Color"] or Library.Flags["Name Color"]
                DrawingImmediate.OutlinedText(Vector2.new(X + NameWidth / 2, Y), 13, NameColor.Color, NameColor.Alpha, Name, true, "Verdana")
                X = X + NameWidth + Padding
            end

            if Distance then
                local DistanceColor = (Library.Flags["Use Occupied Color"] and Data.Occupied) and Library.Flags["Occupied Color"] or Library.Flags["Distance Color"]
                DrawingImmediate.OutlinedText(Vector2.new(X + DistanceWidth / 2, Y), 13, DistanceColor.Color, DistanceColor.Alpha, Distance, true, "Verdana")
            end

            local Groups = Data.Groups
            if not (Library.Flags["Render Modules"] and Groups) then continue end
            if MathAbs(Screen.X - CenterX) > Half or MathAbs(Screen.Y - CenterY) > Half then continue end

            for _, Group in ipairs(Groups) do
                local GroupType = Group.Type

                local Enabled = (GroupType == "Engine" and Library.Flags["Vehicle Engine"]) or (GroupType == "Ammo" and Library.Flags["Vehicle Ammo"])
                if not Enabled then continue end

                local Color = GroupType == "Engine" and Library.Flags["Engine Color"] or Library.Flags["Ammo Color"]

                local PointCount = 0
                for _, Part in ipairs(Group.Parts) do
                    if Part and Part.Parent then
                        PointCount = self:ProjectPartCorners(Part, PointCount)
                    end
                end

                if PointCount == 0 then continue end
                Convex.Static.HWMPoints = self:TruncateBuffer(Convex.Scratch.Points, PointCount, Convex.Static.HWMPoints)

                local Size = self:CalculateConvexHull(Convex.Scratch.Points, PointCount, Convex.Scratch.Hull)
                if Size == 0 then continue end

                local Verts = self:BuildHullVerts(Convex.Scratch.Hull, Size)
                self:DrawPolygon(Verts, Size, Color.Color, Color.Alpha)
                self:DrawOutline(Verts, Size, Color.Color, Color.Alpha, 1)
            end
        end
    end

    if Library.Flags["Render Drones"] then
        for _, Data in pairs(Module.Stored.Drones) do
            local Part = Data.Part
            if not Part or not Part.Parent then continue end

            if is_team_check_active() then
                local Team
                if Data.OwnerTag and Data.OwnerTag.Parent and Data.OwnerTag:IsA("StringValue") then
                    Team = Module.Function:GetPlayerTeam(Data.OwnerTag.Value)
                end
                if LocalPlayer.Team and LocalPlayer.Team.Parent and Team == LocalPlayer.Team.Name then
                    continue
                end
            end

            local Position = Part.CFrame.Position

            local Screen, OnScreen = Camera:WorldToScreenPoint(Position)
            if not OnScreen then continue end

            local DroneText = "Drone"
            if HumanoidRootPart then
                local Distance = vector.magnitude(HumanoidRootPart.CFrame.Position - Position) / 2.78125
                DroneText = string.format("Drone [%.0f]", Distance)
            end

            DrawingImmediate.OutlinedText(Screen, 13, Library.Flags["Drone Color"].Color, Library.Flags["Drone Color"].Alpha, DroneText, true, "Verdana")
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.5)
        Module.Function:VehicleCache()
        Module.Function:DroneCache()
        Module.Function:OccupiedCache()
    end
end)

task.spawn(function()
    while true do
        task.wait(5)
        if Library.Flags["Disable Armor"] then
            Module.Function:ScanArmor()
        end
    end
end)

-- // Initalize \\ --
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
Library:Watermark("Goop")

RunService.Render:Connect(function()
    Module.Function:Render()
end)
