--!strict

--[[
    Created by Moon#9601 (858557060563992617) / https://github.com/0x580x540x43
    Updated on 11/6/22

    This script is not optimized do not hurt me, I will optimize it later
]]

local Players: Players = game:GetService("Players")
local RunService: RunService = game:GetService("RunService")

local LocalPlayer: Player = Players.LocalPlayer
local Character: Model = LocalPlayer.Character
local isnetworkowner: any = isnetworkowner or function(Part) return Part.ReceiveAge == 0 end

local Mesh, ID, MeshId, TextureId, Handle, Table -- Locals that should be initiated "globally" to allow for slight optimizations -- all are nil

local function split(Input: string, Seperator: string)
    Table = {}
    for str in string.gmatch(Input, "([^"..Seperator.."]+)") do
        table.insert(Table, str)
    end
    return Table
end

Functions = {}

-- Hat Functions

Functions.GetMeshId = function(Object: any) -- Returns a "SpecialMesh" or a "Part" or a "MeshPart" or an "Accesory"'s mesh id.
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
end

Functions.GetTextureId = function(Object: any) -- Returns a "SpecialMesh" or a "Part" or a "MeshPart" or an "Accesory"'s texture id.
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
end

Functions.GetHats = function() -- returns a list of hats
    local Hats: table = {}
    for _,v in pairs(Character:GetChildren()) do
        if v:IsA("Accessory") then
            Handle = v:WaitForChild("Handle")
            Mesh = Handle:FindFirstChildWhichIsA("SpecialMesh") or Handle
    
            
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
end

Functions.RenameHats = function()
    local Hats: table = Functions.GetHats() -- Get's table of hats

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
end

Functions.AntiRagDoll = function()
    for _,v in pairs(Character:GetDescendants()) do
        if v:IsA("HingeConstraint") or v:IsA("BallSocketConstraint") then -- Most ragdoll games use these two constraints, finds them and destroys them
            v:Destroy()
        end
    end
end

Functions.Noclip = function(Object: Part?)  -- Object is type "nil" for nocliping the character or a "Part"
    local obj: any = Object or Character
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
end

Functions.RemoveMesh = function(Object: SpecialMesh)
    for _,v in pairs(Object:GetDescendants()) do
        if v:IsA("SpecialMesh") then
            v:Destroy()
        end
    end
end


-- Aligning (Credits: StrokeThePea)

Functions.CFrameAlign = function(Part0: Part, Part1: Part, Position: CFrame?, Angle: CFrame?)
	local CFrame_Position: CFrame = Position or CFrame.new()
	local CFrame_Angle: CFrame = Angle or CFrame.Angles(0,0,0)
	if isnetworkowner(Part0) == true then
		Part0.CFrame = Part1.CFrame * CFrame_Position * CFrame_Angle
	end
end

Functions.Align = function(Part0: Part, Part1: Part, Position: Vector3?, Orientation: Vector3?, MaxAlign: boolean?)
	local AlignPosition: AlignPosition = Instance.new("AlignPosition"); do
		AlignPosition.MaxForce = 66666666666
		AlignPosition.RigidityEnabled = true
		AlignPosition.Responsiveness = 200
		AlignPosition.Name = "AlignPosition_1"
		AlignPosition.Parent = Part0
	end

	local AlignOrientation: AlignOrientation = Instance.new("AlignOrientation"); do
		AlignOrientation.MaxTorque = 9e9 -- Better To Decrease this to avoid weird movement on R15.
		AlignOrientation.Responsiveness = 200
		AlignOrientation.Name = "AlignOrientation"
		AlignOrientation.Parent = Part0
	end

	local Attachment1: Attachment = Instance.new("Attachment"); do
		Attachment1.Position = Position or Vector3.new(0,0,0)
		Attachment1.Orientation = Orientation or Vector3.new(0,0,0)
		Attachment1.Name = "Attachment_1"
		Attachment1.Parent = Part0
	end

	local Attachment2: Attachment = Instance.new("Attachment"); do
		Attachment2.Name = "Attachment_2"
		Attachment2.Parent = Part1
	end

	AlignPosition.Attachment0 = Attachment1
	AlignPosition.Attachment1 = Attachment2
	AlignOrientation.Attachment0 = Attachment1
	AlignOrientation.Attachment1 = Attachment2

	if MaxAlign == true then
		task.spawn(function()
			repeat task.wait() until isnetworkowner(Part0) == true
			task.wait(0.05) -- Avoiding Bugs
			local AlignPosition2: AlignPosition = Instance.new("AlignPosition"); do
				AlignPosition2.Name = "AlignPosition_2"
				AlignPosition2.RigidityEnabled = true
				AlignPosition2.Parent = Part0
			end
			AlignPosition2.Attachment0 = Attachment1
			AlignPosition2.Attachment1 = Attachment2
		end)
	end
end

return Functions
