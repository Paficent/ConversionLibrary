--[[
    Created by Moon#9601 (858557060563992617) / https://github.com/0x580x540x43
    Updated on 7/4/22

    This script is not optimized do not hurt me, I will optimize it later
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local Mesh, ID, MeshId, TextureId, Handle, Table

local function split(Input, Seperator) -- Not my function :)
    Table = {}
    for str in string.gmatch(Input, "([^"..Seperator.."]+)") do
        table.insert(Table, str)
    end
    return Table
end

Functions = {
    GetMeshId = function(Object)
        if Object:IsA("SpecialMesh") then
            ID = Object.MeshId
        elseif Object:IsA("Part") then
            ID = Object:FindFirstChildWhichIsA("SpecialMesh").MeshId
        elseif Object:IsA("MeshPart") then
            ID = Object.MeshId
        elseif Object:IsA("Accessory") then
            ID = Object:WaitForChild("Handle"):FindFirstChildWhichIsA("SpecialMesh").MeshId
        else
            return 'Error - Param "Object" [1] is not a ClassType of "SpecialMesh" or "Part" or "Accessory" or "MeshPart"'
        end

        if split(ID, '=')[2] ~= nil then
            MeshId = split(ID, '=')[2]
        else
            MeshId = split(ID, 'rbxassetid://')[1]
        end
        return MeshId
    end,
    GetTextureId = function(Object)
        if Object:IsA("SpecialMesh") then
            ID = Object.TextureId
        elseif Object:IsA("Part") then
            ID = Object:FindFirstChildWhichIsA("SpecialMesh").TextureId
        elseif Object:IsA("MeshPart") then
            ID = Object.TextureID
        elseif Object:IsA("Accessory") then
            ID = Object:WaitForChild("Handle"):FindFirstChildWhichIsA("SpecialMesh").TextureId

        else
            return 'Error - Param "Object" [1] is not a ClassType of "SpecialMesh" or "Part" or "Accessory" or "MeshPart"'
        end

        if split(ID, '=')[2] ~= nil then
            TextureId = split(ID, '=')[2]
        else
            TextureId = split(ID, 'rbxassetid://')[1]
        end
        return TextureId
    end,
    GetHats = function()
        local Hats = {}
        for _,v in pairs(Character:GetChildren()) do
            if v:IsA("Accessory") then
                Handle = v:WaitForChild("Handle")
                Mesh = Handle:FindFirstChildWhichIsA("SpecialMesh")
        
                if Hats[v.Name] then
                    print("Duplicate found")
                end

                MeshId = Functions.GetMeshId(Mesh)
                TextureId = Functions.GetTextureId(Mesh)
                
                Hats[tostring(TextureId)] = {
                    Name = v.Name,
                    MeshId = MeshId,
                    MeshLink = "https://www.roblox.com/library/" .. MeshId,
                    TextureId = TextureId,
                    TextureLink = "https://www.roblox.com/library/" .. TextureId,
                    Size = Handle.Size,
                    Object = v
                }
            end
        end
        return Hats
    end,
    RenameHats = function()
        local Hats = Functions.GetHats() -- Get's table of hats

        for i,v in pairs(Hats) do
            for _,Hat in pairs(Character:GetChildren()) do
                if Hat:IsA("Accessory") then
                    Handle = v:WaitForChild("Handle")
                    Mesh = Handle:FindFirstChildWhichIsA("SpecialMesh")

                    ID = Functions.GetMeshId(Mesh) -- Get's the mesh's TextureId

                    if Hat.Name == v.Name and ID == i then
                        Hat.Name = i
                    end
                end
            end
        end
    end,
    AntiRagDoll = function()
        for _,v in pairs(Character:GetDescendants()) do
            if v:IsA("HingeConstraint") or v:IsA("BallSocketConstraint") then -- Most ragdoll games use these two constraints, finds them and destroys them
                v:Destroy()
            end
        end
    end,
    Noclip = function(Object)
        local obj = Object or Character
        if obj == Object then
            RunService.Stepped:Connect(function()
                obj.CanCollide = false
            end)
        else
            RunService.Stepped:Connect(function()
                for _,v in pairs(obj:GetDescendants()) do
                    if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Part") then
                        v.CanCollide = false
                    end
                end
            end)
        end
    end,
    RemoveMesh = function(Object)
        for _,v in pairs(Object:GetDescendants()) do
            if v:IsA("SpecialMesh") then
                v:Destroy()
            end
        end
    end
}

return Functions
