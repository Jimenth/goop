-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")

local Module = {
    Function = {},
    Added = {},

    Game = {
        Animals = Workspace:FindFirstChild("Animals"),
        DeadAnimals = Workspace:FindFirstChild("DeadAnimals"),
    },
    
    Stored = {
        Entities = {},
        Dead = {}
    }
}

local Library = loadfile("Source.lua")()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Hunting Season", Size = Vector2.new(360, 295)})

local VisualsTab = Window:Page({Name = "Visuals", Columns = 1})
local AnimalsSection = VisualsTab:Section({Name = "Animals", Side = 1})

AnimalsSection:Toggle({Name = "Initialize Entities", Flag = "Initialize Entities", Default = false, Callback = function(Value) end})
AnimalsSection:Toggle({Name = "Display Gender", Flag = "Display Gender", Default = false, Callback = function(Value) end})

AnimalsSection:Separator()

AnimalsSection:Toggle({Name = "Render Dead", Flag = "Render Dead", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Name", Flag = "Name Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})

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
    local Dead = Module.Stored.Dead

    for Identifier, Entry in Stored do
        if not Entry or not Entry.Parent or not Library.Flags["Initialize Entities"] then
            Stored[Identifier] = nil
        end
    end

    for Identifier, Entry in Dead do
        if not Entry or not Entry.Parent or not Library.Flags["Render Dead"] then
            Dead[Identifier] = nil
        end
    end

    if Library.Flags["Initialize Entities"] then
        for _, Animal in Module.Game.Animals:GetChildren() do
            local Identifier = tostring(Animal)

            if not Stored[Identifier] then
                Stored[Identifier] = Animal
            end
        end
    end

    if Library.Flags["Render Dead"] then
        for _, Animal in Module.Game.DeadAnimals:GetChildren() do
            local Identifier = tostring(Animal)

            if not Dead[Identifier] then
                Dead[Identifier] = Animal
            end
        end
    end
end

function Module.Function:GetBodyData(Animal)
    if not Animal then return nil end

    local Organs = Animal:FindFirstChild("Organs")
    if not Organs then return nil end

    return {
		Head = Organs:FindFirstChild("Brain"),
		
		LeftLeg = Animal:FindFirstChildOfClass("MeshPart") or Animal:FindFirstChild("RootPart"),
		RightLeg = Animal:FindFirstChildOfClass("MeshPart") or Animal:FindFirstChild("RootPart"),
		LeftArm = Animal:FindFirstChildOfClass("MeshPart") or Animal:FindFirstChild("RootPart"),
		RightArm = Animal:FindFirstChildOfClass("MeshPart") or Animal:FindFirstChild("RootPart"),
		Torso = Organs:FindFirstChild("Heart") or Animal:FindFirstChild("RootPart"),
		
		HumanoidRootPart = Animal:FindFirstChild("RootPart"),
	}
end

function Module.Function:AnimalData(Animal, Parts)
    if not Animal then return nil end

    local Data = {
        Username = tostring(Animal),
        Displayname = Animal:GetAttribute("DisplayName"),
        Userid = math.random(-999999, 999999),
        Character = Animal,
        PrimaryPart = Parts.HumanoidRootPart,
        Humanoid = Parts.HumanoidRootPart,
        Head = Parts.Head,
        Torso = Parts.Torso,
        LeftArm = Parts.LeftArm or Parts.HumanoidRootPart,
        LeftLeg = Parts.LeftLeg or Parts.HumanoidRootPart,
        RightArm = Parts.RightArm or Parts.HumanoidRootPart,
        RightLeg = Parts.RightLeg or Parts.HumanoidRootPart,
        BodyHeightScale = 1,
        RigType = 0,
        Teamname = "Animals",
        Toolname = "Unknown",
        Whitelisted = false,
        Archenemies = false,
        Aimbot_Part = Parts.Head,
        Aimbot_TP_Part = Parts.Head,
        Triggerbot_Part = Parts.Head,
        Health = 100,
        MaxHealth = 100,
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

    return tostring(Animal), Data
end

function Module.Function.Render()
    if not Library.Flags["Render Dead"] then return end 

    for _, Animal in pairs(Module.Stored.Dead) do
        if Animal and Animal:FindFirstChild("RootPart") then
            local HumanoidRootPart = Animal:FindFirstChild("RootPart")
            if Library.Flags["Render Dead"] then
                local RealName

                if Library.Flags["Display Gender"] then
                    RealName = "Dead ".. Animal:GetAttribute("Sex").. " ".. Animal:GetAttribute("DisplayName")
                else
                    RealName = "Dead ".. Animal:GetAttribute("DisplayName")
                end
                local Screen, OnScreen = Camera:WorldToScreenPoint(HumanoidRootPart.Position)

                if OnScreen then
                    DrawingImmediate.OutlinedText(Screen, 14, Library.Flags["Name Color"].Color, Library.Flags["Name Color"].Alpha, RealName, true, "Proggy")
                end
            end            
        end
    end
end

function Module.Function.PostLocal()
    local Seen = {}

    for _, Entity in Module.Stored.Entities do
        local HumanoidRootPart = Entity:FindFirstChild("RootPart")
        if HumanoidRootPart and Entity.Parent then
            local Key = tostring(Entity)
            local Parts = Module.Function:GetBodyData(Entity)

            if not Parts or not Parts.Head or not Parts.HumanoidRootPart then
                continue
            end

            if Parts and Parts.Head and Parts.HumanoidRootPart then
                if not Module.Added[Key] then
                    local ID, Data = Module.Function:AnimalData(Entity, Parts)

                    if ID and Data then
                        add_model_data(Data, ID)
                        Module.Added[ID] = Entity
                    end
                else
                    if Library.Flags["Display Gender"] then
                        edit_model_data({ Displayname = Entity:GetAttribute("Sex").. " ".. Entity:GetAttribute("DisplayName") }, Key)
                    end
                end
                Seen[Key] = true
            end
        end
    end

    for Key, Model in pairs(Module.Added) do
        local HumanoidRootPart = Model:FindFirstChild("RootPart")
        if not HumanoidRootPart or not Seen[Key] then
            remove_model_data(Key)
            Module.Added[Key] = nil
        end
    end
end

-- // Initalize \\ --
Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
task.spawn(function() while true do task.wait(0.8) Module.Function:Cache() end end)
RunService.PostLocal:Connect(Module.Function.PostLocal)
RunService.Render:Connect(Module.Function.Render)
