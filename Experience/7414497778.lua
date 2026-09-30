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
        Armor = {},

        Viewport = Workspace.CurrentCamera.ViewportSize,
        LocalTeam = nil,
        TeamCheck = false
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

function Module.Function:CollectPartCorners(Parts, Out)
    local Count = 0

    for _, Part in Parts do
        if not (Part and Part.Parent and Part:IsA("BasePart")) then continue end

        local Position = Part.Position
        local Size = Part.Size
        local PartCFrame = Part.CFrame

        local HalfSizeX = Size.X * 0.5
        local HalfSizeY = Size.Y * 0.5
        local HalfSizeZ = Size.Z * 0.5

        local RightVector = PartCFrame.RightVector
        local UpVector = PartCFrame.UpVector
        local LookVector = PartCFrame.LookVector

        local RightX, RightY, RightZ = RightVector.X * HalfSizeX, RightVector.Y * HalfSizeX, RightVector.Z * HalfSizeX
        local UpX, UpY, UpZ = UpVector.X * HalfSizeY, UpVector.Y * HalfSizeY, UpVector.Z * HalfSizeY
        local LookX, LookY, LookZ = LookVector.X * HalfSizeZ, LookVector.Y * HalfSizeZ, LookVector.Z * HalfSizeZ

        for SignR = -1, 1, 2 do
            for SignU = -1, 1, 2 do
                for SignL = -1, 1, 2 do
                    Count = Count + 1
                    Out[Count] = Vector3New(
                        Position.X + SignR * RightX + SignU * UpX + SignL * LookX,
                        Position.Y + SignR * RightY + SignU * UpY + SignL * LookY,
                        Position.Z + SignR * RightZ + SignU * UpZ + SignL * LookZ
                    )
                end
            end
        end
    end

    for Index = Count + 1, #Out do
        Out[Index] = nil
    end

    return Count
end

function Module.Function:ProjectCorners(Corners, Count, WriteOffset)
    local Points = Convex.Scratch.Points

    for Index = 1, Count do
        local ScreenPoint, OnScreen = Camera:WorldToScreenPoint(Corners[Index])
        if OnScreen then
            WriteOffset = WriteOffset + 1
            local Slot = Points[WriteOffset]
            if Slot then
                Slot.X = ScreenPoint.X
                Slot.Y = ScreenPoint.Y
            else
                Points[WriteOffset] = {X = ScreenPoint.X, Y = ScreenPoint.Y}
            end
        end
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

function Module.Function:CacheVehicle(Vehicle)
    if Vehicle.Name == "DONOT" or not Vehicle:IsA("Model") or not Vehicle.PrimaryPart then return end

    local Vehicles = Module.Stored.Vehicles
    local Identifier = tostring(Vehicle)

    if not Vehicles[Identifier] then
        local DamageModules = Vehicle:FindFirstChild("DamageModules")

        Vehicles[Identifier] = {
            Vehicle = Vehicle,
            PrimaryPart = Vehicle.PrimaryPart,
            Name = Vehicle.Name,
            Groups = nil,
            Occupied = false,
            Team = Module.Function:GetVehicleTeam(Vehicle),

            Position = nil,
            DistanceText = nil
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
                            Parts = {EnginePart},
                            Corners = {},
                            CornerCount = 0
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
                            Parts = Parts,
                            Corners = {},
                            CornerCount = 0
                        }
                    end
                end
            end

            Data.Groups = Groups
        end)
    end
end

function Module.Function:ResolveFolders()
    local Game = Module.Game
    if not Game.Vehicles or not Game.Vehicles.Parent then
        Game.Vehicles = Workspace:FindFirstChild("SpawnedVehicles")
    end
    if not Game.Placed or not Game.Placed.Parent then
        Game.Placed = Workspace:FindFirstChild("PlacedBuildings")
    end
end

function Module.Function:VehicleCache()
    Module.Function:ResolveFolders()
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
        pcall(Module.Function.CacheVehicle, Module.Function, Vehicle)
    end
end

function Module.Function:OccupiedCache()
    for _, Data in Module.Stored.Vehicles do
        pcall(function()
            local Vehicle = Data.Vehicle

            if Vehicle and Vehicle.Parent then
                Data.Occupied = Vehicle:GetAttribute("Occupied") == "true"
            end
        end)
    end
end

function Module.Function:CacheDrone(Drone)
    if not Library.Flags["Render Drones"] then return end
    if not (Drone:IsA("Model") and Drone.Name:lower():find("drone", 1, true)) then return end

    local Drones = Module.Stored.Drones
    local Identifier = tostring(Drone)

    if not Drones[Identifier] then
        local DroneModel = Drone:FindFirstChild("Drone")
        if not DroneModel then return end

        local DronePart = DroneModel:IsA("Model") and DroneModel:FindFirstChild("Drone")
        if not DronePart or not DronePart:IsA("BasePart") then return end

        local OwnerTag = Drone:FindFirstChild("OwnershipTag")
        if not OwnerTag then return end

        Drones[Identifier] = {
            Model = Drone,
            Part = DronePart,
            OwnerTag = OwnerTag,
            Name = Drone.Name,
            Class = "Drone",
            Occupied = Drone:GetAttribute("Occupied") == true,
            Team = nil,

            Position = nil,
            Text = nil
        }
    end
end

function Module.Function:DroneCache()
    local Drones = Module.Stored.Drones

    for Identifier, Entry in Drones do
        if not Entry or not Entry.Model or not Entry.Model.Parent then
            Drones[Identifier] = nil
        end
    end

    Module.Function:ResolveFolders()
    if not Module.Game.Placed then return end

    for _, Drone in Module.Game.Placed:GetChildren() do
        pcall(Module.Function.CacheDrone, Module.Function, Drone)
    end

    for _, Entry in Drones do
        local OwnerTag = Entry.OwnerTag
        if OwnerTag and OwnerTag.Parent and OwnerTag:IsA("StringValue") then
            Entry.Team = Module.Function:GetPlayerTeam(OwnerTag.Value)
        end
    end
end

function Module.Function:ScanArmor()
    if not Library.Flags["Disable Armor"] then return end
    if not Module.Game.Vehicles then return end

    local Cache = Module.Stored.Armor

    for _, Vehicle in Module.Game.Vehicles:GetChildren() do
        pcall(function()
            if Vehicle.Name == "DONOT" or Vehicle.ClassName ~= "Model" then return end

            local Values = Cache[Vehicle]
            if not Values then
                Values = {}
                for _, Item in Vehicle:GetDescendants() do
                    if Item:IsA("NumberValue") and Item.Name == "ArmourValue" then
                        Values[Item] = Item.Value
                    end
                end
                Cache[Vehicle] = Values
            end
            for ValueObject, _ in Values do
                if ValueObject.Parent and ValueObject.Value ~= 0 then
                    ValueObject.Value = 0
                end
            end
        end)
    end

    for Vehicle in Cache do
        if not Vehicle.Parent then
            Cache[Vehicle] = nil
        end
    end
end

function Module.Function:RestoreArmor()
    local Cache = Module.Stored.Armor

    for Vehicle, Values in Cache do
        for ValueObject, Original in Values do
            if ValueObject and ValueObject.Parent then
                ValueObject.Value = Original
            end
        end
        Cache[Vehicle] = nil
    end
end

function Module.Function.UpdateTargets()
    local Stored = Module.Stored

    Camera = Workspace.CurrentCamera or Camera
    if Camera then
        Stored.Viewport = Camera.ViewportSize
    end

    local RenderVehicles = Library.Flags["Render Vehicles"]
    local RenderDrones = Library.Flags["Render Drones"]
    if not (RenderVehicles or RenderDrones) then return end

    local Character = LocalPlayer and LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local MyPosition = HumanoidRootPart and HumanoidRootPart.Parent and HumanoidRootPart.Position

    local Team = LocalPlayer and LocalPlayer.Team
    Stored.LocalTeam = (Team and Team.Parent) and Team.Name or nil
    Stored.TeamCheck = is_team_check_active()

    if RenderVehicles then
        local ShowDistance = Library.Flags["Vehicle Distance"]
        local WantModules = Library.Flags["Render Modules"] and (Library.Flags["Vehicle Ammo"] or Library.Flags["Vehicle Engine"])
        local CenterX, CenterY = Stored.Viewport.X * 0.5, Stored.Viewport.Y * 0.5
        local Half = Library.Flags["Field of View"].Value * 0.5

        for _, Data in Stored.Vehicles do
            local Vehicle, PrimaryPart = Data.Vehicle, Data.PrimaryPart
            Data.Position, Data.DistanceText = nil, nil

            if not (Vehicle and Vehicle.Parent and PrimaryPart and PrimaryPart.Parent and PrimaryPart:IsA("BasePart")) then continue end

            local Position = PrimaryPart.Position
            Data.Position = Position

            if ShowDistance and MyPosition then
                Data.DistanceText = string.format("[%.0f]", vector.magnitude(MyPosition - Position) / 2.78125)
            end

            local Groups = Data.Groups
            if Groups then
                local InView = false
                if WantModules and Camera then
                    local Screen, OnScreen = Camera:WorldToScreenPoint(Position)
                    InView = OnScreen and MathAbs(Screen.X - CenterX) <= Half and MathAbs(Screen.Y - CenterY) <= Half
                end

                for _, Group in Groups do
                    local Enabled = InView and ((Group.Type == "Engine" and Library.Flags["Vehicle Engine"]) or (Group.Type == "Ammo" and Library.Flags["Vehicle Ammo"]))
                    Group.CornerCount = Enabled and Module.Function:CollectPartCorners(Group.Parts, Group.Corners) or 0
                end
            end
        end
    end

    if RenderDrones then
        for _, Data in Stored.Drones do
            local Part = Data.Part
            Data.Position, Data.Text = nil, nil

            if not (Part and Part.Parent) then continue end

            local Position = Part.Position
            Data.Position = Position
            Data.Text = MyPosition and string.format("Drone [%.0f]", vector.magnitude(MyPosition - Position) / 2.78125) or "Drone"
        end
    end
end

function Module.Function:RenderVehicle(Data)
    local Stored = Module.Stored
    local Position = Data.Position
    if not Position then return end

    if Stored.TeamCheck and Stored.LocalTeam and Data.Team == Stored.LocalTeam then return end

    local Screen, OnScreen = Camera:WorldToScreenPoint(Position)
    if not OnScreen then return end

    local Name = Library.Flags["Vehicle Names"] and Data.Name or nil
    local Distance = Data.DistanceText

    local NameWidth = Name and DrawingImmediate.GetTextBounds("Avant", 13, Name).X or 0
    local DistanceWidth = Distance and DrawingImmediate.GetTextBounds("Avant", 13, Distance).X or 0
    local Padding = (Name and Distance) and 4 or 0

    local X = Screen.X - (NameWidth + Padding + DistanceWidth) / 2
    local Y = Screen.Y

    local UseOccupied = Library.Flags["Use Occupied Color"] and Data.Occupied

    if Name then
        local NameColor = UseOccupied and Library.Flags["Occupied Color"] or Library.Flags["Name Color"]
        DrawingImmediate.OutlinedText(Vector2.new(X + NameWidth / 2, Y), 13, NameColor.Color, NameColor.Alpha, Name, true, "Avant")
        X = X + NameWidth + Padding
    end

    if Distance then
        local DistanceColor = UseOccupied and Library.Flags["Occupied Color"] or Library.Flags["Distance Color"]
        DrawingImmediate.OutlinedText(Vector2.new(X + DistanceWidth / 2, Y), 13, DistanceColor.Color, DistanceColor.Alpha, Distance, true, "Avant")
    end

    local Groups = Data.Groups
    if not (Library.Flags["Render Modules"] and Groups) then return end

    for _, Group in Groups do
        if Group.CornerCount == 0 then continue end

        local Color = Group.Type == "Engine" and Library.Flags["Engine Color"] or Library.Flags["Ammo Color"]

        local PointCount = self:ProjectCorners(Group.Corners, Group.CornerCount, 0)
        if PointCount == 0 then continue end
        Convex.Static.HWMPoints = self:TruncateBuffer(Convex.Scratch.Points, PointCount, Convex.Static.HWMPoints)

        local Size = self:CalculateConvexHull(Convex.Scratch.Points, PointCount, Convex.Scratch.Hull)
        if Size == 0 then continue end

        local Verts = self:BuildHullVerts(Convex.Scratch.Hull, Size)
        self:DrawPolygon(Verts, Size, Color.Color, Color.Alpha)
        self:DrawOutline(Verts, Size, Color.Color, Color.Alpha, 1)
    end
end

function Module.Function:RenderDrone(Data)
    local Stored = Module.Stored
    local Position = Data.Position
    if not Position or not Data.Text then return end

    if Stored.TeamCheck and Stored.LocalTeam and Data.Team == Stored.LocalTeam then return end

    local Screen, OnScreen = Camera:WorldToScreenPoint(Position)
    if not OnScreen then return end

    DrawingImmediate.OutlinedText(Screen, 13, Library.Flags["Drone Color"].Color, Library.Flags["Drone Color"].Alpha, Data.Text, true, "Avant")
end

function Module.Function:Render()
    if not Camera then return end

    if Library.Flags["Render Vehicles"] then
        for _, Data in Module.Stored.Vehicles do
            Module.Function:RenderVehicle(Data)
        end
    end

    if Library.Flags["Render Drones"] then
        for _, Data in Module.Stored.Drones do
            Module.Function:RenderDrone(Data)
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(Module.Function.VehicleCache, Module.Function)
        pcall(Module.Function.DroneCache, Module.Function)
        pcall(Module.Function.OccupiedCache, Module.Function)
    end
end)

task.spawn(function()
    while true do
        task.wait(5)
        if Library.Flags["Disable Armor"] then
            pcall(Module.Function.ScanArmor, Module.Function)
        end
    end
end)

-- // Initalize \\ --
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
Library:Watermark("Goop")

RunService.PostLocal:Connect(function()
    pcall(Module.Function.UpdateTargets)
end)

RunService.Render:Connect(function()
    pcall(Module.Function.Render, Module.Function)
end)
