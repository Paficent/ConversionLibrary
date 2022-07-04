--[[
    Created by Moon#9601 (858557060563992617) / https://github.com/0x580x540x43
    Updated on 7/4/22

    This script is not optimized do not hurt me, I will optimize it later
]]

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local Mesh, ID, MeshId

local function split(Input, Seperator) -- Not my function :)
    local Table = {}
    for str in string.gmatch(Input, "([^"..Seperator.."]+)") do
        table.insert(Table, str)
    end
    return Table
end

local GetMeshId = function(Mesh)
    if split(Mesh.TextureId, '=')[2] ~= nil then
        MeshId = split(Mesh.TextureId, '=')[2]
    else
        MeshId = split(Mesh.TextureId, 'rbxassetid://')[1]
    end
    return MeshId
end

Functions = {
    GetHats = function()
        local Hats = {}
        for _,v in pairs(Character:GetChildren()) do
            if v:IsA("Accessory") then
                if v:WaitForChild("Handle"):FindFirstChild("SpecialMesh") == nil then
                    Mesh = v:WaitForChild("Handle"):FindFirstChild("Mesh")
                else
                    Mesh = v:WaitForChild("Handle"):FindFirstChild("SpecialMesh")
                end
        
                if Hats[v.Name] then
                    print("Duplicate found")
                end

                ID = GetMeshId(Mesh)
                
                Hats[tostring(ID)] = {
                    Name = v.Name,
                    Object = v
                }
            end
        end
        return Hats
    end,
    RenameHats = function()
        local Hats = Functions.GetHats()

        for i,v in pairs(Hats) do
            for _,Hat in pairs(Character:GetChildren()) do
                if Hat:IsA("Accessory") then
                    if Hat:WaitForChild("Handle"):FindFirstChild("SpecialMesh") == nil then
                        Mesh = Hat:WaitForChild("Handle"):FindFirstChild("Mesh")
                    else
                        Mesh = Hat:WaitForChild("Handle"):FindFirstChild("SpecialMesh")
                    end
                    ID = GetMeshId(Mesh)

                    if Hat.Name == v.Name and ID == i then
                        print("Test")
                    end
                end
            end
        end
    end
}

return Functions
