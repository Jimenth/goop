-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Module = {
    Function = {},

    Game = {
        Animals = Workspace:FindFirstChild("Living") and Workspace:FindFirstChild("Living").Animals
    },
    
    Stored = {
        Entities = {},

        -- Render cache: filled outside RunService.Render, only read inside it.
        RenderTargets = {}, -- { Animal, RootPart, Parts, Name } (every 0.25s)
        RenderCache = {},   -- { BoxCFrame, BoxSize, Name } (every tick)
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

function Module.Function:WorldBoxToScreen(BoxCFrame, BoxSize)
    local Center = BoxCFrame.Position
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

function Module.Function:Cache()
    if not LocalPlayer then return nil end
    if not Module.Game.Animals then return nil end
    local Current = {}

    for _, Animal in Module.Game.Animals:GetChildren() do
        if Animal and Animal:IsA("Model") then
            local Rendered = Animal:FindFirstChild("RenderedBy")
            if Rendered:FindFirstChild(LocalPlayer.Name) then
                Current[Animal] = true

                if not Module.Stored.Entities[Animal] then
                    Module.Stored.Entities[Animal] = Animal
                end
            end
        end
    end

    for Instance in pairs(Module.Stored.Entities) do
        local Rendered = Instance:FindFirstChild("RenderedBy")
        if not Current[Instance] or not Rendered:FindFirstChild(LocalPlayer.Name) then
            Module.Stored.Entities[Instance] = nil
        end
    end
end

-- // Render Cache \\ --
-- Everything that touches the game (GetChildren, FindFirstChild, attributes,
-- positions, bounding boxes) happens here, outside RunService.Render.

function Module.Function.UpdateRenderTargets()
    local Targets = {}

    if Library.Flags["Render Boxes"] or Library.Flags["Render Names"] then
        for _, Animal in pairs(Module.Stored.Entities) do
            local RootPart = Animal and Animal:FindFirstChild("HumanoidRootPart")
            if not RootPart then continue end

            local Parts, Count = Module.Function:GetEntityParts(Animal)
            if Count > 0 then
                Targets[#Targets + 1] = {
                    Animal = Animal,
                    RootPart = RootPart,
                    Parts = Parts,
                    Name = Animal:GetAttribute("RealFileName"),
                }
            end
        end
    end

    Module.Stored.RenderTargets = Targets
end

function Module.Function.UpdateRenderCache()
    local Cache = {}

    local Character = LocalPlayer and LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

    if HumanoidRootPart then
        local UseMaximum = Library.Flags["Use Maximum Render"]
        local Maximum = Library.Flags["Maximum Render"].Value

        for _, Target in Module.Stored.RenderTargets do
            if not Target.RootPart.Parent then continue end
            if UseMaximum and vector.magnitude(Target.RootPart.Position - HumanoidRootPart.Position) >= Maximum then continue end

            local BoxCFrame, BoxSize = GetBoundingBox(Target.Parts)
            if BoxCFrame then
                Cache[#Cache + 1] = { BoxCFrame = BoxCFrame, BoxSize = BoxSize, Name = Target.Name }
            end
        end
    end

    Module.Stored.RenderCache = Cache
end

-- // Render \\ --
-- Only iterates the render cache and draws with DrawingImmediate.

function Module.Function.Render()
    local Flags = Library.Flags

    for _, Entry in Module.Stored.RenderCache do
        local BoxPosition, BoxSize = Module.Function:WorldBoxToScreen(Entry.BoxCFrame, Entry.BoxSize)
        if BoxPosition and BoxSize then
            local ScaledSize = Vector2.new(BoxSize.X * 2, BoxSize.Y * 2)
            local ScaledPosition = Vector2.new(BoxPosition.X - (ScaledSize.X - BoxSize.X) * 0.5, BoxPosition.Y - (ScaledSize.Y - BoxSize.Y) * 0.5)

            local TopY = ScaledPosition.Y
            local CenterX = ScaledPosition.X + ScaledSize.X * 0.5

            if Flags["Render Boxes"] then
                local Thickness = 1

                DrawingImmediate.Rectangle(Vector2.new(ScaledPosition.X - Thickness, ScaledPosition.Y - Thickness), Vector2.new(ScaledSize.X + Thickness * 2, ScaledSize.Y + Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                DrawingImmediate.Rectangle(Vector2.new(ScaledPosition.X + Thickness, ScaledPosition.Y + Thickness), Vector2.new(ScaledSize.X - Thickness * 2, ScaledSize.Y - Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                DrawingImmediate.Rectangle(ScaledPosition, ScaledSize, Flags["Box Color"].Color, Flags["Box Color"].Alpha, 1)
            end

            if Flags["Render Names"] and Entry.Name then
                DrawingImmediate.OutlinedText(Vector2.new(CenterX, TopY - 16), 14, Flags["Name Color"].Color, Flags["Name Color"].Alpha, Entry.Name, true, Library.Font)
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
        if Library.Flags["Loop Ammunition"] then
            if not LocalPlayer then continue end

            local Character = LocalPlayer.Character
            if not Character then continue end

            local Equipped = Character:FindFirstChild("Equiped")
            if Equipped then
                local Value = Equipped.Value.Name
                local Weapon
                if Equipped.Value.Name then
                    Weapon = Character:FindFirstChild(Value)
                end
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
        task.wait(1/15)
    end
end)

-- // Initalize \\ --
Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
PlayerSection:Button({Name = "Teleport to Skin Man", Callback = function() Module.Function:Teleport(Vector3.new(-34.342793, 7.000000, 83.419090)) Window:Notify("Teleported", 2) end})
PlayerSection:Button({Name = "Teleport to Meat Man", Callback = function() Module.Function:Teleport(Vector3.new(-26.730238, 3.601006, 11.802993)) Window:Notify("Teleported", 2) end})
task.spawn(function() while true do task.wait(0.5) Module.Function:Cache() end end)
task.spawn(function() while true do task.wait(0.25) pcall(Module.Function.UpdateRenderTargets) end end)
task.spawn(function() while true do task.wait(0) pcall(Module.Function.UpdateRenderCache) end end)
RunService.Render:Connect(Module.Function.Render)