local Library = {
    Flags = {},

    Appearance = {
        Font = "Proggy",
        FontSize = 13,

        Coloring = {
            Accent = Color3.fromRGB(177, 156, 217),
            AccentDark = Color3.fromRGB(139, 107, 163),
            Background = Color3.fromRGB(28, 28, 28),
            BackgroundDark = Color3.fromRGB(20, 20, 20),
            Border = Color3.fromRGB(50, 50, 50),
            Black = Color3.fromRGB(0, 0, 0),
            White = Color3.fromRGB(255, 255, 255),
            Dim = Color3.fromRGB(180, 180, 180),
        }
    },

    Service = {
        UserInputService = game:GetService("UserInputService"),
    },

    Input = {
        Mouse = nil,
        FocusedTextbox = nil,
        MouseX = 0,
        MouseY = 0,
        MouseDown = false,
        MouseClicked = false,
        RightClicked = false,
        MousePrevious = false,
        RightPrevious = false,
        Consumed = false,
        ActiveKeyPickers = {},
    },

    Camera = workspace.CurrentCamera,
    Viewport = workspace.CurrentCamera.ViewportSize,

    LayoutConstants = {
        SectionPadding = 7,
        SectionGap = 6,
        SectionHeaderHeight = 26,
        SectionInnerPadding = 5,
        ElementSpacing = 0,
        SwatchWidth = 28,
        SwatchGap = 3,
        MaxChainedPickers = 3,
    },

    Windows = {},

    Folders = {
        Directory = "Goop",
        Configs = "Goop/".. tostring(game.GameId).. "/Configs",
    },

    Keys = {
        ["A"] = "a",
        ["B"] = "b",
        ["C"] = "c",
        ["D"] = "d",
        ["E"] = "e",
        ["F"] = "f",
        ["G"] = "g",
        ["H"] = "h",
        ["I"] = "i",
        ["J"] = "j",
        ["K"] = "k",
        ["L"] = "l",
        ["M"] = "m",
        ["N"] = "n",
        ["O"] = "o",
        ["P"] = "p",
        ["Q"] = "q",
        ["R"] = "r",
        ["S"] = "s",
        ["T"] = "t",
        ["U"] = "u",
        ["V"] = "v",
        ["W"] = "w",
        ["X"] = "x",
        ["Y"] = "y",
        ["Z"] = "z",
        ["Zero"] = "0",
        ["One"] = "1",
        ["Two"] = "2",
        ["Three"] = "3",
        ["Four"] = "4",
        ["Five"] = "5",
        ["Six"] = "6",
        ["Seven"] = "7",
        ["Eight"] = "8",
        ["Nine"] = "9",
        ["Space"] = " ",
        ["Minus"] = "-",
        ["Underscore"] = "_",
        ["Period"] = ".",
    }
}

for _, File in Library.Folders do
    if not isfolder(File) then
        makefolder(File)
    end
end

Library.Input.Mouse = Library.Service.UserInputService:GetMouseLocation()

function Library:FormatMouseButton(Name)
    if Name == "LeftButton" or Name == "MouseButton1" then return "MB1" elseif Name == "RightButton" or Name == "MouseButton2" then return "MB2" end
    return Name
end

function Library:HSVToRGB(H, S, V)
    local Hue6 = H * 6
    local SectorIndex = math.floor(Hue6) % 6
    local FractionalPart = Hue6 - math.floor(Hue6)
    
    local p = math.floor(V * (1 - S) * 255)
    local q = math.floor(V * (1 - FractionalPart * S) * 255)
    local t = math.floor(V * (1 - (1 - FractionalPart) * S) * 255)
    local v = math.floor(V * 255)

    if SectorIndex == 0 then return v, t, p end
    if SectorIndex == 1 then return q, v, p end
    if SectorIndex == 2 then return p, v, t end
    if SectorIndex == 3 then return p, q, v end
    if SectorIndex == 4 then return t, p, v end
    return v, p, q
end

function Library:RGBToHSV(R, G, B)
    R, G, B = R / 255, G / 255, B / 255
    
    local MaxComponent = math.max(R, G, B)
    local MinComponent = math.min(R, G, B)
    local Delta = MaxComponent - MinComponent
    
    local Saturation = MaxComponent == 0 and 0 or Delta / MaxComponent
    local Value = MaxComponent
    local Hue = 0
    
    if Delta > 0 then
        if MaxComponent == R then
            Hue = ((G - B) / Delta) % 6
        elseif MaxComponent == G then
            Hue = (B - R) / Delta + 2
        else
            Hue = (R - G) / Delta + 4
        end
        Hue = Hue / 6
    end
    
    return Hue, Saturation, Value
end

function Library:UpdateInput()
    Library.Input.Mouse = Library.Service.UserInputService:GetMouseLocation()
    Library.Input.MouseX = Library.Input.Mouse.X
    Library.Input.MouseY = Library.Input.Mouse.Y

    local LeftNow = isleftpressed()
    local RightNow = isrightpressed and isrightpressed() or false

    Library.Input.MouseClicked = LeftNow and not Library.Input.MousePrevious
    Library.Input.RightClicked = RightNow and not Library.Input.RightPrevious
    Library.Input.MouseDown = LeftNow
    Library.Input.MousePrevious = LeftNow
    Library.Input.RightPrevious = RightNow
end

function Library:IsHovering(X, Y, Width, Height)
    return Library.Input.MouseX >= X and Library.Input.MouseX <= X + Width and Library.Input.MouseY >= Y and Library.Input.MouseY <= Y + Height
end

function Library:DrawToggleVisual(X, Y, Width, IsOn, Label)
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(15, 15), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(13, 13), IsOn and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(11, 11), IsOn and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 18, Y + 1), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, Label, false, Library.Appearance.Font)
end

function Library:DrawSwatch(X, Y, Color, Alpha)
    Alpha = Alpha or 255
    if Alpha < 255 then
        DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(14, 6), Color3.fromRGB(160, 160, 160), 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 14, Y), Vector2.new(14, 6), Color3.fromRGB(100, 100, 100), 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X, Y + 6), Vector2.new(14, 7), Color3.fromRGB(100, 100, 100), 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 14, Y + 6), Vector2.new(14, 7), Color3.fromRGB(160, 160, 160), 1)
    end
    local DarkR = math.max(Color.R * 255-38, 0)
    local DarkG = math.max(Color.G * 255-49, 0)
    local DarkB = math.max(Color.B * 255-54, 0)
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(28, 13), Color3.fromRGB(DarkR, DarkG, DarkB), 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(26, 11), Color, Alpha / 255)
end

function Library:DrawSliderVisual(X, Y, Width, Min, Max, Value, Label)
    DrawingImmediate.OutlinedText(Vector2.new(X, Y), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, Label, false, Library.Appearance.Font)

    local BarY = Y + 15
    DrawingImmediate.FilledRectangle(Vector2.new(X, BarY), Vector2.new(Width, 15), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, BarY + 1), Vector2.new(Width-2, 13), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, BarY + 2), Vector2.new(Width-4, 11), Library.Appearance.Coloring.Background, 1)

    local Fraction  = (Value - Min) / (Max - Min)
    local FillWidth = math.floor((Width - 2) * Fraction)
    if FillWidth > 0 then
        DrawingImmediate.FilledRectangle(Vector2.new(X + 1, BarY + 1), Vector2.new(FillWidth, 13), Library.Appearance.Coloring.AccentDark, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 2, BarY + 2), Vector2.new(math.max(FillWidth-2, 0), 11), Library.Appearance.Coloring.Accent, 1)
    end

    local ValueText = math.floor(Value) .. "/" .. Max
    DrawingImmediate.OutlinedText(Vector2.new(X + Width / 2 - 15, BarY + 1), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, ValueText, false, Library.Appearance.Font)
end

function Library:DrawButtonVisual(X, Y, Width, Label, IsHovered)
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(Width, 22), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(Width-2, 20), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width-4, 18), IsHovered and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 4, Y + 4), Library.Appearance.FontSize, IsHovered and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.White, 1, Label, false, Library.Appearance.Font)
end

function Library:DrawDropdownVisual(X, Y, Width, Label, SelectedText, IsOpen)
    DrawingImmediate.OutlinedText(Vector2.new(X, Y), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, Label, false, Library.Appearance.Font)

    local BarY = Y + 15
    DrawingImmediate.FilledRectangle(Vector2.new(X, BarY), Vector2.new(Width, 22), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, BarY + 1), Vector2.new(Width-2, 20), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, BarY + 2), Vector2.new(Width-4, 18), Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 4, BarY + 4), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, SelectedText, false, Library.Appearance.Font)
    DrawingImmediate.OutlinedText(Vector2.new(X + Width-15, BarY + 4), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, IsOpen and "-" or "+", false, Library.Appearance.Font)
end

function Library:DrawSeparator(X, Y, Width)
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y + 3), Vector2.new(Width, 1), Library.Appearance.Coloring.Border, 0.5)
end

function Library:DrawLabel(X, Y, Text, TextColor)
    DrawingImmediate.OutlinedText(Vector2.new(X, Y), Library.Appearance.FontSize, TextColor or Library.Appearance.Coloring.Dim, 1, Text, false, Library.Appearance.Font)
end

function Library:DrawKeyPickerBadge(X, Y, Label, IsCapturing, IsHovered)
    local W = Library.LayoutConstants.SwatchWidth
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y),   Vector2.new(W, 13), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(W-2, 11), IsCapturing and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(W-4, 9), IsCapturing and Library.Appearance.Coloring.Accent or (IsHovered and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background), 1)
    local TextBounds = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 11, Label)
    local TextX = X + math.floor((W - TextBounds.X) / 2)
    local TextY = Y + math.floor((13 - TextBounds.Y) / 2)
    DrawingImmediate.OutlinedText(Vector2.new(TextX, TextY), 11, IsCapturing and Library.Appearance.Coloring.White or Library.Appearance.Coloring.Dim, 1, Label, false, Library.Appearance.Font)
    return W
end

local Element = {}
Element.__index = Element

function Element.New(Section, ElementType, Options)
    local Self = setmetatable({}, Element)
    Self.Section = Section
    Self.Type = ElementType
    Self.Name = Options.Name or ""
    Self.Flag = Options.Flag
    Self.Callback = Options.Callback or function() end
    Self.Height = 20
    Self.X, Self.Y, Self.Width = 0, 0, 0

    Self.AttachedColorPickers = {}
    Self.AttachedKeyPicker = nil

    if ElementType == "Toggle" then
        Self.Value = Options.Default or false
        if Self.Flag then Library.Flags[Self.Flag] = Self.Value end
        Self.Height = 20

    elseif ElementType == "Slider" then
        Self.Min = Options.Min or 0
        Self.Max = Options.Max or 100
        Self.Value = Options.Default or Self.Min
        if Self.Flag then Library.Flags[Self.Flag] = {Value = Self.Value} end
        Self.Height = 35

    elseif ElementType == "Dropdown" then
        Self.Options = Options.Options or {}
        Self.SelectedIndex = Options.Default or 1
        Self.Open = false
        if Self.Flag then Library.Flags[Self.Flag] = {Value = Self.Options[Self.SelectedIndex]} end
        Self.Height = 42

    elseif ElementType == "Button" then
        Self.Height = 26

    elseif ElementType == "ColorPicker" then
        local DefaultColor = Options.Default or Color3.fromRGB(177, 156, 217)
        Self.Color = {DefaultColor.R*255, DefaultColor.G*255, DefaultColor.B*255}
        Self.Alpha = Options.DefaultAlpha or 1
        if Self.Flag then
            Library.Flags[Self.Flag] = {
                Color = DefaultColor,
                Alpha = Self.Alpha,
            }
        end
        Self.Height = 20

    elseif ElementType == "Textbox" then
        Self.Value = Options.Default or ""
        Self.Placeholder = Options.Placeholder or "Type here..."
        Self.MaxLength = Options.MaxLength or 64
        Self.Focused = false
        Self.PrevKeys = {}
        if Self.Flag then Library.Flags[Self.Flag] = Self.Value end
        Self.Height = 28

    elseif ElementType == "KeyPicker" then
        Self.ToggleElement = Options.ToggleElement
        Self.BoundKey = Options.Default or "None"
        Self.Mode = "Toggle"
        Self.Capturing = false
        Self.CapturingTime = 0
        Self.ContextOpen = false
        Self.Height = 0
        if Self.Flag then
            Library.Flags[Self.Flag] = {Key = Self.BoundKey, Mode = Self.Mode}
            Library.Input.ActiveKeyPickers[#Library.Input.ActiveKeyPickers + 1] = Self
        end

    elseif ElementType == "Separator" then
        Self.Height = 8

    elseif ElementType == "Label" then
        Self.TextColor = Options.Color
        Self.Height = 16

    elseif ElementType == "ConfigBox" then
        Self.Height = 80
        Self.ConfigState = Options.ConfigState

    elseif ElementType == "HalfButton" then
        Self.Height = 0
        Self.PairCallback = Options.Callback
        Self.PairLabel = Options.Name
    end

    return Self
end

function Element:SyncFlag()
    if not self.Flag then return end
    if self.Type == "Toggle" then
        Library.Flags[self.Flag] = self.Value
    elseif self.Type == "Slider" then
        Library.Flags[self.Flag] = {Value = self.Value}
    elseif self.Type == "Dropdown" then
        Library.Flags[self.Flag] = {Value = self.Options[self.SelectedIndex]}
    elseif self.Type == "ColorPicker" then
        Library.Flags[self.Flag] = {Color = Color3.fromRGB(self.Color[1], self.Color[2], self.Color[3]), Alpha = math.clamp(self.Alpha, 0, 1)}
    elseif self.Type == "Textbox" then
        Library.Flags[self.Flag] = self.Value
    elseif self.Type == "KeyPicker" then
        Library.Flags[self.Flag] = {Key = self.BoundKey, Mode = self.Mode}
    end
end

local SW = Library.LayoutConstants.SwatchWidth
local SG = Library.LayoutConstants.SwatchGap

local function SwatchX(RightEdge, Index)
    return RightEdge - SW - Index * (SW + SG)
end

function Element:ColorPicker(Options)
    assert(self.Type == "Toggle", "ColorPicker can only be attached to a Toggle")
    assert(#self.AttachedColorPickers < 2, "A Toggle can only have a maximum of 2 attached ColorPickers")
    Options = Options or {}
    Options.Name = Options.Name or self.Name
    local NewPicker = Element.New(self.Section, "ColorPicker", Options)
    NewPicker.Hidden = true
    self.AttachedColorPickers[#self.AttachedColorPickers + 1] = NewPicker
    self.Section.Elements[#self.Section.Elements + 1] = NewPicker
    return NewPicker
end

function Element:KeyPicker(Options)
    assert(self.Type == "Toggle", "KeyPicker can only be attached to a Toggle")
    assert(self.AttachedKeyPicker == nil, "A Toggle can only have one attached KeyPicker")
    Options = Options or {}
    Options.ToggleElement = self
    local NewPicker = Element.New(self.Section, "KeyPicker", Options)
    NewPicker.Hidden = true
    self.AttachedKeyPicker = NewPicker
    self.Section.Elements[#self.Section.Elements + 1] = NewPicker
    return NewPicker
end

function Element:Render()
    local X, Y, Width = self.X, self.Y, self.Width
    local AnchorRight = self.SectionRightEdge or (X + Width)

    if self.Type == "Toggle" then
        Library:DrawToggleVisual(X, Y, Width, self.Value, self.Name)

        for Index, Picker in ipairs(self.AttachedColorPickers) do
            local SX = SwatchX(AnchorRight, Index - 1)
            Library:DrawSwatch(SX, Y + 1, Color3.fromRGB(Picker.Color[1], Picker.Color[2], Picker.Color[3]), Picker.Alpha * 255)

            if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(SX, Y + 1, SW, 13) then
                Library.Input.Consumed = true
                Library:ToggleColorPickerWindow(Picker, SX - 260, Y + 18)
                return
            end
        end

        if self.AttachedKeyPicker then
            local Keypicker = self.AttachedKeyPicker
            local NumSwatches = #self.AttachedColorPickers
            local BX = SwatchX(AnchorRight, NumSwatches)
            local BY = Y + 1
            local RawLabel = Keypicker.Capturing and "..." or Library:FormatMouseButton(Keypicker.BoundKey)
            local BadgeLabel = #RawLabel > 3 and RawLabel:sub(1, 3) or RawLabel
            local Hovered = Library:IsHovering(BX, BY, SW, 13)
            Library:DrawKeyPickerBadge(BX, BY, BadgeLabel, Keypicker.Capturing, Hovered)

            if Library.Input.MouseClicked and not Library.Input.Consumed and Hovered then
                Library.Input.Consumed = true
                Keypicker.Capturing = true
                Keypicker.ContextOpen = false
                Keypicker.CapturingTime = tick()
                Library.CapturingKeyPicker = Keypicker
            end

            if Library.Input.RightClicked and not Library.Input.Consumed and Hovered then
                Library.Input.Consumed = true
                Keypicker.ContextOpen = not Keypicker.ContextOpen
                if Keypicker.ContextOpen then
                    Library.KeyPickerContext = {Element = Keypicker, X = BX, Y = BY + 16}
                else
                    Library.KeyPickerContext = nil
                end
            end
        end

        if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(X, Y, Width, 15) then
            Library.Input.Consumed = true
            self.Value = not self.Value
            self:SyncFlag()
            self.Callback(self.Value)
        end

    elseif self.Type == "Slider" then
        Library:DrawSliderVisual(X, Y, Width, self.Min, self.Max, self.Value, self.Name)

        local BarY = Y + 15
        if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(X, BarY, Width, 15) then
            Library.ActiveSlider = self
            Library.Input.Consumed = true
        end
        if Library.ActiveSlider == self and Library.Input.MouseDown then
            local NewValue = math.clamp(math.floor(self.Min + ((Library.Input.MouseX - X - 2) / (Width - 4)) * (self.Max - self.Min)), self.Min, self.Max)
            if NewValue ~= self.Value then
                self.Value = NewValue
                self:SyncFlag()
                self.Callback(self.Value)
            end
        end
        if not Library.Input.MouseDown and Library.ActiveSlider == self then
            Library.ActiveSlider = nil
        end

    elseif self.Type == "Dropdown" then
        Library:DrawDropdownVisual(X, Y, Width, self.Name, self.Options[self.SelectedIndex], self.Open)

        local BarY = Y + 15
        if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(X, BarY, Width, 22) then
            Library.Input.Consumed = true
            if Library.ActiveDropdown == self then
                Library.ActiveDropdown = nil
                self.Open = false
            else
                if Library.ActiveDropdown then Library.ActiveDropdown.Open = false end
                Library.ActiveDropdown = self
                self.Open = true
            end
        end

        if self.Open and Library.ActiveDropdown == self then
            Library.DropdownOverlay = {X = X, Y = BarY + 22, Width = Width, Element = self}
        end

    elseif self.Type == "Button" then
        local IsHovered = Library:IsHovering(X, Y, Width, 22) and not Library.Input.Consumed
        Library:DrawButtonVisual(X, Y, Width, self.Name, IsHovered)
        if Library.Input.MouseClicked and IsHovered then
            Library.Input.Consumed = true
            self.Callback()
        end

    elseif self.Type == "ColorPicker" then
        Library:DrawLabel(X, Y+2, self.Name, Library.Appearance.Coloring.White)
        local SX = SwatchX(AnchorRight, 0)
        Library:DrawSwatch(SX, Y+1, Color3.fromRGB(self.Color[1], self.Color[2], self.Color[3]), self.Alpha * 255)
        if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(SX, Y+1, SW, 13) then
            Library.Input.Consumed = true
            Library:ToggleColorPickerWindow(self, SX - 260, Y + 18)
        end

    elseif self.Type == "Separator" then
        Library:DrawSeparator(X, Y, Width)

    elseif self.Type == "Label" then
        Library:DrawLabel(X, Y, self.Name, self.TextColor)

    elseif self.Type == "KeyPicker" then
        
    elseif self.Type == "Textbox" then
        local IsFocused = (Library.Input.FocusedTextbox == self)

        DrawingImmediate.FilledRectangle(Vector2.new(X, Y),   Vector2.new(Width, 22), Library.Appearance.Coloring.Black,  1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(Width-2, 20), IsFocused and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width-4, 18), Library.Appearance.Coloring.Background, 1)

        local DisplayText = self.Value ~= "" and self.Value or self.Placeholder
        local TextColor = self.Value ~= "" and Library.Appearance.Coloring.White or Library.Appearance.Coloring.Dim
        local TB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 11, DisplayText)
        DrawingImmediate.OutlinedText(Vector2.new(X + 5, Y + math.floor((22 - TB.Y) / 2)), 11, TextColor, 1, DisplayText, false, Library.Appearance.Font)

        if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(X, Y, Width, 22) then
            Library.Input.Consumed = true
            Library.Input.FocusedTextbox = self
        end

        if IsFocused then
            local PressedKeys = getpressedkeys()
            for _, Key in ipairs(PressedKeys) do
                if not table.find(self.PrevKeys, Key) then
                    if Key == "Enter" then 
                        Library.Input.FocusedTextbox = nil
                        self.PrevKeys = {}
                        self:SyncFlag()
                        self.Callback(self.Value)
                        break
                    elseif Key == "Backspace" then
                        self.Value = self.Value:sub(1, -2)
                        self:SyncFlag()
                    elseif Library.Keys[Key] and #self.Value < self.MaxLength then
                        self.Value = self.Value .. Library.Keys[Key]
                        self:SyncFlag()
                    end
                end
            end
            self.PrevKeys = getpressedkeys() or {}
        end
    end
end

-- // Section Class \\ --

local Section = {}
Section.__index = Section

function Section.New(Page, Options)
    local Self = setmetatable({}, Section)
    Self.Page = Page
    Self.Name = Options.Name or "Section"
    Self.Side = Options.Side or 1
    Self.Elements = {}
    Self.X, Self.Y, Self.Width, Self.Height = 0, 0, 0, 0
    Page.Sections[#Page.Sections + 1] = Self
    return Self
end

function Section:AddElement(ElementType, Options)
    local NewElement = Element.New(self, ElementType, Options or {})
    self.Elements[#self.Elements + 1] = NewElement
    return NewElement
end

function Section:Toggle(Options) return self:AddElement("Toggle", Options) end
function Section:Slider(Options) return self:AddElement("Slider", Options) end
function Section:Dropdown(Options) return self:AddElement("Dropdown", Options) end
function Section:Button(Options) return self:AddElement("Button", Options) end
function Section:Separator() return self:AddElement("Separator", {}) end
function Section:Label(Options) return self:AddElement("Label", Options) end
function Section:Textbox(Options) return self:AddElement("Textbox", Options) end

function Section:ColorPicker(Options)
    local NewElement = self:AddElement("ColorPicker", Options)
    local Previous = self.Elements[#self.Elements - 1]
    if Previous and Previous.Type == "Toggle" then
        assert(#Previous.AttachedColorPickers < 2, "A Toggle can only have a maximum of 2 attached ColorPickers")
        Previous.AttachedColorPickers[#Previous.AttachedColorPickers + 1] = NewElement
        NewElement.Hidden = true
    end
    return NewElement
end

function Section:KeyPicker(Options)
    Options = Options or {}
    if not Options.ToggleElement then
        local Previous = self.Elements[#self.Elements]
        assert(Previous and Previous.Type == "Toggle", "KeyPicker must be preceded by a Toggle when ToggleElement is not specified")
        Options.ToggleElement = Previous
    end
    assert(Options.ToggleElement.Type == "Toggle", "KeyPicker must have a ToggleElement that is a Toggle")
    assert(Options.ToggleElement.AttachedKeyPicker == nil, "A Toggle can only have one attached KeyPicker")
    local NewElement = self:AddElement("KeyPicker", Options)
    Options.ToggleElement.AttachedKeyPicker = NewElement
    NewElement.Hidden = true
    return NewElement
end

function Section:GetContentHeight()
    local TotalHeight = Library.LayoutConstants.SectionHeaderHeight
    for _, El in ipairs(self.Elements) do
        if not El.Hidden then
            TotalHeight = TotalHeight + El.Height
        end
    end
    return TotalHeight + Library.LayoutConstants.SectionInnerPadding
end

function Section:Render(X, Y, Width)
    self.X, self.Y, self.Width = X, Y, Width
    local Padding = Library.LayoutConstants.SectionInnerPadding
    local HeaderHeight = Library.LayoutConstants.SectionHeaderHeight

    local ContentHeight = self:GetContentHeight()
    self.Height = ContentHeight

    DrawingImmediate.FilledRectangle(Vector2.new(X,   Y), Vector2.new(Width, self.Height), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(Width-2, self.Height-2), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width-4, self.Height-4), Library.Appearance.Coloring.BackgroundDark, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width-4, 2), Library.Appearance.Coloring.Accent, 1)
    DrawingImmediate.OutlinedText( Vector2.new(X + 8, Y + 6), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, self.Name, false, Library.Appearance.Font)

    local CursorX = X + Padding
    local CursorY = Y + HeaderHeight
    local InnerWidth = Width - Padding * 2
    local SectionRightEdge = CursorX + InnerWidth

    for _, El in ipairs(self.Elements) do
        if not El.Hidden then
            El.X, El.Y, El.Width = CursorX, CursorY, InnerWidth
            El.SectionRightEdge = SectionRightEdge
            El:Render()
            CursorY = CursorY + El.Height
        end
    end
end

-- // Page Class \\ --

local Page = {}
Page.__index = Page

function Page.New(Window, Options)
    local Self = setmetatable({}, Page)
    Self.Window = Window
    Self.Name = Options.Name or "Page"
    Self.Columns = Options.Columns or 1
    Self.Sections = {}
    Window.Pages[#Window.Pages + 1] = Self
    return Self
end

function Page:Section(Options)
    return Section.New(self, Options)
end

function Page:Render(X, Y, Width, Height)
    local Columns = self.Columns
    local ColumnWidth = math.floor((Width - (Columns - 1) * 6) / Columns)
    local ColumnCursorY = {}
    for Col = 1, Columns do
        ColumnCursorY[Col] = Y + Library.LayoutConstants.SectionPadding
    end

    if Columns >= 2 then
        for DivCol = 1, Columns - 1 do
            local DivX = X + DivCol * (ColumnWidth + 6) - 4
            DrawingImmediate.FilledRectangle(
                Vector2.new(DivX, Y + Library.LayoutConstants.SectionPadding),
                Vector2.new(1, Height - Library.LayoutConstants.SectionPadding * 2),
                Library.Appearance.Coloring.Border, 0.7
            )
        end
    end

    for _, SectionInstance in ipairs(self.Sections) do
        local Col = math.clamp(SectionInstance.Side or 1, 1, Columns)
        local ColX = X + (Col - 1) * (ColumnWidth + 6) + Library.LayoutConstants.SectionPadding
        local SecY = ColumnCursorY[Col]

        SectionInstance:Render(ColX, SecY, ColumnWidth - Library.LayoutConstants.SectionPadding * 2)

        ColumnCursorY[Col] = SecY + SectionInstance.Height + Library.LayoutConstants.SectionGap
    end
end

-- // Window Class \\ --

local Window = {}
Window.__index = Window

function Window.New(Options)
    local Self = setmetatable({}, Window)
    Self.Name = Options.Name or "Window"
    Self.Width = (Options.Size and Options.Size.X) or 550
    Self.Height = (Options.Size and Options.Size.Y) or 600
    Self.X = Library.Viewport.X / 2 - Self.Width / 2
    Self.Y = Library.Viewport.Y / 2 - Self.Height / 2
    Self.Pages = {}
    Self.CurrentPageIndex = 1
    Self.Visible = true
    Self.Dragging = false
    Self.DragOffsetX = 0
    Self.DragOffsetY = 0
    Self.PreviousToggleState = false
    Self.Keybinds = {}
    Self.KeybindAnimations = {}
    Self.KeybindPreviousStates = {}
    Self.Notification = {Text = "", Timer = 0}

    Library.Windows[#Library.Windows + 1] = Self

    RunService.PostLocal:Connect(function()
        local PressedKeys = getpressedkeys() or {}

        local function IsKeyPressed(TargetKey) return table.find(PressedKeys, TargetKey) ~= nil end

        local RightShiftPressed = IsKeyPressed("RightShift")

        if RightShiftPressed and not Self.PreviousToggleState then
            Self.Visible = not Self.Visible
            Self.PreviousToggleState = true
            Library.Input.FocusedTextbox = nil
            for _, P in ipairs(Self.Pages) do
                for _, S in ipairs(P.Sections) do
                    for _, El in ipairs(S.Elements) do
                        if El.Type == "Textbox" and El.Focused then
                            El.Focused = false
                            El.PrevKeys = {}
                        end
                    end
                end
            end
        elseif not RightShiftPressed then
            Self.PreviousToggleState = false
        end

        if Library.CapturingKeyPicker then
            local Keypicker = Library.CapturingKeyPicker
            local ElapsedTime = tick() - Keypicker.CapturingTime
            if ElapsedTime >= 0.4 then
                for _, Key in ipairs(PressedKeys) do
                    if Key ~= "LeftButton" and Key ~= "RightButton" and Key ~= "MB1" and Key ~= "MB2" and Key ~= "" then
                        Keypicker.BoundKey = Key
                        Keypicker.Capturing = false
                        Keypicker:SyncFlag()
                        Library.CapturingKeyPicker = nil
                        break
                    end
                end
            end
        end

        for _, Keybind in ipairs(Self.Keybinds) do
            local KeyIsActive = IsKeyPressed(Keybind.Code)

            if KeyIsActive then
                local WasPressedLastFrame = Self.KeybindPreviousStates[Keybind.Key] or false
                if not WasPressedLastFrame then
                    if Keybind.Element.Type == "Toggle" then
                        Keybind.Element.Value = not Keybind.Element.Value
                        Keybind.Element:SyncFlag()
                        Keybind.Element.Callback(Keybind.Element.Value)
                    end
                    Self.KeybindPreviousStates[Keybind.Key] = true
                end
            else
                Self.KeybindPreviousStates[Keybind.Key] = nil
            end
        end

        for _, Keypicker in ipairs(Library.Input.ActiveKeyPickers) do
            if Keypicker.BoundKey ~= "None" then
                local TE = Keypicker.ToggleElement
                if TE then
                    local KeyIsActive = IsKeyPressed(Keypicker.BoundKey)

                    if Keypicker.Mode == "Toggle" then
                        local WasPressedLastFrame = Keypicker.PrevPressed or false

                        if KeyIsActive and not WasPressedLastFrame then
                            TE.Value = not TE.Value
                            TE:SyncFlag()
                            TE.Callback(TE.Value)
                            Keypicker.PrevPressed = true
                        elseif not KeyIsActive then
                            Keypicker.PrevPressed = false
                        end

                    elseif Keypicker.Mode == "Hold" then
                        if TE.Value ~= KeyIsActive then
                            TE.Value = KeyIsActive
                            TE:SyncFlag()
                            TE.Callback(TE.Value)
                        end
                    end
                end
            end
        end
    end)

    return Self
end

function Window:Page(Options)
    return Page.New(self, Options)
end

function Window:Notify(Text)
    self.Notification.Text = Text
    self.Notification.Timer = 120
end

function Window:BindKey(Name, Code, ElementInstance)
    self.Keybinds[#self.Keybinds + 1] = {Key = Name, Code = Code, Element = ElementInstance, Name = ElementInstance.Name}
    self.KeybindAnimations[Name] = {X = 120, Alpha = 0}
end

function Window:RenderKeybindList()
    if #self.Keybinds == 0 then return end

    local BaseX = Library.Viewport.X - 185
    local BaseY = 50
    local Index = 0
    local AnimationSpeed = 0.12

    local AnyVisible = false
    for _, Keybind in ipairs(self.Keybinds) do
        if (self.KeybindAnimations[Keybind.Key].Alpha or 0) > 0.01 then
            AnyVisible = true; break
        end
    end

    if AnyVisible then
        DrawingImmediate.FilledRectangle(Vector2.new(BaseX, BaseY-22), Vector2.new(175, 20), Library.Appearance.Coloring.Black, 0.7)
        DrawingImmediate.FilledRectangle(Vector2.new(BaseX, BaseY-22), Vector2.new(175, 2), Library.Appearance.Coloring.Accent, 1)
        DrawingImmediate.OutlinedText(Vector2.new(BaseX + 4, BaseY-18), 11, Library.Appearance.Coloring.White, 0.9, "Keybinds", false, Library.Appearance.Font)
    end

    for _, Keybind in ipairs(self.Keybinds) do
        local Animation = self.KeybindAnimations[Keybind.Key]
        local IsOn = Keybind.Element.Value or false
        local TargetX = IsOn and 0 or 120
        local TargetAlpha = IsOn and 1 or 0
        Animation.X = Animation.X + (TargetX - Animation.X) * AnimationSpeed
        Animation.Alpha = Animation.Alpha + (TargetAlpha - Animation.Alpha) * AnimationSpeed

        if Animation.Alpha > 0.01 then
            local EntryX = BaseX + Animation.X
            local EntryY = BaseY + Index * 22
            DrawingImmediate.FilledRectangle(Vector2.new(EntryX, EntryY), Vector2.new(175, 20), Library.Appearance.Coloring.Black, Animation.Alpha * 0.8)
            DrawingImmediate.FilledRectangle(Vector2.new(EntryX, EntryY), Vector2.new(2, 20), Library.Appearance.Coloring.Accent, Animation.Alpha)
            DrawingImmediate.OutlinedText(Vector2.new(EntryX + 6, EntryY + 3), 11, Library.Appearance.Coloring.White, Animation.Alpha, Keybind.Element.Name, false, Library.Appearance.Font)
            DrawingImmediate.OutlinedText(Vector2.new(EntryX + 130,EntryY + 3), 11, Library.Appearance.Coloring.Dim,   Animation.Alpha, "[" .. Keybind.Key .. "]", false, Library.Appearance.Font)
            Index = Index + 1
        end
    end
end

function Window:Render()
    if Library.ActiveColorPicker and Library.ActiveColorPicker.LastRect and Library.Input.MouseClicked then
        local Rect = Library.ActiveColorPicker.LastRect
        if Library:IsHovering(Rect[1], Rect[2], Rect[3], Rect[4]) then
            Library.Input.Consumed = true
        end
    end

    if Library.LastDropdownRect and Library.ActiveDropdown and Library.ActiveDropdown.Open and Library.Input.MouseClicked then
        local Rect = Library.LastDropdownRect
        if Library:IsHovering(Rect[1], Rect[2], Rect[3], Rect[4]) then
            Library.Input.Consumed = true
        elseif not Library:IsHovering(Rect[5], Rect[6], Rect[7], Rect[8]) then
            Library.ActiveDropdown.Open = false
            Library.ActiveDropdown = nil
        end
    end

    local X, Y = self.X, self.Y
    if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(X, Y, self.Width, 26) then
        self.Dragging = true
        self.DragOffsetX = Library.Input.MouseX - X
        self.DragOffsetY = Library.Input.MouseY - Y
        Library.Input.Consumed = true
    end
    if not Library.Input.MouseDown then self.Dragging = false end
    if self.Dragging then
        self.X = Library.Input.MouseX - self.DragOffsetX
        self.Y = Library.Input.MouseY - self.DragOffsetY
        X, Y = self.X, self.Y
    end

    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(self.Width, self.Height), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(self.Width-2, self.Height-2), Library.Appearance.Coloring.Accent, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(self.Width-4, self.Height-4), Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 9, Y + 8), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, self.Name, false, Library.Appearance.Font)

    local CX, CY = X + 9, Y + 26
    local CW, CH = self.Width - 18, self.Height - 35
    DrawingImmediate.FilledRectangle(Vector2.new(CX, CY), Vector2.new(CW, CH), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CX + 1, CY + 1), Vector2.new(CW-2, CH-2), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CX + 2, CY + 2), Vector2.new(CW-4, CH-4), Library.Appearance.Coloring.BackgroundDark, 1)

    local NumTabs = #self.Pages
    local TabGap = 2
    local TotalGaps = (NumTabs - 1) * TabGap
    local TotalTabWidth = CW - 14
    local TabWidth = math.floor((TotalTabWidth - TotalGaps) / NumTabs)
    local TabY = CY + 4
    for Index, PageInstance in ipairs(self.Pages) do
        local TabX = CX + 7 + (Index - 1) * (TabWidth + TabGap)
        local IsActive = (self.CurrentPageIndex == Index)
        DrawingImmediate.FilledRectangle(Vector2.new(TabX, TabY), Vector2.new(TabWidth, 23), Library.Appearance.Coloring.Border, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(TabX + 1, TabY + 1), Vector2.new(TabWidth-2, IsActive and 22 or 21), IsActive and Library.Appearance.Coloring.Background or Library.Appearance.Coloring.BackgroundDark, 1)
        if IsActive then
            DrawingImmediate.FilledRectangle(Vector2.new(TabX, TabY + 22), Vector2.new(TabWidth, 9), Library.Appearance.Coloring.Border, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(TabX + 1, TabY + 22), Vector2.new(TabWidth-2, 9), Library.Appearance.Coloring.Background, 1)
        end
        local TextBounds = DrawingImmediate.GetTextBounds(Library.Appearance.Font, Library.Appearance.FontSize, PageInstance.Name)
        local TextX = TabX + math.floor((TabWidth - TextBounds.X) / 2)
        DrawingImmediate.OutlinedText(Vector2.new(TextX, TabY + 5), Library.Appearance.FontSize, IsActive and Library.Appearance.Coloring.White or Library.Appearance.Coloring.Dim, 1, PageInstance.Name, false, Library.Appearance.Font)
        if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(TabX, TabY, TabWidth, 23) then
            Library.Input.Consumed = true
            self.CurrentPageIndex = Index
            if Library.ActiveDropdown then Library.ActiveDropdown.Open = false end
            Library.ActiveDropdown = nil
            Library.ActiveColorPicker = nil
            Library.KeyPickerContext = nil
            Library.Input.FocusedTextbox = nil
        end
    end

    local IX, IY = CX + 7, CY + 30
    local IW, IH = CW - 14, CH - 37
    DrawingImmediate.FilledRectangle(Vector2.new(IX, IY), Vector2.new(IW, IH), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(IX + 1, IY + 1), Vector2.new(IW-2, IH-2), Library.Appearance.Coloring.Background, 1)

    local CurrentPage = self.Pages[self.CurrentPageIndex]
    if CurrentPage then
        CurrentPage:Render(IX, IY, IW, IH)
    end

    if Library.DropdownOverlay then
        local Overlay = Library.DropdownOverlay
        local DropdownElement = Overlay.Element
        local TotalHeight = #DropdownElement.Options * 20
        Library.LastDropdownRect = {
            Overlay.X, Overlay.Y, Overlay.Width, TotalHeight,
            Overlay.X, Overlay.Y - 22, Overlay.Width, 22 + TotalHeight,
        }
        for Index, Option in ipairs(DropdownElement.Options) do
            local OptionY = Overlay.Y + (Index - 1) * 20
            local IsHovered = Library:IsHovering(Overlay.X, OptionY, Overlay.Width, 20)
            DrawingImmediate.FilledRectangle(Vector2.new(Overlay.X, OptionY), Vector2.new(Overlay.Width, 20), Library.Appearance.Coloring.Black, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(Overlay.X + 1, OptionY + 1), Vector2.new(Overlay.Width-2, 18), IsHovered and Library.Appearance.Coloring.Border or (Index == DropdownElement.SelectedIndex and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background), 1)
            DrawingImmediate.OutlinedText(Vector2.new(Overlay.X + 4, OptionY + 3), Library.Appearance.FontSize, 1, Option, false, Library.Appearance.Font)
            if Library.Input.MouseClicked and IsHovered then
                DropdownElement.SelectedIndex = Index
                DropdownElement.Open = false
                Library.ActiveDropdown = nil
                Library.Input.Consumed = true
                DropdownElement:SyncFlag()
                DropdownElement.Callback(DropdownElement.Options[Index])
            end
        end
    else
        Library.LastDropdownRect = nil
    end

    if Library.KeyPickerContext then
        local Keypicker = Library.KeyPickerContext.Element
        local MX = Library.KeyPickerContext.X
        local MY = Library.KeyPickerContext.Y
        local MenuW = 90
        local MenuH = 4 + #{"Toggle", "Hold"} * 22 + 4

        DrawingImmediate.FilledRectangle(Vector2.new(MX, MY), Vector2.new(MenuW, MenuH), Library.Appearance.Coloring.Black, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(MX + 1, MY + 1), Vector2.new(MenuW-2, MenuH-2), Library.Appearance.Coloring.Border, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(MX + 2, MY + 2), Vector2.new(MenuW-4, MenuH-4), Library.Appearance.Coloring.BackgroundDark, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(MX + 2, MY + 2), Vector2.new(MenuW-4, 2), Library.Appearance.Coloring.Accent, 1)

        for Index, Mode in ipairs({"Toggle", "Hold"}) do
            local OptionY = MY + 4 + (Index - 1) * 22
            local IsHovered = Library:IsHovering(MX+4, OptionY, MenuW-8, 20)
            local IsActive = (Keypicker.Mode == Mode)

            DrawingImmediate.FilledRectangle(Vector2.new(MX + 4, OptionY), Vector2.new(MenuW-8, 20), Library.Appearance.Coloring.Black,  1)
            DrawingImmediate.FilledRectangle(Vector2.new(MX + 5, OptionY + 1), Vector2.new(MenuW-10, 18),
                IsHovered and Library.Appearance.Coloring.Border or Library.Appearance.Coloring.Background, 1)

            DrawingImmediate.FilledRectangle(Vector2.new(MX + 8,  OptionY + 4), Vector2.new(11, 11), Library.Appearance.Coloring.Black,  1)
            DrawingImmediate.FilledRectangle(Vector2.new(MX + 9,  OptionY + 5), Vector2.new(9, 9), IsActive and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(MX + 10, OptionY + 6), Vector2.new(7, 7), IsActive and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.BackgroundDark, 1)

            DrawingImmediate.OutlinedText(Vector2.new(MX + 23, OptionY + 3), Library.Appearance.FontSize,
                IsActive and Library.Appearance.Coloring.White or Library.Appearance.Coloring.Dim,
                1, Mode, false, Library.Appearance.Font)

            if Library.Input.MouseClicked and IsHovered then
                Keypicker.Mode = Mode
                Keypicker.ContextOpen = false
                Library.KeyPickerContext = nil
                Library.Input.Consumed = true
                Keypicker:SyncFlag()
            end
        end

        if Library.Input.MouseClicked and not Library.Input.Consumed then
            Keypicker.ContextOpen = false
            Library.KeyPickerContext = nil
        end
    end

    Library:RenderColorPicker()

    if self.Notification.Timer > 0 then
        self.Notification.Timer = self.Notification.Timer - 1
        local Alpha = math.min(self.Notification.Timer / 30, 1)
        DrawingImmediate.OutlinedText(Vector2.new(X + self.Width/2, Y + self.Height + 8), Library.Appearance.FontSize, Library.Appearance.Coloring.Accent, Alpha, self.Notification.Text, true, Library.Appearance.Font)
    end

    if Library.Input.MouseClicked and Library.ActiveDropdown and Library.ActiveDropdown.Open and not Library.Input.Consumed then
        Library.ActiveDropdown.Open = false
        Library.ActiveDropdown = nil
    end
    
    for _, P in ipairs(self.Pages) do
        for _, S in ipairs(P.Sections) do
            for _, El in ipairs(S.Elements) do
                if El.Type == "Textbox" and El.Focused then
                    El.Focused = false
                    El.PrevKeys = {}
                end
            end
        end
    end
end

-- // Color Picker Window \\ --

function Library:ToggleColorPickerWindow(ColorPickerElement, SpawnX, SpawnY)
    if self.ActiveColorPicker == ColorPickerElement then
        self.ActiveColorPicker = nil
        return
    end
    self.ActiveColorPicker = ColorPickerElement
    self.ActiveColorPicker.WindowX = SpawnX
    self.ActiveColorPicker.WindowY = SpawnY
    self.ActiveColorPicker.WindowWidth = 260
    self.ActiveColorPicker.WindowHeight = 250
    local H, S, V = self:RGBToHSV(ColorPickerElement.Color[1], ColorPickerElement.Color[2], ColorPickerElement.Color[3])
    self.ActiveColorPicker.Hue = H
    self.ActiveColorPicker.Saturation = S
    self.ActiveColorPicker.Value = V
end

function Library:RenderColorPicker()
    local PickerElement = self.ActiveColorPicker
    if not PickerElement then return end

    local WX = PickerElement.WindowX
    local WY = PickerElement.WindowY
    local WW = PickerElement.WindowWidth
    local WH = PickerElement.WindowHeight

    local CloseX = WX + WW - 22
    if self.Input.MouseClicked and self:IsHovering(CloseX, WY + 4, 16, 16) then
        self.ActiveColorPicker = nil
        return
    end

    if self.Input.MouseClicked and self:IsHovering(WX, WY, WW - 24, 22) then
        PickerElement.WindowDragging = true
        PickerElement.WindowDragOffsetX = self.Input.MouseX - WX
        PickerElement.WindowDragOffsetY = self.Input.MouseY - WY
    end
    if not self.Input.MouseDown then PickerElement.WindowDragging = false end
    if PickerElement.WindowDragging then
        PickerElement.WindowX = self.Input.MouseX - PickerElement.WindowDragOffsetX
        PickerElement.WindowY = self.Input.MouseY - PickerElement.WindowDragOffsetY
        WX, WY = PickerElement.WindowX, PickerElement.WindowY
    end

    PickerElement.LastRect = {WX, WY, WW, WH}

    DrawingImmediate.FilledRectangle(Vector2.new(WX,   WY), Vector2.new(WW, WH), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(WX + 1, WY + 1), Vector2.new(WW-2, WH-2), self.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(WX + 2, WY + 2), Vector2.new(WW-4, WH-4), self.Appearance.Coloring.Background, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(WX + 2, WY + 2), Vector2.new(WW-4, 2), self.Appearance.Coloring.Accent, 1)
    DrawingImmediate.OutlinedText(   Vector2.new(WX + 8, WY + 6), self.Appearance.FontSize, self.Appearance.Coloring.White, 1, PickerElement.Name .. " Color", false, self.Appearance.Font)

    local CloseHovered = self:IsHovering(CloseX, WY + 4, 16, 16)
    DrawingImmediate.FilledRectangle(Vector2.new(CloseX, WY + 4), Vector2.new(16, 16), CloseHovered and Color3.fromRGB(200, 50, 50) or self.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(CloseX + 4, WY + 5), self.Appearance.FontSize, self.Appearance.Coloring.White, 1, "X", false, self.Appearance.Font)

    local SVX, SVY = WX + 8, WY + 24
    local SVSize = 170
    local PixelStep = 4

    DrawingImmediate.FilledRectangle(Vector2.new(SVX-1, SVY-1), Vector2.new(SVSize+2, SVSize+2), self.Appearance.Coloring.Black, 1)

    for PX = 0, SVSize-1, PixelStep do
        for PY = 0, SVSize-1, PixelStep do
            local S = PX / SVSize
            local V = 1 - (PY / SVSize)
            local R, G, B = self:HSVToRGB(PickerElement.Hue, S, V)
            DrawingImmediate.FilledRectangle(Vector2.new(SVX+PX, SVY+PY), Vector2.new(PixelStep, PixelStep), Color3.fromRGB(R, G, B), 1)
        end
    end

    local CX = SVX + math.floor(PickerElement.Saturation * (SVSize - 1))
    local CY = SVY + math.floor((1 - PickerElement.Value) * (SVSize - 1))
    DrawingImmediate.FilledRectangle(Vector2.new(CX-4, CY-4), Vector2.new(9, 9), self.Appearance.Coloring.White, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CX-3, CY-3), Vector2.new(7, 7), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CX-2, CY-2), Vector2.new(5, 5), Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]), 1)

    if self.Input.MouseClicked and self:IsHovering(SVX, SVY, SVSize, SVSize) then
        PickerElement.DraggingSV = true
    end
    if PickerElement.DraggingSV and self.Input.MouseDown then
        PickerElement.Saturation = math.clamp((self.Input.MouseX - SVX) / SVSize, 0, 1)
        PickerElement.Value = math.clamp(1 - (self.Input.MouseY - SVY) / SVSize, 0, 1)
        PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3] = self:HSVToRGB(PickerElement.Hue, PickerElement.Saturation, PickerElement.Value)
        PickerElement:SyncFlag()
        PickerElement.Callback(Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]))
    end
    if not self.Input.MouseDown then PickerElement.DraggingSV = false end

    local PrevX, PrevY = WX + 185, WY + 24
    DrawingImmediate.FilledRectangle(Vector2.new(PrevX, PrevY),   Vector2.new(55, 40), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(PrevX + 1, PrevY + 1), Vector2.new(53, 38), Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]), PickerElement.Alpha)

    DrawingImmediate.OutlinedText(Vector2.new(PrevX, PrevY + 46), 11, self.Appearance.Coloring.Dim, 1, math.floor(PickerElement.Color[1]) .. ", " .. math.floor(PickerElement.Color[2]), false, self.Appearance.Font)
    DrawingImmediate.OutlinedText(Vector2.new(PrevX, PrevY + 60), 11, self.Appearance.Coloring.Dim, 1, tostring(math.floor(PickerElement.Color[3])), false, self.Appearance.Font)
    local HexValue = string.format("#%02X%02X%02X", PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3])
    DrawingImmediate.OutlinedText(Vector2.new(PrevX, PrevY + 74), 11, self.Appearance.Coloring.Accent, 1, HexValue, false, self.Appearance.Font)
    DrawingImmediate.OutlinedText(Vector2.new(PrevX, PrevY + 88), 11, self.Appearance.Coloring.Dim, 1, string.format("A: %.2f", PickerElement.Alpha), false, self.Appearance.Font)

    local HueX, HueY = WX + 8, WY + 200
    local HueW, HueH = 170, 14
    local HueStep = 2

    DrawingImmediate.FilledRectangle(Vector2.new(HueX-1, HueY-1), Vector2.new(HueW+2, HueH+2), self.Appearance.Coloring.Black, 1)
    for HX = 0, HueW-1, HueStep do
        local H = HX / HueW
        local R, G, B = self:HSVToRGB(H, 1, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(HueX+HX, HueY), Vector2.new(HueStep, HueH), Color3.fromRGB(R, G, B), 1)
    end
    local HueCursorX = HueX + math.floor(PickerElement.Hue * (HueW - 1))
    DrawingImmediate.FilledRectangle(Vector2.new(HueCursorX-2, HueY-2), Vector2.new(5, HueH+4), self.Appearance.Coloring.White, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(HueCursorX-1, HueY-1), Vector2.new(3, HueH+2), self.Appearance.Coloring.Black, 1)

    if self.Input.MouseClicked and self:IsHovering(HueX, HueY-2, HueW, HueH+4) then
        PickerElement.DraggingHue = true
    end
    if PickerElement.DraggingHue and self.Input.MouseDown then
        PickerElement.Hue = math.clamp((self.Input.MouseX - HueX) / HueW, 0, 0.999)
        PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3] = self:HSVToRGB(PickerElement.Hue, PickerElement.Saturation, PickerElement.Value)
        PickerElement:SyncFlag()
        PickerElement.Callback(Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]))
    end
    if not self.Input.MouseDown then PickerElement.DraggingHue = false end

    local AlphaX, AlphaY = WX + 8, WY + 220
    local AlphaW, AlphaH = 170, 14

    local CheckStep = 7
    for AX = 0, AlphaW-1, CheckStep do
        local Dark = (math.floor(AX / CheckStep) % 2 == 0)
        local ChunkW = math.min(CheckStep, AlphaW - AX)
        DrawingImmediate.FilledRectangle(Vector2.new(AlphaX+AX, AlphaY), Vector2.new(ChunkW, AlphaH/2), Dark and Color3.fromRGB(100,100,100) or Color3.fromRGB(160, 160, 160), 1)
        DrawingImmediate.FilledRectangle(Vector2.new(AlphaX+AX, AlphaY+AlphaH/2), Vector2.new(ChunkW, AlphaH/2), Dark and Color3.fromRGB(160,160,160) or Color3.fromRGB(100, 100, 100), 1)
    end

    local Steps = 20
    for Step = 0, Steps-1 do
        local Alpha = 1 - (Step / Steps)
        local StepX = AlphaX + math.floor(Step / Steps * AlphaW)
        local StepW = math.floor(AlphaW / Steps) + 1
        DrawingImmediate.FilledRectangle(Vector2.new(StepX, AlphaY), Vector2.new(StepW, AlphaH),
            Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]), Alpha)
    end

    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX-1, AlphaY-1), Vector2.new(AlphaW + 2, AlphaH + 2), self.Appearance.Coloring.Black, 0)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX-1, AlphaY-1), Vector2.new(AlphaW + 2, 1), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX-1, AlphaY+AlphaH), Vector2.new(AlphaW + 2, 1), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX-1, AlphaY-1), Vector2.new(1, AlphaH + 2), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX+AlphaW, AlphaY-1), Vector2.new(1, AlphaH + 2), self.Appearance.Coloring.Black, 1)

    local AlphaCursorX = AlphaX + math.floor((1 - PickerElement.Alpha) * (AlphaW - 1))
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaCursorX-2, AlphaY-2), Vector2.new(5, AlphaH + 4), self.Appearance.Coloring.White, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaCursorX-1, AlphaY-1), Vector2.new(3, AlphaH + 2), self.Appearance.Coloring.Black, 1)

    if self.Input.MouseClicked and self:IsHovering(AlphaX, AlphaY-2, AlphaW, AlphaH + 4) then
        PickerElement.DraggingAlpha = true
    end
    if PickerElement.DraggingAlpha and self.Input.MouseDown then
        PickerElement.Alpha = math.clamp(1 - (self.Input.MouseX - AlphaX) / AlphaW, 0, 1)
        PickerElement:SyncFlag()
        PickerElement.Callback(Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]))
    end
    if not self.Input.MouseDown then PickerElement.DraggingAlpha = false end
end

function Library:ExportFlags()
    local Lines = {"return {"}
    for Flag, Value in pairs(self.Flags) do
        local T = type(Value)
        if T == "boolean" then
            Lines[#Lines+1] = string.format('  ["%s"] = %s,', Flag, tostring(Value))
        elseif T == "number" then
            Lines[#Lines+1] = string.format('  ["%s"] = %s,', Flag, tostring(Value))
        elseif T == "table" then
            local Parts = {}
            if Value.Color then
                local C = Value.Color
                Parts[#Parts+1] = string.format("Color = Color3.fromRGB(%d,%d,%d)", math.floor(C.R*255), math.floor(C.G*255), math.floor(C.B*255))
            end
            if Value.Alpha ~= nil then Parts[#Parts+1] = "Alpha = " .. tostring(Value.Alpha) end
            if Value.Value ~= nil then Parts[#Parts+1] = "Value = " .. (type(Value.Value) == "string" and ('"'..Value.Value..'"') or tostring(Value.Value)) end
            if Value.Key   ~= nil then Parts[#Parts+1] = 'Key = "' .. tostring(Value.Key) .. '"' end
            if Value.Mode  ~= nil then Parts[#Parts+1] = 'Mode = "' .. tostring(Value.Mode) .. '"' end
            Lines[#Lines+1] = string.format('  ["%s"] = {%s},', Flag, table.concat(Parts, ", "))
        end
    end
    Lines[#Lines+1] = "}"
    return table.concat(Lines, "\n")
end

function Library:ApplyFlags(LoadedFlags)
    for _, Win in ipairs(self.Windows) do
        for _, P in ipairs(Win.Pages) do
            for _, S in ipairs(P.Sections) do
                for _, El in ipairs(S.Elements) do
                    if El.Flag and LoadedFlags[El.Flag] ~= nil then
                        local Saved = LoadedFlags[El.Flag]
                        if El.Type == "Toggle" then
                            El.Value = Saved == true
                            El:SyncFlag()
                            pcall(El.Callback, El.Value)
                        elseif El.Type == "Slider" then
                            El.Value = tonumber(Saved.Value) or El.Value
                            El:SyncFlag()
                            pcall(El.Callback, El.Value)
                        elseif El.Type == "Dropdown" then
                            for i, Opt in ipairs(El.Options) do
                                if Opt == Saved.Value then El.SelectedIndex = i break end
                            end
                            El:SyncFlag()
                            pcall(El.Callback, El.Options[El.SelectedIndex])
                        elseif El.Type == "ColorPicker" then
                            if Saved.Color then
                                El.Color = {Saved.Color.R*255, Saved.Color.G*255, Saved.Color.B*255}
                            end
                            if Saved.Alpha ~= nil then El.Alpha = Saved.Alpha end
                            El:SyncFlag()
                            pcall(El.Callback, Color3.fromRGB(El.Color[1], El.Color[2], El.Color[3]))
                        elseif El.Type == "KeyPicker" then
                            if Saved.Key  then El.BoundKey = Saved.Key  end
                            if Saved.Mode then El.Mode     = Saved.Mode end
                            El:SyncFlag()
                        end
                    end
                end
            end
        end
    end
end

function Library:Settings()
    assert(#self.Windows > 0, "No windows exist")
    
    local Win = self.Windows[#self.Windows]
    local SettingsPage = Win:Page({Name = "Settings", Columns = 2})
    local ThemeSection = SettingsPage:Section({Name = "Theme", Side = 1})

    local ColorDefs = {
        {Name = "Accent", Key = "Accent"},
        {Name = "Accent Dark", Key = "AccentDark"},
        {Name = "Background", Key = "Background"},
        {Name = "Background Dark", Key = "BackgroundDark"},
        {Name = "Border",  Key = "Border"},
    }

    local ThemePickers = {}
    for _, Def in ipairs(ColorDefs) do
        local Picker = ThemeSection:ColorPicker({
            Name = Def.Name,
            Flag = "Theme_" .. Def.Key,
            Default = self.Appearance.Coloring[Def.Key],
            DefaultAlpha = 1,
            Callback = function(Color)
                Library.Appearance.Coloring[Def.Key] = Color
            end,
        })
        ThemePickers[Def.Key] = Picker
    end

    ThemeSection:Separator()
    ThemeSection:Label({Name = "Presets", Color = self.Appearance.Coloring.Dim})

    local Presets = {
        {Name = "Purple", Colors = {177,156,217,139,107,163}},
        {Name = "B",   Colors = {100,160,255, 60,120,200}},
        {Name = "R",    Colors = {255,100,100,200, 60, 60}},
        {Name = "G",  Colors = {100,255,130, 60,200, 80}},
    }
    for _, Preset in ipairs(Presets) do
        ThemeSection:Button({
            Name = Preset.Name,
            Callback = function()
                local C = Preset.Colors
                Library.Appearance.Coloring.Accent     = Color3.fromRGB(C[1],C[2],C[3])
                Library.Appearance.Coloring.AccentDark = Color3.fromRGB(C[4],C[5],C[6])
                ThemePickers["Accent"].Color     = {C[1],C[2],C[3]}
                ThemePickers["AccentDark"].Color = {C[4],C[5],C[6]}
                ThemePickers["Accent"]:SyncFlag()
                ThemePickers["AccentDark"]:SyncFlag()
                Win:Notify("Theme: " .. Preset.Name)
            end,
        })
    end

    local ConfigSection = SettingsPage:Section({Name = "Config", Side = 2})

    local State = {
        List = {},
        Selected = nil,
    }

    local function RefreshList()
        State.List = {}
        if isfolder(Library.Folders.Configs) then
            for _, Path in ipairs(listfiles(Library.Folders.Configs)) do
                local Name = Path:match("([^/\\]+)$")
                if Name and Name:sub(-4) == ".lua" then
                    State.List[#State.List+1] = Name:sub(1,-5)
                end
            end
        end
        table.sort(State.List)
        if State.Selected then
            local Found = false
            for _, N in ipairs(State.List) do
                if N == State.Selected then Found = true break end
            end
            if not Found then State.Selected = nil end
        end
    end

    RefreshList()

    local BoxRows = 5
    local RowH = 16
    local BoxH = BoxRows * RowH + 6
    local ListBox = ConfigSection:Label({Name = ""})
    ListBox.Height = BoxH + 4

    local NameBox = ConfigSection:Textbox({
        Placeholder = "Config name...",
        MaxLength = 48,
        Callback = function(Value) end,
    })

    function ListBox:Render()
        local X, Y, W = self.X, self.Y, self.Width
        DrawingImmediate.FilledRectangle(Vector2.new(X,   Y),   Vector2.new(W,   BoxH),   Library.Appearance.Coloring.Black,          1)
        DrawingImmediate.FilledRectangle(Vector2.new(X+1, Y+1), Vector2.new(W-2, BoxH-2), Library.Appearance.Coloring.Border,         1)
        DrawingImmediate.FilledRectangle(Vector2.new(X+2, Y+2), Vector2.new(W-4, BoxH-4), Library.Appearance.Coloring.BackgroundDark, 1)

        if #State.List == 0 then
            local TB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 11, "No configs saved")
            DrawingImmediate.OutlinedText(
                Vector2.new(X + math.floor((W - TB.X) / 2), Y + math.floor((BoxH - TB.Y) / 2)),
                11, Library.Appearance.Coloring.Dim, 1, "No configs saved", false, Library.Appearance.Font)
            return
        end

        for i, Name in ipairs(State.List) do
            if i > BoxRows then break end
            local RY = Y + 3 + (i-1) * RowH
            local IsSelected = (State.Selected == Name)
            local TB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 11, Name)
            DrawingImmediate.OutlinedText(
                Vector2.new(X + math.floor((W - TB.X) / 2), RY + math.floor((RowH - TB.Y) / 2)),
                11, IsSelected and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.Dim,
                1, Name, false, Library.Appearance.Font)

            if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(X+2, RY, W-4, RowH) then
                Library.Input.Consumed = true
                State.Selected = Name
                NameBox.Value = Name
            end
        end
    end

    -- Button rows
    local function MakeButtonRow(LabelA, CallbackA, LabelB, CallbackB)
        local Row = ConfigSection:Label({Name = ""})
        Row.Height = 26
        function Row:Render()
            local X, Y, W = self.X, self.Y, self.Width
            local BW = math.floor((W - 3) / 2)
            local function DrawBtn(BX, Label, Callback)
                local Hov = Library:IsHovering(BX, Y, BW, 22) and not Library.Input.Consumed
                DrawingImmediate.FilledRectangle(Vector2.new(BX,   Y),   Vector2.new(BW,   22), Library.Appearance.Coloring.Black,  1)
                DrawingImmediate.FilledRectangle(Vector2.new(BX+1, Y+1), Vector2.new(BW-2, 20), Library.Appearance.Coloring.Border, 1)
                DrawingImmediate.FilledRectangle(Vector2.new(BX+2, Y+2), Vector2.new(BW-4, 18), Hov and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background, 1)
                local TB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 11, Label)
                DrawingImmediate.OutlinedText(
                    Vector2.new(BX + math.floor((BW - TB.X) / 2), Y + math.floor((22 - TB.Y) / 2)),
                    11, Hov and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.White,
                    1, Label, false, Library.Appearance.Font)
                if Library.Input.MouseClicked and Hov then
                    Library.Input.Consumed = true
                    Callback()
                end
            end
            DrawBtn(X, LabelA, CallbackA)
            DrawBtn(X + BW + 3, LabelB, CallbackB)
        end
    end

    local function SaveConfig()
        local Name = NameBox.Value ~= "" and NameBox.Value or State.Selected
        if not Name or Name == "" then Win:Notify("Enter a config name") return end
        local ok = pcall(writefile, Library.Folders.Configs .. "/" .. Name .. ".lua", Library:ExportFlags())
        if ok then
            State.Selected = Name
            RefreshList()
            Win:Notify("Saved: " .. Name)
        else
            Win:Notify("Save failed")
        end
    end

    local function LoadConfig()
        local Name = State.Selected
        if not Name then Win:Notify("No config selected") return end
        local Path = Library.Folders.Configs .. "/" .. Name .. ".lua"
        if not isfile(Path) then Win:Notify("File not found") return end
        local fn = loadstring(readfile(Path))
        if not fn then Win:Notify("Parse error") return end
        local ok, Data = pcall(fn)
        if not ok or type(Data) ~= "table" then Win:Notify("Load error") return end
        Library:ApplyFlags(Data)
        Win:Notify("Loaded: " .. Name)
    end

    local function DeleteConfig()
        local Name = State.Selected
        if not Name then Win:Notify("No config selected") return end
        local Path = Library.Folders.Configs .. "/" .. Name .. ".lua"
        if not isfile(Path) then Win:Notify("File not found") return end
        delfile(Path)
        NameBox.Value = ""
        RefreshList()
        Win:Notify("Deleted: " .. Name)
    end

    MakeButtonRow("Save", SaveConfig, "Load", LoadConfig)
    MakeButtonRow("Delete", DeleteConfig, "Refresh", function()
        RefreshList()
        Win:Notify("Refreshed")
    end)

    return SettingsPage
end

function Library:Window(Options)
    return Window.New(Options or {})
end

RunService.Render:Connect(function()
    Library:UpdateInput()
    Library.Input.Consumed = false
    Library.DropdownOverlay = nil

    local Now = tick()
    for _, WindowInstance in ipairs(Library.Windows) do
        local WatermarkText = WindowInstance.Name .. "  |  " .. math.floor(get_overlay_fps()) .. " fps"
        local WatermarkWidth = #WatermarkText * 7 + 16
        DrawingImmediate.FilledRectangle(Vector2.new(10, 10), Vector2.new(WatermarkWidth, 22), Library.Appearance.Coloring.Black, 0.8)
        DrawingImmediate.FilledRectangle(Vector2.new(10, 10), Vector2.new(WatermarkWidth,  2), Library.Appearance.Coloring.Accent, 1)
        DrawingImmediate.OutlinedText(   Vector2.new(18, 14), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 0.9, WatermarkText, false, Library.Appearance.Font)

        if WindowInstance.Visible then
            WindowInstance:RenderKeybindList()
            WindowInstance:Render()
        end
    end
end)

return Library
