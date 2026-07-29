-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Module = {
    Function = {},
    Added = {},

    Game = {
        Tycoons = Workspace.Tycoon.Tycoons
    },
    
    Stored = {
        Mouse = {X = 0, Y = 0}
    }
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()
local Offsets = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Resources/Offsets.lua"))()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | War Tycoon", Size = Vector2.new(550, 520)})

local MainTab = Window:Page({Name = "Main", Columns = 2})
local Automation = MainTab:Section({Name = "Automation", Side = 1})

-- // Automation Section \\ --
Automation:Toggle({Name = "Auto Collect", Flag = "Auto Collect", Default = false, Callback = function(Value) end})
Automation:Toggle({Name = "Auto Purchase", Flag = "Auto Purchase", Default = false, Callback = function(Value) end})
Automation:Toggle({Name = "Auto Rebirth", Flag = "Auto Rebirth", Default = false, Callback = function(Value) end})

-- // Function \\ --

function Module.Function:GetCompletion()
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not PlayerGui then return 0 end

    local HUD = PlayerGui.UI.Container.HUD.Menu.HUD
    local Left = HUD:FindFirstChild("Left")
    if not Left then return 0 end

    local BaseStatus = Left:FindFirstChild("BaseStatus")
    if not BaseStatus then return 0 end

    local Completion = BaseStatus:FindFirstChild("Completion")
    if not Completion then return 0 end

    local Progress = Completion:FindFirstChild("BarProgressAmount")
    if not Progress then return 0 end

    local Percentage = tonumber(memory.readstring(Progress, Offsets.GuiObject.Text):match("%d+")) or 0
    return Percentage or 0
end

local Suffixes = {
    k = 1e3,
    m = 1e6,
    b = 1e9,
    t = 1e12,
}

function Module.Function:GetRebirthCost()
    local Label = LocalPlayer.PlayerGui.UI.Container.HUD.Menu.HUD.Rebirths.RebirthButton.Rebirth.Main.TextLabel
    if not Label or not Label:IsA("TextLabel") then return nil end

    local Text = memory.readstring(Label, Offsets.GuiObject.Text)
    if not Text or Text == "" then return nil end

    local Number, Suffix = Text:match("-%s*([%d%.]+)%s*(%a?)")
    if not Number then return nil end

    local Value = tonumber(Number)
    if not Value then return nil end

    local Multiplier = Suffixes[Suffix:lower()] or 1
    return Value * Multiplier
end

function Module.Function:UpdateInput()
    local Mouse = UserInputService:GetMouseLocation()
    Module.Stored.Mouse.X = Mouse.X
    Module.Stored.Mouse.Y = Mouse.Y
end

function Module.Function:GetCash()
    local Stats = LocalPlayer:FindFirstChild("leaderstats")
    if not Stats then return 0 end

    local Cash = Stats:FindFirstChild("Cash")
    if not Cash then return 0 end

    return Cash.Value or 0
end

function Module.Function:GetRebirths()
    local Stats = LocalPlayer:FindFirstChild("leaderstats")
    if not Stats then return 0 end

    local Rebirths = Stats:FindFirstChild("Rebirths")
    if not Rebirths then return 0 end

    return Rebirths.Value or 0
end

function Module.Function:GetPlot()
    for _, Plot in Module.Game.Tycoons:GetChildren() do
        if Plot:GetAttribute("Owner") == LocalPlayer.Name then
            return Plot
        end
    end
end

function Module.Function:IsPriority(Name)
    for _, Key in {"oil", "Oil", "OIL", "Bunker Start", "Bunker Oil Drill Room", "Bunker Frame", "Oil Drill", "Gas", "Solar"} do
        if Name:find(Key, 1, true) then
            return true
        end
    end
    return false
end

function Module.Function:SetPosition(Object, Target)
    if not Object or not Object:IsA("BasePart") then print("Setposition broke G") end
    if not Target or not Target:IsA("BasePart") then print("Setposition broke G") end
    Object.Position = Target.Position + vector.create(0.2, 0.2, 0.2)
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

function Module.Function:SmoothMoveMouse(TargetX, TargetY)
    local StartX, StartY = Module.Stored.Mouse.X, Module.Stored.Mouse.Y
    local DeltaX, DeltaY = TargetX - StartX, TargetY - StartY

    for Step = 1, 15 do
        local Progress = Step / 15
        local EasedProgress = 1 - math.pow(1 - Progress, 2)

        local InterpX = StartX + (DeltaX * EasedProgress)
        local InterpY = StartY + (DeltaY * EasedProgress)

        local MicroX = math.random(-1, 1) * 0.5
        local MicroY = math.random(-1, 1) * 0.5

        local FinalX = math.floor(InterpX + MicroX)
        local FinalY = math.floor(InterpY + MicroY)

        mousemoveabs(FinalX, FinalY)
        Module.Stored.Mouse.X, Module.Stored.Mouse.Y = FinalX, FinalY

        task.wait(0.005 + math.random() * 0.002)
    end

    mousemoveabs(TargetX, TargetY)
    Module.Stored.Mouse.X, Module.Stored.Mouse.Y = TargetX, TargetY
end

function Module.Function:ClickButton(Button)
    local Position = Module.Function:GetCenterPosition(Button)
    local FinalX = math.floor(Position.X + math.random(-3, 3))
    local FinalY = math.floor(Position.Y + math.random(-3, 3))
    Module.Function:SmoothMoveMouse(FinalX, FinalY)
    task.wait(0.3 + math.random() * 0.2)
    mouse1click()
    task.wait(0.05 + math.random() * 0.03)
end

function Module.Function:AutoCollect()
    local Character = LocalPlayer.Character
    if not Character then return end

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end

    local Plot = Module.Function:GetPlot()
    if not Plot then return end

    local Collector = Plot:FindFirstChild("Essentials") and Plot.Essentials:FindFirstChild("CollectorParts")
    local Object = Collector and Collector:FindFirstChild("Collector")
    if Object then
        Module.Function:SetPosition(HumanoidRootPart, Object)
    end
end

function Module.Function:ResolvePad(Item)
    local Primary = Item:FindFirstChild("Gradient") or Item.PrimaryPart

    if Primary and Primary:IsA("BasePart") then
        return Primary
    end

    if Primary and Primary:IsA("Model") then
        local Part = Primary.PrimaryPart or Primary:FindFirstChildWhichIsA("BasePart", true)
        if Part then return Part end
    end

    return Item:FindFirstChildWhichIsA("BasePart", true)
end

function Module.Function:AutoComplete()
    if not Library.Flags["Auto Purchase"] then return end

    local Character = LocalPlayer.Character
    if not Character then return end

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end

    local Plot =  Module.Function:GetPlot()
    if not Plot then return end

    local Items = Plot:FindFirstChild("UnpurchasedButtons")
    if not Items then return end

    local Children = Items:GetChildren()
    if #Children == 0 then
        print("Completed")
        return
    end

    local RebirthButtons, OilButtons, CashButtons = {}, {}, {}

    for _, Item in ipairs(Children) do
        local Type = Item:GetAttribute("ButtonType")
        local Pad = Module.Function:ResolvePad(Item)
        if not Pad then continue end

        if Type == "Rebirth" then
            local Req = tonumber(Item:GetAttribute("RebirthRequirement")) or 0
            if Module.Function:GetRebirths() >= Req then
                RebirthButtons[#RebirthButtons + 1] = {Pad = Pad, Req = Req}
            end
        elseif Type == "Cash" then
            local Price = tonumber(Item:GetAttribute("Price")) or 0
            if Module.Function:IsPriority(Item.Name) then
                OilButtons[#OilButtons + 1] = {Pad = Pad, Price = Price}
            else
                CashButtons[#CashButtons + 1] = {Pad = Pad, Price = Price}
            end
        end
    end

    if #RebirthButtons > 0 then
        table.sort(RebirthButtons, function(a, b) return a.Req < b.Req end)
        for _, Button in ipairs(RebirthButtons) do
            Module.Function:SetPosition(HumanoidRootPart, Button.Pad)
            task.wait(0.3)
        end
        return
    end

    if #OilButtons > 0 then
        table.sort(OilButtons, function(a, b) return a.Price < b.Price end)
        for _, Target in ipairs(OilButtons) do
            if Module.Function:GetCash() >= Target.Price then
                Module.Function:SetPosition(HumanoidRootPart, Target.Pad)
                task.wait(0.3)
            else
                Module.Function:AutoCollect()
                return
            end
        end
        return
    end

    if #CashButtons > 0 then
        table.sort(CashButtons, function(a, b) return a.Price < b.Price end)
        for _, Button in ipairs(CashButtons) do
            if Module.Function:GetCash() >= Button.Price then
                 Module.Function:SetPosition(HumanoidRootPart, Button.Pad)
                task.wait(0.3)
            else
                Module.Function:AutoCollect()
                return
            end
        end
        return
    end
end

task.spawn(function()
    while true do
        if Library.Flags["Auto Collect"] then
             Module.Function:AutoCollect()
        end
        task.wait(0.4)
    end
end)

task.spawn(function()
    while true do
        if Library.Flags["Auto Purchase"] then
            Module.Function:AutoComplete()
            task.wait(0.4)
        end

        if Library.Flags["Auto Rebirth"] then
            if Module.Function:GetCompletion() == 100 then
                if Module.Function:GetRebirthCost() < Module.Function:GetCash() then
                    Module.Function:ClickButton(LocalPlayer.PlayerGui.UI.Container.HUD.Menu.HUD.Rebirths.RebirthButton.Rebirth)
                    task.wait(2)
                    Module.Function:ClickButton(LocalPlayer.PlayerGui.UI.Container.HUD.Menu.HUD.Rebirths.RebirthMenu.Background.Body.Options.ConfirmButton)
                else
                    Module.Function:AutoCollect()
                end
            end
        end
        task.wait(0.4)
    end
end)

-- // Initalize \\ --

Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())

RunService.PostLocal:Connect(function() Module.Function:UpdateInput() end)
