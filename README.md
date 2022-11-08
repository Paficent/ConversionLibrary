# Conversion Library
Luau library for converting FD Scripts into FE Scripts using reanimation

Created by `Moon#9601 (858557060563992617)`

Credits to `StrokeThePea (https://github.com/StrokeThePea/)` for his Align functions

```lua
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/0x580x540x43/ConversionLibrary/main/Functions.lua"))()
```


#### Functions are formatted via

```lua
<type> Functions.FunctionName(MultipleTypes: Part | Accessory, OptionalArgument: CFrame?)

-- 'FunctionName' is the name of the function
-- 'MultipleTypes' is an argument that can support different types without breaking, in this example it would accept 'Part' or 'Accessory'
-- 'OptionalArgument' is an argument that accepts 'nil' or 'CFrame' as a type
```

## Functions


### GetMeshId
```lua
<function> Functions.GetMeshId(Object: SpecialMesh | Part | MeshPart | Accessory)
```
Returns the `ID` of the Mesh being used in the `Object`, without `rbxassetid://`


### GetTextureId
```lua
<function> Functions.GetTextureId(Object: SpecialMesh | Part | MeshPart | Accessory)
```
Returns the `ID` of the Texture being used in the `Object`, without `rbxassetid://`


### GetHats
```lua
<function> Functions.GetHats()
```
Returns the a table of all the Hats Parented to your Character formatted like
```lua
local Hats = {
    ["TextureId"] = { -- Hats are named in the table by their TextureId
        Name = "HatName",
        MeshId = "MeshId",
        MeshLink = "https://www.roblox.com/library/MeshId",
        TextureId = "TextureId",
        TextureLink = "https://www.roblox.com/library/TextureLink",
        Size = "SizeX, SizeY, SizeX"
    } 
}
```


### RenameHats
```lua
<function> Functions.RenameHats()
```
Renamed the Characters accessories by their `TextureId`


### AntiRagDoll
```lua
<function> Functions.AntiRagDoll()
```
Attempts to disable ragdoll on your character in games that have ragdoll

### Noclip
```lua
<function> Functions.Noclip(Object: Part?)
```
Noclips an object (if `Object` is a Part) or your entire character if `Object` is nil

### RemoveMesh
```lua
<function> Functions.RemoveMesh(Object: Part)
```
Destroys all meshes that are children of the Part `Object`

### CFrameAlign
```lua
<function> Functions.CFrameAlign(Part0: Part, Part1: Part, Position: CFrame?, Angle: CFrame?)
```
Aligns `Part0` and `Part1` with the position `Positon` and angle `Angle`, must be called in a loop.

Example:
```lua
local Hat = game.Players.LocalPlayer.Character:FindFirstChild("Hat Name").Handle
local rad = math.rad

game:GetService("RunService").Heartbeat:Connect(function() -- Loop
    Functions.CFrameAlign(Hat, game.Players.LocalPlayer.Character.Torso, CFrame.new(0,0,0), CFrame.Angles(rad(0), rad(0), rad(0)))
end)

Hat:BreakJoints()
```

### Align
```lua
<function> Functions.Align(Part0: Part, Part1: Part, Position: Vector3?, Orientation: Vector3?, MaxAlign: boolean?)
```
Aligns `Part0` and `Part1` with the position `Positon` and angle `Angle`.

Example:
```lua
local Hat = game.Players.LocalPlayer.Character:FindFirstChild("Hat Name").Handle

Functions.Align(Hat, game.Players.LocalPlayer.Character.Torso, Vector3.new(0,0,0), Vector3.new(0,0,0), false)

Hat:BreakJoints()
```
