-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Module = {
    Function = {},

    Game = {
        Animals = game.Workspace.Animals,
        Drops = game.Workspace.Drops,
        Plants = game.Workspace.Plants,
        Bases = game.Workspace.Bases,
        Loners = game.Workspace.Bases.Loners,
        Nodes = game.Workspace.Nodes,
        Events = game.Workspace.Events
    },

    Nodes = {
        ["Phosphate_Node"] = "Phosphate",
        ["Stone_Node"] = "Stone",
        ["Metal_Node"] = "Metal",
    },

    Animals = {
        ["PREFAB_ANIMAL_WILDBOAR"] = "Boar",
        ["PREFAB_ANIMAL_WOLF"] = "Wolf",
        ["PREFAB_ANIMAL_DEER"] = "Deer"
    },

    Overrides = {
        Node = {
            Stone = Color3.fromRGB(180, 180, 180),
            Metal = Color3.fromRGB(120, 160, 200),
            Phosphate = Color3.fromRGB(120, 220, 120),
        },

        Plant = {
            Wool = Color3.fromRGB(255, 255, 255),
            Tomato = Color3.fromRGB(255, 60, 60),
            Pumpkin = Color3.fromRGB(255, 150, 40),
            Corn = Color3.fromRGB(245, 220, 70),
            Blueberry = Color3.fromRGB(70, 110, 230),
            Raspberry = Color3.fromRGB(220, 50, 120),
            Lemon = Color3.fromRGB(240, 230, 80),
        },
    },

    Base = {
        ["Base Cabinet"] = "Base Cabinet",
        ["Large Storage Box"] = "Large Storage Box",
        ["Small Storage Box"] = "Small Storage Box",
        ["Storage Cabinet"] = "Storage Cabinet",
        ["Sleeping Bag"] = "Sleeping Bag",
        ["Shotgun Turret"] = "Shotgun Turret",
        ["Auto Turret"] = "Auto Turret"
    },

    Crates = {
        ["BTR Crate"] = "BTR",
        ["Wooden Crate"] = "Wooden",
        ["Locked Wooden Crate"] = "Wooden",
        ["Locked Metal Crate"] = "Metal",
        ["Locked Steel Crate"] = "Steel",
    },

    Stored = {
        Game = {},
        Base = {}
    },

    Armor = {"Armor_59","Armor_60","Armor_63", "Armor_111","Armor_112","Armor_113","Armor_114","Armor_115", "Armor_116","Armor_117","Armor_118","Armor_119","Armor_120", "Armor_121","Armor_122","Armor_123","Armor_124","Armor_125", "Armor_141","Armor_142","Armor_143","Armor_145","Armor_146", "Armor_147","Armor_148","Armor_149","Armor_150","Armor_152", "Armor_153","Armor_154","Armor_155","Armor_156","Armor_157", "Armor_158","Armor_159","Armor_222","Armor_223","Armor_271", "Armor_272","Armor_298","Armor_308","Armor_309"}
}

local Library = loadfile("Source.lua")()
local Offsets = loadfile("Offsets.lua")()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Fallen Survival", Size = Vector2.new(700, 750)})

local VisualsTab = Window:Page({Name = "Visuals", Columns = 2})
local Static, Entities = VisualsTab:MultiSection({ Sections = { "Static", "Entities" }, Side = 1 })
local Miscellaneous, Loot, Bases = VisualsTab:MultiSection({ Sections = { "Other", "Loot", "Bases" }, Side = 2 })
local Events = VisualsTab:Section({Name = "Events", Side = 2})
local PlayersSection = VisualsTab:Section({Name = "Players", Side = 1})

-- // Entities Section \\ --

Entities:Toggle({Name = "Render Animals", Flag = "Render Animal", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Animal", Flag = "Animal Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Entities:Slider({Name = "Maximum Render", Flag = "Animal Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})
Entities:Dropdown({Name = "Animal Filter", Flag = "Animal Filter", Multi = true, Options = {"Wolf", "Boar", "Deer"}, Default = {1, 2}, Callback = function(Value) end})

-- // Static Section \\ --

Static:Toggle({Name = "Render Nodes", Flag = "Render Node", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Node", Flag = "Node Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Static:Toggle({Name = "Override Color", Flag = "Node Override", Default = false, Callback = function(Value) end})
Static:Slider({Name = "Maximum Render", Flag = "Node Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})
Static:Dropdown({Name = "Node Filter", Flag = "Node Filter", Multi = true, Options = {"Stone", "Metal", "Phosphate"}, Default = {1}, Callback = function(Value) end})

Static:Separator()

Static:Toggle({Name = "Render Plants", Flag = "Render Plant", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Plant", Flag = "Plant Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Static:Toggle({Name = "Override Color", Flag = "Plant Override", Default = false, Callback = function(Value) end})
Static:Slider({Name = "Maximum Render", Flag = "Plant Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})
Static:Dropdown({Name = "Plant Filter", Flag = "Plant Filter", Multi = true, Options = {"Wool", "Tomato", "Pumpkin", "Corn", "Blueberry", "Raspberry", "Lemon"}, Default = {1}, Callback = function(Value) end})

Static:Separator()

Static:Toggle({Name = "Render Drops", Flag = "Render Drop", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Drop", Flag = "Drop Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Static:Slider({Name = "Maximum Render", Flag = "Drop Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

-- // Loot and Miscellaneous Section \\ --

Loot:Toggle({Name = "Render Body Bag", Flag = "Render Body Bag", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Body Bag", Flag = "Body Bag Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Loot:Slider({Name = "Maximum Render", Flag = "Body Bag Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

Loot:Separator()

Loot:Toggle({Name = "Render Crates", Flag = "Render Crate", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Crate", Flag = "Crate Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Loot:Dropdown({Name = "Crate Filter", Flag = "Crate Filter", Multi = true, Options = {"BTR", "Wooden", "Metal", "Steel"}, Default = {1}, Callback = function(Value) end})
Loot:Slider({Name = "Maximum Render", Flag = "Crate Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

-- 

Miscellaneous:Toggle({Name = "Render Sleeper", Flag = "Render Sleeper", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Sleeper", Flag = "Sleeper Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Miscellaneous:Slider({Name = "Maximum Render", Flag = "Sleeper Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

Miscellaneous:Separator()

Miscellaneous:Toggle({Name = "Render Flycopter", Flag = "Render Flycopter", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Flycopter", Flag = "Flycopter Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Miscellaneous:Slider({Name = "Maximum Render", Flag = "Flycopter Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

Miscellaneous:Separator()

Miscellaneous:Toggle({Name = "Render Wooden Boat", Flag = "Render Wooden Boat", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Wooden Boat", Flag = "Wooden Boat Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Miscellaneous:Slider({Name = "Maximum Render", Flag = "Wooden Boat Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

Miscellaneous:Toggle({Name = "Render Military Boat", Flag = "Render Military Boat", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Military Boat", Flag = "Military Boat Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Miscellaneous:Slider({Name = "Maximum Render", Flag = "Military Boat Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

-- // Bases Section \\ --

Bases:Toggle({Name = "Render Bases", Flag = "Render Bases", Default = false, Callback = function(Value) end})
Bases:Toggle({Name = "Render Hull", Flag = "Render Hull", Default = false, Callback = function(Value) end})
Bases:Slider({Name = "Maximum Render", Flag = "Base Render", Min = 0, Max = 300, Default = 50, Callback = function(Value) end})

Bases:Separator()
Bases:Label({Name = "Loot"})

Bases:Toggle({Name = "Render Base Cabinet", Flag = "Render Base Cabinet", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Base Cabinet", Flag = "Base Cabinet Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Bases:Toggle({Name = "Render Large Box", Flag = "Render Large Storage Box", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Large Storage Box", Flag = "Large Storage Box Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Bases:Toggle({Name = "Render Small Box", Flag = "Render Small Storage Box", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Small Storage Box", Flag = "Small Storage Box Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Bases:Toggle({Name = "Render Storage Cabinet", Flag = "Render Storage Cabinet", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Storage Cabinet", Flag = "Storage Cabinet Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})

Bases:Separator()
Bases:Label({Name = "Weapons"})

Bases:Toggle({Name = "Render Shotgun Turret", Flag = "Render Shotgun Turret", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Shotgun Turret", Flag = "Shotgun Turret Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 1, Callback = function(Color) end})
Bases:Toggle({Name = "Render Auto Turret", Flag = "Render Auto Turret", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Auto Turret", Flag = "Auto Turret Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 1, Callback = function(Color) end})

Bases:Separator()
Bases:Label({Name = "Miscellaneous"})
Bases:Toggle({Name = "Render Sleeping Bag", Flag = "Render Sleeping Bag", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Sleeping Bag", Flag = "Sleeping Bag Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})

-- // Events Section \\ --

Events:Toggle({Name = "Render BTR", Flag = "Render BTR", Default = false, Callback = function(Value) end}):ColorPicker({Name = "BTR", Flag = "BTR Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Events:Toggle({Name = "Show Health", Flag = "Show Health", Default = false, Callback = function(Value) end})
Events:Slider({Name = "Maximum Render", Flag = "BTR Render", Min = 0, Max = 1300, Default = 1000, Callback = function(Value) end})

Events:Separator()

Events:Toggle({Name = "Render Timed", Flag = "Render Timed", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Timed", Flag = "Timed Color", Default = Color3.fromRGB(255, 255, 255), Alpha = 1, Callback = function(Color) end})
Events:Toggle({Name = "Show Remaining Time", Flag = "Show Remaining Time", Default = false, Callback = function(Value) end})
Events:Slider({Name = "Maximum Render", Flag = "Timed Render", Min = 0, Max = 1300, Default = 1000, Callback = function(Value) end})

-- // Players Section \\ --

PlayersSection:Toggle({Name = "Render Player Armor", Flag = "Armor Viewer", Default = false, Callback = function(Value) end})

-- // Function \\ --

function Module.Function:Filter(Class, Name)
    local Flag = Library.Flags[Class.. " Filter"]
    if not Flag then return true end

    local Selected = Flag.Value
    if next(Selected) == nil then return true end

    if Selected[Name] ~= nil then return Selected[Name] and true or false end

    for _, Option in Selected do
        if Option == Name then
            return true
        end
    end

    return false
end

function Module.Function:Color(Class, Name)
    local Overrides = Module.Overrides[Class]

    if Overrides and Library.Flags[Class.. " Override"] then
        local Override = Overrides[Name]
        if Override then
            return Override
        end
    end

    return Library.Flags[Class.. " Color"].Color
end

function Module.Function:Hull(Part)
    local Position = Part.Position
    local Half = Part.Size * 0.5

    local Right = Part.RightVector * Half.X
    local Up = Part.UpVector * Half.Y
    local Look = Part.LookVector * Half.Z

    local Points = table.create(8)
    local Count = 0

    for X = -1, 1, 2 do
        for Y = -1, 1, 2 do
            for Z = -1, 1, 2 do
                local Screen, Visible = Camera:WorldToScreenPoint(Position + Right * X + Up * Y + Look * Z)
                if Visible then
                    Count += 1
                    Points[Count] = Vector2.new(Screen.X, Screen.Y)
                end
            end
        end
    end

    if Count < 3 then return nil end

    table.sort(Points, function(A, B)
        return A.X < B.X or (A.X == B.X and A.Y < B.Y)
    end)

    local Hull = table.create(Count + 1)
    local H = 0

    for I = 1, Count do
        local P = Points[I]
        while H >= 2 do
            local O, A = Hull[H - 1], Hull[H]
            if (A.X - O.X) * (P.Y - O.Y) - (A.Y - O.Y) * (P.X - O.X) > 0 then break end
            H -= 1
        end
        H += 1
        Hull[H] = P
    end

    local Lower = H + 1
    for I = Count - 1, 1, -1 do
        local P = Points[I]
        while H >= Lower do
            local O, A = Hull[H - 1], Hull[H]
            if (A.X - O.X) * (P.Y - O.Y) - (A.Y - O.Y) * (P.X - O.X) > 0 then break end
            H -= 1
        end
        H += 1
        Hull[H] = P
    end

    for I = H, Count + 1 do
        Hull[I] = nil
    end

    return Hull
end

local Size = 45

function Module.Function:ImagePath(Image)
    return "Goop/3747388906/Images" .. "/" .. Image .. ".png"
end

function Module.Function:MakeFolder()
    if not isfolder("Goop/3747388906/Images") then makefolder("Goop/3747388906/Images") end
end

function Module.Function:ValidPNG(Data)
    return type(Data) == "string" and #Data > 8 and Data:sub(1, 8) == string.char(0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A)
end

function Module.Function:Download(ID)
    local I, Data = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Images/" .. ID .. ".png")
    end)
    if I and Module.Function:ValidPNG(Data) then
        pcall(writefile, Module.Function:ImagePath(ID), Data)
        return true
    end
    return false
end

function Module.Function:Initialize()
    Module.Function:MakeFolder()

    local Good, Repaired, Failed = 0, 0, 0

    for _, ID in Module.Armor do
        local Path = Module.Function:ImagePath(ID)
        local Valid = false

        if isfile(Path) then
            local I, Data = pcall(readfile, Path)
            Valid = I and Module.Function:ValidPNG(Data)
        end

        if Valid then
            Good += 1
        else
            if Module.Function:Download(ID) then
                Repaired += 1
            else
                Failed += 1
            end
        end
    end

    print(("images ready: %d ok, %d downloaded/repaired, %d failed"):format(Good, Repaired, Failed))
end

Module.Function:Initialize()

local ActiveImages = {}
local CurrentTarget = nil
local CurrentSignature = nil

function Module.Function:ClearImages()
    for _, Image in ipairs(ActiveImages) do
        Image:Remove()
    end
    ActiveImages = {}
end

function Module.Function:GetArmor(Character)
    local Armor, Seen = {}, {}
    for _, Piece in ipairs(Character:GetChildren()) do
        if Piece:IsA("Model") then
            local Matched = Piece.Name:match("^(Armor_%d+)")
            if Matched and not Seen[Matched] then
                Seen[Matched] = true
                table.insert(Armor, Matched)
            end
        end
    end
    return Armor
end

function Module.Function:GetClosest()
    local Mouse = UserInputService:GetMouseLocation()
    local Closest, ClosestDistance = nil, math.huge

    for _, Player in Players:GetChildren() do
        if Player ~= LocalPlayer then
            local Character = Player.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart then
                local Screen, OnScreen = Camera:WorldToScreenPoint(HumanoidRootPart.Position)
                if OnScreen then
                    local DeltaX = Screen.X - Mouse.X
                    local DeltaY = Screen.Y - Mouse.Y
                    local Distance = DeltaX * DeltaX + DeltaY * DeltaY
                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        Closest = Player
                    end
                end
            end
        end
    end
    return Closest
end

function Module.Function.Cache()
    local Stored = Module.Stored.Game
    local Base = Module.Stored.Base

    for Identifier, Entry in Stored do
        local Object = Entry.Object
        if not Object or not Object.Parent then
            Stored[Identifier] = nil
        end
    end

    for Identifier, Entry in Base do
        local Object = Entry.Object
        if not Object or not Object.Parent then
            Base[Identifier] = nil
        end
    end

    if Library.Flags["Render Node"] then
        for _, Node in Module.Game.Nodes:GetChildren() do
            local Identifier = tostring(Node)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Node,
                    Object = Node:FindFirstChildOfClass("MeshPart"),
                    Name = Module.Nodes[Node.Name],
                    Class = "Node"
                }
            end
        end
    end

    if Library.Flags["Render Animal"] then
        for _, Animal in Module.Game.Animals:GetChildren() do
            local Identifier = tostring(Animal)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Animal,
                    Object = Animal:FindFirstChild("HumanoidRootPart"),
                    Name = Module.Animals[Animal.Name],
                    Class = "Animal"
                }
            end
        end
    end

    if Library.Flags["Render Drop"] then
        for _, Drop in Module.Game.Drops:GetChildren() do
            local Identifier = tostring(Drop)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Drop,
                    Object = Drop:FindFirstChildOfClass("MeshPart"),
                    Name = Drop.Name,
                    Class = "Drop"
                }
            end
        end
    end

    if Library.Flags["Render Plant"] then
        for _, Plant in Module.Game.Plants:GetChildren() do
            local Identifier = tostring(Plant)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Plant,
                    Object = Plant:FindFirstChildOfClass("MeshPart"),
                    Name = Plant.Name:sub(1, -7),
                    Class = "Plant"
                }
            end
        end
    end

    if Library.Flags["Render Body Bag"] then
        local BodyBags = Module.Game.Loners:FindFirstChild("Body Bag")

        if BodyBags then
            for _, Body in BodyBags:GetChildren() do
                local Identifier = tostring(Body)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Body,
                        Object = Body:FindFirstChildOfClass("MeshPart"),
                        Name = "Body Bag",
                        Class = "Body Bag"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Sleeper"] then
        local Sleepers = Module.Game.Loners:FindFirstChild("Sleeper")

        if Sleepers then
            for _, Sleeper in Sleepers:GetChildren() do
                local Identifier = tostring(Sleeper)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Sleeper,
                        Object = Sleeper:FindFirstChildOfClass("MeshPart"),
                        Name = "Sleeper",
                        Class = "Sleeper"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Flycopter"] then
        local Flycopters = Module.Game.Loners:FindFirstChild("Salvaged Flycopter")

        if Flycopters then
            for _, Flycopter in Flycopters:GetChildren() do
                local Identifier = tostring(Flycopter)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Flycopter,
                        Object = Flycopter:FindFirstChildOfClass("MeshPart"),
                        Name = "Flycopter",
                        Class = "Flycopter"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Wooden Boat"] then
        local Boats = Module.Game.Loners:FindFirstChild("Wooden Boat")

        if Boats then
            for _, Boat in Boats:GetChildren() do
                local Identifier = tostring(Boat)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Boat,
                        Object = Boat:FindFirstChildOfClass("MeshPart"),
                        Name = "Wooden Boat",
                        Class = "Wooden Boat"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Military Boat"] then
        local Boats = Module.Game.Loners:FindFirstChild("Military Boat")

        if Boats then
            for _, Boat in Boats:GetChildren() do
                local Identifier = tostring(Boat)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Boat,
                        Object = Boat:FindFirstChildOfClass("MeshPart"),
                        Name = "Military Boat",
                        Class = "Military Boat"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Crate"] then
        for FolderName, Label in Module.Crates do
            local Folder = Module.Game.Loners:FindFirstChild(FolderName)

            if Folder then
                for _, Crate in Folder:GetChildren() do
                    local Identifier = tostring(Crate)

                    if not Stored[Identifier] then
                        Stored[Identifier] = {
                            Model = Crate,
                            Object = Crate:FindFirstChildOfClass("MeshPart"),
                            Name = Label,
                            Class = "Crate"
                        }
                    end
                end
            end
        end
    end

    --

    if Library.Flags["Render BTR"] then
        local BTR = Module.Game.Events:FindFirstChild("BTR")

        if BTR then
            local Identifier = tostring(BTR)
            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = BTR,
                    Object = BTR:FindFirstChild("HumanoidRootPart"),
                    Name = "BTR",
                    Class = "BTR"
                }
            end
        end
    end

    if Library.Flags["Render Timed"] then
        local Crates = Module.Game.Loners:FindFirstChild("Timed Crate")

        if Crates then
            for _, Crate in Crates:GetChildren() do
                local Identifier = tostring(Crate)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Crate,
                        Object = Crate:FindFirstChildOfClass("MeshPart"),
                        Name = "Timed Crate",
                        Class = "Timed"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Bases"] then
        for _, Model in Module.Game.Bases:GetChildren() do
            if Model.Name == "Loners" then continue end

            for _, Holder in Model:GetChildren() do
                local Label = Module.Base[Holder.Name]
                if not Label then continue end
                if not Library.Flags["Render ".. Label] then continue end

                for _, Component in Holder:GetChildren() do
                    local Identifier = tostring(Component)

                    if not Base[Identifier] then
                        Base[Identifier] = {
                            Model = Component,
                            Object = Component:FindFirstChild("Main"),
                            Name = Component.Name,
                            Class = Label
                        }
                    end
                end
            end
        end
    end
end

function Module.Function.Render()
    if Library.Flags["Armor Viewer"] then
        local Target = Module.Function:GetClosest()

        if not Target then
            if CurrentTarget then
                Module.Function:ClearImages()
                CurrentTarget, CurrentSignature = nil, nil
            end
            return
        end

        local Armor = Module.Function:GetArmor(Target.Character)
        local Signature = table.concat(Armor, "|")

        if Target == CurrentTarget and Signature == CurrentSignature then
            return
        end

        CurrentTarget, CurrentSignature = Target, Signature
        Module.Function:ClearImages()

        local Count = math.min(#Armor, 7)
        local Spacing = 10

        local TotalWidth = (Count * Size) + ((Count - 1) * Spacing)
        local StartX = (Camera.ViewportSize.X - TotalWidth) / 2

        local BottomPadding = 180
        local CenterY = Camera.ViewportSize.Y - Size - BottomPadding

        for i = 1, Count do
            local ID = Armor[i]

            if isfile(Module.Function:ImagePath(ID)) then
                local Image = Drawing.new("Image")

                Image.Size = Vector2.new(Size, Size)
                Image.Color = Color3.fromRGB(255, 255, 255)
                Image.Opacity = 1
                Image.ZIndex = 5
                Image.Visible = true

                Image.Position = Vector2.new(
                    StartX + (i - 1) * (Size + Spacing),
                    CenterY
                )

                Image.Data = readfile(Module.Function:ImagePath(ID))
                table.insert(ActiveImages, Image)
            end
        end
    end

    for _, Entry in Module.Stored.Game do
        if Library.Flags["Render ".. Entry.Class] then
            if Entry.Model and Entry.Object and Module.Function:Filter(Entry.Class, Entry.Name) then
                local Object = Entry.Object
                local Screen, Visible = Camera:WorldToScreenPoint(Object.Position)

                local Name
                local Distance = vector.magnitude(Camera.Position - Object.Position)
                if Distance <= Library.Flags[Entry.Class.. " Render"].Value then
                    if Entry.Class == "Body Bag" then
                        local Owner = Entry.Model:GetAttribute("OwnerName")
                        Name = (Owner ~= nil and Owner.. "'s Body Bag" or "Body Bag").. " [".. math.floor(Distance).. "]"
                    elseif Entry.Class == "Sleeper" then
                        local NameTag = Entry.Model:FindFirstChild("NameTag")
                        local Label = NameTag and NameTag:FindFirstChild("Label")
                        local Owner = Label and memory.readstring(Label, Offsets.GuiObject.Text)
                        Name = (Owner and Owner.. "'s Sleeper" or "Sleeper").. " [".. math.floor(Distance).. "]"
                    elseif Entry.Class == "Flycopter" then
                        local Health = math.floor(tonumber(Entry.Model:GetAttribute("Health")) or 0)
                        local MaxHealth = math.floor(tonumber(Entry.Model:GetAttribute("MaxHealth")) or 0)

                        Name = Entry.Name.. " [".. Health.. "/".. MaxHealth.. "] ".. " [".. math.floor(Distance).. "]"
                    elseif Entry.Class == "BTR" then
                        local Destroyed = Entry.Model:GetAttribute("Destroyed")

                        if Destroyed == "true" then
                            Name = Entry.Name.. " [DESTROYED] ".. " [".. math.floor(Distance).. "]"
                        elseif Library.Flags["Show Health"] then
                            local Health = math.floor(tonumber(Entry.Model:GetAttribute("Health")) or 0)
                            local MaxHealth = math.floor(tonumber(Entry.Model:GetAttribute("MaxHealth")) or 0)
                            Name = Entry.Name.. " [".. Health.. "/".. MaxHealth.. "] ".. " [".. math.floor(Distance).. "]"
                        else
                            Name = Entry.Name.. " [".. math.floor(Distance).. "]"
                        end
                    elseif Entry.Class == "Timed" then
                        if Library.Flags["Show Remaining Time"] then
                            local Timer = Entry.Model:FindFirstChild("Timer")
                            local GuiHolder = Timer and Timer:FindFirstChild("GuiHolder")
                            local Label = GuiHolder and GuiHolder:FindFirstChild("Label")
                            local TextLabel = Label and Label:FindFirstChild("TextLabel")
                            local Remaining = TextLabel and memory.readstring(TextLabel, Offsets.GuiObject.Text)

                            Name = Entry.Name.. (Remaining and " (".. Remaining.. ")" or "").. " [".. math.floor(Distance).. "]"
                        else
                            Name = Entry.Name.. " [".. math.floor(Distance).. "]"
                        end
                    else
                        Name = Entry.Name.. " [".. math.floor(Distance).. "]"
                    end

                    if Visible then
                        DrawingImmediate.OutlinedText(Screen, 13, Module.Function:Color(Entry.Class, Entry.Name), Library.Flags[Entry.Class.. " Color"].Alpha, Name, true, "Pixel")
                    end
                end
            end
        end
    end

    if Library.Flags["Render Bases"] then
        for _, Entry in Module.Stored.Base do
            if Library.Flags["Render ".. Entry.Class] and Entry.Model and Entry.Object then
                local Object = Entry.Object
                local Screen, Visible = Camera:WorldToScreenPoint(Object.Position)
                local Distance = vector.magnitude(Camera.Position - Object.Position)

                if Visible and Distance <= Library.Flags["Base Render"].Value then
                    local Flag = Library.Flags[Entry.Class.. " Color"]
                    local Position = Vector2.new(Screen.X, Screen.Y)

                    if Library.Flags["Render Hull"] then
                        local Points = Module.Function:Hull(Object)
                        if Points then
                            Points[#Points + 1] = Points[1]
                            DrawingImmediate.Polyline(Points, Flag.Color, Flag.Alpha, 2)

                            local TopY = math.huge
                            for _, Point in Points do
                                if Point.Y < TopY then TopY = Point.Y end
                            end
                            Position = Vector2.new(Screen.X, TopY - 16)
                        end
                    end

                    DrawingImmediate.OutlinedText(Position, 13, Flag.Color, Flag.Alpha, Entry.Model.Name, true, "Pixel")
                end
            end
        end
    end
end

-- // Initalize \\ --
Library:Watermark("Goop")
Library:GroupList(1154360, {"Founder", "Co-Founder", "Lead Developer", "Game Moderator"})
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())

task.spawn(function() while true do task.wait(1 / 4) Module.Function.Cache() end end)
RunService.Render:Connect(Module.Function.Render)
