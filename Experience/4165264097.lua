-- // Service and Module \\ --

local State
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Module = {
    Added = {},
    Function = {},

    Game = {
        GameObjects = Workspace.Game.Current.Spawned.GameObjects,
        Entities = Workspace.Game.Current.Spawned.NPCs.enemies
    },
    
    Stored = {
        Objects = {},
        Entities = {}
    }
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Reign Fall", Size = Vector2.new(480, 360)})

local VisualsTab = Window:Page({Name = "Visuals", Columns = 1})
local DropsSection = VisualsTab:Section({Name = "Drops", Side = 1})
local GameSection = VisualsTab:Section({Name = "Game", Side = 1})

-- // Drops Section \\ --

DropsSection:Toggle({Name = "Render Ammunition", Flag = "Render Ammunition", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Ammunition", Flag = "Ammunition Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
DropsSection:Toggle({Name = "Render Medkits", Flag = "Render Medkit", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Medkit", Flag = "Medkit Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
DropsSection:Toggle({Name = "Render Collectibles", Flag = "Render Collectible", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Collectible", Flag = "Collectible Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})

-- // Game Section \\ --

GameSection:Toggle({Name = "Render Objective Placements", Flag = "Render Objective Placement", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Objective Placement", Flag = "Objective Placement Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
GameSection:Toggle({Name = "Render Objective Items", Flag = "Render Objective Item", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Objective Item", Flag = "Objective Item Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
GameSection:Separator()
GameSection:Toggle({Name = "Initialize Entities", Flag = "Initialize Entities", Default = false, Callback = function(Value) end})

-- // Functions \\ --

function Module.Function.Cache()
    local Stored = Module.Stored.Objects

    for Identifier, Entry in Stored do
        if not Entry or not Entry.Parent then
            Stored[Identifier] = nil
        end
    end

    for _, Drop in Module.Game.GameObjects:GetChildren() do
        if Library.Flags["Render Ammunition"] and Drop.Name == "pickup_ammo" then
            local Identifier = tostring(Drop)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Drop,
                    Object = Drop.PrimaryPart,
                    Name = "Ammunition",
                    Class = "Ammunition"
                }
            end
        end

        if Library.Flags["Render Medkit"] and Drop.Name == "pickup_medkit" then
            local Identifier = tostring(Drop)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Drop,
                    Object = Drop.PrimaryPart,
                    Name = "Medkit",
                    Class = "Medkit"
                }
            end
        end

        if Library.Flags["Render Collectible"] and Drop.Name == "collectible" then
            local Identifier = tostring(Drop)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Drop,
                    Object = Drop.PrimaryPart,
                    Name = "Collectible",
                    Class = "Collectible"
                }
            end
        end

        if Library.Flags["Render Objective Item"] and string.sub(Drop.Name, 1, 7) == "mission" then
            local Identifier = tostring(Drop)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Drop,
                    Object = Drop.PrimaryPart,
                    Name = "Objective Item",
                    Class = "Objective Item"
                }
            end
        end

        if Library.Flags["Render Objective Placement"] and string.sub(Drop.Name, 1, 9) == "objective" then
            local Identifier = tostring(Drop)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Drop,
                    Object = Drop.PrimaryPart,
                    Name = "Objective Placement",
                    Class = "Objective Placement"
                }
            end
        end
    end

    if Library.Flags["Initialize Entities"] then
        for _, Entity in Module.Game.Entities:GetChildren() do
            local Identifier = tostring(Entity)

            if not Module.Stored.Entities[Identifier] then
                Module.Stored.Entities[Identifier] = Entity
            end
        end
    end
end

function Module.Function:GetBodyData(Character)
    if not Character then return nil end

    return {
		Head = Character:FindFirstChild("Head"),
		
		LeftLeg = Character:FindFirstChild("Left Leg"),
		RightLeg = Character:FindFirstChild("Right Leg"),
		LeftArm = Character:FindFirstChild("Left Arm"),
		RightArm = Character:FindFirstChild("Right Arm"),
		Torso = Character:FindFirstChild("Torso"),
		
		HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart"),
	}
end

function Module.Function:EntityData(Entity, Parts)
    if not Entity then return nil end

    local Humanoid = Entity and Entity:FindFirstChild("Humanoid")
    if not Humanoid then return nil end

    local Health = Humanoid and Humanoid.Health 
    local MaxHealth = Humanoid and Humanoid.MaxHealth

    local Data = {
        Username = tostring(Entity),
        Displayname = Entity.Name,
        Userid = math.random(-999999, 999999),
        Character = Entity,
        PrimaryPart = Parts.HumanoidRootPart,
        Humanoid = Humanoid,
        Head = Parts.Head,
        Torso = Parts.Torso,
        LeftArm = Parts.LeftArm or Parts.HumanoidRootPart,
        LeftLeg = Parts.LeftLeg or Parts.HumanoidRootPart,
        RightArm = Parts.RightArm or Parts.HumanoidRootPart,
        RightLeg = Parts.RightLeg or Parts.HumanoidRootPart,
        BodyHeightScale = 1,
        RigType = 0,
        Teamname = "Zombies",
        Toolname = "Unknown",
        Whitelisted = false,
        Archenemies = false,
        Aimbot_Part = Parts.Head,
        Aimbot_TP_Part = Parts.Head,
        Triggerbot_Part = Parts.Head,
        Health = Health,
        MaxHealth = Humanoid and Humanoid.MaxHealth or 0,
        body_parts_data = {
            { name = "LowerTorso", part = Parts.Torso },
            { name = "LeftUpperLeg", part = Parts.LeftLeg },
            { name = "LeftLowerLeg", part = Parts.LeftLeg },
            { name = "RightUpperLeg", part = Parts.RightLeg },
            { name = "RightLowerLeg", part = Parts.RightLeg },
            { name = "LeftUpperArm", part = Parts.LeftArm },
            { name = "LeftLowerArm", part = Parts.LeftArm },
            { name = "RightUpperArm", part = Parts.RightArm },
            { name = "RightLowerArm", part = Parts.RightArm },
        },
        full_body_data = {
            { name = "Head", part = Parts.Head },
            { name = "UpperTorso", part = Parts.Torso },
            { name = "LowerTorso", part = Parts.Torso },
            { name = "HumanoidRootPart", part = Parts.HumanoidRootPart },
            { name = "LeftUpperArm", part = Parts.LeftArm },
            { name = "LeftLowerArm", part = Parts.LeftArm },
            { name = "LeftHand", part = Parts.LeftArm },
            { name = "RightUpperArm", part = Parts.RightArm },
            { name = "RightLowerArm", part = Parts.RightArm },
            { name = "RightHand", part = Parts.RightArm },
            { name = "LeftUpperLeg", part = Parts.LeftLeg },
            { name = "LeftLowerLeg", part = Parts.LeftLeg },
            { name = "LeftFoot", part = Parts.LeftLeg },
            { name = "RightUpperLeg", part = Parts.RightLeg },
            { name = "RightLowerLeg", part = Parts.RightLeg },
            { name = "RightFoot", part = Parts.RightLeg },
        }
    }

    return tostring(Entity), Data
end

function Module.Function.PreModel()
    if Library.Flags["Initialize Entities"] then
        State = true
        local Seen = {}

        for _, Entity in Module.Stored.Entities do
            local Humanoid = Entity:FindFirstChild("Humanoid")
            if Humanoid and Entity.Parent then
                local Key = tostring(Entity)
                local Parts = Module.Function:GetBodyData(Entity)

                if not Parts or not Parts.Head or not Parts.HumanoidRootPart then
                    continue
                end

                if Parts.Head and Parts.HumanoidRootPart then
                    if not Module.Added[Key] then
                        local Success, ID, Data = pcall(function()
                            return Module.Function:EntityData(Entity, Parts)
                        end)

                        if Success and ID and Data then
                            add_model_data(Data, ID)
                            Module.Added[ID] = Entity
                        end
                    else
                        edit_model_data({ Health = Humanoid.Health }, Key)
                    end

                    Seen[Key] = true
                end
            end
        end

        for Key, Model in pairs(Module.Added) do
            local HumanoidRootPart = Model:FindFirstChild("HumanoidRootPart")
            if not HumanoidRootPart or not Seen[Key] then
                remove_model_data(Key)
                Module.Added[Key] = nil
            end
        end
    elseif not Library.Flags["Initialize Entities"] and State then
        clear_model_data()
        State = false
    end
end

function Module.Function.Render() 
    for _, Entry in Module.Stored.Objects do
        if Library.Flags["Render ".. Entry.Class] then
            if Entry and Entry.Model then
                local Primary = Entry.Object
                if not Primary then continue end

                local Screen, Visible = Camera:WorldToScreenPoint(Primary.Position)

                if Visible then
                    DrawingImmediate.OutlinedText(Screen, 13, Library.Flags[Entry.Class.. " Color"].Color, Library.Flags[Entry.Class.. " Color"].Alpha, Entry.Name, true, "Pixel")
                end
            end
        end
    end
end

-- // Initalize \\ --
Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
task.spawn(function() while true do task.wait(0.8) Module.Function:Cache() end end)
RunService.PreModel:Connect(Module.Function.PreModel)
RunService.Render:Connect(Module.Function.Render)
