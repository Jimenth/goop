<img width="219" height="230" alt="5b69c79d71ccd60156ae7df681fe95aa" src="https://github.com/user-attachments/assets/7fe41ae1-63eb-4efc-bf9c-1b7c55aad3a9" />

**Library |** 
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua")()
```

**Window |**
Creates a new Window Element
```lua
local Window = Library:Window({
    Name = string,
    Size = Vector2
})
```

**Page |**
Creates a new Page Element inside of the called Window
```lua
local Page = Window:Page({
    Name = string,
    Columns = number
})
```

**Section |**
Creates a new Section inside of the given Page
```lua
local Section = Page:Section({
    Name = string,
    Side = number
})
```

**Toggle |**
Creates a new Toggle Element
```lua
local Toggle = Section:Toggle({
    Name = string,
    Flag = string,
    Default = boolean,
    Callback = function
})
```

**Slider |**
Creates a new Slider Element

*A nil Name argument will move the slider itself into the Y position of it's non-existent text, reducing UI clutter*
```lua
local Slider = Section:Slider({
    Name = string,
    Flag = string,
    Min = number,
    Max = number,
    Default = number,
    Decimals = number,
    Suffix = string,
    Callback = function
})
```

**Dropdown |**
Creates a new Dropdown Element
```lua
local Dropdown = Section:Dropdown({
    Name = string,
    Flag = string,
    Options = {string},
    Default = number,
    Multi = boolean,
    Callback = function
})
```

For `Multi = false`, the callback receives the selected option.

For `Multi = true`, the callback receives a table containing the selected options.

**Button |**
Creates a new Button Element
```lua
local Button = Section:Button({
    Name = string,
    Callback = function
})
```

**ColorPicker |**
Creates a new Color Picker Element
```lua
local ColorPicker = Section:ColorPicker({
    Name = string,
    Flag = string,
    Default = Color3,
    Alpha = number,
    Callback = function
})
```

**Textbox |**
Creates a new Textbox Element
```lua
local Textbox = Section:Textbox({
    Name = string,
    Flag = string,
    Default = string,
    Placeholder = string,
    MaxLength = number,
    Callback = function
})
```

**KeyPicker |**
Creates a new Key Picker attached to a Toggle
```lua
local KeyPicker = Toggle:KeyPicker({
    Flag = string,
    Default = string,
    Callback = function
})
```

**Separator |**
Creates a visual separator
```lua
Section:Separator()
```

**Label |**
Creates a new Label Element
```lua
local Label = Section:Label({
    Name = string,
    Color = Color3
})
```

***Extra Windows***

**Style Window**
```lua
local StyleWindow = Library:StyleWindow()
```

**Config Window**
```lua
local ConfigWindow = Library:ConfigWindow()
```

*Initalize Windows*
```lua
Library:NavBar(Library.Windows[1], StyleWin, ConfigWin)
```
