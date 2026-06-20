local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local LOD = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/Severe/refs/heads/main/Modules/Bounding.lua"))()
local Module = {
    Function = {},

    Game = {
        Animals = Workspace:FindFirstChild("Living") and Workspace:FindFirstChild("Living").Animals
    },
    
    Stored = {
        Entities = {},
    },

    Paths = {}
}

local Library = loadfile("Source.lua")()

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

function Module.Function:Cache()
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

function Module.Function.Render()
    for _, Animal in pairs(Module.Stored.Entities) do
        if Animal and Animal:FindFirstChild("HumanoidRootPart") then
            if not LocalPlayer then continue end

            local Character = LocalPlayer.Character
            if not Character then continue end

            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if not HumanoidRootPart then continue end

            if Library.Flags["Use Maximum Render"] and vector.magnitude(Animal:FindFirstChild("HumanoidRootPart").Position - HumanoidRootPart.Position) >= Library.Flags["Maximum Render"].Value then continue end

            local Parts, Count = Module.Function:GetEntityParts(Animal)

            if Count > 0 then
                local BoundingBox = LOD.GetBoundingBox(Parts)
                if BoundingBox then
                    local ScaledSize = BoundingBox.Size * 2

                    local ScaledPosition = Vector2.new(BoundingBox.Position.X - (ScaledSize.X - BoundingBox.Size.X) * 0.5, BoundingBox.Position.Y - (ScaledSize.Y - BoundingBox.Size.Y) * 0.5)

                    local TopY = ScaledPosition.Y
                    local CenterX = ScaledPosition.X + ScaledSize.X * 0.5

                    if Library.Flags["Render Boxes"] then
                        local Thickness = 1

                        DrawingImmediate.Rectangle(Vector2.new(ScaledPosition.X - Thickness, ScaledPosition.Y - Thickness), Vector2.new(ScaledSize.X + Thickness * 2, ScaledSize.Y + Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                        DrawingImmediate.Rectangle(Vector2.new(ScaledPosition.X + Thickness, ScaledPosition.Y + Thickness), Vector2.new(ScaledSize.X - Thickness * 2, ScaledSize.Y - Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                        DrawingImmediate.Rectangle(ScaledPosition, ScaledSize, Library.Flags["Box Color"].Color, Library.Flags["Box Color"].Alpha, 1)
                    end

                    if Library.Flags["Render Names"] then
                        local RealName = Animal:GetAttribute("RealFileName")
                        DrawingImmediate.OutlinedText(Vector2.new(CenterX, TopY - 16), 14, Library.Flags["Name Color"].Color, Library.Flags["Name Color"].Alpha, RealName, true, "Proggy")
                    end
                end
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

Library:Settings()
PlayerSection:Button({Name = "Teleport to Skin Man", Callback = function() Module.Function:Teleport(Vector3.new(-34.342793, 7.000000, 83.419090)) Window:Notify("Teleported", 2) end})
PlayerSection:Button({Name = "Teleport to Meat Man", Callback = function() Module.Function:Teleport(Vector3.new(-26.730238, 3.601006, 11.802993)) Window:Notify("Teleported", 2) end})
task.spawn(function() while true do task.wait(0.5) Module.Function:Cache() end end)
RunService.Render:Connect(Module.Function.Render)
