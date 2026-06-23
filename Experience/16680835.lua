local Library = loadfile("Source.lua")()
local StyleWin = Library:StyleWindow()
local ConfigWin = Library:ConfigWindow()
Library:NavBar(Library.Windows[1], StyleWin, ConfigWin)

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Notoriety", Size = Vector2.new(550, 622)})

local MainTab = Window:Page({Name = "Main", Columns = 2})
local EntitiesSection = MainTab:Section({Name = "Entities", Side = 1})
local WeaponSection = MainTab:Section({Name = "Weapon", Side = 2})
local PlayerSection = MainTab:Section({Name = "Player", Side = 2})

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

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

EntitiesSection:Toggle({
    Name = "Render Citizens",
    Flag = "Render Citizens",
    Default = false,
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

            for Key, Model in pairs(Module.Stored.Entities) do
                if Model then
                    remove_model_data(Key)
                    Module.Stored.Entities[Key] = nil
                end
            end
        end
    end
})

EntitiesSection:Toggle({
    Name = "Render Police",
    Flag = "Render Police",
    Default = false,
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

            for Key, Model in pairs(Module.Stored.Entities) do
                if Model then
                    remove_model_data(Key)
                    Module.Stored.Entities[Key] = nil
                end
            end
        end
    end
})

--

WeaponSection:Toggle({ Name = "Loop Primary Ammunition", Flag = "Loop Primary", Default = false, Callback = function(Value) end })
WeaponSection:Toggle({ Name = "Loop Secondary Ammunition", Flag = "Loop Secondary", Default = false, Callback = function(Value) end })
WeaponSection:Toggle({ Name = "Loop Gadget Ammunition", Flag = "Loop Gadget", Default = false, Callback = function(Value) end })

-- 

PlayerSection:Toggle({ Name = "Loop Stamina", Flag = "Loop Stamina", Default = false, Callback = function(Value) end })

-- // Model Data \\ --

function Module.Function:GetEntityParts(Model)
	if not Model then return nil end

	return {
		Head = Model:FindFirstChild("Head"),
		UpperTorso = Model:FindFirstChild("UpperTorso"),
		LowerTorso = Model:FindFirstChild("LowerTorso"),
		
		LeftUpperArm = Model:FindFirstChild("LeftUpperArm"),
		LeftLowerArm = Model:FindFirstChild("LeftLowerArm"),
		LeftHand = Model:FindFirstChild("LeftHand"),
		
		RightUpperArm = Model:FindFirstChild("RightUpperArm"),
		RightLowerArm = Model:FindFirstChild("RightLowerArm"),
		RightHand = Model:FindFirstChild("RightHand"),
		
		LeftUpperLeg = Model:FindFirstChild("LeftUpperLeg"),
		LeftLowerLeg = Model:FindFirstChild("LeftLowerLeg"),
		LeftFoot = Model:FindFirstChild("LeftFoot"),
		
		RightUpperLeg = Model:FindFirstChild("RightUpperLeg"),
		RightLowerLeg = Model:FindFirstChild("RightLowerLeg"),
		RightFoot = Model:FindFirstChild("RightFoot"),
		
		LeftLeg = Model:FindFirstChild("Left Leg"),
		RightLeg = Model:FindFirstChild("Right Leg"),
		LeftArm = Model:FindFirstChild("Left Arm"),
		RightArm = Model:FindFirstChild("Right Arm"),
		Torso = Model:FindFirstChild("Torso"),
		
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
		Torso = Parts.Torso or Parts.UpperTorso,
		UpperTorso = Parts.UpperTorso,
		LowerTorso = Parts.LowerTorso,
		LeftArm = Parts.LeftArm or Parts.LeftUpperArm,
		LeftLeg = Parts.LeftLeg or Parts.LeftUpperLeg,
		RightArm = Parts.RightArm or Parts.RightUpperArm,
		RightLeg = Parts.RightLeg or Parts.RightUpperLeg,
		LeftUpperArm = Parts.LeftUpperArm,
		LeftLowerArm = Parts.LeftLowerArm,
		LeftHand = Parts.LeftHand,
		RightUpperArm = Parts.RightUpperArm,
		RightLowerArm = Parts.RightLowerArm,
		RightHand = Parts.RightHand,
		LeftUpperLeg = Parts.LeftUpperLeg,
		LeftLowerLeg = Parts.LeftLowerLeg,
		LeftFoot = Parts.LeftFoot,
		RightUpperLeg = Parts.RightUpperLeg,
		RightLowerLeg = Parts.RightLowerLeg,
		RightFoot = Parts.RightFoot,
		BodyHeightScale = 1,
		RigType = 0,
		Toolname = "Unknown",
		Teamname = Model.Name,
		Whitelisted = false,
		Archenemies = false,
		Aimbot_Part = Parts.Head,
		Aimbot_TP_Part = Parts.Head,
		Triggerbot_Part = Parts.Head,
		Health = Health,
		MaxHealth = MaxHealth,
		body_parts_data = {
			{ name = "LowerTorso", part = Parts.LowerTorso },
			{ name = "LeftUpperLeg", part = Parts.LeftUpperLeg },
			{ name = "LeftLowerLeg", part = Parts.LeftLowerLeg },
			{ name = "RightUpperLeg", part = Parts.RightUpperLeg },
			{ name = "RightLowerLeg", part = Parts.RightLowerLeg },
			{ name = "LeftUpperArm", part = Parts.LeftUpperArm },
			{ name = "LeftLowerArm", part = Parts.LeftLowerArm },
			{ name = "RightUpperArm", part = Parts.RightUpperArm },
			{ name = "RightLowerArm", part = Parts.RightLowerArm },
		},
		full_body_data = {
			{ name = "Head", part = Parts.Head },
			{ name = "UpperTorso", part = Parts.UpperTorso },
			{ name = "LowerTorso", part = Parts.LowerTorso },
			{ name = "HumanoidRootPart", part = Parts.HumanoidRootPart },
			{ name = "LeftUpperArm", part = Parts.LeftUpperArm },
			{ name = "LeftLowerArm", part = Parts.LeftLowerArm },
			{ name = "LeftHand", part = Parts.LeftHand },
			{ name = "RightUpperArm", part = Parts.RightUpperArm },
			{ name = "RightLowerArm", part = Parts.RightLowerArm },
			{ name = "RightHand", part = Parts.RightHand },
			{ name = "LeftUpperLeg", part = Parts.LeftUpperLeg },
			{ name = "LeftLowerLeg", part = Parts.LeftLowerLeg },
			{ name = "LeftFoot", part = Parts.LeftFoot },
			{ name = "RightUpperLeg", part = Parts.RightUpperLeg },
			{ name = "RightLowerLeg", part = Parts.RightLowerLeg },
			{ name = "RightFoot", part = Parts.RightFoot },
		}
	}

	return tostring(Model), Data
end

function Module.Function:ScanEntities(Table)
    for _, Path in ipairs(Module.Paths) do
        for _, Entity in ipairs(Path:GetChildren()) do
            if not Entity or Entity.ClassName ~= "Model" or Entity == LocalPlayer.Character then continue end
            if not Module.Function:Validated(Entity) then continue end

            local Invalid = false
            for _, Player in ipairs(Players:GetChildren()) do
                if Player.Character == Entity then
                    Invalid = true
                    break
                end
            end
            if Invalid then continue end

            local Key = tostring(Entity)
            local Parts = Module.Function:GetEntityParts(Entity)

            if not Parts or not Parts.HumanoidRootPart then continue end

            local Humanoid = Entity:FindFirstChildOfClass("Humanoid")

            if not Module.Stored.Entities[Key] then
                local ID, Data = Module.Function:GetEntityData(Entity, Parts)
                if ID and Data then
                    if add_model_data(Data, ID) then
                        Module.Stored.Entities[ID] = Entity
                    end
                end
            else
                if Humanoid then
                    edit_model_data({ Health = Humanoid.Health }, Key)
                end
            end

            Table[Key] = true
        end
    end
end

task.spawn(function()
    while true do
        if not LocalPlayer then return end

        local Seen = {}

        for Key, Model in pairs(Module.Stored.Entities) do
            if not Model or not Model.Parent then
                remove_model_data(Key)
                Module.Stored.Entities[Key] = nil
                continue
            end

            if not Seen[Key] then
                local HumanoidRootPart = Model:FindFirstChild("HumanoidRootPart")
                if not HumanoidRootPart then
                    remove_model_data(Key)
                    Module.Stored.Entities[Key] = nil
                end
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

PlayerSection:Button({ Name = "Secure Bags", Callback = function() Module.Function:TeleportBags() end })
Library:Settings()
RunService.PostLocal:Connect(Module.Function.AmmunitionLoop)
