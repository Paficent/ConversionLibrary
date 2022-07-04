local ConversionFunctions = loadstring(game:HttpGet("https://raw.githubusercontent.com/0x580x540x43/ConversionLibrary/main/Functions.lua"))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
--[[
    I'm wearing https://www.roblox.com/catalog/4506945409/Corrupt-Demonic-Greatsword and https://www.roblox.com/catalog/4315489767/Demonic-Greatsword
    The issue with these hats is that they are both named "MeshPartAccessory" but many scripts still use them, even though many hats are made like this and it can be an issue

    To solve this problem you can use the function GetHats()
]]

local Hats = ConversionFunctions.GetHats()

for i,v in pairs(Hats) do -- Hats are named by their texture id's since different meshes can have the same meshid but it's less likely for different meshes to have the same texture id
    print(i) -- 4506940486 / 4315250791
    print(v.Name) -- "MeshPartAccessory" / "MeshPartAccessory"
    print(v.MeshId) -- 4315410540 / 4315410540
    print(v.MeshLink) -- "https://www.roblox.com/library/4315410540" / "https://www.roblox.com/library/4315410540"
    print(v.TextureId) -- 4506940486 / 4315250791
    print(v.TextureLink) -- https://www.roblox.com/library/4506940486" / https://www.roblox.com/library/4315250791"
    print(v.Size) -- 4, 4, 1 / 4, 4, 1
end

-- Want to rename the hats so you can differentiate between the two?

ConversionFunctions.RenameHats()

-- Let's test if the renaming worked

for _,Hat in pairs(Character:GetChildren()) do
    if Hat:IsA("Accessory") then
        warn(Hat.Name) -- 4506940486 / 4315250791
    end
end

-- Final check to see if the naming named everything correctly
print(Character[4506940486].Handle.SpecialMesh.TextureId) -- 4506940486
print(ConversionFunctions.GetMeshId(Character[4506940486].Handle.SpecialMesh)) -- 4506940486

ConversionFunctions.RemoveMesh(Character[4506940486]) -- Removes the mesh of the corrupt demonic greatsword

ConversionFunctions.Noclip() -- Could be an object or nil to noclip the entire player

Character[4506940486]:FindFirstChild("Handle"):BreakJoints() -- Final demonstration showing that with these functions you can make sure you're using the right hat
