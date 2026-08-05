# Extra.lua — API Reference

Everything `Extra.lua` adds on top of Severe. Load it once with `loadfile("Extra.lua")()`.

- **Access** column: `R` = readable, `W` = writable. `R` only means read-only.
- Properties are declared per class; a class inheriting the member (e.g. `TextLabel` from `GuiObject`) gets it too.
- **Native note:** `BasePart.Position`, `CFrame`, `Size`, `Transparency` are **Severe-native** and deliberately *not* re-declared here — use them directly.

---

## Properties

### BasePart  *(Part, MeshPart, UnionOperation, TrussPart)*
| Property | Type | Access |
|---|---|---|
| Reflectance | number | R/W |
| Color3 | Color3 | R/W |
| CastShadow, Locked, Massless | boolean | R/W |
| Anchored, CanCollide, CanQuery, CanTouch | boolean | R/W |
| Material | Enum.Material | R/W |
| AssemblyLinearVelocity, AssemblyAngularVelocity | Vector3 | R/W |
| Owner | Instance | R/W |

```lua
part.Anchored = true
part.Material = Enum.Material.Neon
print(part.AssemblyLinearVelocity)
```

### Humanoid
| Property | Type | Access |
|---|---|---|
| Health, MaxHealth | number | R/W |
| WalkSpeed, JumpPower, JumpHeight | number | R/W |
| HipHeight, MaxSlopeAngle | number | R/W |
| HealthDisplayDistance, NameDisplayDistance | number | R/W |
| DisplayName | string | R/W |
| Jump, Sit, PlatformStand, AutoRotate, AutoJumpEnabled | boolean | R/W |
| UseJumpPower, RequiresNeck, BreakJointsOnDeath | boolean | R/W |
| AutomaticScalingEnabled, EvaluateStateMachine | boolean | R/W |
| CameraOffset, TargetPoint | Vector3 | R/W |
| MoveDirection | Vector3 | R |
| DisplayDistanceType, HealthDisplayType, NameOcclusion, RigType | Enum | R/W |
| FloorMaterial | Enum.Material | R |

```lua
humanoid.WalkSpeed = 50           -- W
print(humanoid.Health)            -- R
```

### Camera
| Property | Type | Access |
|---|---|---|
| FieldOfView | number *(degrees)* | R/W |
| ImagePlaneDepth | number | R/W |

`FieldOfView` is converted for you — read/write in **degrees** (Roblox stores radians).

### Workspace
| Property | Type | Access |
|---|---|---|
| Gravity | number | R/W *(writable — drives the sim, not the read-only copy)* |
| GlobalWind, AirDensity | Vector3 / number | R/W |

### Player
| Property | Type | Access |
|---|---|---|
| AccountAge | number | R |
| LocaleId | string | R |
| HealthDisplayDistance, NameDisplayDistance, MaxZoomDistance, MinZoomDistance | number | R/W |
| TeamColor | BrickColor | R/W |
| CameraMode | Enum.CameraMode | R/W |
| ModelInstance | Instance | R/W |
| Mouse | Instance | R |

### Team
| Property | Type | Access |
|---|---|---|
| TeamColor | Color3 | R/W |
| BrickColor | BrickColor | R/W |

Both map the same value: `TeamColor` gives/takes a **Color3**, `BrickColor` a **BrickColor**.

### GuiObject  *(Frame, TextLabel, TextButton, TextBox, ImageLabel, ImageButton, ScrollingFrame)*
| Property | Type | Access |
|---|---|---|
| Position, Size | UDim2 | R/W |
| AnchorPoint | Vector2 | R/W |
| Rotation, BackgroundTransparency | number | R/W |
| LayoutOrder, ZIndex, BorderSizePixel | number | R/W |
| BackgroundColor3 | Color3 | R/W |
| Visible, Active, ClipsDescendants, Selectable, Interactable | boolean | R/W |
| AbsolutePosition, AbsoluteSize | Vector2 | R |
| AbsoluteRotation | number | R |

### TextLabel / TextButton
| Property | Type | Access |
|---|---|---|
| Text | string | R/W |
| TextColor3, TextStrokeColor3 | Color3 | R/W |
| TextSize, TextTransparency, TextStrokeTransparency, LineHeight | number | R/W |
| Font, MaxVisibleGraphemes | number | R/W |
| TextScaled, TextWrapped, RichText | boolean | R/W |
| TextXAlignment, TextYAlignment | Enum | R/W |
| *(TextButton only)* AutoButtonColor, Modal, Selected | boolean | R/W |

*(TextBox uses the shared GuiObject-offset Text/TextColor3/RichText.)*

### Tool
| Property | Type | Access |
|---|---|---|
| GripForward, GripRight, GripUp | Vector3 | R/W |

### VehicleSeat
| Property | Type | Access |
|---|---|---|
| MaxSpeed, Torque, TurnSpeed, SteerFloat, ThrottleFloat | number | R/W |
| Occupant | Instance | R |

### AnimationTrack
| Property | Type | Access |
|---|---|---|
| TimePosition | number | R/W |
| Speed | number | R |
| Looped | boolean | R/W |
| IsPlaying | boolean | R |
| Animation, Animator | Instance | R |

### Lighting / Atmosphere / Sky / Terrain / ParticleEmitter / Beam / post-effects
Large sets of the usual properties (colors, floats, textures) — e.g. `Lighting.Brightness/FogColor/ClockTime(R)`, `Atmosphere.Density/Color`, `Sky.SunAngularSize/Skybox*`, `Terrain.WaterColor/GrassLength`, `ParticleEmitter.Rate/Lifetime(NumberRange)`, `BloomEffect/BlurEffect/DepthOfFieldEffect/ColorCorrectionEffect.*`. All R/W unless noted.

### Other single properties
`Model.Scale` (R/W), `SpecialMesh.Offset` (R/W, Vector3), `ProximityPrompt.ActionText/ObjectText/Enabled/HoldDuration/KeyboardKeyCode(Enum)`, `SpawnLocation.*`, `Clothing.Color3`, `Shirt.ShirtTemplate`, `Pants.PantsTemplate`, `Weld/WeldConstraint.Part0/Part1`, `Attachment.Position`, `DataModel.JobId(R)/PlaceVersion(R)/GameLoaded(R)`, `InputObject.Position(R, Vector2)`, `MouseService.InputObject(R)`.

---

## Methods

### Humanoid
- **`Humanoid:TakeDamage(amount: number)`** → *nothing.* Lowers `Health` (floored at 0). **Only affects the local character's humanoid**; a no-op on any other humanoid.
- **`Humanoid:MoveTo(position: Vector3)`** → `signal`. Walks toward the point; the returned signal fires on arrival. Wait from your own thread: `humanoid:MoveTo(pos):wait()`. Also fires the `Humanoid.MoveToFinished` event.

### Model / BasePart — bounding box
- **`Model:GetBoundingBox()`** → `(CFrame, Vector3)`. World-space, orientation-aware, over the model's direct-child parts.
- **`BasePart:GetBoundingBox()`** → `(CFrame, Vector3)`. That single part's oriented box.
- **`GetBoundingBox(x)`** *(global)* → `(CFrame, Vector3)`. `x` may be a **Model**, a **BasePart**, or a **table of parts**.

```lua
local cf, size = character:GetBoundingBox()
local cf2, size2 = GetBoundingBox({ part1, part2 })
```

### Instance
- **`Instance:GetFullName()`** → `string`. Dotted path from the top ancestor down.
- **`Instance:GetPropertyChangedSignal(name: string)`** → `signal` firing `(newValue)` when that property changes.

### Terrain
- **`Terrain:GetMaterialColor(material: Enum.Material)`** → `Color3`.
- **`Terrain:SetMaterialColor(material: Enum.Material, color: Color3)`** → *nothing.*

### Animator
- **`Animator:GetPlayingAnimationTracks()`** → `{ AnimationTrack }`.

### DataModel
- **`game:GetTickRate()`** → `number?` (world steps per second).

### TweenService
- **`TweenService:Create(instance, tweenInfo, properties)`** → `Tween`.
- **`TweenService:GetValue(alpha, easingStyle, easingDirection)`** → `number`.
- **`TweenService:GetActiveTweens()`** → `{ Tween }` (the tweens created here that are playing).

`tweenInfo` may be a real `TweenInfo` **or** a plain table `{ Time=, EasingStyle=, EasingDirection=, RepeatCount=, Reverses=, DelayTime= }`. Styles/directions accept enums or strings. `{ CFrame = x }` is aliased to `{ Position = x }` (writing a character's CFrame spins the rig).

```lua
TweenService:Create(part, { Time = 1, EasingStyle = "Quad" }, { Position = target }):Play()
```

**Tween object:** `:Play()`, `:Pause()`, `:Cancel()`; fields `.Completed` (signal), `.Finished` (boolean — poll this in hot loops), `.PlaybackState`, `.Instance`, `.TweenInfo`.

### UserInputService
- **`:IsKeyDown(keyCode)`** → `boolean`
- **`:GetKeysPressed()`** → `{ Enum.KeyCode }`
- **`:IsMouseButtonPressed(button)`** → `boolean`
- **`:GetMouseLocation()`** → `Vector2`

---

## Events (Connections)

All return a **signal**; `:Connect(fn)` (capital C) returns a connection with `:Disconnect()`. They're detected by polling, activate only while connected, and are omitted where reliable detection isn't possible.

| Class | Event | Handler args |
|---|---|---|
| **Instance** (universal) | ChildAdded | `(child)` |
| | ChildRemoved | `(child)` |
| | DescendantAdded | `(descendant)` |
| | DescendantRemoving | `(descendant)` |
| | AncestryChanged | `(child, newParent)` |
| | Destroying | `()` — best-effort |
| | AttributeChanged | `(attributeName)` |
| **Players** | PlayerAdded | `(player)` |
| | PlayerRemoving | `(player)` |
| **Player** | CharacterAdded | `(character)` |
| | CharacterRemoving | `(character)` |
| **Humanoid** | HealthChanged | `(newHealth)` |
| | Died | `()` — fires once |
| | Jumping | `(active)` |
| | Seated | `(active)` |
| | MoveToFinished | `(reached)` |
| **AnimationTrack** | Stopped, Ended | `()` |
| **VehicleSeat** | OccupantChanged | `(occupant)` |
| **UserInputService** | InputChanged | `(inputObject)` — mouse-move only |
| | WindowFocused | `()` |
| | TextBoxFocused | `(textBox)` |

```lua
local conn = workspace.ChildAdded:Connect(function(child)
    print("added:", child.Name)
end)
-- later
conn:Disconnect()

humanoid.HealthChanged:Connect(function(Health)
    print("health:", Health)
end)
```

**Notes**
- `PlayerAdded` / `CharacterAdded` only fire for players/characters that appear *after* you connect — iterate `Players:GetChildren()` / check `player.Character` for existing ones.
- `Died` fires exactly once, then stops watching (a dead humanoid can't die again).
- **Not implemented** (can't be detected reliably): `Instance.Changed`; Humanoid `Running/FreeFalling/Climbing/Swimming/StateChanged/StateEnabledChanged`.

---

## Globals

- **`GetBoundingBox(...)`** — see Methods.
- **`_G.TweenService`** — fallback table (`Create`, `GetValue`, `GetActiveTweens`) if `game:GetService("TweenService")` doesn't resolve.
- **`_G.Easing`** — table of every EasingStyle function (`Linear`, `Sine`, `Quad`, `Cubic`, `Quart`, `Quint`, `Back`, `Circular`, `Exponential`, `Elastic`, `Bounce`), each `In/Out/InOut`.
