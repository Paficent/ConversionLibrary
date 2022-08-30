--[[
    Created by Moon#9601 (858557060563992617) / https://github.com/0x580x540x43
    Updated on 8/30/22

    This script is not optimized do not hurt me, I will optimize it later
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

local Mesh, ID, MeshId, TextureId, Handle, Table -- Locals that should be initiated "globally" to allow for slight optimizations -- all are nil

local function split(Input, Seperator) -- I didn't make this because I am lazy lick my clit
    Table = {}
    for str in string.gmatch(Input, "([^"..Seperator.."]+)") do
        table.insert(Table, str)
    end
    return Table
end

Functions = {
    GetMeshId = function(Object) -- Returns a "SpecialMesh" or a "Part" or a "MeshPart" or an "Accesory"'s mesh id.
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
    GetTextureId = function(Object) -- Returns a "SpecialMesh" or a "Part" or a "MeshPart" or an "Accesory"'s texture id.
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
    GetHats = function() -- returns a list of hats
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
                    Size = Handle.Size
                }
            end
        end
        return Hats
    end,
    RenameHats = function() -- [void]
        local Hats = Functions.GetHats() -- Get's table of hats

        for i,v in pairs(Hats) do
            for _,Hat in pairs(Character:GetChildren()) do
                if Hat:IsA("Accessory") then
                    Handle = Hat:FindFirstChild("Handle")
                    Mesh = Handle:FindFirstChildWhichIsA("SpecialMesh")

                    TextureId = Functions.GetTextureId(Mesh)
                    if Hat.Name == v.Name and TextureId == i then
                        Hat.Name = i
                    end
                end
            end
        end
    end,
    AntiRagDoll = function() -- [void]
        for _,v in pairs(Character:GetDescendants()) do
            if v:IsA("HingeConstraint") or v:IsA("BallSocketConstraint") then -- Most ragdoll games use these two constraints, finds them and destroys them
                v:Destroy()
            end
        end
    end,
    Noclip = function(Object)  -- Object is type "nil" for nocliping the character or a "Part" [void]
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
    RemoveMesh = function(Object) -- Object is a "SpecialMesh" [void]
        for _,v in pairs(Object:GetDescendants()) do
            if v:IsA("SpecialMesh") then
                v:Destroy()
            end
        end
    end
}

return Functions
