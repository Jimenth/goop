-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Module = {
    Function = {},

    Game = {
        Animals = Workspace:FindFirstChild("Living") and Workspace:FindFirstChild("Living").Animals
    },
    
    Stored = {
        Entities = {},
    }
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()
task.wait(2)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Extra/Module.lua"))()
task.wait(2)

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Foresto", Size = Vector2.new(550, 622)})

local MainTab = Window:Page({Name = "Main", Columns = 2})
local AnimalsSection = MainTab:Section({Name = "Animals", Side = 1})
local PlayerSection = MainTab:Section({Name = "Player", Side = 2})

AnimalsSection:Toggle({Name = "Render Names", Flag = "Render Names", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Name", Flag = "Name Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
AnimalsSection:Toggle({Name = "Render Boxes", Flag = "Render Boxes", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Box", Flag = "Box Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})

--

AnimalsSection:Separator()
AnimalsSection:Toggle({Name = "Use Maximum Render", Flag = "Use Maximum Render", Default = false, Callback = function(Value) end})
AnimalsSection:Slider({Name = "Maximum Render", Flag = "Maximum Render", Min = 0, Max = 1500, Default = 400, Callback = function(Value) end})

-- 

PlayerSection:Toggle({Name = "Loop Ammunition", Flag = "Loop Ammunition", Default = false, Callback = function(Value) end})
PlayerSection:Separator()

-- // Functions \\ --

function Module.Function:GetEntityParts(Entity)
    local Parts = {}
    local Count = 0
    
    for _, Child in Entity:GetChildren() do
        if Child:IsA("Part") or Child:IsA("MeshPart") then
            Count = Count + 1
            Parts[Count] = Child
        end
    end
    
    return Parts, Count
end

function Module.Function:WorldBoxToScreen(Center, BoxSize)
    local HX, HY, HZ = BoxSize.X * 0.5, BoxSize.Y * 0.5, BoxSize.Z * 0.5
    local MinX, MinY, MaxX, MaxY = math.huge, math.huge, -math.huge, -math.huge
    local OnScreen = false
    for SX = -1, 1, 2 do
        for SY = -1, 1, 2 do
            for SZ = -1, 1, 2 do
                local Screen, Visible = Camera:WorldToScreenPoint(Vector3.new(Center.X + SX * HX, Center.Y + SY * HY, Center.Z + SZ * HZ))
                if Screen.X < MinX then MinX = Screen.X end
                if Screen.X > MaxX then MaxX = Screen.X end
                if Screen.Y < MinY then MinY = Screen.Y end
                if Screen.Y > MaxY then MaxY = Screen.Y end
                if Visible then OnScreen = true end
            end
        end
    end
    if not OnScreen then return nil end
    return Vector2.new(MinX, MinY), Vector2.new(MaxX - MinX, MaxY - MinY)
end

function Module.Function:IsRenderedForMe(Animal)
    local Rendered = Animal:FindFirstChild("RenderedBy")
    return Rendered ~= nil and Rendered:FindFirstChild(LocalPlayer.Name) ~= nil
end

function Module.Function:Cache()
    if not LocalPlayer then return nil end
    if not Module.Game.Animals then return nil end

    local Entities = Module.Stored.Entities
    local Current = {}

    for _, Animal in Module.Game.Animals:GetChildren() do
        if Animal and Animal:IsA("Model") and Module.Function:IsRenderedForMe(Animal) then
            Current[Animal] = true

            local Data = Entities[Animal]
            if not Data then
                Data = {}
                Entities[Animal] = Data
            end

            Data.Root = Animal:FindFirstChild("HumanoidRootPart")
            Data.Parts, Data.PartCount = Module.Function:GetEntityParts(Animal)
            Data.Name = Animal:GetAttribute("RealFileName")
        end
    end

    for Animal in pairs(Entities) do
        if not Current[Animal] then
            Entities[Animal] = nil
        end
    end
end

function Module.Function.UpdateTargets()
    Camera = Workspace.CurrentCamera or Camera

    if not (Library.Flags["Render Boxes"] or Library.Flags["Render Names"]) then return end

    local Character = LocalPlayer and LocalPlayer.Character
    local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")
    local MyPosition = MyRoot and MyRoot.Position

    local UseMaximum = Library.Flags["Use Maximum Render"]
    local Maximum = Library.Flags["Maximum Render"].Value

    for Animal, Data in Module.Stored.Entities do
        Data.Center, Data.Size = nil, nil

        local Root = Data.Root
        if not MyPosition or not Root or not Root.Parent or not Animal.Parent then continue end

        if UseMaximum and vector.magnitude(Root.Position - MyPosition) >= Maximum then continue end

        if Data.PartCount > 0 then
            local Ok, Box, WorldSize = pcall(GetBoundingBox, Data.Parts)
            if Ok and Box and WorldSize then
                Data.Center, Data.Size = Box.Position, WorldSize
            end
        end
    end
end

function Module.Function.Render()
    local ShowBoxes = Library.Flags["Render Boxes"]
    local ShowNames = Library.Flags["Render Names"]
    if not (ShowBoxes or ShowNames) then return end

    for _, Data in pairs(Module.Stored.Entities) do
        if not Data.Center then continue end

        local BoxPosition, BoxSize = Module.Function:WorldBoxToScreen(Data.Center, Data.Size)
        if BoxPosition and BoxSize then
            local ScaledSize = Vector2.new(BoxSize.X * 2, BoxSize.Y * 2)

            local ScaledPosition = Vector2.new(BoxPosition.X - (ScaledSize.X - BoxSize.X) * 0.5, BoxPosition.Y - (ScaledSize.Y - BoxSize.Y) * 0.5)

            local TopY = ScaledPosition.Y
            local CenterX = ScaledPosition.X + ScaledSize.X * 0.5

            if ShowBoxes then
                local Thickness = 1

                DrawingImmediate.Rectangle(Vector2.new(ScaledPosition.X - Thickness, ScaledPosition.Y - Thickness), Vector2.new(ScaledSize.X + Thickness * 2, ScaledSize.Y + Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                DrawingImmediate.Rectangle(Vector2.new(ScaledPosition.X + Thickness, ScaledPosition.Y + Thickness), Vector2.new(ScaledSize.X - Thickness * 2, ScaledSize.Y - Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                DrawingImmediate.Rectangle(ScaledPosition, ScaledSize, Library.Flags["Box Color"].Color, Library.Flags["Box Color"].Alpha, 1)
            end

            if ShowNames and Data.Name then
                DrawingImmediate.OutlinedText(Vector2.new(CenterX, TopY - 16), 14, Library.Flags["Name Color"].Color, Library.Flags["Name Color"].Alpha, Data.Name, true, "Proggy")
            end
        end
    end
end

function Module.Function:Teleport(Position)
    if not LocalPlayer then return nil end

    local Character = LocalPlayer.Character
    if not Character then return nil end

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return nil end

    HumanoidRootPart.Position = Position
end

task.spawn(function()
    while true do
        task.wait(1/15)

        if Library.Flags["Loop Ammunition"] then
            if not LocalPlayer then continue end

            local Character = LocalPlayer.Character
            if not Character then continue end

            local Equipped = Character:FindFirstChild("Equiped")
            local EquippedValue = Equipped and Equipped.Value
            if EquippedValue then
                local Weapon = Character:FindFirstChild(EquippedValue.Name)
                if Weapon then
                    if Weapon:GetAttribute("MaxAmmo") ~= 600 then
                        Weapon:SetAttribute("MaxAmmo", 600)
                    end

                    if Weapon:GetAttribute("Ammo") ~= 600 then
                        Weapon:SetAttribute("Ammo", 600)
                    end
                end
            end
        end
    end
end)

-- // Initalize \\ --
Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
PlayerSection:Button({Name = "Teleport to Skin Man", Callback = function() Module.Function:Teleport(Vector3.new(-34.342793, 7.000000, 83.419090)) Window:Notify("Teleported", 2) end})
PlayerSection:Button({Name = "Teleport to Meat Man", Callback = function() Module.Function:Teleport(Vector3.new(-26.730238, 3.601006, 11.802993)) Window:Notify("Teleported", 2) end})
task.spawn(function() while true do task.wait(0.5) Module.Function:Cache() end end)
RunService.PostLocal:Connect(Module.Function.UpdateTargets)
RunService.Render:Connect(Module.Function.Render)
