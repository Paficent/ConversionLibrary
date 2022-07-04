--[[
    Created by Moon#9601 (858557060563992617) / https://github.com/0x580x540x43
    Updated on 7/4/22

    This script is not optimized do not hurt me, I will optimize it later
]]

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local Mesh, ID, MeshId, Table

local function split(Input, Seperator) -- Not my function :)
    Table = {}
    for str in string.gmatch(Input, "([^"..Seperator.."]+)") do
        table.insert(Table, str)
    end
    return Table
end

Functions = {
    GetMeshId = function(mesh)
        if not mesh:IsA("SpecialMesh") then
            return "Error - Param \"mesh\" is not a ClassType of \"SpecialMesh\""
        end
        if split(mesh.TextureId, '=')[2] ~= nil then
            MeshId = split(mesh.TextureId, '=')[2]
        else
            MeshId = split(mesh.TextureId, 'rbxassetid://')[1]
        end
        return MeshId
    end,
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

                ID = Functions.GetMeshId(Mesh)
                
                Hats[tostring(ID)] = {
                    Name = v.Name,
                    MeshLink = "https://www.roblox.com/library/" .. ID,
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
                    ID = Functions.GetMeshId(Mesh)

                    if Hat.Name == v.Name and ID == i then
                        Hat.Name = i
                    end
                end
            end
        end
    end
}

return Functions
