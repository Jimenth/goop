-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local Module = {
    Function = {},

    Game = {
        Citizens = Workspace:FindFirstChild("Citizens"),
        Police = Workspace:FindFirstChild("Police"),

        Bags = Workspace:FindFirstChild("Bags"),
        BagArea = Workspace:FindFirstChild("BagSecuredArea")
    },
    
    Stored = {
        Entities = {},
        Citizen = {},
        Police = {}
    },

    Paths = {}
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Notoriety", Size = Vector2.new(550, 622)})

local MainTab = Window:Page({Name = "Main", Columns = 2})
local EntitiesSection = MainTab:Section({Name = "Entities", Side = 1})
local WeaponSection = MainTab:Section({Name = "Weapon", Side = 2})
local PlayerSection = MainTab:Section({Name = "Player", Side = 2})

-- // Entity Section \\ --

EntitiesSection:Toggle({Name = "Render Citizens", Flag = "Render Citizens", Default = false,
    Callback = function(Value)
        if Value then
            if not table.find(Module.Paths, Module.Game.Citizens) then
                table.insert(Module.Paths, Module.Game.Citizens)
            end
        else
            local Index = table.find(Module.Paths, Module.Game.Citizens)
            if Index then
                table.remove(Module.Paths, Index)
            end

            for Key, Entry in Module.Stored.Entities do
                if Entry then
                    remove_model_data(Key)
                    Module.Stored.Entities[Key] = nil
                end
            end
        end
    end
})

EntitiesSection:Toggle({Name = "Target Citizens", Flag = "Target Citizens", Default = false, Callback = function(Value) end })

EntitiesSection:Separator()

EntitiesSection:Toggle({Name = "Render Police", Flag = "Render Police", Default = false,
    Callback = function(Value)
        if Value then
            if not table.find(Module.Paths, Module.Game.Police) then
                table.insert(Module.Paths, Module.Game.Police)
            end
        else
            local Index = table.find(Module.Paths, Module.Game.Police)
            if Index then
                table.remove(Module.Paths, Index)
            end

            for Key, Entry in Module.Stored.Entities do
                if Entry then
                    remove_model_data(Key)
                    Module.Stored.Entities[Key] = nil
                end
            end
        end
    end
})

EntitiesSection:Toggle({Name = "Target Police", Flag = "Target Police", Default = true, Callback = function(Value) end })

-- // Weapon Section \\ --

WeaponSection:Toggle({ Name = "Loop Primary Ammunition", Flag = "Loop Primary", Default = false, Callback = function(Value) end })
WeaponSection:Toggle({ Name = "Loop Secondary Ammunition", Flag = "Loop Secondary", Default = false, Callback = function(Value) end })
WeaponSection:Toggle({ Name = "Loop Gadget Ammunition", Flag = "Loop Gadget", Default = false, Callback = function(Value) end })

-- // Player Section \\ --

PlayerSection:Toggle({ Name = "Loop Stamina", Flag = "Loop Stamina", Default = false, Callback = function(Value) end })

-- // Model Data \\ --

function Module.Function:GetEntityParts(Model)
	if not Model then return nil end

	return {
        Head = Model:FindFirstChild("Head") or Model:FindFirstChild("HumanoidRootPart"),
		LeftLeg = Model:FindFirstChild("Left Leg") or Model:FindFirstChild("HumanoidRootPart"),
		RightLeg = Model:FindFirstChild("Right Leg") or Model:FindFirstChild("HumanoidRootPart"),
		LeftArm = Model:FindFirstChild("Left Arm") or Model:FindFirstChild("HumanoidRootPart"),
		RightArm = Model:FindFirstChild("Right Arm") or Model:FindFirstChild("HumanoidRootPart"),
		Torso = Model:FindFirstChild("Torso") or Model:FindFirstChild("HumanoidRootPart"),
		
		HumanoidRootPart = Model:FindFirstChild("HumanoidRootPart"),
	}
end

function Module.Function:Validated(Model)
	if not Model or Model.ClassName ~= "Model" then return false end
	
	local Humanoid = Model:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return false end
	
	local Parts = Module.Function:GetEntityParts(Model)
	if not Parts or not Parts.HumanoidRootPart then return false end
	
	return true
end

function Module.Function:ShouldTarget(Model)
    if Model.Parent == Module.Game.Citizens and not Library.Flags["Target Citizens"] then
        return true
    elseif Model.Parent == Module.Game.Police and not Library.Flags["Target Police"] then
        return true
    end

    return false
end

function Module.Function:GetEntityData(Model, Parts)
	if not Model or not Parts then return nil, nil end

	local Humanoid = Model:FindFirstChildOfClass("Humanoid")
	local Health = Humanoid and Humanoid.Health or 100
	local MaxHealth = Humanoid and Humanoid.MaxHealth or 100

	local Data = {
		Username = tostring(Model),
		Displayname = Model.Name,
		Userid = -1,
		Character = Model,
		PrimaryPart = Model.PrimaryPart or Parts.HumanoidRootPart,
		Humanoid = Humanoid or Model.PrimaryPart,
		Head = Parts.Head,
		Torso = Parts.Torso,
		UpperTorso = Parts.Torso,
		LowerTorso = Parts.Torso,
		LeftArm = Parts.LeftArm,
		LeftLeg = Parts.LeftLeg,
		RightArm = Parts.RightArm,
		RightLeg = Parts.RightLeg,
		LeftUpperArm = Parts.LeftArm,
		LeftLowerArm = Parts.LeftArm,
		LeftHand = Parts.LeftArm,
		RightUpperArm = Parts.RightArm,
		RightLowerArm = Parts.RightArm,
		RightHand = Parts.RightArm,
		LeftUpperLeg = Parts.LeftLeg,
		LeftLowerLeg = Parts.LeftLeg,
		LeftFoot = Parts.LeftLeg,
		RightUpperLeg = Parts.RightLeg,
		RightLowerLeg = Parts.RightLeg,
		RightFoot = Parts.RightLeg,
		BodyHeightScale = 1,
		RigType = 0,
		Toolname = "Unknown",
		Teamname = Model.Name,
		Whitelisted = Module.Function:ShouldTarget(Model),
		Archenemies = false,
		Aimbot_Part = Parts.Head,
		Aimbot_TP_Part = Parts.Head,
		Triggerbot_Part = Parts.Head,
		Health = Health,
		MaxHealth = MaxHealth,
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

	return tostring(Model), Data
end

function Module.Function:ScanEntities(Table)
    for _, Path in Module.Paths do
        for _, Entity in Path:GetChildren() do
            if not Entity or Entity.ClassName ~= "Model" or Entity == LocalPlayer.Character then continue end

            local Key = tostring(Entity)
            local Cached = Module.Stored.Entities[Key]

            if Cached then
                if Cached.Humanoid then
                    edit_model_data({ Health = Cached.Humanoid.Health }, Key)
                    edit_model_data({ Whitelisted = Module.Function:ShouldTarget(Entity) }, Key)
                end
                Table[Key] = true
                continue
            end

            local Invalid = false
            for _, Player in Players:GetChildren() do
                if Player.Character == Entity then
                    Invalid = true
                    break
                end
            end
            if Invalid then continue end

            local Humanoid = Entity:FindFirstChildOfClass("Humanoid")
            if not Humanoid then continue end

            local Parts = Module.Function:GetEntityParts(Entity)
            if not Parts or not Parts.HumanoidRootPart then continue end

            local ID, Data = Module.Function:GetEntityData(Entity, Parts)
            if ID and Data and add_model_data(Data, ID) then
                Module.Stored.Entities[ID] = {
                    Model = Entity,
                    Parts = Parts,
                    Humanoid = Humanoid,
                }
            end

            Table[Key] = true
        end
    end
end

task.spawn(function()
    while true do
        if not LocalPlayer then return end

        local Seen = {}

        for Key, Entry in Module.Stored.Entities do
            local Model = Entry.Model
            if not Model or not Model.Parent or not Model:FindFirstChild("HumanoidRootPart") then
                remove_model_data(Key)
                Module.Stored.Entities[Key] = nil
            end
        end

        Module.Function:ScanEntities(Seen)
        task.wait(1)
    end
end)

-- // Functions \\ --

function Module.Function.AmmunitionLoop()
    if not LocalPlayer then return nil end

    local Character = LocalPlayer.Character
    if not Character then return nil end 

    if Library.Flags["Loop Primary"] then
        local Maximum = Character:FindFirstChild("PrimaryAmmoMax") and Character:FindFirstChild("PrimaryAmmoMax"):FindFirstChild("MagCapacity")
        if not Maximum then return end

        local Current = Character:FindFirstChild("PrimaryAmmo")
        if not Current then return end

        if Maximum.Value > 0 then
            Current.Value = Maximum.Value
        end
    end

    if Library.Flags["Loop Secondary"] then
        local Maximum = Character:FindFirstChild("SecondaryAmmoMax") and Character:FindFirstChild("SecondaryAmmoMax"):FindFirstChild("MagCapacity")
        if not Maximum then return end

        local Current = Character:FindFirstChild("SecondaryAmmo")
        if not Current then return end

        if Maximum.Value > 0 then
            Current.Value = Maximum.Value
        end
    end

    if Library.Flags["Loop Gadget"] then
        local Maximum = Character:FindFirstChild("GadgetAmmoMax") and Character:FindFirstChild("GadgetAmmoMax"):FindFirstChild("MagCapacity")
        if not Maximum then return end

        local Current = Character:FindFirstChild("GadgetAmmo")
        if not Current then return end

        if Maximum.Value > 0 then
            Current.Value = Maximum.Value
        end
    end

    if Library.Flags["Loop Stamina"] then
        local Maximum = Character:FindFirstChild("MaxStamina")
        if not Maximum then return end

        local Current = Character:FindFirstChild("Stamina")
        if not Current then return end

        if Maximum.Value > 0 then
            Current.Value = Maximum.Value
        end
    end
end

function Module.Function:TeleportBags()
    if not Module.Game.BagArea then return end

    for _, Bag in Module.Game.Bags:GetChildren() do
        if Bag then
            local Object = Bag:FindFirstChildOfClass("UnionOperation")
            local TargetPosition = Module.Game.BagArea:FindFirstChildOfClass("Part").Position
            if Object and Object.Name == "MoneyBag" then
                Object.Position = TargetPosition
            end
        end
    end
end

-- // Initalize \\ --

Library:Watermark("Goop")
PlayerSection:Button({ Name = "Secure Bags", Callback = function() Module.Function:TeleportBags() end })
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
RunService.PostLocal:Connect(Module.Function.AmmunitionLoop)