local FontSize = 13
local Default = "Fonts"

local Fonts = {
    Stored = {
        { "ProggyClean.ttf",       "ProggyClean.json",       "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/ProggyClean.ttf" },
        { "Minecraftia.ttf",       "Minecraftia.json",       "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/Minecraftia.ttf" },
        { "Verdana.ttf",           "Verdana.json",           "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/Verdana.ttf" },
        { "Visitor.ttf",           "Visitor.json",           "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/Visitor.ttf" },
        { "SmallestPixel.ttf",     "SmallestPixel.json",     "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/SmallestPixel.ttf" },
        { "Windows-XP-Tahoma.ttf", "Windows-XP-Tahoma.json", "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/Windows-XP-Tahoma.ttf" },
        { "Source-Sans-Pro.ttf",   "Source-Sans-Pro.json",   "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/Source-Sans-Pro.ttf" },
        { "Monaco.ttf",            "Monaco.json",            "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/Monaco.ttf" },
    },

    Registered = {},
    List = {},
}

function Fonts.Load(Path)
    Path = (type(Path) == "string" and Path ~= "" and Path) or Default

    if not fs.folder(Path) then
        pcall(function() fs.make(Path) end)
    end

    for _, FontData in Fonts.Stored do
        local FileName, Url = FontData[1], FontData[3]
        local Name = FileName:match("([^%.]+)")

        if Fonts.Registered[Name] then
            continue
        end

        local FilePath = Path .. "/" .. Name .. ".bin"

        if not fs.file(FilePath) then
            local Ok, Body = pcall(function() return http.get({ url = Url }) end)
            if Ok and type(Body) == "string" and #Body > 0 then
                fs.write(FilePath, Body)
            else
                print("[Fonts] download failed: " .. Name)
                continue
            end
        end

        local OkRead, Data = pcall(function() return fs.read(FilePath) end)
        if not OkRead or type(Data) ~= "string" or #Data == 0 then
            print("[Fonts] read failed: " .. Name)
            continue
        end

        local OkReg = pcall(function() Drawing.RegisterFont(Name, FontSize, Data) end)
        if OkReg then
            Fonts.Registered[Name] = true
            table.insert(Fonts.List, Name)
        else
            print("[Fonts] register failed: " .. Name)
        end
    end

    print("[Fonts] registered " .. #Fonts.List .. " font(s): " .. table.concat(Fonts.List, ", "))
    return Fonts.List
end

return Fonts
