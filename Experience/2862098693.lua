local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Module = {
    Function = {},

    Game = {
        Dropped = Workspace:FindFirstChild("DroppedItems"),
        Vehicles = Workspace:FindFirstChild("Vehicles"),
        Zones = Workspace:FindFirstChild("AiZones"),
        Exits = Workspace:FindFirstChild("NoCollision") and Workspace.NoCollision:FindFirstChild("ExitLocations")
    },
    
    Stored = {
        Zoom = false,
        Original = {
            Recoil = {},
            Spread = {},
            FieldOfView = nil,
        },

        Cache = {
            Drops  = {},
            Corpses = {},
            Vehicles = {},
            Exits = {},
            AI = {},
            Players = {},
            Humanoid = {},
            Health = {}
        },

        Client = {
            Character = nil,
            HumanoidRootPart = nil,
            Position = Vector3.new(0, 0, 0)
        }
    }
}

local Library = loadfile("Source.lua")()
local Offsets = loadfile("Offsets.lua")()
local Window = Library:Window({Name = "Goop | Project Delta", Size = Vector2.new(550, 600)})

local AimingTab = Window:Page({Name = "Aiming & Ballistics", Columns = 2})
local VisualsTab = Window:Page({Name = "Visuals", Columns = 2})
Library:Settings()

local BallisticSection = AimingTab:Section({Name = "Ballistics", Side = 2})
BallisticSection:Toggle({Name = "Modify Recoil", Flag = "No Recoil", Default = false, Callback = function(Value) end})
BallisticSection:Slider({Name = "Recoil Percentage", Flag = "Recoil Amount", Min = 0, Max = 100, Default = 100, Callback = function(Value) end})
BallisticSection:Toggle({Name = "Modify Drop", Flag = "No Drop", Default = false, Callback = function(Value) end})
BallisticSection:Slider({Name = "Drop Percentage", Flag = "Drop Amount", Min = 0, Max = 100, Default = 100, Callback = function(Value) end})

--

local WorldSection = VisualsTab:Section({Name = "World", Side = 1})
local GameSection = VisualsTab:Section({Name = "Game", Side = 12})
WorldSection:Toggle({Name = "Render Drops", Flag = "Render Drops", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Drop", Flag = "Drop Color", Default = Color3.fromRGB(255, 255, 255), DefaultAlpha = 1, Callback = function(Color) end})
WorldSection:Slider({Name = "Maximum Render", Flag = "Drop Render", Min = 0, Max = 1000, Default = 500, Callback = function(Value) end})
WorldSection:Dropdown({Name = "Item Filter", Flag = "Drop Filter", Multi = true, Options = {"Weapons", "Attachments", "Magazines", "Ammo", "Medical", "Armor", "Clothing", "Visors", "Optics", "Melee", "Grenades", "Deployables", "Food", "Keys", "Tools", "Materials", "Electronics", "Valuables", "Maps", "Special"}, Default = {1, 3}, Callback = function(Value) end})
WorldSection:Separator()
WorldSection:Toggle({Name = "Render Corpses", Flag = "Render Corpses", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Corpse", Flag = "Corpse Color", Default = Color3.fromRGB(255, 255, 255), DefaultAlpha = 1, Callback = function(Color) end})
WorldSection:Slider({Name = "Maximum Render", Flag = "Corpses Render", Min = 0, Max = 1000, Default = 500, Callback = function(Value) end})
WorldSection:Separator()
WorldSection:Toggle({Name = "Render Vehicles", Flag = "Render Vehicles", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Vehicle", Flag = "Vehicle Color", Default = Color3.fromRGB(255, 255, 255), DefaultAlpha = 1, Callback = function(Color) end})
WorldSection:Slider({Name = "Maximum Render", Flag = "Vehicles Render", Min = 0, Max = 1000, Default = 500, Callback = function(Value) end})
WorldSection:Separator()
WorldSection:Toggle({Name = "Render Exits", Flag = "Render Exits", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Exit", Flag = "Exit Color", Default = Color3.fromRGB(255, 255, 255), DefaultAlpha = 1, Callback = function(Color) end})
WorldSection:Slider({Name = "Maximum Render", Flag = "Exits Render", Min = 0, Max = 1000, Default = 500, Callback = function(Value) end})

GameSection:Toggle({Name = "Zoom", Flag = "Zoom", Default = false, Callback = function(Value) end}):KeyPicker({ Flag = "Zoom Key", Default = "Z", Callback = function() if not Library.Flags["Zoom"] then return nil end Module.Stored.Zoom = not Module.Stored.Zoom end})
GameSection:Slider({Name = "Zoom Amount", Flag = "Zoom Amount", Min = 0, Max = 90, Default = 25, Callback = function(Value) end})
GameSection:Separator()
GameSection:Toggle({Name = "Remove Screen Effects", Flag = "Remove Screen Effects", Default = false, Callback = function(Value) end})

-- 

local Interface = {
    Dimensions = {
        Width = 320,
        Height = 64,
    }
}

local Items = {
    ["Weapons"] = {
        "AKM",
        "AKMN",
        "AsVal",
        "FAL",
        "GoldenMakarov",
        "IZh81",
        "IZh12",
        "KPVT",
        "M4",
        "Makarov",
        "MK23",
        "MP443",
        "MP5SD",
        "Mosin",
        "PKM",
        "PPSH41",
        "R700",
        "RPG7",
        "Saiga12",
        "SKS",
        "SVD",
        "TFZ98S",
        "TOZ106",
        "TT33",
        "VZ61",
        "YakB",
        "B8V20",
        "ADAR15",
        "M9Fade"
    },

    ["Attachments"] = {
        "ACOG",
        "DAGR",
        "DV2",
        "ELCAN",
        "FlashHiderAKM",
        "FlashHiderFAL",
        "FlashHiderKAC",
        "FlashHiderM4",
        "FlashHiderSVD",
        "Flashlight",
        "FrontAKMN",
        "FrontAsVal",
        "FrontFAL",
        "FrontIZh12",
        "FrontIZh81",
        "FrontM4",
        "FrontMK12",
        "FrontPKM",
        "FrontRomanianAKMN",
        "FrontSKS",
        "FrontSVD",
        "FrontSaiga",
        "FrontTimberwolf",
        "FrontADAR",
        "GoldenDV2",
        "HandleAKMN",
        "HandleAsVal",
        "HandleFAL",
        "HandleM4",
        "HandleRK3AKMN",
        "HoloSight",
        "ImprFrontAKM",
        "ImprHandleAKM",
        "ImprStockAKM",
        "KACSuppressor",
        "LaserPointer",
        "LPVO",
        "MuzzleBrakeAKM",
        "OKP7",
        "OilCanSuppressor",
        "PBS1",
        "PEQ15",
        "PSO1",
        "PistolMuzzleBrake",
        "PolymerStockAKMN",
        "PolymerStockFAL",
        "PuScope",
        "Scope6X",
        "SniperScope",
        "SOCOM556",
        "SRO",
        "StockA5",
        "StockAKMN",
        "StockAsVal",
        "StockFAL",
        "StockIZh12",
        "StockIZh81",
        "StockM4",
        "StockMK12",
        "StockMP5",
        "StockPKM",
        "StockPPSH41",
        "StockPT1AKMN",
        "StockSKS",
        "StockSVD",
        "StockADAR",
        "T1Sight",
        "TacticalFrontAKMN",
        "TacticalFrontFAL",
        "TacticalFrontSKS",
        "TacticalFrontSVD",
        "TacticalStockSKS",
        "TacticalStockSVD",
        "TimberWolfSuppressor",
        "DefaultFrontMosin",
        "DefaultStockMosin"
    },

    ["Magazines"] = {
        "20Rnd556",
        "20rndFAL",
        "30rndFAL",
        "762x25MAG",
        "762x25Rnd71Mag",
        "762x25TTMAG",
        "762x39MAG",
        "762x39ImprMAG",
        "762x39Rnd75Mag",
        "762x54Rnd10Mag",
        "762x54Rnd20Mag",
        "9x18MakarovMAG",
        "9x18MakarovDrumMag",
        "9x18vzMag",
        "9x18vzDrumMag",
        "9x19MP443MAG",
        "9x19MP5MAG",
        "9x19MP5DrumMAG",
        "9x39Mag",
        "9x39Rnd30Mag",
        "AmmoBoxPKM100rnd",
        "Mag556",
        "Mag556Rnd100",
        "MagR700",
        "MagTFZ98",
        "MagTOZ106",
        "MK23ExtMag",
        "PMAG10rnd",
        "SaigaMag5rnd",
        "SaigaMag20rnd"
    },

    ["Ammo"] = {
        "12gaAP",
        "12gaBuckshot",
        "12gaFlechette",
        "12gaSlug",
        "338AP",
        "338T",
        "45AP",
        "45Tracer",
        "556x45AP",
        "556x45Tracer",
        "762x25AP",
        "762x25Tracer",
        "762x39AP",
        "762x39Tracer",
        "762x51AP",
        "762x51Tracer",
        "762x54AP",
        "762x54Tracer",
        "9x18AP",
        "9x18Tracer",
        "9x18Z",
        "9x19AP",
        "9x19Tracer",
        "9x39AP",
        "9x39Z",
        "PG7",
        "127x108Tracer",
        "145x114Tracer",
        "S8KO"
    },

    ["Medical"] = {
        "AI2",
        "AI4",
        "AA2",
        "Bandage",
        "Defib",
        "IFAK",
        "Rags",
        "WoundDressing",
        "SerumYellow",
        "SerumRed",
        "SerumGreen",
        "SerumPurple"
    },

    ["Armor"] = {
        "6B2",
        "6B23",
        "6B27",
        "6B43",
        "6B47",
        "6B5",
        "Altyn",
        "Attak5",
        "Bandoiler",
        "ConcealedVest",
        "DozerArmor",
        "FastMT",
        "HSPV",
        "IOTV4",
        "JPC",
        "Kulon",
        "LegArmor",
        "Lynx",
        "MotorcycleHelmet",
        "SSH68",
        "Smersh",
        "TORS",
        "TankCap",
        "Tortilla",
        "ZSh",
        "UNOVest",
        "UNOHelmet",
        "ScavKingVest",
        "ScavKingHelmet"
    },

    ["Clothing"] = {
        "Balaclava",
        "CamoPants",
        "CamoShirt",
        "CivilianPants",
        "CivilianShirt",
        "CombatGloves",
        "GhillieHood",
        "GhillieLegs",
        "GhillieTorso",
        "GorkaPants",
        "GorkaShirt",
        "HandWraps",
        "KneePads",
        "SewnMask",
        "SpecopsBackpack",
        "WastelandBackpack",
        "WastelandPants",
        "WastelandShirt",
        "SantaHat"
    },

    ["Visors"] = {
        "AltynVisor",
        "FastVisor",
        "LowCutVisor",
        "MaskaVisor",
        "MotorcycleHelmetVisor",
        "ZShVisor"
    },

    ["Optics"] = {
        "GP5",
        "GP5Filter",
        "HeadMount",
        "ONV9",
        "QuadNVG",
        "PN6K5",
        "SPSh44"
    },

    ["Melee"] = {
        "AnarchyTomahawk",
        "Cutlass",
        "Greatsword",
        "IceAxe",
        "IceDagger",
        "Karambit",
        "Kukri",
        "Longsword",
        "PlasmaNinjato",
        "Reapir",
        "Scythe",
        "TitanShield"
    },

    ["Grenades"] = {
        "f1",
        "M84",
        "RGD5",
        "RGO"
    },

    ["Deployables"] = {
        "Barricade",
        "GrenadeTrap",
        "MON50",
        "PMN2",
        "Sandbag"
    },

    ["Food"] = {
        "Beans",
        "BloxyCola",
        "CatfrogSoda",
        "ChocolateBar",
        "CondensedMilk",
        "KevCola",
        "MaxEnergy",
        "ResKola",
        "WaterBottle"
    },

    ["Keys"] = {
        "AirfieldTunnelsKey",
        "Apartment13Key",
        "Apartment21Key",
        "ATCKey",
        "B05Key",
        "CitySubstationtKey",
        "CraneKey",
        "DormA211Key",
        "DormB203Key",
        "EVACKey",
        "FactoryGarageKey",
        "FrigateKey",
        "FuelingStationKey",
        "HydroBasementKey",
        "LighthouseKey",
        "PoolKey",
        "VillageKey",
        "Villa1Key",
        "BlueCard",
        "OrangeCard",
        "RedCard",
        "KeyChain"
    },

    ["Tools"] = {
        "FlatScrewdriver",
        "Hammer",
        "Lighter",
        "PH2Screwdriver",
        "Wrench",
        "RepairKit"
    },

    ["Materials"] = {
        "AABattery",
        "AramidFabric",
        "Bolts",
        "CopperCoil",
        "CottonFabric",
        "DuctTape",
        "Fuze",
        "Gold50g",
        "Gunpowder",
        "LinenFabric",
        "Lvl4Plate",
        "MetalChunks",
        "Nails",
        "Nuts",
        "OilCan",
        "Planks",
        "RipstopFabric",
        "Rubles",
        "SteelPipe",
        "SuperGlue",
        "WeaponParts"
    },

    ["Electronics"] = {
        "CFan",
        "CPU",
        "GPU",
        "PDA",
        "PortableConsole",
        "PSU",
        "RAM",
        "SSD",
        "Smartphone"
    },

    ["Valuables"] = {
        "GoldWatch",
        "GoldenTicket",
        "SolterStatue"
    },

    ["Maps"] = {
        "EstonianBorderMap",
        "Map",
        "Pathfinder",
        "Radio"
    },

    ["Special"] = {
        "GiftTier1",
        "GiftTier2",
        "GiftTier3",
        "Immunster",
        "ImmunsterReactor",
        "ImmunsterWinter",
        "Snowball",
        "T12W",
        "TFZ0"
    }
}

function Module.Function:GetDistance2D(A, B)
    local DeltaX = A.X - B.X
    local DeltaY = A.Y - B.Y
    return math.sqrt(DeltaX * DeltaX + DeltaY * DeltaY)
end

function Module.Function:GetClosestEntity()
    local Entities = {}
    local MousePosition = getmouseposition()
    local ClosestEntity = nil
    local ClosestDistance = 100

    for _, Player in pairs(Module.Stored.Cache.Players) do
        table.insert(Entities, Player)
    end

    for _, AI in pairs(Module.Stored.Cache.AI) do
        table.insert(Entities, AI)
    end
    
    for _, Entity in pairs(Entities) do
        if Entity:IsA("Player") then
            if Entity ~= LocalPlayer and Entity.Character then
                local Character = Entity.Character
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                
                if HumanoidRootPart then
                    local Screen, OnScreen = Camera:WorldToScreenPoint(HumanoidRootPart.Position)
                    
                    if OnScreen then
                        local Distance = Module.Function:GetDistance2D(Vector2.new(MousePosition.X, MousePosition.Y), Vector2.new(Screen.X, Screen.Y))
                        
                        if Distance < ClosestDistance then
                            ClosestDistance = Distance
                            ClosestEntity = Entity
                        end
                    end
                end
            end
        elseif Entity:IsA("Model") then
            local HumanoidRootPart = Entity:FindFirstChild("HumanoidRootPart")
                
            if HumanoidRootPart then
                local Screen, OnScreen = Camera:WorldToScreenPoint(HumanoidRootPart.Position)
                    
                if OnScreen then
                    local Distance = Module.Function:GetDistance2D(Vector2.new(MousePosition.X, MousePosition.Y), Vector2.new(Screen.X, Screen.Y))
                        
                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        ClosestEntity = Entity
                    end
                end
            end
        end
    end
    
    return ClosestEntity
end

function Module.Function:GetWeapon(Character)
    if not Character then return "None" end

    local Instance = Character:FindFirstChild("Holding")
    
    if Instance and Instance.ClassName == "ObjectValue" and Instance.Value then
        if Instance.Value.Name and type(Instance.Value.Name) == "string" then
            return Instance.Value.Name
        end
    end

    return "None"
end

function Module.Function:GetClothing(Character)
    if not Character then return end
    local Mask, Head, Chestrig, Leg, Back = "None", "None", "None", "None", "None"

    local Clothing = Character:FindFirstChild("Clothing")
    if Clothing then
        local function Get(Name)
            local Object = Clothing:FindFirstChild(Name)
            return (Object and Object.Value and type(Object.Value.Name) == "string" and Object.Value.Name) or "None"
        end

        Mask = Get("ClothingMask")
        Head = Get("ClothingHeadware")
        Chestrig = Get("ClothingChestRig")
        Leg = Get("ClothingLegArmor")
        Back = Get("ClothingBackpack")
    end

    return Mask, Head, Chestrig, Leg, Back
end

function Module.Function:GetBodyParts(Model)
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

        HumanoidRootPart = Model:FindFirstChild("HumanoidRootPart"),
    }
end

function Module.Function:EntityData(Model, Parts)
	if not Model then return nil end 

	local Humanoid = Model:FindFirstChildOfClass("Humanoid")
	local Health = 100
	local MaxHealth = 100
	
	if Humanoid then
		Health = Humanoid.Health
		MaxHealth = Humanoid.MaxHealth
	end

	local Data = {
		Username = tostring(Model),
		Displayname = Model.Name,
		Userid = -1,
		Character = Model,
		PrimaryPart = Model.PrimaryPart or Parts.HumanoidRootPart,
		Humanoid = Humanoid or Model.PrimaryPart,
		Head = Parts.Head,
		Torso = Parts.UpperTorso,
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
		RigType = 1,
		Toolname = Model:FindFirstChildOfClass("Model").Name,
		Teamname = "AI",
		Whitelisted = false,
		Archenemies = true,
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

function Module.Function:GetPlayerData(Player)
	if not Player then return nil end

	local Character = Player.Character
	if not Character then return nil end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return nil end

	local Parts = Module.Function:GetBodyParts(Character)
	if not Parts then return nil end

	local Health = Humanoid.Health
	local MaxHealth = Humanoid.MaxHealth

	local Data = {
		Username = Player.Name,
		Displayname = Player.DisplayName,
		Userid = Player.UserId,

		Character = Character,
		PrimaryPart = Character.PrimaryPart,
		Humanoid = Humanoid,

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
		RigType = 1,
		Toolname = "Unknown",
		Teamname = Player.Team or "No Team",

		Whitelisted = false,
		Archenemies = false,

		Aimbot_Part = Parts.Head,
		Aimbot_TP_Part = Parts.Head,
		Triggerbot_Part = Parts.Head,

		Health = Health,
		MaxHealth = MaxHealth,

		body_parts_data = {
			{ name = "LowerTorso", part = Character:FindFirstChild("LowerTorso") },
			{ name = "LeftUpperLeg", part = Character:FindFirstChild("LeftUpperLeg") },
			{ name = "LeftLowerLeg", part = Character:FindFirstChild("LeftLowerLeg") },
			{ name = "RightUpperLeg", part = Character:FindFirstChild("RightUpperLeg") },
			{ name = "RightLowerLeg", part = Character:FindFirstChild("RightLowerLeg") },
			{ name = "LeftUpperArm", part = Character:FindFirstChild("LeftUpperArm") },
			{ name = "LeftLowerArm", part = Character:FindFirstChild("LeftLowerArm") },
			{ name = "RightUpperArm", part = Character:FindFirstChild("RightUpperArm") },
			{ name = "RightLowerArm", part = Character:FindFirstChild("RightLowerArm") },
		},

		full_body_data = {
			{ name = "Head", part = Character:FindFirstChild("Head") },
			{ name = "UpperTorso", part = Character:FindFirstChild("UpperTorso") },
			{ name = "LowerTorso", part = Character:FindFirstChild("LowerTorso") },
			{ name = "HumanoidRootPart", part = Character:FindFirstChild("HumanoidRootPart") },

			{ name = "LeftUpperArm", part = Character:FindFirstChild("LeftUpperArm") },
			{ name = "LeftLowerArm", part = Character:FindFirstChild("LeftLowerArm") },
			{ name = "LeftHand", part = Character:FindFirstChild("LeftHand") },

			{ name = "RightUpperArm", part = Character:FindFirstChild("RightUpperArm") },
			{ name = "RightLowerArm", part = Character:FindFirstChild("RightLowerArm") },
			{ name = "RightHand", part = Character:FindFirstChild("RightHand") },

			{ name = "LeftUpperLeg", part = Character:FindFirstChild("LeftUpperLeg") },
			{ name = "LeftLowerLeg", part = Character:FindFirstChild("LeftLowerLeg") },
			{ name = "LeftFoot", part = Character:FindFirstChild("LeftFoot") },

			{ name = "RightUpperLeg", part = Character:FindFirstChild("RightUpperLeg") },
			{ name = "RightLowerLeg", part = Character:FindFirstChild("RightLowerLeg") },
			{ name = "RightFoot", part = Character:FindFirstChild("RightFoot") },
		},
	}

	return tostring(Character), Data
end

function Module.Function:UpdateClient()
    local Character = LocalPlayer and LocalPlayer.Character
    if Character then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart and HumanoidRootPart.Parent then
            Module.Stored.Client.Character = Character
            Module.Stored.Client.HumanoidRootPart = HumanoidRootPart
            Module.Stored.Client.Position = HumanoidRootPart.Position
            return true
        end
    end
    Module.Stored.Client.Character = nil
    Module.Stored.Client.HumanoidRootPart = nil
    return false
end

function Module.Function:ItemValid(Name)
    local Selected = Library.Flags["Drop Filter"] and Library.Flags["Drop Filter"].Value or {}
    if #Selected == 0 then return true end

    local CategorySet = {}
    for _, Category in ipairs(Selected) do
        CategorySet[Category] = true
    end

    for Category in pairs(CategorySet) do
        local List = Items[Category]
        if List then
            for _, ItemName in ipairs(List) do
                if Name == ItemName then
                    return true
                end
            end
        end
    end

    return false
end

function Module.Function:Cache()
    if not Module.Function:UpdateClient() then return end
    if not Module.Stored.Client.Character then return end
    local ClientPosition = Module.Stored.Client.Position
    
    local function Process(Enabled, Storage, MaxDistance, Validator)
        if not Enabled then return end
        
        for Key, Data in pairs(Storage) do
            if not Key.Parent or not Data.Object or not Data.Object.Parent then Storage[Key] = nil elseif Validator and not Validator(Key) then Storage[Key] = nil elseif vector.magnitude(ClientPosition - Data.Object.Position) > MaxDistance then Storage[Key] = nil end
        end
    end
    
    if Library.Flags["Render Drops"] then
        local Maximum = Library.Flags["Drop Render"].Value
        Process(true, Module.Stored.Cache.Drops, Maximum, function(Drop) return Module.Function:ItemValid(Drop.Name) end)
        
        if Module.Game.Dropped then
            for _, Drop in ipairs(Module.Game.Dropped:GetChildren()) do
                if Drop.ClassName == "Model" and not Drop:FindFirstChild("Head") and not Module.Stored.Cache.Drops[Drop] then
                    local Object = Drop.PrimaryPart
                    if Object and Object:IsA("BasePart") and vector.magnitude(ClientPosition - Object.Position) <= Maximum and Module.Function:ItemValid(Drop.Name) then
                        Module.Stored.Cache.Drops[Drop] = { Item = Drop, Object = Object, Name = Drop.Name }
                    end
                end
            end
        end
    end
    
    if Library.Flags["Render Corpses"] then
        local Maximum = Library.Flags["Corpses Render"].Value
        Process(true, Module.Stored.Cache.Corpses, Maximum, nil)
        
        if Module.Game.Dropped then
            for _, Corpse in ipairs(Module.Game.Dropped:GetChildren()) do
                if Corpse:FindFirstChild("Head") and Corpse.ClassName == "Model" and not Module.Stored.Cache.Corpses[Corpse] then
                    local Object = Corpse.PrimaryPart
                    if Object and vector.magnitude(ClientPosition - Object.Position) <= Maximum then
                        Module.Stored.Cache.Corpses[Corpse] = {
                            Item = Corpse,
                            Object = Object,
                            Name = Corpse:GetAttribute("DisplayName") or Corpse.Name
                        }
                    end
                end
            end
        end
    end
    
    if Library.Flags["Render Vehicles"] then
        local Maximum = Library.Flags["Vehicles Render"].Value
        
        for Vehicle, Data in pairs(Module.Stored.Cache.Vehicles) do
            if not Vehicle.Parent then
                Module.Stored.Cache.Vehicles[Vehicle] = nil
            else
                local Body = Vehicle:FindFirstChild("Body")
                local Object = Body and Body.PrimaryPart
                if not Object or vector.magnitude(ClientPosition - Object.Position) > Maximum then
                    Module.Stored.Cache.Vehicles[Vehicle] = nil
                end
            end
        end
        
        for _, Vehicle in ipairs(Module.Game.Vehicles:GetChildren()) do
            if Vehicle.ClassName == "Model" and not Module.Stored.Cache.Vehicles[Vehicle] then
                local Body = Vehicle:FindFirstChild("Body")
                local Object = Body and Body.PrimaryPart
                if Object and vector.magnitude(ClientPosition - Object.Position) <= Maximum then
                    local Name = Vehicle.Name.. " [".. Vehicle:GetAttribute("VehicleType").. "]"
                    Module.Stored.Cache.Vehicles[Vehicle] = { Item = Vehicle, Object = Object, Name = Name }
                end
            end
        end
    end
    
    if Library.Flags["Render Exits"] then
        local Maximum = Library.Flags["Exits Render"].Value
        Process(true, Module.Stored.Cache.Exits, Maximum, nil)
        
        if Module.Game.Exits then
            for _, Exit in ipairs(Module.Game.Exits:GetChildren()) do
                if Exit.ClassName == "Part" and not Module.Stored.Cache.Exits[Exit] then
                    if vector.magnitude(ClientPosition - Exit.Position) <= Maximum then
                        Module.Stored.Cache.Exits[Exit] = {
                            Item = Exit,
                            Object = Exit,
                            Name = "Exit Location"
                        }
                    end
                end
            end
        end
    end
end

function Module.Function:Render()
    if not Module.Stored.Client.HumanoidRootPart then return end
    
    if Library.Flags["Render Drops"] then
        for _, Data in pairs(Module.Stored.Cache.Drops) do
            local Object = Data.Object
            if Object and Object.Parent then
                local Screen, OnScreen = Camera:WorldToScreenPoint(Object.Position)
                if OnScreen then
                    DrawingImmediate.OutlinedText(Screen, 13, Library.Flags["Drop Color"].Color, Library.Flags["Drop Color"].Alpha, Data.Name, true, "Proggy")
                end
            end
        end
    end

    if Library.Flags["Render Corpses"] then
        for _, Data in pairs(Module.Stored.Cache.Corpses) do
            local Object = Data.Object
            if Object and Object.Parent then
                local Screen, OnScreen = Camera:WorldToScreenPoint(Object.Position)
                if OnScreen then
                    DrawingImmediate.OutlinedText(Screen, 13, Library.Flags["Corpse Color"].Color, Library.Flags["Corpse Color"].Alpha, Data.Name..  "'s Corpse", true, "Proggy")
                end
            end
        end
    end

    if Library.Flags["Render Vehicles"] then
        for _, Data in pairs(Module.Stored.Cache.Vehicles) do
            local Object = Data.Object
            if Object and Object.Parent then
                local Screen, OnScreen = Camera:WorldToScreenPoint(Object.Position)
                if OnScreen then
                    DrawingImmediate.OutlinedText(Screen, 13, Library.Flags["Vehicle Color"].Color, Library.Flags["Vehicle Color"].Alpha, Data.Name, true, "Proggy")
                end
            end
        end
    end

    if Library.Flags["Render Exits"] then
        for _, Data in pairs(Module.Stored.Cache.Exits) do
            local Object = Data.Object
            if Object and Object.Parent then
                local Screen, OnScreen = Camera:WorldToScreenPoint(Object.Position)
                if OnScreen then
                    DrawingImmediate.OutlinedText(Screen, 13, Library.Flags["Exit Color"].Color, Library.Flags["Exit Color"].Alpha, Data.Name, true, "Proggy")
                end
            end
        end
    end
end

function Module.Function:CacheBallistics()
    Module.Stored.Original.FieldOfView = Camera.FieldOfView

    for _, Caliber in pairs(game.ReplicatedStorage.AmmoTypes:GetChildren()) do
        local Name = Caliber.Name
        if not Module.Stored.Original.Recoil[Name] then
            Module.Stored.Original.Recoil[Name] = {
                RecoilStrength = Caliber:GetAttribute("RecoilStrength"),
            }
        end
        if not Module.Stored.Original.Spread[Name] then
            Module.Stored.Original.Spread[Name] = {
                ProjectileDrop = Caliber:GetAttribute("ProjectileDrop"),
            }
        end
    end

    for _, Weapon in pairs(game.ReplicatedStorage.RangedWeapons:GetChildren()) do
        local Name = Weapon.Name
        if not Module.Stored.Original.Recoil[Name] then
            Module.Stored.Original.Recoil[Name] = {
                RecoilRecoveryTimeMod = Weapon:GetAttribute("RecoilRecoveryTimeMod"),
            }
        end
    end
end

task.spawn(function()
	while true do
		task.wait(0.5)

        local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
        local NoInsetGui = PlayerGui:FindFirstChild("NoInsetGui")
        local MainFrame = NoInsetGui:FindFirstChild("MainFrame")
        local ScreenEffects = MainFrame:FindFirstChild("ScreenEffects")

        if Library.Flags["Remove Screen Effects"] then
            memory.writeu8(ScreenEffects, Offsets.GuiObject.Visible, 0)
        else
            memory.writeu8(ScreenEffects, Offsets.GuiObject.Visible, 1)
        end

		Module.Function:Cache()
		local RecoilPct = (Library.Flags["No Recoil"] and (Library.Flags["Recoil Amount"] and Library.Flags["Recoil Amount"].Value or 0) or 100) / 100
		local DropPct = (Library.Flags["No Drop"] and (Library.Flags["Drop Amount"] and Library.Flags["Drop Amount"].Value or 0) or 100) / 100

        for _, Caliber in game.ReplicatedStorage.AmmoTypes:GetChildren() do
            local Original = Module.Stored.Original.Recoil[Caliber.Name]
            if Original and Original.RecoilStrength ~= nil then
                local Target = Original.RecoilStrength * RecoilPct
                if Caliber:GetAttribute("RecoilStrength") ~= Target then
                    Caliber:SetAttribute("RecoilStrength", Target)
                end
            end

            local OriginalDrop = Module.Stored.Original.Spread[Caliber.Name]
            if OriginalDrop and OriginalDrop.ProjectileDrop ~= nil then
                local Target = OriginalDrop.ProjectileDrop * DropPct
                if Caliber:GetAttribute("ProjectileDrop") ~= Target then
                    Caliber:SetAttribute("ProjectileDrop", Target)
                end
            end
        end

        for _, Weapon in pairs(game.ReplicatedStorage.RangedWeapons:GetChildren()) do
            local Original = Module.Stored.Original.Recoil[Weapon.Name]
            if Original and Original.RecoilRecoveryTimeMod ~= nil then
                local Target = Original.RecoilRecoveryTimeMod * RecoilPct
                if Weapon:GetAttribute("RecoilRecoveryTimeMod") ~= Target then
                    Weapon:SetAttribute("RecoilRecoveryTimeMod", Target)
                end
            end
        end

		local Seen = {}

		for _, Zone in Module.Game.Zones:GetChildren() do
			for _, NPC in ipairs(Zone:GetChildren()) do
				if typeof(NPC) ~= "Instance" or NPC.ClassName ~= "Model" then continue end

				local Humanoid = NPC:FindFirstChildOfClass("Humanoid")
				if not Humanoid then continue end

				local HumanoidRootPart = NPC:FindFirstChild("HumanoidRootPart")
				if not HumanoidRootPart then continue end

				if NPC.PrimaryPart ~= HumanoidRootPart then continue end

				local Parts = Module.Function:GetBodyParts(NPC)
				if not Parts or not Parts.HumanoidRootPart then continue end

				local Key = tostring(NPC)

				if not Module.Stored.Cache.AI[Key] then
					local ID, Data = Module.Function:EntityData(NPC, Parts)
					if ID and Data and ID == Key and add_model_data(Data, ID) then
						Module.Stored.Cache.AI[Key] = NPC
					end
				else
					edit_model_data({ Health = Humanoid.Health }, Key)
				end

				Seen[Key] = true
			end
		end

		for Index, Player in Players:GetChildren() do
			if not Player or Player == LocalPlayer then continue end

			local Character = Player.Character
			if not Character or Character == Module.Stored.Client.Character then continue end

			local Humanoid = Character:FindFirstChildOfClass("Humanoid")
			if not Humanoid then continue end

			local Parts = Module.Function:GetBodyParts(Character)
			if not Parts or not Parts.HumanoidRootPart then continue end

			local Key = tostring(Character)

			if is_team_check_active() then
				if Player.Team == LocalPlayer.Team then
					if Module.Stored.Cache.Players[Key] then
						remove_model_data(Key)
						Module.Stored.Cache.Players[Key] = nil
					end
				else
					if not Module.Stored.Cache.Players[Key] then
						local ID, Data = Module.Function:GetPlayerData(Player)
						if ID and Data and ID == Key and add_model_data(Data, ID) then
							Module.Stored.Cache.Players[Key] = Character
						end
					else
						edit_model_data({ Health = Humanoid.Health }, Key)
					end
					Seen[Key] = true
				end
			else
				if not Module.Stored.Cache.Players[Key] then
					local ID, Data = Module.Function:GetPlayerData(Player)
					if ID and Data and ID == Key and add_model_data(Data, ID) then
						Module.Stored.Cache.Players[Key] = Character
					end
				else
					edit_model_data({ Health = Humanoid.Health }, Key)
				end
				Seen[Key] = true
			end
		end

		for ID, Model in pairs(Module.Stored.Cache.AI) do
			if not Model or not Model.Parent or not Seen[ID] then
				remove_model_data(ID)
				Module.Stored.Cache.AI[ID] = nil
			end
		end

		for ID, Model in pairs(Module.Stored.Cache.Players) do
			if not Model or not Model.Parent or not Seen[ID] then
				remove_model_data(ID)
				Module.Stored.Cache.Players[ID] = nil
			end
		end
	end
end)

function Module.Function:SetFOV(Value)
    Camera.FieldOfView = Value
end

function Module.Function:DrawIndicator(Position, Character, Transparency)
    local X = Position.X
    local Y = Position.Y
    local Width = Interface.Dimensions.Width
    local Height = Interface.Dimensions.Height
    local C = Library.Appearance.Coloring
    local ContentX = X + 4
    local ContentY = Y + 4
    local ContentW = Width - 8
    local ContentH = Height - 8

    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(Width, Height), C.Black, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(Width - 2, Height - 2), C.Border, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width - 4, Height - 4), C.Background, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width - 4, 2), C.Accent, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(ContentX, ContentY), Vector2.new(ContentW, ContentH), C.Background, Transparency)

    local WeaponName = Module.Function:GetWeapon(Character) or "None"
    if typeof(WeaponName) ~= "string" then WeaponName = tostring(WeaponName or "") end
    if WeaponName == "" or WeaponName == "None" then WeaponName = "No Weapon" end
    DrawingImmediate.OutlinedText(Vector2.new(X + Width / 2, ContentY + 12), Library.Appearance.FontSize, C.White, Transparency, WeaponName, true, Library.Appearance.Font)

    local CurrentHealth = 0
    local MaxHealth = 100
    if Character then
        local Hum = Module.Stored.Cache.Humanoid[Character]
        if not Hum or not Hum.Parent then
            Hum = Character:FindFirstChildOfClass("Humanoid")
            Module.Stored.Cache.Humanoid[Character] = Hum
        end
        if Hum then
            if Module.Stored.Cache.Health[Character] == nil then
                Module.Stored.Cache.Health[Character] = tonumber(Hum.MaxHealth) or 100
            end
            MaxHealth = Module.Stored.Cache.Health[Character] or 100
            CurrentHealth = tonumber(Hum.Health) or 0
        end
    end

    local Percent = math.clamp((MaxHealth == 0) and 0 or (CurrentHealth / MaxHealth), 0, 1)
    local BarW = ContentW - 18
    local BarH = Library.Appearance.FontSize + 4
    local BarX = ContentX + 9
    local BarY = ContentY + ContentH - (BarH + 6)
    local FillW = math.floor((BarW - 4) * Percent)
    if Percent > 0 and FillW < 2 then FillW = 2 end

    local LocalCharacter = LocalPlayer.Character
    if LocalCharacter then
        local LocalHumanoid = LocalCharacter:FindFirstChildOfClass("Humanoid")
        if LocalHumanoid then
            local LocalHealth = LocalHumanoid.Health
            local Indication = "Even"
            local IndicationColor = C.Dim

            if LocalHealth > CurrentHealth then
                Indication = "You're Winning!"
                IndicationColor = Color3.fromRGB(0, 255, 0)
            elseif LocalHealth < CurrentHealth then
                Indication = "You're Losing!"
                IndicationColor = Color3.fromRGB(255, 0, 0)
            end

            DrawingImmediate.OutlinedText(
                Vector2.new(BarX, BarY - 15),
                Library.Appearance.FontSize, IndicationColor, Transparency,
                Indication, false, Library.Appearance.Font
            )
        end
    end

    DrawingImmediate.FilledRectangle(Vector2.new(BarX, BarY), Vector2.new(BarW, BarH), C.Black, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(BarX + 1, BarY + 1), Vector2.new(BarW - 2, BarH - 2), C.Border, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(BarX + 2, BarY + 2), Vector2.new(BarW - 4, BarH - 4), C.Background, Transparency)
    if FillW > 0 then
        DrawingImmediate.FilledRectangle(Vector2.new(BarX + 2, BarY + 2), Vector2.new(FillW, BarH - 4), C.AccentDark, Transparency)
        DrawingImmediate.FilledRectangle(Vector2.new(BarX + 2, BarY + 2), Vector2.new(math.max(FillW - 2, 0), BarH - 4), C.Accent, Transparency)
    end

    local HealthText = tostring(math.floor(CurrentHealth)) .. "/" .. tostring(MaxHealth)
    DrawingImmediate.OutlinedText(
        Vector2.new(BarX + BarW / 2, BarY + (BarH / 2) - 5),
        Library.Appearance.FontSize, C.White, Transparency,
        HealthText, true, Library.Appearance.Font
    )

    local Kills = 0
    local Deaths = 0
    if game.ReplicatedStorage:FindFirstChild("Players") and Character then
        local Name = nil
        for _, Player in ipairs(game:GetService("Players"):GetChildren()) do
            if Player.Character == Character then
                Name = Player.Name
                break
            end
        end

        if Name then
            local PlayerFolder = game.ReplicatedStorage:FindFirstChild("Players"):FindFirstChild(Name)
            if PlayerFolder then
                local Stats = PlayerFolder:FindFirstChild("Status") and PlayerFolder.Status:FindFirstChild("Journey") and PlayerFolder.Status.Journey:FindFirstChild("Statistics")
                if Stats then
                    Kills = Stats:GetAttribute("Kills") or 0
                    Deaths = Stats:GetAttribute("Deaths") or 0
                end
            end
        end
    end

    local Ratio = Deaths == 0 and string.format("%.2f", Kills) or string.format("%.2f", Kills / Deaths)

    local KDTextBounds = DrawingImmediate.GetTextBounds(Library.Appearance.Font, Library.Appearance.FontSize, "K/D: " .. Ratio)
    local KDX = BarX + BarW - KDTextBounds.X
    local KDY = BarY - 15

    DrawingImmediate.OutlinedText(
        Vector2.new(KDX, KDY),
        Library.Appearance.FontSize, C.White, Transparency,
        "K/D: " .. Ratio, false, Library.Appearance.Font
    )
end

function Module.Function:DrawClothing(Position, Character, Transparency)
    local X = Position.X
    local Y = Position.Y
    local Width = 400
    local Height = 70
    local C = Library.Appearance.Coloring
    local ContentX = X + 4
    local ContentY = Y + 4
    local ContentW = Width - 8
    local ContentH = Height - 8

    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(Width, Height), C.Black, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(Width - 2, Height - 2), C.Border, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width - 4, Height - 4), C.Background, Transparency)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width - 4, 2), C.Accent, Transparency) 
    DrawingImmediate.FilledRectangle(Vector2.new(ContentX, ContentY), Vector2.new(ContentW, ContentH), C.Background, Transparency)

    local Mask, Head, Chestrig, Leg, Back = Module.Function:GetClothing(Character)

    local BoxWidth = 70
    local BoxHeight = 30
    local Spacing = 6
    local StartX = ContentX + 9
    local LabelY = ContentY + 10
    local BoxY = ContentY + 22

    local function Shorten(String, Maximum)
        if #String <= Maximum then return String end
        return string.sub(String, 1, Maximum - 2) .. ".."
    end

    for Index, Item in ipairs({{Name = "Mask", Value = Mask or "None"}, {Name = "Helmet", Value = Head or "None"}, {Name = "Rig", Value = Chestrig  or "None"}, {Name = "Backpack", Value = Back or "None"}, {Name = "Legs", Value = Leg or "None"}}) do
        local BoxX = StartX + ((Index - 1) * (BoxWidth + Spacing))

        DrawingImmediate.OutlinedText(
            Vector2.new(BoxX + BoxWidth / 2, LabelY),
            Library.Appearance.FontSize, C.Dim, Transparency,
            Item.Name, true, Library.Appearance.Font
        )

        DrawingImmediate.FilledRectangle(Vector2.new(BoxX, BoxY), Vector2.new(BoxWidth, BoxHeight), C.Black, Transparency)
        DrawingImmediate.FilledRectangle(Vector2.new(BoxX + 1, BoxY + 1), Vector2.new(BoxWidth - 2, BoxHeight - 2), C.Border, Transparency)
        DrawingImmediate.FilledRectangle(Vector2.new(BoxX + 2, BoxY + 2), Vector2.new(BoxWidth - 4, BoxHeight - 4), C.Background, Transparency)

        DrawingImmediate.OutlinedText(
            Vector2.new(BoxX + BoxWidth / 2, BoxY + BoxHeight / 2 - 5),
            Library.Appearance.FontSize, C.White, Transparency,
            Shorten(Item.Value, 11), true, Library.Appearance.Font
        )
    end
end

Module.Function:CacheBallistics()
RunService.Render:Connect(function()
    Module.Function:Render()

    if Module.Stored.Zoom then
        memory.writef32(Camera, Offsets.Camera.FieldOfView, math.rad(Library.Flags["Zoom Amount"].Value))
    else
        memory.writef32(Camera, Offsets.Camera.FieldOfView, math.rad(Module.Stored.Original.FieldOfView))
    end
    
    local Entity = Module.Function:GetClosestEntity()
    if not Entity then return end
    
    local Target
    if Entity.ClassName == "Player" then
        if not Entity.Character then return end
        Target = Entity.Character
    elseif Entity.ClassName == "Model" then
        local HumanoidRootPart = Entity:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then return end
        Target = Entity
    else
        return
    end
    
    local ClothingWindowPosition = Vector2.new((Camera.ViewportSize.X / 2) - 200, Camera.ViewportSize.Y - Interface.Dimensions.Height - 180)
    Module.Function:DrawClothing(ClothingWindowPosition, Target, 1)
    
    local WindowPosition = Vector2.new((Camera.ViewportSize.X / 2) - (Interface.Dimensions.Width / 2), Camera.ViewportSize.Y - Interface.Dimensions.Height - 100)
    Module.Function:DrawIndicator(WindowPosition, Target, 1)
end)
