-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Module = {
    Function = {},
    
    Stored = {
        Map = nil,
        Gun = nil,
        OldPosition = nil
    }
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()
task.wait(2)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Extra/Module.lua"))()
task.wait(2)

local TweenService = _G.TweenService

local Roles = {
    Knife = {"Murderer", Color3.fromRGB(255, 0, 0), 1},
    Gun = {"Sheriff", Color3.fromRGB(0, 0, 255), 1}
}

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Murder Mystery 2", Size = Vector2.new(550, 600)})

local MainTab = Window:Page({Name = "Main", Columns = 2})
local VisualsSection = MainTab:Section({Name = "Visuals", Side = 1})
local ExploitsSection = MainTab:Section({Name = "Exploits", Side = 2})
local AutofarmSection = MainTab:Section({Name = "Automation", Side = 2})

-- // Visuals Section \\ --

local RenderRoles = VisualsSection:Toggle({ Name = "Render Roles", Flag = "Render Roles", Default = false, Callback = function(Value) end })
RenderRoles:ColorPicker({ Name = "Sheriff", Flag = "Sheriff Color", Default = Color3.fromRGB(0, 0, 255), Alpha = 1, Callback = function(Color) Roles.Gun[2] = Color end })
RenderRoles:ColorPicker({ Name = "Murderer", Flag = "Murderer Color", Default = Color3.fromRGB(255, 0, 0), Alpha = 1, Callback = function(Color) Roles.Knife[2] = Color end })

local RenderGun = VisualsSection:Toggle({ Name = "Render Gun", Flag = "Render Gun", Default = false, Callback = function(Value) end })
RenderGun:ColorPicker({ Name = "Gun Color", Flag = "Gun Color", Default = Color3.fromRGB(0, 255, 0), Alpha = 1, Callback = function(Color) end })

-- // Functions \\ --

function Module.Function:GetMap()
    for _, Map in Workspace:GetChildren() do
        if Map:IsA("Model") and Map:FindFirstChild("CoinContainer") then
            return Map
        end
    end
    return nil
end

function Module.Function:GetGun()
    local Map = Module.Stored.Map
    if not Map then return nil end

    for _, Gun in ipairs(Map:GetChildren()) do
        if Gun:IsA("Part") and Gun.Name == "GunDrop" then
            return Gun
        end
    end
    return nil
end

function Module.Function:GetClosestCoin(CharacterPosition)
    local Map = Module.Stored.Map
    if not Map then return nil end

    local Coins = Map:FindFirstChild("CoinContainer")
    if not Coins then return nil end

    local ClosestCoin = nil
    local ClosestDistance = math.huge

    for _, Coin in Coins:GetChildren() do
        if Coin and Coin:FindFirstChild("CoinVisual") and Coin:FindFirstChild("TouchInterest") then
            local Distance = vector.magnitude(Coin.Position - CharacterPosition)
            if Distance < ClosestDistance then
                ClosestDistance = Distance
                ClosestCoin = Coin
            end
        end
    end

    return ClosestCoin
end

function Module.Function:CheckRole(Player)
    local Character = Player.Character
    if not Character then return nil, nil end

    local Backpack = Player:FindFirstChild("Backpack")
    if not Backpack then return nil, nil end

    for _, Tool in ipairs(Character:GetChildren()) do
        local Data = Roles[Tool.Name]
        if Data then
            return Data[1], Data[2], Data[3]
        end
    end

    for _, Tool in ipairs(Backpack:GetChildren()) do
        local Data = Roles[Tool.Name]
        if Data then
            return Data[1], Data[2], Data[3]
        end
    end

    return nil, nil
end

function Module.Function:WorldBoxToScreen(Center, Size)
    local HalfX, HalfY, HalfZ = Size.X / 2, Size.Y / 2, Size.Z / 2
    local MinX, MinY, MaxX, MaxY = math.huge, math.huge, -math.huge, -math.huge
    local OnScreen = false
    for _, Corner in {
        Vector3.new(-HalfX, -HalfY, -HalfZ), Vector3.new(-HalfX, -HalfY, HalfZ),
        Vector3.new(-HalfX,  HalfY, -HalfZ), Vector3.new(-HalfX,  HalfY, HalfZ),
        Vector3.new( HalfX, -HalfY, -HalfZ), Vector3.new( HalfX, -HalfY, HalfZ),
        Vector3.new( HalfX,  HalfY, -HalfZ), Vector3.new( HalfX,  HalfY, HalfZ),
    } do
        local Screen, Visible = Camera:WorldToScreenPoint(Center + Corner)
        MinX, MaxX = math.min(MinX, Screen.X), math.max(MaxX, Screen.X)
        MinY, MaxY = math.min(MinY, Screen.Y), math.max(MaxY, Screen.Y)
        if Visible then OnScreen = true end
    end
    return MinX, MinY, MaxX, MaxY, OnScreen
end

function Module.Function:Render()
    if Library.Flags["Render Gun"] and Module.Stored.Gun then
        local Screen, OnScreen = Camera:WorldToScreenPoint(Module.Stored.Gun.Position)
        if OnScreen then
            DrawingImmediate.OutlinedText(Screen, 13, Library.Flags["Gun Color"].Color, Library.Flags["Gun Color"].Alpha, "Gun", true, "Verdana")
        end
    end

    if Library.Flags["Render Roles"] then
        for Index, Player in Players:GetChildren() do
            if Player == LocalPlayer then continue end

            local Role, Color, Alpha = Module.Function:CheckRole(Player)
            if Role then
                local Character = Player.Character
                local Box, Size = Character:GetBoundingBox()
                if Size.Y > 0 then
                    local MinX, MinY, MaxX, MaxY, OnScreen = Module.Function:WorldBoxToScreen(Box.Position, Size)
                    if OnScreen then
                        local CenterX = (MinX + MaxX) / 2
                        local BottomY = MaxY + 1
                        DrawingImmediate.OutlinedText(Vector2.new(CenterX, BottomY), 13, Color, Alpha, Role, true, "Verdana")
                    end
                end
            end
        end
    end
end

function Module.Function:TeleportToGun()
    if Module.Stored.Gun and LocalPlayer and LocalPlayer.Character then
        local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then return end

        if Library.Flags["Position Track"] then
            Module.Stored.OldPosition = HumanoidRootPart.Position
        end

        HumanoidRootPart.Position = Module.Stored.Gun.Position + Vector3.new(0, 3, 0)

        if Library.Flags["Position Track"] and Module.Stored.OldPosition then
            task.delay(0.4, function()
                if LocalPlayer and LocalPlayer.Character then
                    if HumanoidRootPart then
                        HumanoidRootPart.Position = Module.Stored.OldPosition
                    end
                end
            end)
        end
    end
end

task.spawn(function()
    local ActiveTween = nil
    local CurrentCoin = nil

    while true do
        if Library.Flags["Auto Collect"] then
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

            if not HumanoidRootPart then
                task.wait()
                continue
            end

            if not Module.Stored.Map then
                task.wait()
                continue
            end

            if not ActiveTween then
                CurrentCoin = Module.Function:GetClosestCoin(HumanoidRootPart.Position)

                if not CurrentCoin then
                    task.wait()
                    continue
                end

                if Library.Flags["Full Bag Suicide"] then
                    if tonumber(LocalPlayer.PlayerGui.MainGUI.Game.CoinBags.Container.Coin.CurrencyFrame.Icon.Coins.Text) == 40 then
                        Humanoid:TakeDamage(100)
                    end
                end

                if vector.magnitude(CurrentCoin.Position - HumanoidRootPart.Position) >= 200 then
                    CurrentCoin = nil
                    task.wait()
                    continue
                end

                local Distance = vector.magnitude(CurrentCoin.Position - HumanoidRootPart.Position)

                ActiveTween = TweenService:Create(
                    HumanoidRootPart,
                    { Time = Distance / 20, EasingStyle = "Linear" },
                    { Position = CurrentCoin.Position }
                )

                ActiveTween:Play()
            elseif ActiveTween.Finished then
                ActiveTween = nil
                CurrentCoin = nil
            end
        end

        task.wait(0.05)
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        
        local NewMap = Module.Function:GetMap()
        if NewMap ~= Module.Stored.Map then
            Module.Stored.Map = NewMap
        end

        local NewGun = Module.Function:GetGun()
        if NewGun ~= Module.Stored.Gun then
            Module.Stored.Gun = NewGun
        end

        if Library.Flags["Auto Grab Gun"] and Module.Stored.Gun and LocalPlayer and LocalPlayer.Character then
            Module.Function:TeleportToGun()
        end
    end
end)

-- // Autofarm Section \\ --

AutofarmSection:Toggle({ Name = "Auto Collect Coins", Flag = "Auto Collect", Default = false, Callback = function(Value) end })
AutofarmSection:Toggle({ Name = "Full Bag Suicide", Flag = "Full Bag Suicide", Default = false, Callback = function(Value) end })

-- // Exploit Section \\ --

ExploitsSection:Toggle({ Name = "Auto Grab Gun", Flag = "Auto Grab Gun", Default = false, Callback = function(Value) end })
ExploitsSection:Separator()
ExploitsSection:Toggle({ Name = "Position Track", Flag = "Position Track", Default = false, Callback = function(Value) end })
ExploitsSection:Button({ Name = "Teleport To Gun", Callback = function() Module.Function:TeleportToGun() end })

-- // Initalize \\ --

Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
RunService.Render:Connect(Module.Function.Render)
