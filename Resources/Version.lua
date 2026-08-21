local function GetVersionPointer()
    local ChunkSize = 1024 * 1024
    local Overlap = 32
    local HashPattern = "^version%-%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%f[%W]"

    for Address = memory.base, memory.base + 4 * 1024 * 1024 * 1024 - ChunkSize, ChunkSize do
        local Ok, Buf = pcall(memory.readbuffer, Address, ChunkSize + Overlap)
        if Ok and Buf then
            local OkStr, ChunkText = pcall(buffer.readstring, Buf, 0, buffer.len(Buf))
            if OkStr and ChunkText then
                local SearchFrom = 1
                while true do
                    local FoundAt = string.find(ChunkText, "version%-", SearchFrom)
                    if not FoundAt then break end

                    local CandidateAddress = Address + (FoundAt - 1)
                    local OkText, Text = pcall(memory.readstring, CandidateAddress)
                    if OkText and Text and Text:match(HashPattern) then
                        return CandidateAddress
                    end

                    SearchFrom = FoundAt + 1
                end
            end
        end
    end

    return nil
end

local Pointer = GetVersionPointer()
local Version = nil

if Pointer then
    Version = memory.readstring(Pointer)
    local Index = string.find(Version, "\\Roblox")
    if Index then
        Version = string.sub(Version, 1, Index - 1)
    end
    Version = Version:match("^version%-%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x") or Version
end

return Version
