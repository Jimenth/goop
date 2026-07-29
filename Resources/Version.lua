local Version

function GetPointer()
    for Address = memory.base, memory.base + 4 * 1024 * 1024 * 1024   - 1024 * 1024 , 1024 * 1024  do 
        local success, buf = pcall(memory.readbuffer, Address, 1024 * 1024 ) 
        if success and buf then 
            local BufferLength = buffer.len(buf) 
            for i = 0, BufferLength - #"version-"  do 
                if buffer.readu8(buf, i) == 118 then 
                    local CheckAddress = Address + i 
                    local StringSuccess, Text = pcall(memory.readstring, CheckAddress) 
                    
                    if StringSuccess and Text and string.sub(Text, 1, #"version-" ) == "version-" then
                        return CheckAddress 
                    end 
                end 
            end 
        end 
    end 
    return nil 
end

local V = GetPointer()

if V then
    Version = memory.readstring(V)
    
    local Index = string.find(Version, "\\Roblox")
    if Index then
        Version = string.sub(Version, 1, Index - 1)
    end
end

return Version
