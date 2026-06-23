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
        Configs = "Goop/" .. tostring(game.GameId) .. "/Configs",
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
    },

    KeyAppearance = {
        ["LeftMouse"] = "mb1",
        ["RightMouse"] = "mb2",

        ["Escape"] = "esc",

        ["F1"] = "f1",
        ["F2"] = "f2",
        ["F3"] = "f3",
        ["F4"] = "f4",
        ["F5"] = "f5",
        ["F6"] = "f6",
        ["F7"] = "f7",
        ["F8"] = "f8",
        ["F9"] = "f9",
        ["F10"] = "f10",
        ["F11"] = "f11",
        ["F12"] = "f12",
    
        ["PrintScreen"] = "prt",

        ["Insert"] = "ins",
        ["Delete"] = "del",

        ["MediaPrevTrack"] = "prev",
        ["MediaPlayPause"] = "play",
        ["MediaNextTrack"] = "next",

        ["OEM_3"] = "`",

        ["1"] = "1",
        ["2"] = "2",
        ["3"] = "3",
        ["4"] = "4",
        ["5"] = "5",
        ["6"] = "6",
        ["7"] = "7",
        ["8"] = "8",
        ["9"] = "9",
        ["0"] = "0",

        ["OEM_MINUS"] = "-",
        ["OEM_PLUS"] = "=",

        ["Backspace"] = "bs",

        ["NumLock"] = "num",

        ["Divide"] = "np/",
        ["Multiply"] = "np*",

        ["Tab"] = "tab",

        ["Q"] = "q",
        ["W"] = "w",
        ["E"] = "e",
        ["R"] = "r",
        ["T"] = "t",
        ["Y"] = "y",
        ["U"] = "u",
        ["I"] = "i",
        ["O"] = "o",
        ["P"] = "p",

        ["OEM_4"] = "[",
        ["OEM_6"] = "]",
        ["OEM_5"] = "\\",

        ["Numpad7"] = "np7",
        ["Numpad8"] = "np8",
        ["Numpad9"] = "np9",

        ["Subtract"] = "np-",
        ["Add"] = "np+",

        ["Numpad6"] = "np6",
        ["Numpad5"] = "np5",
        ["Numpad4"] = "np4",

        ["Enter"] = "enter",

        ["OEM_7"] = "'",
        ["OEM_1"] = ";",

        ["L"] = "l",
        ["K"] = "k",
        ["J"] = "j",
        ["H"] = "h",
        ["G"] = "g",
        ["F"] = "f",
        ["D"] = "d",
        ["S"] = "s",
        ["A"] = "a",

        ["CapsLock"] = "caps",

        ["Shift"] = "shift",
        ["LeftShift"] = "ls",
        ["RightShift"] = "rs",

        ["Z"] = "z",
        ["X"] = "x",
        ["C"] = "c",
        ["V"] = "v",
        ["B"] = "b",
        ["N"] = "n",
        ["M"] = "m",

        ["OEM_COMMA"] = ",",
        ["OEM_PERIOD"] = ".",
        ["OEM_2"] = "/",

        ["UpArrow"] = "↑",

        ["Numpad1"] = "np1",
        ["Numpad2"] = "np2",
        ["Numpad3"] = "np3",

        ["Decimal"] = "np.",
        ["Numpad0"] = "np0",

        ["RightArrow"] = "→",
        ["DownArrow"] = "↓",
        ["LeftArrow"] = "←",

        ["Ctrl"] = "ctrl",
        ["LeftCtrl"] = "lc",
        ["RightCtrl"] = "rc",

        ["Applications"] = "menu",

        ["Alt"] = "alt",
        ["LeftAlt"] = "la",
        ["RightAlt"] = "ra",

        ["Space"] = "space",
    }
}

for _, File in Library.Folders do
    if not isfolder(File) then
        makefolder(File)
    end
end

Library.Input.Mouse = Library.Service.UserInputService:GetMouseLocation()

function Library:FormatMouseButton(Name)
    local Mapped = Library.KeyAppearance[Name]
    if Mapped then return Mapped end
    if #Name == 1 then return Name:lower() end
    local Lower = Name:lower()
    return #Lower > 3 and Lower:sub(1, 3) or Lower
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
    Library.Input.MouseClicked = isleftpressed() and not Library.Input.MousePrevious
    Library.Input.RightClicked = isrightpressed() and not Library.Input.RightPrevious
    Library.Input.MouseDown = isleftpressed()
    Library.Input.MousePrevious = isleftpressed()
    Library.Input.RightPrevious = isrightpressed()
end

function Library:IsHovering(X, Y, Width, Height)
    return Library.Input.MouseX >= X and Library.Input.MouseX <= X + Width and Library.Input.MouseY >= Y and Library.Input.MouseY <= Y + Height
end

function Library:ToggleVisual(X, Y, State, Text)
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(15, 15), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(13, 13), State and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(11, 11), State and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 18, Y + 1), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, Text, false, Library.Appearance.Font)
end

function Library:SwatchVisual(X, Y, Color, Alpha)
    Alpha = Alpha or 255
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(28, 13), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(26, 11), Library.Appearance.Coloring.Border, 1)
    if Alpha < 255 then
        DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(12, 4), Color3.fromRGB(160, 160, 160), 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 14, Y + 2), Vector2.new(12, 4), Color3.fromRGB(100, 100, 100), 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 6), Vector2.new(12, 5), Color3.fromRGB(100, 100, 100), 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 14, Y + 6), Vector2.new(12, 5), Color3.fromRGB(160, 160, 160), 1)
    end
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(24, 9), Color, Alpha / 255)
end

function Library:SliderVisual(X, Y, Width, Min, Max, Value, Text)
    DrawingImmediate.OutlinedText(Vector2.new(X, Y), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, Text, false, Library.Appearance.Font)

    local BarY = Y + 15
    DrawingImmediate.FilledRectangle(Vector2.new(X, BarY), Vector2.new(Width, 15), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, BarY + 1), Vector2.new(Width - 2, 13), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, BarY + 2), Vector2.new(Width - 4, 11), Library.Appearance.Coloring.Background, 1)

    local Fraction = (Value - Min) / (Max - Min)
    local FillWidth = math.floor((Width - 2) * Fraction)
    if FillWidth > 0 then
        DrawingImmediate.FilledRectangle(Vector2.new(X + 1, BarY + 1), Vector2.new(FillWidth, 13), Library.Appearance.Coloring.AccentDark, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 2, BarY + 2), Vector2.new(math.max(FillWidth - 2, 0), 11), Library.Appearance.Coloring.Accent, 1)
    end

    local ValueText = math.floor(Value) .. "/" .. Max
    DrawingImmediate.OutlinedText(Vector2.new(X + Width / 2 - 15, BarY + 1), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, ValueText, false, Library.Appearance.Font)
end

function Library:ButtonVisual(X, Y, Width, Text, IsHovered)
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(Width, 22), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(Width - 2, 20), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width - 4, 18), IsHovered and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 4, Y + 4), Library.Appearance.FontSize, IsHovered and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.White, 1, Text, false, Library.Appearance.Font)
end

function Library:DropdownVisual(X, Y, Width, Text, SelectedText, IsOpen)
    DrawingImmediate.OutlinedText(Vector2.new(X, Y), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, Text, false, Library.Appearance.Font)

    local BarY = Y + 15
    DrawingImmediate.FilledRectangle(Vector2.new(X, BarY), Vector2.new(Width, 22), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, BarY + 1), Vector2.new(Width - 2, 20), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, BarY + 2), Vector2.new(Width - 4, 18), Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 4, BarY + 4), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, SelectedText, false, Library.Appearance.Font)
    DrawingImmediate.OutlinedText(Vector2.new(X + Width - 15, BarY + 4), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, IsOpen and "-" or "+", false, Library.Appearance.Font)
end

function Library:SeparatorVisual(X, Y, Width)
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y + 3), Vector2.new(Width, 1), Library.Appearance.Coloring.Border, 0.5)
end

function Library:LabelVisual(X, Y, Text, TextColor)
    DrawingImmediate.OutlinedText(Vector2.new(X, Y), Library.Appearance.FontSize, TextColor or Library.Appearance.Coloring.Dim, 1, Text, false, Library.Appearance.Font)
end

function Library:KeyPickerVisual(X, Y, Text, IsCapturing, IsHovered)
    local W = Library.LayoutConstants.SwatchWidth
    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(W, 13), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(W - 2, 11), IsCapturing and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(W - 4, 9), IsCapturing and Library.Appearance.Coloring.Accent or (IsHovered and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background), 1)
    local TextBounds = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 10, Text)
    local TextX = X + math.floor((W - TextBounds.X) / 2)
    local TextY = Y + math.floor((13 - TextBounds.Y) / 2)
    DrawingImmediate.OutlinedText(Vector2.new(TextX, TextY), 10, IsCapturing and Library.Appearance.Coloring.White or Library.Appearance.Coloring.Dim, 1, Text, false, Library.Appearance.Font)
    return W
end

-- // Element \\ --

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
        Self.HasRealCallback = Options.Callback ~= nil
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
        Self.Multi = Options.Multi or false

        if Self.Multi then
            Self.SelectedIndices = {}
            local Defaults = Options.Default or {}
            if type(Defaults) == "table" then
                for _, i in ipairs(Defaults) do
                    Self.SelectedIndices[i] = true
                end
            elseif type(Defaults) == "number" then
                Self.SelectedIndices[Defaults] = true
            end
            if Self.Flag then
                local Valid = {}
                for i, _ in pairs(Self.SelectedIndices) do
                    Valid[#Valid + 1] = Self.Options[i]
                end
                Library.Flags[Self.Flag] = {Value = Valid}
            end
        else
            Self.SelectedIndex = type(Options.Default) == "number" and Options.Default or 1
            if Self.Flag then
                Library.Flags[Self.Flag] = {Value = Self.Options[Self.SelectedIndex]}
            end
        end

        Self.Open = false
        Self.Height = 42

    elseif ElementType == "Button" then
        Self.Height = 26

    elseif ElementType == "ColorPicker" then
        local DefaultColor = Options.Default or Color3.fromRGB(177, 156, 217)
        Self.Color = {DefaultColor.R * 255, DefaultColor.G * 255, DefaultColor.B * 255}
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
        Self.HasCallback = Options.Callback ~= nil
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
        if self.Multi then
            local Valid = {}
            for i, selected in pairs(self.SelectedIndices) do
                if selected then Valid[#Valid + 1] = self.Options[i] end
            end
            table.sort(Valid)
            Library.Flags[self.Flag] = { Value = Valid }
        else
            Library.Flags[self.Flag] = { Value = self.Options[self.SelectedIndex] }
        end
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

local function TruncateText(Text, MaxWidth, Font, FontSize)
    local Bounds = DrawingImmediate.GetTextBounds(Font, FontSize, Text)
    if Bounds.X <= MaxWidth then return Text end
    local Truncated = Text
    while #Truncated > 0 do
        Truncated = Truncated:sub(1, -2)
        local TB = DrawingImmediate.GetTextBounds(Font, FontSize, Truncated .. "...")
        if TB.X <= MaxWidth then
            return Truncated .. "..."
        end
    end
    return "..."
end

function Element:Render()
    local X, Y, Width = self.X, self.Y, self.Width
    local AnchorRight = self.SectionRightEdge or (X + Width)

    if self.Type == "Toggle" then
        Library:ToggleVisual(X, Y, self.Value, self.Name)

        for Index, Picker in ipairs(self.AttachedColorPickers) do
            local SX = SwatchX(AnchorRight, Index - 1)
            Library:SwatchVisual(SX, Y + 1, Color3.fromRGB(Picker.Color[1], Picker.Color[2], Picker.Color[3]), Picker.Alpha * 255)

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
            local BadgeLabel = Keypicker.Capturing and "..." or Library:FormatMouseButton(Keypicker.BoundKey)
            local Hovered = Library:IsHovering(BX, BY, SW, 13)
            Library:KeyPickerVisual(BX, BY, BadgeLabel, Keypicker.Capturing, Hovered)

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
            Library:SliderVisual(X, Y, Width, self.Min, self.Max, self.Value, self.Name)

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
            local MaxTextWidth = Width - 20
            local DisplayText

            if self.Multi then
                local Valid = {}
                for i, selected in pairs(self.SelectedIndices) do
                    if selected then Valid[#Valid + 1] = self.Options[i] end
                end
                table.sort(Valid)
                local raw = #Valid == 0 and "None" or table.concat(Valid, ", ")
                DisplayText = TruncateText(raw, MaxTextWidth, Library.Appearance.Font, Library.Appearance.FontSize)
            else
                DisplayText = TruncateText(
                    self.Options[self.SelectedIndex],
                    MaxTextWidth,
                    Library.Appearance.Font,
                    Library.Appearance.FontSize
                )
            end

            Library:DropdownVisual(X, Y, Width, self.Name, DisplayText, self.Open)

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
                Library.DropdownOverlay = { X = X, Y = BarY + 22, Width = Width, Element = self }
            end

    elseif self.Type == "Button" then
        local IsHovered = Library:IsHovering(X, Y, Width, 22) and not Library.Input.Consumed
        Library:ButtonVisual(X, Y, Width, self.Name, IsHovered)
        if Library.Input.MouseClicked and IsHovered then
            Library.Input.Consumed = true
            self.Callback()
        end

    elseif self.Type == "ColorPicker" then
        Library:LabelVisual(X, Y + 2, self.Name, Library.Appearance.Coloring.White)
        local SX = SwatchX(AnchorRight, 0)
        Library:SwatchVisual(SX, Y + 1, Color3.fromRGB(self.Color[1], self.Color[2], self.Color[3]), self.Alpha * 255)
        if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(SX, Y + 1, SW, 13) then
            Library.Input.Consumed = true
            Library:ToggleColorPickerWindow(self, SX - 260, Y + 18)
        end

    elseif self.Type == "Separator" then
        Library:SeparatorVisual(X, Y, Width)

    elseif self.Type == "Label" then
        Library:LabelVisual(X, Y, self.Name, self.TextColor)

    elseif self.Type == "KeyPicker" then

    elseif self.Type == "Textbox" then
        local IsFocused = (Library.Input.FocusedTextbox == self)

        DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(Width, 22), Library.Appearance.Coloring.Black, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(Width - 2, 20), IsFocused and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width - 4, 18), Library.Appearance.Coloring.Background, 1)

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

-- // Section \\ --

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

    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(Width, self.Height), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(Width - 2, self.Height - 2), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width - 4, self.Height - 4), Library.Appearance.Coloring.BackgroundDark, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(Width - 4, 2), Library.Appearance.Coloring.Accent, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 5, Y + 6), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, self.Name, false, Library.Appearance.Font)

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

-- // Page \\ --

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
                Vector2.new(2, Height - Library.LayoutConstants.SectionPadding * 2),
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

-- // Window \\ --

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
    Self.KeybindListVisible = true
    Self.Notifications = {}
    Self.MenuToggleKey = "RightShift"

    Library.Windows[#Library.Windows + 1] = Self

    RunService.PostLocal:Connect(function()
        local PressedKeys = getpressedkeys() or {}
        local function IsKeyPressed(TargetKey) return table.find(PressedKeys, TargetKey) ~= nil end

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
                            if Keypicker.HasCallback then
                                Keypicker.Callback(not TE.Value)
                            else
                                TE.Value = not TE.Value
                                TE:SyncFlag()
                                TE.Callback(TE.Value)
                            end
                            Keypicker.PrevPressed = true
                        elseif not KeyIsActive then
                            Keypicker.PrevPressed = false
                        end

                    elseif Keypicker.Mode == "Hold" then
                        if Keypicker.HasCallback then
                            Keypicker.Callback(KeyIsActive)
                        else
                            if TE.Value ~= KeyIsActive then
                                TE.Value = KeyIsActive
                                TE:SyncFlag()
                                TE.Callback(TE.Value)
                            end
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

function Window:Notify(Text, Duration)
    table.insert(self.Notifications, {
        Text = Text,
        Start = tick(),
        Duration = Duration or 3,
    })
end

function Window:BindKey(Name, Code, ElementInstance)
    self.Keybinds[#self.Keybinds + 1] = {Key = Name, Code = Code, Element = ElementInstance, Name = ElementInstance.Name}
    self.KeybindAnimations[Name] = {X = 120, Alpha = 0}
end

function Window:RenderKeybindList()
    if not self.KeybindListVisible then return end

    local ActivePickers = {}
    for _, P in ipairs(self.Pages) do
        for _, S in ipairs(P.Sections) do
            for _, El in ipairs(S.Elements) do
                if El.Type == "KeyPicker" and El.BoundKey and El.BoundKey ~= "None" and El.ToggleElement then
                    ActivePickers[#ActivePickers + 1] = El
                end
            end
        end
    end

    if #ActivePickers == 0 then return end

    if not self.KeybindWindow then
        self.KeybindWindow = {
            X = 10,
            Y = Library.Viewport.Y / 2 - (#ActivePickers * 24 + 52) / 2,
            Width = 185,
            Dragging = false,
            DragOffsetX = 0,
            DragOffsetY = 0,
        }
    end

    local KW = self.KeybindWindow
    local RowH = 22
    local HeaderH = 28
    local Padding = 8
    local TotalH = HeaderH + #ActivePickers * RowH + Padding

    if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(KW.X, KW.Y, KW.Width, HeaderH) then
        KW.Dragging = true
        KW.DragOffsetX = Library.Input.MouseX - KW.X
        KW.DragOffsetY = Library.Input.MouseY - KW.Y
        Library.Input.Consumed = true
    end
    if not Library.Input.MouseDown then KW.Dragging = false end
    if KW.Dragging then
        KW.X = Library.Input.MouseX - KW.DragOffsetX
        KW.Y = Library.Input.MouseY - KW.DragOffsetY
    end

    local X, Y, W = KW.X, KW.Y, KW.Width

    DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(W, TotalH), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(W - 2, TotalH - 2), Library.Appearance.Coloring.Accent, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(W - 4, TotalH - 4), Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 9, Y + 8), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, "Keybinds", false, Library.Appearance.Font)

    local CX = X + 4
    local CY = Y + HeaderH
    local CW = W - 8

    DrawingImmediate.FilledRectangle(Vector2.new(CX, CY), Vector2.new(CW, TotalH - HeaderH - Padding), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CX + 1, CY + 1), Vector2.new(CW - 2, TotalH - HeaderH - Padding - 2), Library.Appearance.Coloring.BackgroundDark, 1)

    for Index, Keypicker in ipairs(ActivePickers) do
        local TE = Keypicker.ToggleElement
        local State = TE.Value or false
        local RowY = CY + (Index - 1) * RowH + 2

        local NameColor = State and Library.Appearance.Coloring.White or Library.Appearance.Coloring.Dim
        DrawingImmediate.OutlinedText(Vector2.new(CX + 6, RowY + 5), Library.Appearance.FontSize, NameColor, 1, TE.Name, false, Library.Appearance.Font)

        local KeyLabel = "[" .. Library:FormatMouseButton(Keypicker.BoundKey) .. "]"
        local KB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, Library.Appearance.FontSize, KeyLabel)
        DrawingImmediate.OutlinedText(Vector2.new(CX + CW - KB.X - 6, RowY + 5), Library.Appearance.FontSize, Library.Appearance.Coloring.Accent, 1, KeyLabel, false, Library.Appearance.Font)

        if Index < #ActivePickers then
            DrawingImmediate.FilledRectangle(Vector2.new(CX + 2, RowY + RowH - 1), Vector2.new(CW - 4, 1), Library.Appearance.Coloring.Border, 0.5)
        end
    end
end

function Window:RenderNotifications()
    local BaseHeight = 24
    local Padding = 6
    local ToRemove = {}
    local ScreenW = Library.Viewport.X

    for Index, N in ipairs(self.Notifications) do
        local Elapsed = tick() - N.Start
        local Duration = N.Duration

        if Elapsed >= Duration then
            table.insert(ToRemove, Index)
        else
            local TextBounds = DrawingImmediate.GetTextBounds(Library.Appearance.Font, Library.Appearance.FontSize, N.Text)
            local NW = TextBounds.X + Padding * 2
            local NH = math.max(BaseHeight, TextBounds.Y + Padding * 2)
            local BaseX = ScreenW - NW - 10
            local Y = 10 + (Index - 1) * (NH + 6)

            local OffsetX = 0
            local FadeIn = 0.4
            local FadeOut = 0.4

            if Elapsed < FadeIn then
                local T = Elapsed / FadeIn
                local Ease = T < 0.5 and 2 * T * T or -1 + (4 - 2 * T) * T
                OffsetX = (1 - Ease) * (NW + 10)
            elseif Elapsed > Duration - FadeOut then
                local T = (Elapsed - (Duration - FadeOut)) / FadeOut
                local Ease = T < 0.5 and 2 * T * T or -1 + (4 - 2 * T) * T
                OffsetX = Ease * (NW + 10)
            end

            local X = BaseX + OffsetX

            DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(NW, NH), Library.Appearance.Coloring.Black, 0.9)
            DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(NW, 2), Library.Appearance.Coloring.Accent, 1)
            DrawingImmediate.OutlinedText(Vector2.new(X + Padding, Y + Padding - 1), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, N.Text, false, Library.Appearance.Font)
        end
    end

    for I = #ToRemove, 1, -1 do
        table.remove(self.Notifications, ToRemove[I])
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

    -- X close button — checked BEFORE drag so the header click isn't consumed first
    local X, Y = self.X, self.Y
    local CloseX = X + self.Width - 22
    if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(CloseX, Y + 4, 16, 16) then
        Library.Input.Consumed = true
        self.Visible = false
        return
    end

    if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(X, Y, self.Width - 24, 26) then
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
    DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(self.Width - 2, self.Height - 2), Library.Appearance.Coloring.Accent, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(self.Width - 4, self.Height - 4), Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(X + 9, Y + 8), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 1, self.Name, false, Library.Appearance.Font)

    -- Draw X button visual
    local CloseHovered = Library:IsHovering(CloseX, Y + 4, 16, 16)
    DrawingImmediate.FilledRectangle(Vector2.new(CloseX, Y + 4), Vector2.new(16, 16), Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(CloseX + 4, Y + 5), Library.Appearance.FontSize, CloseHovered and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.White, 1, "X", false, Library.Appearance.Font)

    local CX, CY = X + 9, Y + 26
    local CW, CH = self.Width - 18, self.Height - 35
    DrawingImmediate.FilledRectangle(Vector2.new(CX, CY), Vector2.new(CW, CH), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CX + 1, CY + 1), Vector2.new(CW - 2, CH - 2), Library.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CX + 2, CY + 2), Vector2.new(CW - 4, CH - 4), Library.Appearance.Coloring.BackgroundDark, 1)

    local NumTabs = #self.Pages

    if self.IsSubWindow then
        local IX = CX + 7
        local IY = CY + 4
        local IW = CW - 14
        local IH = CH - 11
        DrawingImmediate.FilledRectangle(Vector2.new(IX, IY), Vector2.new(IW, IH), Library.Appearance.Coloring.Border, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(IX + 1, IY + 1), Vector2.new(IW - 2, IH - 2), Library.Appearance.Coloring.Background, 1)
        local CurrentPage = self.Pages[self.CurrentPageIndex]
        if CurrentPage then
            CurrentPage:Render(IX, IY, IW, IH)
        end
    else
    local TabGap = 2
    local TotalGaps = (NumTabs - 1) * TabGap
    local TotalTabWidth = CW - 14
    local TabWidth = math.floor((TotalTabWidth - TotalGaps) / NumTabs)
    local TabY = CY + 4
    for Index, PageInstance in ipairs(self.Pages) do
        local TabX = CX + 7 + (Index - 1) * (TabWidth + TabGap)
        local IsActive = (self.CurrentPageIndex == Index)
        DrawingImmediate.FilledRectangle(Vector2.new(TabX, TabY), Vector2.new(TabWidth, 23), Library.Appearance.Coloring.Border, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(TabX + 1, TabY + 1), Vector2.new(TabWidth - 2, IsActive and 22 or 21), IsActive and Library.Appearance.Coloring.Background or Library.Appearance.Coloring.BackgroundDark, 1)
        if IsActive then
            DrawingImmediate.FilledRectangle(Vector2.new(TabX, TabY + 22), Vector2.new(TabWidth, 9), Library.Appearance.Coloring.Border, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(TabX + 1, TabY + 22), Vector2.new(TabWidth - 2, 9), Library.Appearance.Coloring.Background, 1)
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

    -- Active tab X aligned to the page box coordinate space
    local ActiveTabX = IX + (self.CurrentPageIndex - 1) * (TabWidth + TabGap)

    DrawingImmediate.FilledRectangle(Vector2.new(IX, IY), Vector2.new(IW, IH), Library.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(IX + 1, IY + 1), Vector2.new(IW - 2, IH - 2), Library.Appearance.Coloring.Background, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(ActiveTabX, IY), Vector2.new(TabWidth, 1), Library.Appearance.Coloring.Background, 1)

    local CurrentPage = self.Pages[self.CurrentPageIndex]
    if CurrentPage then
        CurrentPage:Render(IX, IY, IW, IH)
    end
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

            local IsSelected = DropdownElement.Multi
                and (DropdownElement.SelectedIndices[Index] == true)
                or (not DropdownElement.Multi and Index == DropdownElement.SelectedIndex)

            DrawingImmediate.FilledRectangle(Vector2.new(Overlay.X, OptionY), Vector2.new(Overlay.Width, 20), Library.Appearance.Coloring.Black, 1)
            DrawingImmediate.FilledRectangle(
                Vector2.new(Overlay.X + 1, OptionY + 1),
                Vector2.new(Overlay.Width - 2, 18),
                IsHovered and Library.Appearance.Coloring.Border
                    or (IsSelected and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background),
                1
            )

            local TextColor = IsSelected and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.White
            DrawingImmediate.OutlinedText(Vector2.new(Overlay.X + 4, OptionY + 3), Library.Appearance.FontSize, TextColor, 1, Option, false, Library.Appearance.Font)

            if Library.Input.MouseClicked and IsHovered then
                Library.Input.Consumed = true
                if DropdownElement.Multi then
                    DropdownElement.SelectedIndices[Index] = not DropdownElement.SelectedIndices[Index] or nil
                    DropdownElement:SyncFlag()
                    local Valid = {}
                    for i, sel in pairs(DropdownElement.SelectedIndices) do
                        if sel then Valid[#Valid + 1] = DropdownElement.Options[i] end
                    end
                    table.sort(Valid)
                    DropdownElement.Callback(Valid)
                else
                    DropdownElement.SelectedIndex = Index
                    DropdownElement.Open = false
                    Library.ActiveDropdown = nil
                    DropdownElement:SyncFlag()
                    DropdownElement.Callback(DropdownElement.Options[Index])
                end
            end
        end
    end

    if Library.KeyPickerContext then
        local Keypicker = Library.KeyPickerContext.Element
        local MX = Library.KeyPickerContext.X
        local MY = Library.KeyPickerContext.Y
        local MenuW = 90
        local MenuH = 4 + #{"Toggle", "Hold"} * 22 + 4

        DrawingImmediate.FilledRectangle(Vector2.new(MX, MY), Vector2.new(MenuW, MenuH), Library.Appearance.Coloring.Black, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(MX + 1, MY + 1), Vector2.new(MenuW - 2, MenuH - 2), Library.Appearance.Coloring.Border, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(MX + 2, MY + 2), Vector2.new(MenuW - 4, MenuH - 4), Library.Appearance.Coloring.BackgroundDark, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(MX + 2, MY + 2), Vector2.new(MenuW - 4, 2), Library.Appearance.Coloring.Accent, 1)

        for Index, Mode in ipairs({"Toggle", "Hold"}) do
            local OptionY = MY + 4 + (Index - 1) * 22
            local IsHovered = Library:IsHovering(MX + 4, OptionY, MenuW - 8, 20)
            local IsActive = (Keypicker.Mode == Mode)

            DrawingImmediate.FilledRectangle(Vector2.new(MX + 4, OptionY), Vector2.new(MenuW - 8, 20), Library.Appearance.Coloring.Black, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(MX + 5, OptionY + 1), Vector2.new(MenuW - 10, 18), IsHovered and Library.Appearance.Coloring.Border or Library.Appearance.Coloring.Background, 1)

            DrawingImmediate.FilledRectangle(Vector2.new(MX + 8, OptionY + 4), Vector2.new(11, 11), Library.Appearance.Coloring.Black, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(MX + 9, OptionY + 5), Vector2.new(9, 9), IsActive and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(MX + 10, OptionY + 6), Vector2.new(7, 7), IsActive and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.BackgroundDark, 1)

            DrawingImmediate.OutlinedText(Vector2.new(MX + 23, OptionY + 3), Library.Appearance.FontSize, IsActive and Library.Appearance.Coloring.White or Library.Appearance.Coloring.Dim, 1, Mode, false, Library.Appearance.Font)

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

    self:RenderNotifications()

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

-- // Color Picker \\ --

function Library:ToggleColorPickerWindow(ColorPickerElement, SpawnX, SpawnY)
    if self.ActiveColorPicker == ColorPickerElement then
        self.ActiveColorPicker = nil
        return
    end
    self.ActiveColorPicker = ColorPickerElement
    self.ActiveColorPicker.WindowX = SpawnX
    self.ActiveColorPicker.WindowY = SpawnY

    -- All layout constants live here; RenderColorPicker mirrors them exactly.
    --
    -- Inner content area (inside the Black→Border→Background container):
    --   [ SVSize wide SV square ] [ HueBarGap ] [ HueBarW wide hue bar ]
    --   Below that row, with AlphaBarGap vertical gap:
    --   [ AlphaW wide alpha bar ] [ SwatchGap ] [ SwatchSize wide swatch ]
    --   where AlphaW + SwatchGap + SwatchSize == SVSize + HueBarGap + HueBarW
    --
    -- Container has ContPad inner padding on all sides.
    -- Window has TitleH header above the container, WinPad on sides and bottom.

    local TitleH = 24
    local WinPad = 8
    local ContPad = 6

    local SVSize = 200
    local HueBarGap = 6
    local HueBarW = 18
    local AlphaBarH = 18
    local AlphaBarGap = 8

    local TotalContentW = SVSize + HueBarGap + HueBarW

    local ContW = ContPad + TotalContentW + ContPad
    local ContH = ContPad + SVSize + AlphaBarGap + AlphaBarH + ContPad

    local WW = WinPad + ContW + WinPad
    local WH = TitleH + WinPad + ContH + WinPad

    self.ActiveColorPicker.WindowWidth  = WW
    self.ActiveColorPicker.WindowHeight = WH

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

    -- Dragging / close
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

    -- Window chrome
    DrawingImmediate.FilledRectangle(Vector2.new(WX, WY), Vector2.new(WW, WH), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(WX + 1, WY + 1), Vector2.new(WW - 2, WH - 2), self.Appearance.Coloring.Accent, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(WX + 2, WY + 2), Vector2.new(WW - 4, WH - 4), self.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(WX + 8, WY + 6), self.Appearance.FontSize, self.Appearance.Coloring.White, 1, PickerElement.Name .. " Color", false, self.Appearance.Font)

    local CloseHovered = self:IsHovering(CloseX, WY + 4, 16, 16)
    DrawingImmediate.FilledRectangle(Vector2.new(CloseX, WY + 4), Vector2.new(16, 16), self.Appearance.Coloring.Background, 1)
    DrawingImmediate.OutlinedText(Vector2.new(CloseX + 4, WY + 5), self.Appearance.FontSize, CloseHovered and self.Appearance.Coloring.Accent or self.Appearance.Coloring.White, 1, "X", false, self.Appearance.Font)

    local TitleH = 24
    local WinPad = 8
    local ContPad = 6
    local SVSize = 200
    local HueBarGap = 6
    local HueBarW = 18
    local AlphaBarH = 18
    local AlphaBarGap = 8
    local SwatchSize = AlphaBarH
    local SwatchGap = 6
    local TotalContentW = SVSize + HueBarGap + HueBarW
    local AlphaW = TotalContentW - SwatchGap - SwatchSize
    local ContW = ContPad + TotalContentW + ContPad
    local ContH = ContPad + SVSize + AlphaBarGap + AlphaBarH + ContPad
    local PixelStep = 10

    local ContX = WX + WinPad
    local ContY = WY + TitleH + WinPad
    DrawingImmediate.FilledRectangle(Vector2.new(ContX, ContY), Vector2.new(ContW, ContH), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(ContX + 1, ContY + 1), Vector2.new(ContW - 2, ContH - 2), self.Appearance.Coloring.Border, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(ContX + 2, ContY + 2), Vector2.new(ContW - 4, ContH - 4), self.Appearance.Coloring.Background, 1)

    local CX = ContX + ContPad
    local CY = ContY + ContPad

    local SVX = CX
    local SVY = CY
    DrawingImmediate.FilledRectangle(Vector2.new(SVX - 1, SVY - 1), Vector2.new(SVSize + 2, SVSize + 2), self.Appearance.Coloring.Black, 1)
    for PX = 0, SVSize - 1, PixelStep do
        for PY = 0, SVSize - 1, PixelStep do
            local S = PX / SVSize
            local V = 1 - (PY / SVSize)
            local R, G, B = self:HSVToRGB(PickerElement.Hue, S, V)
            DrawingImmediate.FilledRectangle(Vector2.new(SVX + PX, SVY + PY), Vector2.new(PixelStep, PixelStep), Color3.fromRGB(R, G, B), 1)
        end
    end

    local CCX = SVX + math.floor(PickerElement.Saturation * (SVSize - 1))
    local CCY = SVY + math.floor((1 - PickerElement.Value) * (SVSize - 1))
    DrawingImmediate.FilledRectangle(Vector2.new(CCX - 4, CCY - 4), Vector2.new(9, 9), self.Appearance.Coloring.White, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CCX - 3, CCY - 3), Vector2.new(7, 7), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(CCX - 2, CCY - 2), Vector2.new(5, 5), Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]), 1)

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

    local HueX = SVX + SVSize + HueBarGap
    local HueY = SVY
    local HueStep = 2
    DrawingImmediate.FilledRectangle(Vector2.new(HueX - 1, HueY - 1), Vector2.new(HueBarW + 2, SVSize + 2), self.Appearance.Coloring.Black, 1)
    for HStep = 0, SVSize - 1, HueStep do
        local H = HStep / SVSize
        local R, G, B = self:HSVToRGB(H, 1, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(HueX, HueY + HStep), Vector2.new(HueBarW, HueStep), Color3.fromRGB(R, G, B), 1)
    end

    local HueCursorY = HueY + math.floor(PickerElement.Hue * (SVSize - 1))
    DrawingImmediate.FilledRectangle(Vector2.new(HueX - 2, HueCursorY - 2), Vector2.new(HueBarW + 4, 5), self.Appearance.Coloring.White, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(HueX - 1, HueCursorY - 1), Vector2.new(HueBarW + 2, 3), self.Appearance.Coloring.Black, 1)

    if self.Input.MouseClicked and self:IsHovering(HueX - 2, HueY - 2, HueBarW + 4, SVSize + 4) then
        PickerElement.DraggingHue = true
    end
    if PickerElement.DraggingHue and self.Input.MouseDown then
        PickerElement.Hue = math.clamp((self.Input.MouseY - HueY) / SVSize, 0, 0.999)
        PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3] = self:HSVToRGB(PickerElement.Hue, PickerElement.Saturation, PickerElement.Value)
        PickerElement:SyncFlag()
        PickerElement.Callback(Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]))
    end
    if not self.Input.MouseDown then PickerElement.DraggingHue = false end

    -- Alpha bar: starts at CX, spans AlphaW, right-edge aligns with hue bar right-edge
    -- Preview swatch: immediately right of alpha bar (gap SwatchGap), same height
    -- Together: AlphaW + SwatchGap + SwatchSize == TotalContentW == SVSize + HueBarGap + HueBarW
    local AlphaX = CX
    local AlphaY = SVY + SVSize + AlphaBarGap

    -- Checkerboard
    local CheckStep = 7
    for AX = 0, AlphaW - 1, CheckStep do
        local Dark = (math.floor(AX / CheckStep) % 2 == 0)
        local ChunkW = math.min(CheckStep, AlphaW - AX)
        DrawingImmediate.FilledRectangle(Vector2.new(AlphaX + AX, AlphaY), Vector2.new(ChunkW, AlphaBarH / 2), Dark and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(160, 160, 160), 1)
        DrawingImmediate.FilledRectangle(Vector2.new(AlphaX + AX, AlphaY + AlphaBarH / 2), Vector2.new(ChunkW, AlphaBarH / 2), Dark and Color3.fromRGB(160, 160, 160) or Color3.fromRGB(100, 100, 100), 1)
    end

    local Steps = 24
    for Step = 0, Steps - 1 do
        local A = Step / Steps
        local StepX = AlphaX + math.floor(Step / Steps * AlphaW)
        local StepW = math.floor(AlphaW / Steps) + 1
        DrawingImmediate.FilledRectangle(Vector2.new(StepX, AlphaY), Vector2.new(StepW, AlphaBarH), Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]), A)
    end

    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX - 1, AlphaY - 1), Vector2.new(AlphaW + 2, 1), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX - 1, AlphaY + AlphaBarH), Vector2.new(AlphaW + 2, 1), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX - 1, AlphaY - 1), Vector2.new(1, AlphaBarH + 2), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaX + AlphaW, AlphaY - 1), Vector2.new(1, AlphaBarH + 2), self.Appearance.Coloring.Black, 1)

    local AlphaCursorX = AlphaX + math.floor(PickerElement.Alpha * (AlphaW - 1))
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaCursorX - 2, AlphaY - 2), Vector2.new(5, AlphaBarH + 4), self.Appearance.Coloring.White, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(AlphaCursorX - 1, AlphaY - 1), Vector2.new(3, AlphaBarH + 2), self.Appearance.Coloring.Black, 1)

    if self.Input.MouseClicked and self:IsHovering(AlphaX - 2, AlphaY - 2, AlphaW + 4, AlphaBarH + 4) then
        PickerElement.DraggingAlpha = true
    end
    if PickerElement.DraggingAlpha and self.Input.MouseDown then
        PickerElement.Alpha = math.clamp((self.Input.MouseX - AlphaX) / AlphaW, 0, 1)
        PickerElement:SyncFlag()
        PickerElement.Callback(Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]))
    end
    if not self.Input.MouseDown then PickerElement.DraggingAlpha = false end

    local SwatchX = AlphaX + AlphaW + SwatchGap
    local SwatchY = AlphaY

    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX, SwatchY), Vector2.new(SwatchSize / 2, SwatchSize / 2), Color3.fromRGB(160, 160, 160), 1)
    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX + SwatchSize / 2, SwatchY), Vector2.new(SwatchSize / 2, SwatchSize / 2), Color3.fromRGB(100, 100, 100), 1)
    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX, SwatchY + SwatchSize / 2), Vector2.new(SwatchSize / 2, SwatchSize / 2), Color3.fromRGB(100, 100, 100), 1)
    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX + SwatchSize / 2, SwatchY + SwatchSize / 2), Vector2.new(SwatchSize / 2, SwatchSize / 2), Color3.fromRGB(160, 160, 160), 1)

    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX, SwatchY), Vector2.new(SwatchSize, SwatchSize), Color3.fromRGB(PickerElement.Color[1], PickerElement.Color[2], PickerElement.Color[3]), PickerElement.Alpha)

    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX - 1, SwatchY - 1), Vector2.new(SwatchSize + 2, 1), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX - 1, SwatchY + SwatchSize), Vector2.new(SwatchSize + 2, 1), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX - 1, SwatchY - 1), Vector2.new(1, SwatchSize + 2), self.Appearance.Coloring.Black, 1)
    DrawingImmediate.FilledRectangle(Vector2.new(SwatchX + SwatchSize, SwatchY - 1), Vector2.new(1, SwatchSize + 2), self.Appearance.Coloring.Black, 1)
end

function Library:ExportFlags()
    local Lines = {"return {"}
    for Flag, Value in pairs(self.Flags) do
        local Type = type(Value)
        if type(Value) == "boolean" then
            Lines[#Lines + 1] = string.format('  ["%s"] = %s,', Flag, tostring(Value))
        elseif type(Value) == "number" then
            Lines[#Lines + 1] = string.format('  ["%s"] = %s,', Flag, tostring(Value))
        elseif type(Value) == "table" then
    local Parts = {}
    if Value.Color then
        local Color = Value.Color
        Parts[#Parts + 1] = string.format("Color = Color3.fromRGB(%d,%d,%d)", math.floor(Color.R * 255), math.floor(Color.G * 255), math.floor(Color.B * 255))
    end
    if Value.Alpha ~= nil then Parts[#Parts + 1] = "Alpha = " .. tostring(Value.Alpha) end
    if Value.Value ~= nil then
        if type(Value.Value) == "table" then
            local Items = {}
            for _, Item in ipairs(Value.Value) do
                Items[#Items + 1] = '"' .. tostring(Item) .. '"'
            end
            Parts[#Parts + 1] = "Value = {" .. table.concat(Items, ", ") .. "}"
        else
            Parts[#Parts + 1] = "Value = " .. (type(Value.Value) == "string" and ('"' .. Value.Value .. '"') or tostring(Value.Value))
        end
    end
    if Value.Key ~= nil then Parts[#Parts + 1] = 'Key = "' .. tostring(Value.Key) .. '"' end
    if Value.Mode ~= nil then Parts[#Parts + 1] = 'Mode = "' .. tostring(Value.Mode) .. '"' end
    Lines[#Lines + 1] = string.format('  ["%s"] = {%s},', Flag, table.concat(Parts, ", "))
end
    end
    Lines[#Lines + 1] = "}"
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
                            if El.Multi then
                                El.SelectedIndices = {}
                                if type(Saved.Value) == "table" then
                                    for _, savedVal in ipairs(Saved.Value) do
                                        for i, opt in ipairs(El.Options) do
                                            if opt == savedVal then
                                                El.SelectedIndices[i] = true
                                                break
                                            end
                                        end
                                    end
                                end
                                El:SyncFlag()
                                local Valid = {}
                                for i, sel in pairs(El.SelectedIndices) do
                                    if sel then Valid[#Valid + 1] = El.Options[i] end
                                end
                                table.sort(Valid)
                                pcall(El.Callback, Valid)
                            else
                                for i, Opt in ipairs(El.Options) do
                                    if Opt == Saved.Value then
                                        El.SelectedIndex = i
                                        break
                                    end
                                end
                                El:SyncFlag()
                                pcall(El.Callback, El.Options[El.SelectedIndex])
                            end

                        elseif El.Type == "ColorPicker" then
                            if Saved.Color then
                                El.Color = {Saved.Color.R * 255, Saved.Color.G * 255, Saved.Color.B * 255}
                            end
                            if Saved.Alpha ~= nil then
                                El.Alpha = Saved.Alpha
                            end
                            El:SyncFlag()
                            pcall(El.Callback, Color3.fromRGB(El.Color[1], El.Color[2], El.Color[3]))

                        elseif El.Type == "KeyPicker" then
                            if Saved.Key then
                                El.BoundKey = Saved.Key
                            end
                            if Saved.Mode then
                                El.Mode = Saved.Mode
                            end
                            El:SyncFlag()
                        end
                    end
                end
            end
        end
    end
end

function Library:StyleWindow()
    assert(#self.Windows > 0, "No windows exist")
    local MainWin = self.Windows[1]

    local StyleWin = Window.New({
        Name = "Style",
        Size = Vector2.new(300, 420),
    })
    StyleWin.Visible    = false
    StyleWin.MenuToggleKey = ""
    StyleWin.IsSubWindow = true

    local StylePage = StyleWin:Page({Name = "Style", Columns = 1})
    local StyleSection = StylePage:Section({Name = "Theme", Side = 1})

    local ColorDefs = {
        {Name = "Accent", Key = "Accent"},
        {Name = "Accent Dark", Key = "AccentDark"},
        {Name = "Background", Key = "Background"},
        {Name = "Background Dark", Key = "BackgroundDark"},
        {Name = "Border", Key = "Border"},
    }

    local ThemePickers = {}
    for _, Def in ipairs(ColorDefs) do
        local Picker = StyleSection:ColorPicker({
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

    StyleSection:Separator()

    local Presets = {
        {Name = "Purple", Accent = Color3.fromRGB(177, 156, 217), AccentDark = Color3.fromRGB(139, 107, 163)},
        {Name = "Blue", Accent = Color3.fromRGB(100, 160, 255), AccentDark = Color3.fromRGB(60, 120, 200)},
        {Name = "Red", Accent = Color3.fromRGB(255, 100, 100), AccentDark = Color3.fromRGB(200, 60, 60)},
        {Name = "Green", Accent = Color3.fromRGB(100, 255, 130), AccentDark = Color3.fromRGB(60, 200, 80)},
    }

    local PresetByName, PresetNames = {}, {}
    for _, Preset in ipairs(Presets) do
        PresetByName[Preset.Name] = Preset
        PresetNames[#PresetNames + 1] = Preset.Name
    end

    StyleSection:Dropdown({
        Name = "Preset",
        Options = PresetNames,
        Default = 1,
        Callback = function(Selection)
            local Preset = PresetByName[Selection]
            if not Preset then return end
            Library.Appearance.Coloring.Accent     = Preset.Accent
            Library.Appearance.Coloring.AccentDark = Preset.AccentDark
            ThemePickers["Accent"].Color     = {Preset.Accent.R * 255,     Preset.Accent.G * 255,     Preset.Accent.B * 255}
            ThemePickers["AccentDark"].Color = {Preset.AccentDark.R * 255, Preset.AccentDark.G * 255, Preset.AccentDark.B * 255}
            ThemePickers["Accent"]:SyncFlag()
            ThemePickers["AccentDark"]:SyncFlag()
            MainWin:Notify("Theme: " .. Preset.Name, 2)
        end,
    })

    StyleSection:Separator()

    StyleSection:Toggle({
        Name = "Show Keybind List",
        Flag = "UI_KeybindList",
        Default = true,
        Callback = function(Value)
            MainWin.KeybindListVisible = Value
        end,
    })

    local MenuKeyToggle = StyleSection:Toggle({
        Name = "Menu Toggle Key",
        Flag = "UI_MenuToggle",
        Default = false,
        Callback = function() end,
    })

    MenuKeyToggle:KeyPicker({
        Flag = "UI_MenuKey",
        Default = "RightShift",
        Callback = function() end,
    })

    local _MenuKP = MenuKeyToggle.AttachedKeyPicker
    if _MenuKP then
        local _OrigSync = _MenuKP.SyncFlag
        function _MenuKP:SyncFlag()
            _OrigSync(self)
            MainWin.MenuToggleKey = self.BoundKey
        end
        MainWin.MenuToggleKey = _MenuKP.BoundKey
    end

    return StyleWin
end

function Library:ConfigWindow()
    assert(#self.Windows > 0, "No windows exist")
    local MainWin = self.Windows[1]

    local ConfigWin = Window.New({
        Name = "Configurations",
        Size = Vector2.new(300, 420),
    })
    ConfigWin.Visible = false
    ConfigWin.MenuToggleKey = ""
    ConfigWin.IsSubWindow = true

    local ConfigPage    = ConfigWin:Page({Name = "Config", Columns = 1})
    local ConfigSection = ConfigPage:Section({Name = "Config", Side = 1})

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
                    State.List[#State.List + 1] = Name:sub(1, -5)
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

    local BoxRows = 7
    local RowH = 16
    local BoxH = BoxRows * RowH + 6
    local ListBox = ConfigSection:Label({Name = ""})
    ListBox.Height = BoxH + 4

    local NameBox = ConfigSection:Textbox({
        Placeholder = "Config name...",
        MaxLength = 48,
        Callback = function() end,
    })

    function ListBox:Render()
        local X, Y, W = self.X, self.Y, self.Width
        DrawingImmediate.FilledRectangle(Vector2.new(X, Y), Vector2.new(W, BoxH), Library.Appearance.Coloring.Black, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 1, Y + 1), Vector2.new(W - 2, BoxH - 2), Library.Appearance.Coloring.Border, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(X + 2, Y + 2), Vector2.new(W - 4, BoxH - 4), Library.Appearance.Coloring.BackgroundDark, 1)

        if #State.List == 0 then
            local TB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 13, "No configs saved")
            DrawingImmediate.OutlinedText(
                Vector2.new(X + math.floor((W - TB.X) / 2), Y + math.floor((BoxH - TB.Y) / 2)),
                14, Library.Appearance.Coloring.Dim, 1, "No configs saved", false, Library.Appearance.Font)
            return
        end

        for i, Name in ipairs(State.List) do
            if i > BoxRows then break end
            local RY = Y + 3 + (i - 1) * RowH
            local IsSelected = (State.Selected == Name)
            local TB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 11, Name)
            DrawingImmediate.OutlinedText(
                Vector2.new(X + math.floor((W - TB.X) / 2), RY + math.floor((RowH - TB.Y) / 2)),
                11, IsSelected and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.Dim,
                1, Name, false, Library.Appearance.Font)

            if Library.Input.MouseClicked and not Library.Input.Consumed and Library:IsHovering(X + 2, RY, W - 4, RowH) then
                Library.Input.Consumed = true
                State.Selected = Name
                NameBox.Value  = Name
            end
        end
    end

    local function MakeButtonRow(LabelA, CallbackA, LabelB, CallbackB)
        local Row = ConfigSection:Label({Name = ""})
        Row.Height = 26
        function Row:Render()
            local X, Y, W = self.X, self.Y, self.Width
            local BW = math.floor((W - 3) / 2)
            local function DrawBtn(BX, Text, Callback)
                local Hov = Library:IsHovering(BX, Y, BW, 22) and not Library.Input.Consumed
                DrawingImmediate.FilledRectangle(Vector2.new(BX, Y), Vector2.new(BW, 22), Library.Appearance.Coloring.Black, 1)
                DrawingImmediate.FilledRectangle(Vector2.new(BX + 1, Y + 1), Vector2.new(BW - 2, 20), Library.Appearance.Coloring.Border, 1)
                DrawingImmediate.FilledRectangle(Vector2.new(BX + 2, Y + 2), Vector2.new(BW - 4, 18), Hov and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background, 1)
                local TB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, 11, Text)
                DrawingImmediate.OutlinedText(
                    Vector2.new(BX + math.floor((BW - TB.X) / 2), Y + math.floor((22 - TB.Y) / 2)),
                    11, Hov and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.White,
                    1, Text, false, Library.Appearance.Font)
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
        if not Name or Name == "" then MainWin:Notify("Enter a config name", 2) return end
        local ok = pcall(writefile, Library.Folders.Configs .. "/" .. Name .. ".lua", Library:ExportFlags())
        if ok then
            State.Selected = Name
            RefreshList()
            MainWin:Notify("Saved: " .. Name)
        else
            MainWin:Notify("Save failed")
        end
    end

    local function LoadConfig()
        local Name = State.Selected
        if not Name then MainWin:Notify("No config selected", 2) return end
        local Path = Library.Folders.Configs .. "/" .. Name .. ".lua"
        if not isfile(Path) then MainWin:Notify("File not found", 2) return end
        local fn = loadstring(readfile(Path))
        if not fn then MainWin:Notify("Parse error") return end
        local ok, Data = pcall(fn)
        if not ok or type(Data) ~= "table" then MainWin:Notify("Load error", 2) return end
        Library:ApplyFlags(Data)
        MainWin:Notify("Loaded: " .. Name, 2)
    end

    local function DeleteConfig()
        local Name = State.Selected
        if not Name then MainWin:Notify("No config selected", 2) return end
        local Path = Library.Folders.Configs .. "/" .. Name .. ".lua"
        if not isfile(Path) then MainWin:Notify("File not found", 2) return end
        delfile(Path)
        NameBox.Value = ""
        RefreshList()
        MainWin:Notify("Deleted: " .. Name, 2)
    end

    MakeButtonRow("Save", SaveConfig, "Load", LoadConfig)
    MakeButtonRow("Delete", DeleteConfig, "Refresh", function()
        RefreshList()
        MainWin:Notify("Refreshed", 2)
    end)

    return ConfigWin
end

function Library:NavBar(MainWin, StyleWin, ConfigWin)
    local BtnSize = 28
    local BtnGap  = 3
    local Pad     = 6
    local NumBtns = 3
    local W = Pad + NumBtns * BtnSize + (NumBtns - 1) * BtnGap + Pad
    local H = Pad + BtnSize + Pad + 4

    Library.NavBarData = {
        X = Library.Viewport.X / 2 - W / 2,
        Y = 40,
        Width  = W,
        Height = H,
        Buttons = {
            {Label = "M", Window = MainWin},
            {Label = "S", Window = StyleWin},
            {Label = "C", Window = ConfigWin},
        },
    }
end

function Library:Window(Options)
    return Window.New(Options or {})
end

Library.MasterVisible = true
Library.MasterPrevState = false
Library.MasterSavedStates = {}

RunService.Render:Connect(function()
    Library:UpdateInput()
    Library.Input.Consumed = false
    Library.DropdownOverlay = nil

    local MainWin = Library.Windows[1]
    if not MainWin then return end

    local MenuKey = MainWin.MenuToggleKey or "RightShift"
    local PressedKeys = getpressedkeys() or {}
    local MenuKeyDown = table.find(PressedKeys, MenuKey) ~= nil

    if MenuKeyDown and not Library.MasterPrevState then
        if Library.MasterVisible then
            Library.MasterSavedStates = {}
            for _, Win in ipairs(Library.Windows) do
                Library.MasterSavedStates[Win] = Win.Visible
                Win.Visible = false
            end
            Library.MasterVisible = false
        else
            for _, Win in ipairs(Library.Windows) do
                Win.Visible = Library.MasterSavedStates[Win] or false
            end
            Library.MasterVisible = true
        end
        Library.MasterPrevState = true
        Library.Input.FocusedTextbox = nil
    elseif not MenuKeyDown then
        Library.MasterPrevState = false
    end

    if Library.NavBarData then
        local NB = Library.NavBarData
        local BtnSize = 28
        local BtnGap = 3
        local Pad = 6

        DrawingImmediate.FilledRectangle(Vector2.new(NB.X, NB.Y), Vector2.new(NB.Width, NB.Height), Library.Appearance.Coloring.Black, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(NB.X + 1, NB.Y + 1), Vector2.new(NB.Width - 2, NB.Height - 2), Library.Appearance.Coloring.Accent, 1)
        DrawingImmediate.FilledRectangle(Vector2.new(NB.X + 2, NB.Y + 2), Vector2.new(NB.Width - 4, NB.Height - 4), Library.Appearance.Coloring.Background, 1)

        for i, Btn in ipairs(NB.Buttons) do
            local BX = NB.X + Pad + (i - 1) * (BtnSize + BtnGap)
            local BY = NB.Y + Pad
            local IsActive = Btn.Window and Btn.Window.Visible
            local Hov = Library:IsHovering(BX, BY, BtnSize, BtnSize) and not Library.Input.Consumed

            DrawingImmediate.FilledRectangle(Vector2.new(BX, BY), Vector2.new(BtnSize, BtnSize), Library.Appearance.Coloring.Black, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(BX + 1, BY + 1), Vector2.new(BtnSize - 2, BtnSize - 2), IsActive and Library.Appearance.Coloring.AccentDark or Library.Appearance.Coloring.Border, 1)
            DrawingImmediate.FilledRectangle(Vector2.new(BX + 2, BY + 2), Vector2.new(BtnSize - 4, BtnSize - 4), IsActive and Library.Appearance.Coloring.Accent or (Hov and Library.Appearance.Coloring.BackgroundDark or Library.Appearance.Coloring.Background), 1)

            local TB = DrawingImmediate.GetTextBounds(Library.Appearance.Font, Library.Appearance.FontSize, Btn.Label)
            DrawingImmediate.OutlinedText(
                Vector2.new(BX + math.floor((BtnSize - TB.X) / 2), BY + math.floor((BtnSize - TB.Y) / 2)),
                Library.Appearance.FontSize,
                IsActive and Library.Appearance.Coloring.White or (Hov and Library.Appearance.Coloring.Accent or Library.Appearance.Coloring.Dim),
                1, Btn.Label, false, Library.Appearance.Font)

            if Library.Input.MouseClicked and Hov and Btn.Window then
                Library.Input.Consumed = true
                Btn.Window.Visible = not Btn.Window.Visible
                if not Library.MasterVisible then
                    Library.MasterSavedStates[Btn.Window] = Btn.Window.Visible
                end
            end
        end
    end

    local WatermarkText  = MainWin.Name .. "  |  " .. math.floor(get_overlay_fps()) .. " FPS"
    local WatermarkWidth = #WatermarkText * 7 + 16
    DrawingImmediate.FilledRectangle(Vector2.new(10, 10), Vector2.new(WatermarkWidth, 22), Library.Appearance.Coloring.Black, 0.8)
    DrawingImmediate.FilledRectangle(Vector2.new(10, 10), Vector2.new(WatermarkWidth, 2), Library.Appearance.Coloring.Accent, 1)
    DrawingImmediate.OutlinedText(Vector2.new(18, 14), Library.Appearance.FontSize, Library.Appearance.Coloring.White, 0.9, WatermarkText, false, Library.Appearance.Font)
    MainWin:RenderKeybindList()

    for _, WindowInstance in ipairs(Library.Windows) do
        if WindowInstance.Visible then
            WindowInstance:Render()
        end
    end
end)

return Library
