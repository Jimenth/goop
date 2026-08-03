-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Module = {
    Function = {},
    Added = {},

    Game = {
        ATMs = Workspace.ATMs,
        Registers = Workspace.CashRegisters,
        Vehicles = Workspace.BountyVehicles.Vehicles,
        Bank = Workspace.EnterableBuildings.Bank.Robbery
    },
    
    Stored = {
        Game = {},
        Characters = {},
        Mouse = {X = 0, Y = 0},
        MouseMove = {
            Active = false,
        },

        Click = {
            Active = false,
        },

        Lockpick = {
            Cache = {},
            Picking = false,
            
            Current = {
                Indexed = 1,
                Click = 0,
            },
        },

        ATM = {
            Cache = {},
            Positioned = false,

            Previous = {
                Time = 0,
                Target = nil
            },
        },

        GlassCutting = {
            Cache = {},
            Positioned = false,
        },

        Vehicle = {
            Cache = {},
            Wired = {},
            Wiring = false,
            WireActive = false,
            PrevCrowClick = 0,

            Numbers = {
                Stage = "Idle",
                Sequence = {},
                Index = 1,
                Clicking = false,

                LastDigit = nil,
                Blank = false,

                VisibleTime = nil,
                WaitTime = 0,
                Cache = {}
            }
        }
    }
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()
local Offsets = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Resources/Offsets.lua"))()
local Bounding = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/Severe/refs/heads/main/Modules/Bounding.lua"))()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | ER:LC", Size = Vector2.new(550, 520)})

local MainTab = Window:Page({Name = "Main", Columns = 1})
local VisualsTab = Window:Page({Name = "Visuals", Columns = 2})
local Automation = MainTab:Section({Name = "Automation", Side = 1})
local Robberies = VisualsTab:Section({Name = "Robberies", Side = 1})
local Specific = VisualsTab:Section({Name = "Specific", Side = 2})
local PlayersSection = VisualsTab:Section({Name = "Players", Side = 1})

-- // Automation Section \\ --

Automation:Toggle({Name = "Auto Vehicle", Flag = "Auto Vehicle", Default = false, Callback = function(Value) end})
Automation:Toggle({Name = "Auto Lockpick", Flag = "Auto Lockpick", Default = false, Callback = function(Value) end})
Automation:Toggle({Name = "Auto ATM", Flag = "Auto ATM", Default = false, Callback = function(Value) end})
Automation:Toggle({Name = "Auto Jewelry", Flag = "Auto Jewelry", Default = false, Callback = function(Value) end})

-- // Robberies Section \\ --

Robberies:Toggle({Name = "Render ATMs", Flag = "Render ATM", Default = false, Callback = function(Value) end}):ColorPicker({Name = "ATM", Flag = "ATM Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
Robberies:Slider({Name = "Maximum Render", Flag = "ATM Render", Min = 0, Max = 2000, Default = 400, Callback = function(Value) end})

Robberies:Separator()

Robberies:Toggle({Name = "Render Registers", Flag = "Render Register", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Register", Flag = "Register Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
Robberies:Slider({Name = "Maximum Render", Flag = "Register Render", Min = 0, Max = 2000, Default = 400, Callback = function(Value) end})

Robberies:Separator()

Robberies:Toggle({Name = "Render Stealable Vehicles", Flag = "Render Vehicle", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Vehicle", Flag = "Vehicle Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
Robberies:Slider({Name = "Maximum Render", Flag = "Vehicle Render", Min = 0, Max = 2000, Default = 400, Callback = function(Value) end})

-- // Specific Section \\ --

Specific:Toggle({Name = "Render Money", Flag = "Render Money", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Money", Flag = "Money Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
Specific:Slider({Name = "Maximum Render", Flag = "Money Render", Min = 0, Max = 2000, Default = 400, Callback = function(Value) end})

Specific:Separator()

Specific:Toggle({Name = "Render Bank Code Locations", Flag = "Render Bank Code Location", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Bank Code Location", Flag = "Bank Code Location Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
Specific:Slider({Name = "Maximum Render", Flag = "Bank Code Location Render", Min = 0, Max = 100, Default = 50, Callback = function(Value) end})

-- // Players Section \\ --

PlayersSection:Toggle({Name = "Render Wanted", Flag = "Render Wanted", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Wanted", Flag = "Wanted Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 1, Callback = function(Color) end})

-- // Function \\ --

function Module.Function:GetCharacterParts(Character)
    if not Character then
        return {}, 0
    end
    
    local Parts = {}
    local Count = 0
    
    for _, Child in Character:GetChildren() do
        if Child:IsA("Part") or Child:IsA("MeshPart") then
            Count = Count + 1
            Parts[Count] = Child
        end
    end
    
    return Parts, Count
end

function Module.Function:Cache()
    local Stored = Module.Stored.Game
    local Characters = Module.Stored.Characters or {}

    for Identifier, Entry in Stored do
        local Object = Entry.Object

        if not Object or not Object.Parent then
            Stored[Identifier] = nil
        elseif Entry.Class == "Register" then
            local Register = Entry.Model
            local Health = Register and Register:FindFirstChild("Info") and Register.Info:FindFirstChild("Health")

            if not Health or Health.Value <= 0 or not Object or not Object.Parent or Entry.Model.Name == "CashRegister_Broken" then
                Stored[Identifier] = nil
            end
        end
    end

    for Identifier, Entry in Characters do
        local Character = Entry.Character

        if not Character or not Character.Parent then
            Characters[Identifier] = nil
        end
    end

    if Library.Flags["Render ATM"] then
        for _, ATM in Module.Game.ATMs:GetChildren() do
            local Identifier = tostring(ATM)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = ATM,
                    Object = ATM:FindFirstChild("ClickPart"),
                    Name = "ATM",
                    Class = "ATM"
                }
            end
        end
    end

    if Library.Flags["Render Register"] then
        for _, Register in Module.Game.Registers:GetChildren() do
            local Health = Register:FindFirstChild("Info") and Register.Info:FindFirstChild("Health")

            if Health and Health.Value > 0 and Register.Name ~= "CashRegister_Broken" then
                local Identifier = tostring(Register)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Register,
                        Object = Register:FindFirstChild("register_Cube.003"),
                        Name = "Register",
                        Class = "Register"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Vehicle"] then
        for _, Vehicle in Module.Game.Vehicles:GetChildren() do
            local Base = Vehicle:FindFirstChild("Body") and Vehicle.Body:FindFirstChild("Base")

            if Base then
                local Identifier = tostring(Vehicle)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Vehicle,
                        Object = Base,
                        Name = Vehicle.Name,
                        Class = "Vehicle"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Money"] then
        if not Workspace.HouseRobbery then return nil end 

        for _, Bill in Workspace.HouseRobbery:GetChildren() do
            if Bill and Bill:IsA("BasePart") then
                local Identifier = tostring(Bill)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Bill,
                        Object = Bill,
                        Name = Bill.Name,
                        Class = "Money"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Bank Code Location"] then
        if not Module.Game.Bank then return nil end 

        for _, Location in Module.Game.Bank:FindFirstChild("EntryCodeItems"):GetChildren() do
            if Location and Location:IsA("Model") and Location:FindFirstChild("Screen") then
                local Identifier = tostring(Location)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Location,
                        Object = Location:FindFirstChild("Screen"),
                        Name = Location.Name,
                        Class = "Bank Code Location"
                    }
                end
            end
        end
    end

    if Library.Flags["Render Wanted"] then
        for _, Player in Players:GetChildren() do
            if Player:IsA("Player") and Player ~= LocalPlayer then
                local Character = Player.Character
                local Identifier = tostring(Player)

                if Character then
                    local Existing = Characters[Identifier]

                    if not Existing or Existing.Character ~= Character then
                        local Parts, Count = Module.Function:GetCharacterParts(Character)

                        Characters[Identifier] = {
                            Character = Character,
                            Player = Player,
                            Parts = Parts,
                            Count = Count
                        }
                    end
                else
                    Characters[Identifier] = nil
                end
            end
        end
    end
end

function Module.Function:UpdateInput()
    local Mouse = UserInputService:GetMouseLocation()
    Module.Stored.Mouse.X = Mouse.X
    Module.Stored.Mouse.Y = Mouse.Y
end

function Module.Function:GetAbsolutePosition(Object)
    local X = memory.readf32(Object, Offsets.GuiBase2D.AbsolutePosition)
    local Y = memory.readf32(Object, Offsets.GuiBase2D.AbsolutePosition + 4)
    return {X = X, Y = Y}
end

function Module.Function:GetAbsoluteSize(Object)
    local X = memory.readf32(Object, Offsets.GuiBase2D.AbsoluteSize)
    local Y = memory.readf32(Object, Offsets.GuiBase2D.AbsoluteSize + 4)
    return {X = X, Y = Y}
end

function Module.Function:GetCenterPosition(Object)
    local Position  = Module.Function:GetAbsolutePosition(Object)
    local Size = Module.Function:GetAbsoluteSize(Object)
    return {
        X = Position.X + Size.X * 0.5,
        Y = Position.Y + Size.Y * 0.5,
    }
end

function Module.Function:GetColor3(Object)
    local Color = memory.readvector(Object, Offsets.GuiObject.TextColor3)
    return Color
end

function Module.Function:GetText(Object)
    local Text = memory.readstring(Object, Offsets.GuiObject.Text)
    return Text
end

function Module.Function:GetVisible(Object)
    local Visible = memory.readu8(Object, Offsets.GuiObject.Visible)
    return Visible == 1
end

function Module.Function:SmoothMoveMouse(TargetX, TargetY, Steps)
    Steps = Steps or 15

    local StartX, StartY = Module.Stored.Mouse.X, Module.Stored.Mouse.Y
    local DeltaX, DeltaY = TargetX - StartX, TargetY - StartY

    for Step = 1, Steps do
        local Progress = Step / Steps
        local EasedProgress = 1 - math.pow(1 - Progress, 2)

        local X = StartX + (DeltaX * EasedProgress)
        local Y = StartY + (DeltaY * EasedProgress)

        mousemoveabs(math.floor(X), math.floor(Y))

        Module.Stored.Mouse.X = X
        Module.Stored.Mouse.Y = Y

        task.wait(0.02)
    end
end

function Module.Function:ClickButton(Button)
    local Position = Module.Function:GetCenterPosition(Button)

    if not Position then
        return
    end

    local FinalX = math.floor(Position.X + math.random(-3, 3))
    local FinalY = math.floor(Position.Y + math.random(-3, 3))

    Module.Function:SmoothMoveMouse(FinalX, FinalY)

    task.wait(0.3 + math.random() * 0.2)

    mouse1click()

    task.wait(0.05 + math.random() * 0.03)
end

function Module.Function:GetMenu()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    if PlayerGui then 
        local Menus = PlayerGui:FindFirstChild("GameMenus")
        if Menus then return Menus end
    end
end

function Module.Function:SolveLockpick()
    if not Library.Flags["Auto Lockpick"] then
        return false
    end

    local State = Module.Stored.Lockpick

    local Menus = Module.Function:GetMenu()
    if not Menus then
        return false
    end

    local LockpickMenu = Menus:FindFirstChild("Lockpick")

    if not LockpickMenu or not Module.Function:GetVisible(LockpickMenu) then
        State.Picking = false
        State.Current.Indexed = 1
        State.Cache = {}
        return false
    end

    if not State.Cache.Lock then
        local Pick = LockpickMenu:FindFirstChild("Pick")
        if not Pick then
            return false
        end

        local RedLine = Pick:FindFirstChild("RedLine")

        State.Cache.Lock = LockpickMenu
        State.Cache.Pick = Pick
        State.Cache.RedLine = RedLine
        State.Cache.RedCenter = RedLine and RedLine:FindFirstChild("Center")

        State.Cache.Pegs = {}

        for Index = 1, 6 do
            local Peg = Pick:FindFirstChild(tostring(Index))

            if Peg then
                State.Cache.Pegs[Index] = {
                    Object = Peg,
                    Center = Peg:FindFirstChild("Center")
                }
            end
        end
    end

    if not State.Picking then
        State.Picking = true
        State.Current.Indexed = 1
        State.Current.Click = os.clock()
        return true
    end

    if (os.clock() - State.Current.Click) < 0.03 then
        return true
    end

    local RedCenter = State.Cache.RedCenter
    if not RedCenter then
        return true
    end

    local PegData = State.Cache.Pegs[State.Current.Indexed]
    if not PegData or not PegData.Center then
        return true
    end

    local PinPosition = Module.Function:GetCenterPosition(PegData.Center)
    local PinSize = Module.Function:GetAbsoluteSize(PegData.Object)

    local RedParent = RedCenter.Parent
    local RedPosition = Module.Function:GetCenterPosition(RedCenter)
    local RedSize = Module.Function:GetAbsoluteSize(RedParent)

    local PinTop = PinPosition.Y - (PinSize.Y * 0.5)
    local PinBottom = PinPosition.Y + (PinSize.Y * 0.5)

    local RedTop = RedPosition.Y - (RedSize.Y * 0.5)
    local RedBottom = RedPosition.Y + (RedSize.Y * 0.5)

    if PinTop <= RedBottom and RedTop <= PinBottom then
        mouse1click()

        State.Current.Indexed += 1
        State.Current.Click = os.clock()

        if State.Current.Indexed > 6 then
            State.Picking = false
            State.Current.Indexed = 1
            State.Cache = {}
        end
    end

    return true
end

function Module.Function:SolveATM()
    if not Library.Flags["Auto ATM"] then
        return false
    end

    local State = Module.Stored.ATM

    local Menus = Module.Function:GetMenu()
    if not Menus then
        State.Positioned = false
        State.Previous.Target = nil
        State.Cache = {}
        return false
    end

    local Frame = Menus:FindFirstChild("ATM")

    if not Frame then
        State.Positioned = false
        State.Previous.Target = nil
        State.Cache = {}
        return false
    end

    local Hacking = Frame:FindFirstChild("Hacking")

    if not (Hacking and Module.Function:GetVisible(Hacking)) then
        State.Positioned = false
        State.Previous.Target = nil
        State.Cache = {}
        return false
    end

    if not State.Cache.Hacking then
        local Button = Hacking:FindFirstChild("ClickButton")
        local Cycle = Hacking:FindFirstChild("CycleFrame")
        local Selecting = Hacking:FindFirstChild("SelectingCode")

        if not (Button and Cycle and Selecting) then
            return true
        end

        State.Cache.Hacking = Hacking
        State.Cache.Button = Button
        State.Cache.Cycle = Cycle
        State.Cache.Selecting = Selecting
    end

    local Button = State.Cache.Button
    local Cycle = State.Cache.Cycle
    local Selecting = State.Cache.Selecting

    if not State.Positioned then
        local Position = Module.Function:GetCenterPosition(Button)

        if Position then
            mousemoveabs(Position.X, Position.Y)
            State.Positioned = true
        end
    end

    local Target = Module.Function:GetText(Selecting)

    if not Target or Target == "" then
        return true
    end

    if State.Previous.Target == Target then
        if (os.clock() - State.Previous.Time) > 1 then
            State.Previous.Target = nil
        else
            return true
        end
    end

    local Textt

    for Index = 1, 4 do
        local List = Cycle:FindFirstChild("List" .. tostring(Index))

        if List then
            for _, Label in pairs(List:GetChildren()) do
                if Label.ClassName == "TextLabel" then
                    local Color = Module.Function:GetColor3(Label)

                    if Color and Color.x == 0 and Color.y == 0 and Color.z == 0 then
                        Textt = Module.Function:GetText(Label)

                        break
                    end
                end
            end
        end

        if Textt then
            break
        end
    end

    if Textt and Textt == Target and Module.Function:GetVisible(Hacking) then
        mouse1click()

        State.Previous.Target = Target
        State.Previous.Time = os.clock()
    end

    return true
end

function Module.Function:SolveJewelry()
    if not Library.Flags["Auto Jewelry"] then
        return false
    end

    local State = Module.Stored.GlassCutting

    local Menus = Module.Function:GetMenu()
    if not Menus then
        State.Cache = {}
        return false
    end

    local GlassCutting = Menus:FindFirstChild("GlassCutting")

    if not GlassCutting or not Module.Function:GetVisible(GlassCutting) then
        State.Cache = {}
        return false
    end

    if not State.Cache.Green then
        State.Cache.Green = GlassCutting:FindFirstChild("GreenBox")
    end

    local Green = State.Cache.Green
    if not Green then
        return true
    end

    local Position = Module.Function:GetCenterPosition(Green)

    if Position then
        mousemoveabs(
            math.floor(Position.X + 1),
            math.floor(Position.Y)
        )

        Module.Stored.Mouse.X = Position.X + 1
        Module.Stored.Mouse.Y = Position.Y
    end

    return true
end

function Module.Function:SolveVehicle()
    if not Library.Flags["Auto Vehicle"] then
        return false
    end

    local State = Module.Stored.Vehicle

    local Menus = Module.Function:GetMenu()
    if not Menus then
        State.Wired = {}
        State.Wiring = false
        State.Cache = {}
        State.Numbers.Stage = "Idle"
        State.Numbers.VisibleTime = nil
        State.Numbers.Cache = {}
        State.Numbers.Started = false
        return false
    end

    -- // Crowbar \\ --

    local Crowbar = Menus:FindFirstChild("Crowbar")

    if Crowbar and Module.Function:GetVisible(Crowbar) then
        local Frame = Crowbar:FindFirstChild("Main")
        local Game = Frame and Frame:FindFirstChild("Game")

        local Indicator = Game and Game:FindFirstChild("Indicator")
        local Target = Game and Game:FindFirstChild("Target")

        if Indicator and Target then
            local IndicatorPos = Module.Function:GetCenterPosition(Indicator)
            local IndicatorSize = Module.Function:GetAbsoluteSize(Indicator)

            local TargetPos = Module.Function:GetCenterPosition(Target)
            local TargetSize = Module.Function:GetAbsoluteSize(Target)

            local IndicatorLeft = IndicatorPos.X - IndicatorSize.X * 0.5
            local IndicatorRight = IndicatorPos.X + IndicatorSize.X * 0.5

            local TargetLeft = TargetPos.X - TargetSize.X * 0.5
            local TargetRight = TargetPos.X + TargetSize.X * 0.5

            local IndicatorTop = IndicatorPos.Y - IndicatorSize.Y * 0.5
            local IndicatorBottom = IndicatorPos.Y + IndicatorSize.Y * 0.5

            local TargetTop = TargetPos.Y - TargetSize.Y * 0.5
            local TargetBottom = TargetPos.Y + TargetSize.Y * 0.5

            if IndicatorLeft <= TargetRight
                and TargetLeft <= IndicatorRight
                and IndicatorTop <= TargetBottom
                and TargetTop <= IndicatorBottom
                and (os.clock() - State.PrevCrowClick) > 0.12
            then
                mouse1click()
                State.PrevCrowClick = os.clock()
            end
        end

        return true
    end

    -- // Numbers Hack \\ --

    local NumbersHack = Menus:FindFirstChild("NumbersHack")

    if NumbersHack and Module.Function:GetVisible(NumbersHack) then
        local NS = State.Numbers

        if not NS.VisibleTime then
            NS.VisibleTime = os.clock()
            return true
        end

        if os.clock() - NS.VisibleTime < 2 then
            return true
        end

        if not NS.Cache.MainScreen then
            local Background = NumbersHack:FindFirstChild("Background")
            local ScreenBase = Background and Background:FindFirstChild("ScreenBase")
            local ScreenUIBase = ScreenBase and ScreenBase:FindFirstChild("ScreenUIBase")

            local MainScreen = ScreenUIBase and ScreenUIBase:FindFirstChild("MainScreen")

            if not MainScreen then
                return true
            end

            local Start = MainScreen:FindFirstChild("Start")
            local CurrentNumber = MainScreen:FindFirstChild("CurrentNumber")

            NS.Cache.MainScreen = MainScreen
            NS.Cache.Start = Start and Start:FindFirstChild("GO")
            NS.Cache.CurrentNumber = CurrentNumber and CurrentNumber:FindFirstChild("Number")
            NS.Cache.NumberButtons = ScreenUIBase:FindFirstChild("NumberButtons")
        end

        local Start = NS.Cache.Start
        local CurrentNumber = NS.Cache.CurrentNumber
        local NumberButtons = NS.Cache.NumberButtons

        if not (Start and CurrentNumber and NumberButtons) then
            return true
        end

        NS.Stage = NS.Stage or "Idle"

        if NS.Stage == "Idle" then
            if NS.Clicking then
                return true
            end

            if not NS.Started then
                NS.Clicking = true

                task.spawn(function()
                    Module.Function:ClickButton(Start)

                    NS.Sequence = {}
                    NS.Index = 1
                    NS.LastDigit = nil
                    NS.Blank = false
                    NS.Started = true
                    NS.Clicking = false
                    NS.Stage = "Reading"
                end)
            end

            return true
        end

        if NS.Stage == "Reading" then
            local Current = Module.Function:GetText(CurrentNumber)
            local Digit = tonumber(Current)

            if not Current or Current == "" then
                NS.Blank = true
            elseif Digit and (NS.Blank or Digit ~= NS.LastDigit) then
                NS.LastDigit = Digit
                NS.Blank = false

                table.insert(NS.Sequence, Digit)
            end

            if #NS.Sequence == 6 then
                print("Sequence:", table.concat(NS.Sequence))

                NS.Index = 1
                NS.Stage = "Pressing"
            end

            return true
        end

        if NS.Stage == "Pressing" then
            if NS.Clicking then
                return true
            end

            local Number = NS.Sequence[NS.Index]

            if not Number then
                NS.Stage = "Waiting"
                NS.WaitTime = os.clock()
                return true
            end

            local Button = NumberButtons:FindFirstChild(tostring(Number))

            if not Button then
                return true
            end

            NS.Clicking = true

            task.spawn(function()
                Module.Function:ClickButton(Button)

                NS.Index += 1
                NS.Clicking = false
            end)

            return true
        end

        if NS.Stage == "Waiting" then
            if os.clock() - NS.WaitTime > 0.3 then
                print("Restarting sequenc read")

                NS.Sequence = {}
                NS.Index = 1
                NS.LastDigit = nil
                NS.Blank = false
                NS.Stage = "Reading"
            end

            return true
        end

        return true
    end

    -- // Wires \\ --

    local ConnectWires = Menus:FindFirstChild("ConnectWires")

    if not (
        ConnectWires
        and Module.Function:GetVisible(ConnectWires)
    ) then
        State.Wired = {}
        State.Wiring = false
        return false
    end

    if not State.Wiring then
        State.Wiring = true
        State.WiringStart = os.clock()
        return true
    end

    if (os.clock() - State.WiringStart) < 0.25 then
        return true
    end

    local Tangled = ConnectWires:FindFirstChild("TangledWires")
    local TangledVisible

    if Tangled then
        for _, Object in Tangled:GetChildren() do
            if Object.ClassName == "Frame"
                and Module.Function:GetVisible(Object)
            then
                TangledVisible = Object
                break
            end
        end
    end

    if not TangledVisible then
        return true
    end

    for _, Wire in ConnectWires:GetChildren() do
        if Wire.ClassName ~= "Frame"
            or not string.find(Wire.Name, "Wire")
            or string.sub(Wire.Name, -1) ~= "L"
        then
            continue
        end

        if State.Wired[Wire.Name] then
            continue
        end

        local Drag = Wire:FindFirstChild("Drag")
        local DragContact = Drag and Drag:FindFirstChild("Contact")

        if not Drag or not DragContact then
            continue
        end

        local Connected = Drag:GetAttribute("Connected")

        if Connected then
            State.Wired[Wire.Name] = true
            continue
        end

        local RightName = string.sub(Wire.Name, 1, #Wire.Name - 1) .. "R"

        local RightSide = ConnectWires:FindFirstChild(RightName)

        local WireName = RightSide and RightSide:GetAttribute("WireName")

        if type(WireName) ~= "string" then
            continue
        end

        local TargetWire = TangledVisible:FindFirstChild(WireName)

        local TargetContact = TargetWire and TargetWire:FindFirstChild("Contact")

        if not TargetContact then
            continue
        end

        if not State.WireActive then
            State.WireActive = true

            local StartPos = Module.Function:GetCenterPosition(Drag)
            local EndPos = Module.Function:GetCenterPosition(TargetContact)

            task.spawn(function()
                mousemoveabs(StartPos.X, StartPos.Y)

                Module.Stored.Mouse.X = StartPos.X
                Module.Stored.Mouse.Y = StartPos.Y

                task.wait(0.08)

                mouse1press()

                task.wait(0.08)

                Module.Function:SmoothMoveMouse(
                    EndPos.X,
                    EndPos.Y,
                    15
                )

                task.wait(0.05)

                mouse1release()

                local Connected
                for _ = 1, 20 do
                    task.wait(0.02)
                    Connected = Drag:GetAttribute("Connected")
                    if Connected == true or Connected == "true" then
                        break
                    end
                end

                if Connected == true or Connected == "true" then
                    State.Wired[Wire.Name] = true
                end

                State.WireActive = false
            end)
        end

        break
    end

    return true
end

function Module.Function.Render()
    for _, Entry in Module.Stored.Game do
        if Library.Flags["Render ".. Entry.Class] then
            if Entry and Entry.Model then
                local Primary = Entry.Object
                if not Primary then continue end

                local Text = Entry.Name

                local Distance = vector.magnitude(Camera.Position - Primary.Position)
                if Distance <= Library.Flags[Entry.Class.. " Render"].Value then
                    local Screen, Visible = Camera:WorldToScreenPoint(Primary.Position)

                    if Visible then
                        DrawingImmediate.OutlinedText(Screen, 13, Library.Flags[Entry.Class.. " Color"].Color, Library.Flags[Entry.Class.. " Color"].Alpha, Text, true, "Pixel")
                    end
                end
            end
        end
    end

    if Library.Flags["Render Wanted"] then
        for _, Instance in pairs(Module.Stored.Characters) do
            if not Instance.Character then continue end
            if Instance.Player == LocalPlayer then continue end
            local Player = Instance.Player

            if Player:FindFirstChild("Is_Wanted") then
                if Instance.Count > 0 then
                    local BoundingBox = Bounding.GetBoundingBox(Instance.Parts)
                    if BoundingBox then
                        local CenterX = BoundingBox.Position.X + BoundingBox.Size.X * 0.5
                        local BottomY = BoundingBox.Position.Y + BoundingBox.Size.Y + 1

                        DrawingImmediate.OutlinedText(Vector2.new(CenterX, BottomY), 14, Library.Flags["Wanted Color"].Color, Library.Flags["Wanted Color"].Alpha, "WANTED", true, "Pixel")
                    end
                end
            end
        end
    end
end

-- // Initalize \\ --

Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())

RunService.Render:Connect(Module.Function.Render)
task.spawn(function()
    while true do
        task.wait(0.8)
        Module.Function:Cache()
    end
end)
RunService.PostLocal:Connect(function()
    Module.Function:UpdateInput()

    Module.Function:SolveATM()
    Module.Function:SolveJewelry()
    Module.Function:SolveVehicle()
end)

task.spawn(function()
    while true do
        task.wait(0.01)
        Module.Function:SolveLockpick()
    end
end)
