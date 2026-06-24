<img width="219" height="230" alt="5b69c79d71ccd60156ae7df681fe95aa" src="https://github.com/user-attachments/assets/7fe41ae1-63eb-4efc-bf9c-1b7c55aad3a9" />

**Library |**
Initializes the Library Module
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()
```

**Window |**
Creates a new Window Element
*Position is optional — if omitted, the Window spawns centered on screen. The first Window created becomes the Main Window (`Library.Windows[1]`), whose toggle key (RightShift by default) shows/hides the entire UI.*
```lua
local Window = Library:Window({
    Name = string,
    Size = Vector2,
    Position = Vector2
})
```

**Page |**
Creates a new Page Element inside of the called Window
*Columns may be `1` or `2`. A Page holds a maximum of 2 Sections — any further Section calls fold into the last Section instead of creating a new one.*
```lua
local Page = Window:Page({
    Name = string,
    Columns = number
})
```

**Section |**
Creates a new Section inside of the given Page
*Side selects which column the Section renders in (`1` = left, `2` = right). With two Sections in a 2-column Page, the middle gap between them is 4 pixels.*
```lua
local Section = Page:Section({
    Name = string,
    Side = number
})
```

**Toggle |**
Creates a new Toggle Element
*A Toggle can host up to 2 attached ColorPickers and 1 attached KeyPicker (see below).*
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
For `Multi = false`, `Default` is a number (the index) and the callback receives the selected option.
For `Multi = true`, `Default` is a table of indices (`{number}`) and the callback receives a table containing the selected options.

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
*Alpha is the transparency from `0` to `1` (defaults to `1`). Created on a Section by itself, it renders as its own row. It can also be attached to a Toggle, Label, or Section header (see "Attached Pickers").*
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
*`Default` is the starting key name as a string (e.g. `"E"`, `"RightShift"`); defaults to `"None"`. A KeyPicker must have a `Flag` for its key to be processed. Right-click the badge to switch between `Toggle` and `Hold` mode. While rebinding, press `Escape` to cancel.*
```lua
local KeyPicker = Toggle:KeyPicker({
    Flag = string,
    Default = string,
    Callback = function
})
```
On a **Toggle** with no Callback, pressing the key flips the Toggle. With a Callback, the Callback receives the new state instead (`Toggle` mode: alternating `true`/`false`; `Hold` mode: `true` while held, `false` on release).

**Separator |**
Creates a visual separator
```lua
Section:Separator()
```

**Label |**
Creates a new Label Element
*A Label can host up to 2 attached ColorPickers and 1 attached KeyPicker (see below). Since a Label has no value, an attached KeyPicker drives its own Callback.*
```lua
local Label = Section:Label({
    Name = string,
    Color = Color3
})
```

***Attached Pickers***
*ColorPickers and KeyPickers can be attached as small badges to a Toggle, a Label, or directly to a Section header. Limits per host: up to 2 ColorPickers and 1 KeyPicker.*

**Attach to a Toggle or Label**
```lua
local Toggle = Section:Toggle({ Name = "Aimbot", Flag = "Aimbot" })
Toggle:KeyPicker({ Flag = "AimbotKey", Default = "E", Callback = function(state) end })
Toggle:ColorPicker({ Flag = "AimbotColor", Default = Color3.fromRGB(177, 156, 217) })

local Label = Section:Label({ Name = "FOV Circle" })
Label:KeyPicker({ Flag = "FOVKey", Default = "F", Callback = function(state) end })
Label:ColorPicker({ Flag = "FOVColor", Default = Color3.fromRGB(255, 255, 255) })
```

**Attach to a Section header (pass `Section = true`)**
*Section-attached pickers stack vertically beneath the header, left-aligned with the Section's elements.*
```lua
Section:KeyPicker({ Section = true, Flag = "SectionKey", Default = "E", Callback = function(state) end })
Section:ColorPicker({ Section = true, Flag = "SectionColor", Default = Color3.fromRGB(177, 156, 217) })
```

***Extra Windows***
**Style Window**
*Spawns to the right of the Main Window, top edges aligned, 8px gap.*
```lua
local StyleWindow = Library:StyleWindow()
```

**Config Window**
*Spawns to the left of the Main Window, top edges aligned, 8px gap. Saves/loads every Element that has a `Flag`.*
```lua
local ConfigWindow = Library:ConfigWindow()
```

*Initialize the NavBar (pass the Main Window first, then the Style and Config windows)*
```lua
local StyleWin = Library:StyleWindow()
local ConfigWin = Library:ConfigWindow()
Library:NavBar(Library.Windows[1], StyleWin, ConfigWin)
```

***Window Methods***
**Notify |** Displays a temporary notification (`Duration` defaults to 3 seconds)
```lua
Window:Notify(string, number)
```

***Flags & Configs***
*Every Element given a `Flag` writes its current value into `Library.Flags[Flag]`, keyed by type:*
- Toggle → `boolean`
- Slider / Dropdown → `{ Value = ... }`
- Textbox → `string`
- ColorPicker → `{ Color = Color3, Alpha = number }`
- KeyPicker → `{ Key = string, Mode = string }`
```lua
Library.Flags["Aimbot"] -- boolean
Library.Flags["AimbotColor"].Color -- Color3
Library.Flags["AimbotKey"].Key -- string
```
