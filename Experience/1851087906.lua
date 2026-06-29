-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Bounding = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/Severe/refs/heads/main/Modules/Bounding.lua"))()
local Module = {
    Function = {},

    Game = {
        Animals = Workspace:FindFirstChild("Animals")
    },
    
    Stored = {
        Entities = {},
    }
}

local Library = loadfile("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua")()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Hunting Season", Size = Vector2.new(360, 295)})

local VisualsTab = Window:Page({Name = "Visuals", Columns = 1})
local AnimalsSection = VisualsTab:Section({Name = "Animals", Side = 1})

AnimalsSection:Toggle({Name = "Render Names", Flag = "Render Names", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Name", Flag = "Name Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
AnimalsSection:Toggle({Name = "Display Gender", Flag = "Display Gender", Default = false, Callback = function(Value) end})
AnimalsSection:Toggle({Name = "Render Boxes", Flag = "Render Boxes", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Box", Flag = "Box Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})

--

AnimalsSection:Separator()
AnimalsSection:Toggle({Name = "Use Maximum Render", Flag = "Use Maximum Render", Default = false, Callback = function(Value) end})
AnimalsSection:Slider({Name = "Maximum Render", Flag = "Maximum Render", Min = 0, Max = 1500, Default = 400, Callback = function(Value) end})

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

function Module.Function.Cache()
    local Stored = Module.Stored.Entities

    for Identifier, Entry in Stored do
        if not Entry or not Entry.Parent then
            Stored[Identifier] = nil
        end
    end

    if Library.Flags["Render Names"] or Library.Flags["Render Boxes"] then
        for _, Animal in Module.Game.Animals:GetChildren() do
            local Identifier = tostring(Animal)

            if not Stored[Identifier] then
                Stored[Identifier] = Animal
            end
        end
    end
end

function Module.Function.Render()
    for _, Animal in pairs(Module.Stored.Entities) do
        if Animal and Animal:FindFirstChild("RootPart") then
            if not LocalPlayer then continue end

            local Character = LocalPlayer.Character
            if not Character then continue end

            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if not HumanoidRootPart then continue end

            if Library.Flags["Use Maximum Render"] and vector.magnitude(Animal:FindFirstChild("RootPart").Position - HumanoidRootPart.Position) >= Library.Flags["Maximum Render"].Value then continue end

            local Parts, Count = Module.Function:GetEntityParts(Animal)

            if Count > 0 then
                local BoundingBox = Bounding.GetBoundingBox(Parts)
                if BoundingBox then
                    local TopY = BoundingBox.Position.Y
                    local CenterX = BoundingBox.Position.X + BoundingBox.Size.X * 0.5

                    if Library.Flags["Render Boxes"] then
                        local Thickness = 1

                        DrawingImmediate.Rectangle(Vector2.new(BoundingBox.Position.X - Thickness, BoundingBox.Position.Y - Thickness), Vector2.new(BoundingBox.Size.X + Thickness * 2, BoundingBox.Size.Y + Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                        DrawingImmediate.Rectangle(Vector2.new(BoundingBox.Position.X + Thickness, BoundingBox.Position.Y + Thickness), Vector2.new(BoundingBox.Size.X - Thickness * 2, BoundingBox.Size.Y - Thickness * 2), Color3.fromRGB(0, 0, 0), 1, 1)
                        DrawingImmediate.Rectangle(BoundingBox.Position, BoundingBox.Size, Library.Flags["Box Color"].Color, Library.Flags["Box Color"].Alpha, 1)
                    end

                    if Library.Flags["Render Names"] then
                        local RealName

                        if Library.Flags["Display Gender"] then
                            RealName = Animal:GetAttribute("Sex").. " ".. Animal:GetAttribute("DisplayName")
                        else
                            RealName = Animal:GetAttribute("DisplayName")
                        end
                        DrawingImmediate.OutlinedText(Vector2.new(CenterX, TopY - 16), 14, Library.Flags["Name Color"].Color, Library.Flags["Name Color"].Alpha, RealName, true, "Proggy")
                    end
                end
            end
        end
    end
end

-- // Initalize \\ --
Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
task.spawn(function() while true do task.wait(0.8) Module.Function:Cache() end end)
RunService.Render:Connect(Module.Function.Render)
