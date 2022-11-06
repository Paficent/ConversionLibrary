# Conversion Library
Luau library for converting FD Scripts into FE Scripts using reanimation

Created by `Moon#9601 (858557060563992617)`

Credits to `StrokeThePea` for his Align functions

## Getting the library

```lua
local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/0x580x540x43/ConversionLibrary/main/Functions.lua"))()
```
## Hat functions


### GetMeshId
```lua
<function> Functions.GetMeshId(<SpecialMesh, Part, MeshPart, Accessory> Object)
```
Returns the `ID` of the Mesh being used in the `Object`, without `rbxassetid://`


### GetTextureId
```lua
<function> Functions.GetTextureId(union<SpecialMesh, Part, MeshPart, Accessory> Object)
```
Returns the `ID` of the Texture being used in the `Object`, without `rbxassetid://`


### GetHats
```lua
<function> Functions.GetHats(<void>)
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
<function> Functions.RenameHats(<void>)
```
Renamed the Characters accessories by their `TextureId`


### AntiRagDoll
```lua
<function> Functions.AntiRagDoll(<void>)
```
Attempts to disable ragdoll on your character in games that have ragdoll

### Noclip
```lua
<function> Functions.Noclip(union<Part, nil> Object)
```
Noclips an object (if `Object` is a Part) or your entire character if `Object` is nil

### RemoveMesh
```lua
<function> Functions.RemoveMesh(<Part> Object)
```
Destroys all meshes that are children of the Part `Object`


## Align functions

### CFrameAlign
```lua
<function> Functions.CFrameAlign(<Part> Part0, <Part> Part1, <CFrame?> Position, <CFrame?> Angle)
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
<function> Functions.Align(<Part> Part0, <Part> Part1, <Vector3?> Position, <Vector3?> Orientation, <bool?> MaxAlign)
```
Aligns `Part0` and `Part1` with the position `Positon` and angle `Angle`.

Example:
```lua
local Hat = game.Players.LocalPlayer.Character:FindFirstChild("Hat Name").Handle

Functions.Align(Hat, game.Players.LocalPlayer.Character.Torso, Vector3.new(0,0,0), Vector3.new(0,0,0), false)

Hat:BreakJoints()
```
