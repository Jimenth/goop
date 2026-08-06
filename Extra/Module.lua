--[[
    Module.lua

    Extends the memory-backed Instance API with additional Roblox-accurate
    properties and methods that the environment doesn't expose natively.

    Everything is declared through `Instance.declare` using the `memory` library
    documented in spec.d.luau. Offsets are pulled live from Offsets.lua (which
    mirrors https://offsets.imtheo.lol), so field names match the Roblox schema.

    Property / method names follow Roblox exactly (PascalCase), e.g. the offset
    key `Walkspeed` is surfaced as the Roblox property `WalkSpeed`.

    Layout:
      Global.Function   - internal helpers and declaration drivers.
      Global.Properties  - offset data, grouped by memory type then class.
                           A field is either an offset number (read/write), or a
                           table { Offset = n, ReadOnly = true } / with EnumType.
    To add a class, drop another entry under each relevant type table; the
    drivers pick it up automatically.
]]

Drawing.RegisterFont("Source-Sans-Pro", 96, http.get({ url = "https://raw.githubusercontent.com/Jimenth/Misanthropy/refs/heads/main/Fonts/Source-Sans-Pro.ttf" }))

local RawOffsets = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Resources/Offsets.lua"))()
task.wait(2)
assert(RawOffsets, "Module: failed to load offsets from Offsets.lua")

-- Resilience: a missing namespace or field must NOT crash the whole module. Wrap
-- Offsets so `Offsets.X.Y` yields nil (never an "index nil" error) for anything the
-- dump lacks. Fields that come out nil are dropped from the property tables by Lua
-- (a `Name = nil` constructor entry is a no-op), and the declaration drivers skip
-- any table-form entry whose offset is nil -- so missing namespaces just lose their
-- members instead of aborting the load. They're reported once for visibility.
local EmptyNamespace = {}
local Offsets = setmetatable({}, {
    __index = function(_, Key)
        return RawOffsets[Key] or EmptyNamespace
    end,
})

for _, Namespace in {
    "Humanoid", "ClickDetector", "Clothing", "DataModel", "DragDetector", "Workspace", "Terrain",
    "BasePart", "Primitive", "PrimitiveFlags", "ParticleEmitter", "Player", "ProximityPrompt", "Sky",
    "VehicleSeat", "Seat", "RunService", "UnionOperation", "Weld", "WeldConstraint",
    "UserInputService", "WindowInputState", "RenderJob", "RenderView", "VisualEngine",
    "AnimationTrack", "AirProperties", "Animator", "Atmosphere", "Attachment", "Beam", "BloomEffect",
    "BlurEffect", "CharacterMesh", "ColorCorrectionEffect", "ColorGradingEffect", "DepthOfFieldEffect",
    "GuiBase2D", "GuiObject", "Lighting", "Camera", "Model", "World", "SpawnLocation",
    "MouseService", "InputObject", "SpecialMesh", "TextLabel", "TextButton", "Team", "Tool",
} do
    if not RawOffsets[Namespace] then
        print("[Module] missing offset namespace (its members are skipped): " .. Namespace)
    end
end

memory.set_write_strength(1e-6)
local ScratchBuffer = buffer.create(4)

-- locked metatable (can't be augmented) and exposes only lowercase .x/.y/.z plus
-- the `vector` library functions. So there is no Roblox `.Magnitude` / `.Unit`
-- property -- use vector.magnitude(a - b), vector.normalize(v), vector.dot(a, b),
-- and vector.cross(a, b) instead. Tween interpolation relies only on arithmetic
-- operators, which native vectors support, so it is unaffected.

local Global = {
    Function = {},

    Properties = {
        Boolean = {
            Humanoid = {
                AutoJumpEnabled = Offsets.Humanoid.AutoJumpEnabled,
                AutoRotate = Offsets.Humanoid.AutoRotate,
                AutomaticScalingEnabled = Offsets.Humanoid.AutomaticScalingEnabled,
                BreakJointsOnDeath = Offsets.Humanoid.BreakJointsOnDeath,
                EvaluateStateMachine = Offsets.Humanoid.EvaluateStateMachine,
                Jump = Offsets.Humanoid.Jump,
                PlatformStand = Offsets.Humanoid.PlatformStand,
                RequiresNeck = Offsets.Humanoid.RequiresNeck,
                --
                Sit = Offsets.Humanoid.Sit,
                UseJumpPower = Offsets.Humanoid.UseJumpPower,
            },
            DataModel = {
                GameLoaded = { Offset = Offsets.DataModel.GameLoaded, ReadOnly = true },
            },
            ProximityPrompt = {
                Enabled = Offsets.ProximityPrompt.Enabled,
                RequiresLineOfSight = Offsets.ProximityPrompt.RequiresLineOfSight,
            },
            SpawnLocation = {
                Enabled = Offsets.SpawnLocation.Enabled,
                Neutral = Offsets.SpawnLocation.Neutral,
                AllowTeamChangeOnTouch = Offsets.SpawnLocation.AllowTeamChangeOnTouch,
            },
            AnimationTrack = {
                Looped = Offsets.AnimationTrack.Looped,
                IsPlaying = { Offset = Offsets.AnimationTrack.IsPlaying, ReadOnly = true },
            },
            BasePart = {
                CastShadow = Offsets.BasePart.CastShadow,
                Locked = Offsets.BasePart.Locked,
                Massless = Offsets.BasePart.Massless,
            },
            BloomEffect = { Enabled = Offsets.BloomEffect.Enabled },
            BlurEffect = { Enabled = Offsets.BlurEffect.Enabled },
            ColorCorrectionEffect = { Enabled = Offsets.ColorCorrectionEffect.Enabled },
            ColorGradingEffect = { Enabled = Offsets.ColorGradingEffect.Enabled },
            DepthOfFieldEffect = { Enabled = Offsets.DepthOfFieldEffect.Enabled },
            Lighting = { GlobalShadows = Offsets.Lighting.GlobalShadows },
            GuiObject = {
                Visible = Offsets.GuiObject.Visible,
                Active = Offsets.GuiObject.Active,
                ClipsDescendants = Offsets.GuiObject.ClipsDescendants,
                Selectable = Offsets.GuiObject.Selectable,
                Interactable = Offsets.GuiObject.Interactable,
            },
            GuiText = {
                RichText = Offsets.GuiObject.RichText,
            },
            TextLabel = {
                RichText = Offsets.TextLabel.RichText,
                TextScaled = Offsets.TextLabel.TextScaled,
                TextWrapped = Offsets.TextLabel.TextWrapped,
            },
            TextButton = {
                RichText = Offsets.TextButton.RichText,
                TextScaled = Offsets.TextButton.TextScaled,
                TextWrapped = Offsets.TextButton.TextWrapped,
                AutoButtonColor = Offsets.TextButton.AutoButtonColor,
                Modal = Offsets.TextButton.Modal,
                Selected = Offsets.TextButton.Selected,
            },
            ScreenGui = {
                Enabled = Offsets.GuiObject.ScreenGui_Enabled,
            },
        },

        Integer = {
            DataModel = {
                PlaceVersion = { Offset = Offsets.DataModel.PlaceVersion, ReadOnly = true },
                PrimitiveCount = { Offset = Offsets.DataModel.PrimitiveCount, ReadOnly = true },
            },
            Player = {
                AccountAge = { Offset = Offsets.Player.AccountAge, ReadOnly = true },
            },
            Sky = {
                StarCount = Offsets.Sky.StarCount,
            },
            GuiObject = {
                LayoutOrder = Offsets.GuiObject.LayoutOrder,
                ZIndex = Offsets.GuiObject.ZIndex,
                BorderSizePixel = Offsets.GuiObject.BorderSizePixel,
            },
            TextLabel = {
                MaxVisibleGraphemes = Offsets.TextLabel.MaxVisibleGraphemes,
                Font = Offsets.TextLabel.Font,
            },
            TextButton = {
                MaxVisibleGraphemes = Offsets.TextButton.MaxVisibleGraphemes,
                Font = Offsets.TextButton.Font,
            },
            SpawnLocation = {
                Duration = Offsets.SpawnLocation.ForcefieldDuration,
            },
        },

        Float = {
            Humanoid = {
                Health = Offsets.Humanoid.Health,
                HealthDisplayDistance = Offsets.Humanoid.HealthDisplayDistance,
                HipHeight = Offsets.Humanoid.HipHeight,
                JumpHeight = Offsets.Humanoid.JumpHeight,
                JumpPower = Offsets.Humanoid.JumpPower,
                MaxHealth = Offsets.Humanoid.MaxHealth,
                MaxSlopeAngle = Offsets.Humanoid.MaxSlopeAngle,
                NameDisplayDistance = Offsets.Humanoid.NameDisplayDistance,
                WalkSpeed = Offsets.Humanoid.Walkspeed,
            },
            ClickDetector = {
                MaxActivationDistance = Offsets.ClickDetector.MaxActivationDistance,
            },
            DragDetector = {
                MaxActivationDistance = Offsets.DragDetector.MaxActivationDistance,
                MaxDragAngle = Offsets.DragDetector.MaxDragAngle,
                MaxForce = Offsets.DragDetector.MaxForce,
                MaxTorque = Offsets.DragDetector.MaxTorque,
                MinDragAngle = Offsets.DragDetector.MinDragAngle,
                Responsiveness = Offsets.DragDetector.Responsiveness,
            },
            Terrain = {
                GrassLength = Offsets.Terrain.GrassLength,
                WaterReflectance = Offsets.Terrain.WaterReflectance,
                WaterTransparency = Offsets.Terrain.WaterTransparency,
                WaterWaveSize = Offsets.Terrain.WaterWaveSize,
                WaterWaveSpeed = Offsets.Terrain.WaterWaveSpeed,
            },
            ParticleEmitter = {
                Brightness = Offsets.ParticleEmitter.Brightness,
                Drag = Offsets.ParticleEmitter.Drag,
                LightEmission = Offsets.ParticleEmitter.LightEmission,
                LightInfluence = Offsets.ParticleEmitter.LightInfluence,
                Rate = Offsets.ParticleEmitter.Rate,
                TimeScale = Offsets.ParticleEmitter.TimeScale,
                VelocityInheritance = Offsets.ParticleEmitter.VelocityInheritance,
                ZOffset = Offsets.ParticleEmitter.ZOffset,
            },
            Player = {
                HealthDisplayDistance = Offsets.Player.HealthDisplayDistance,
                MaxZoomDistance = Offsets.Player.MaxZoomDistance,
                MinZoomDistance = Offsets.Player.MinZoomDistance,
                NameDisplayDistance = Offsets.Player.NameDisplayDistance,
            },
            ProximityPrompt = {
                HoldDuration = Offsets.ProximityPrompt.HoldDuration,
                MaxActivationDistance = Offsets.ProximityPrompt.MaxActivationDistance,
            },
            Sky = {
                MoonAngularSize = Offsets.Sky.MoonAngularSize,
                SunAngularSize = Offsets.Sky.SunAngularSize,
            },
            VehicleSeat = {
                MaxSpeed = Offsets.VehicleSeat.MaxSpeed,
                SteerFloat = Offsets.VehicleSeat.SteerFloat,
                ThrottleFloat = Offsets.VehicleSeat.ThrottleFloat,
                Torque = Offsets.VehicleSeat.Torque,
                TurnSpeed = Offsets.VehicleSeat.TurnSpeed,
            },
            RunService = {
                HeartbeatFPS = { Offset = Offsets.RunService.HeartbeatFPS, ReadOnly = true },
            },
            AnimationTrack = {
                Speed = { Offset = Offsets.AnimationTrack.Speed, ReadOnly = true },
                TimePosition = Offsets.AnimationTrack.TimePosition,
            },
            Atmosphere = {
                Density = Offsets.Atmosphere.Density,
                Glare = Offsets.Atmosphere.Glare,
                Haze = Offsets.Atmosphere.Haze,
                Offset = Offsets.Atmosphere.Offset,
            },
            Beam = {
                Brightness = Offsets.Beam.Brightness,
                CurveSize0 = Offsets.Beam.CurveSize0,
                CurveSize1 = Offsets.Beam.CurveSize1,
                LightEmission = Offsets.Beam.LightEmission,
                LightInfluence = Offsets.Beam.LightInfluence,
                TextureLength = Offsets.Beam.TextureLength,
                TextureSpeed = Offsets.Beam.TextureSpeed,
                Width0 = Offsets.Beam.Width0,
                Width1 = Offsets.Beam.Width1,
                ZOffset = Offsets.Beam.ZOffset,
            },
            BloomEffect = {
                Intensity = Offsets.BloomEffect.Intensity,
                Size = Offsets.BloomEffect.Size,
                Threshold = Offsets.BloomEffect.Threshold,
            },
            BlurEffect = {
                Size = Offsets.BlurEffect.Size,
            },
            ColorCorrectionEffect = {
                Brightness = Offsets.ColorCorrectionEffect.Brightness,
                Contrast = Offsets.ColorCorrectionEffect.Contrast,
            },
            DepthOfFieldEffect = {
                FarIntensity = Offsets.DepthOfFieldEffect.FarIntensity,
                FocusDistance = Offsets.DepthOfFieldEffect.FocusDistance,
                InFocusRadius = Offsets.DepthOfFieldEffect.InFocusRadius,
                NearIntensity = Offsets.DepthOfFieldEffect.NearIntensity,
            },
            GuiBase2d = {
                AbsoluteRotation = { Offset = Offsets.GuiBase2D.AbsoluteRotation, ReadOnly = true },
            },
            GuiObject = {
                Rotation = Offsets.GuiObject.Rotation,
                BackgroundTransparency = Offsets.GuiObject.BackgroundTransparency,
            },
            TextLabel = {
                TextSize = Offsets.TextLabel.TextSize,
                TextTransparency = Offsets.TextLabel.TextTransparency,
                TextStrokeTransparency = Offsets.TextLabel.TextStrokeTransparency,
                LineHeight = Offsets.TextLabel.LineHeight,
            },
            TextButton = {
                TextSize = Offsets.TextButton.TextSize,
                TextTransparency = Offsets.TextButton.TextTransparency,
                TextStrokeTransparency = Offsets.TextButton.TextStrokeTransparency,
                LineHeight = Offsets.TextButton.LineHeight,
            },
            Lighting = {
                Brightness = Offsets.Lighting.Brightness,
                ClockTime = { Offset = Offsets.Lighting.ClockTime, ReadOnly = true },
                EnvironmentDiffuseScale = Offsets.Lighting.EnvironmentDiffuseScale,
                EnvironmentSpecularScale = Offsets.Lighting.EnvironmentSpecularScale,
                ExposureCompensation = Offsets.Lighting.ExposureCompensation,
                FogEnd = Offsets.Lighting.FogEnd,
                FogStart = Offsets.Lighting.FogStart,
                GeographicLatitude = Offsets.Lighting.GeographicLatitude,
            },
            Camera = {
                ImagePlaneDepth = Offsets.Camera.ImagePlaneDepth,
            },
            Model = {
                Scale = Offsets.Model.Scale,
            },
            BasePart = {
                Reflectance = Offsets.BasePart.Reflectance,
                Transparency = Offsets.BasePart.Transparency,
            },
        },

        Long = {
            DataModel = {
                CreatorId = { Offset = Offsets.DataModel.CreatorId, ReadOnly = true },
                ToRenderView1 = { Offset = Offsets.DataModel.ToRenderView1, ReadOnly = true },
                ToRenderView2 = { Offset = Offsets.DataModel.ToRenderView2, ReadOnly = true },
                ToRenderView3 = { Offset = Offsets.DataModel.ToRenderView3, ReadOnly = true },
            },
            UnionOperation = {
                AssetId = { Offset = Offsets.UnionOperation.AssetId, ReadOnly = true },
            },
            CharacterMesh = {
                BaseTextureId = Offsets.CharacterMesh.BaseTextureId,
                MeshId = Offsets.CharacterMesh.MeshId,
                OverlayTextureId = Offsets.CharacterMesh.OverlayTextureId,
            },
            UserInputService = {
                WindowInputState = { Offset = Offsets.UserInputService.WindowInputState, ReadOnly = true },
            },
            Animator = {
                ActiveAnimations = { Offset = Offsets.Animator.ActiveAnimations, ReadOnly = true },
            },
        },

        Vector2 = {
            ParticleEmitter = {
                SpreadAngle = Offsets.ParticleEmitter.SpreadAngle,
            },
            GuiBase2d = {
                AbsolutePosition = { Offset = Offsets.GuiBase2D.AbsolutePosition, ReadOnly = true },
                AbsoluteSize = { Offset = Offsets.GuiBase2D.AbsoluteSize, ReadOnly = true },
            },
            GuiObject = {
                AnchorPoint = Offsets.GuiObject.AnchorPoint,
            },
            InputObject = {
                Position = { Offset = Offsets.InputObject.MousePosition, ReadOnly = true },
            },
        },

        UDim2 = {
            GuiObject = {
                Position = Offsets.GuiObject.Position,
                Size = Offsets.GuiObject.Size,
            },
        },

        Vector = {
            Humanoid = {
                CameraOffset = Offsets.Humanoid.CameraOffset,
                TargetPoint = Offsets.Humanoid.TargetPoint,
                MoveDirection = { Offset = Offsets.Humanoid.MoveDirection, ReadOnly = true },
            },
            DragDetector = {
                MaxDragTranslation = Offsets.DragDetector.MaxDragTranslation,
                MinDragTranslation = Offsets.DragDetector.MinDragTranslation,
            },
            ParticleEmitter = {
                Acceleration = Offsets.ParticleEmitter.Acceleration,
            },
            Sky = {
                SkyboxOrientation = Offsets.Sky.SkyboxOrientation,
            },
            Attachment = {
                Position = Offsets.Attachment.Position,
            },
            Tool = {
                GripForward = Offsets.Tool.GripForward,
                GripRight = Offsets.Tool.GripRight,
                GripUp = Offsets.Tool.GripUp,
            },
            SpecialMesh = {
                Offset = Offsets.SpecialMesh.Offset,
            },
        },

        Range = {
            ParticleEmitter = {
                Lifetime = Offsets.ParticleEmitter.Lifetime,
                RotSpeed = Offsets.ParticleEmitter.RotSpeed,
                Rotation = Offsets.ParticleEmitter.Rotation,
                Speed = Offsets.ParticleEmitter.Speed,
            },
        },

        Color = {
            Clothing = {
                Color3 = Offsets.Clothing.Color3,
            },
            Terrain = {
                WaterColor = Offsets.Terrain.WaterColor,
            },
            Atmosphere = {
                Color = Offsets.Atmosphere.Color,
                Decay = Offsets.Atmosphere.Decay,
            },
            ColorCorrectionEffect = {
                TintColor = Offsets.ColorCorrectionEffect.TintColor,
            },
            Lighting = {
                Ambient = Offsets.Lighting.Ambient,
                ColorShift_Bottom = Offsets.Lighting.ColorShift_Bottom,
                ColorShift_Top = Offsets.Lighting.ColorShift_Top,
                FogColor = Offsets.Lighting.FogColor,
                OutdoorAmbient = Offsets.Lighting.OutdoorAmbient,
            },
            GuiObject = {
                BackgroundColor3 = Offsets.GuiObject.BackgroundColor3,
            },
            GuiText = {
                TextColor3 = Offsets.GuiObject.TextColor3,
            },
            TextLabel = {
                TextColor3 = Offsets.TextLabel.TextColor3,
                TextStrokeColor3 = Offsets.TextLabel.TextStrokeColor3,
            },
            TextButton = {
                TextColor3 = Offsets.TextButton.TextColor3,
                TextStrokeColor3 = Offsets.TextButton.TextStrokeColor3,
            },
            BasePart = {
                Color3 = Offsets.BasePart.Color3,
            },
        },

        BrickColor = {
            Player = {
                TeamColor = Offsets.Player.TeamColor,
            },
            SpawnLocation = {
                TeamColor = Offsets.SpawnLocation.TeamColor,
            },
            Team = {
                BrickColor = Offsets.Team.BrickColor,
            },
        },

        String = {
            Humanoid = {
                DisplayName = Offsets.Humanoid.DisplayName,
            },
            ClickDetector = {
                MouseIcon = Offsets.ClickDetector.MouseIcon,
            },
            Shirt = {
                ShirtTemplate = Offsets.Clothing.Template,
            },
            Pants = {
                PantsTemplate = Offsets.Clothing.Template,
            },
            DataModel = {
                JobId = { Offset = Offsets.DataModel.JobId, ReadOnly = true },
                ServerIP = { Offset = Offsets.DataModel.ServerIP, ReadOnly = true },
            },
            DragDetector = {
                ActivatedCursorIcon = Offsets.DragDetector.ActivatedCursorIcon,
                CursorIcon = Offsets.DragDetector.CursorIcon,
            },
            ParticleEmitter = {
                Texture = Offsets.ParticleEmitter.Texture,
            },
            Player = {
                LocaleId = { Offset = Offsets.Player.LocaleId, ReadOnly = true },
            },
            ProximityPrompt = {
                ActionText = Offsets.ProximityPrompt.ActionText,
                ObjectText = Offsets.ProximityPrompt.ObjectText,
            },
            Sky = {
                MoonTextureId = Offsets.Sky.MoonTextureId,
                SkyboxBk = Offsets.Sky.SkyboxBk,
                SkyboxDn = Offsets.Sky.SkyboxDn,
                SkyboxFt = Offsets.Sky.SkyboxFt,
                SkyboxLf = Offsets.Sky.SkyboxLf,
                SkyboxRt = Offsets.Sky.SkyboxRt,
                SkyboxUp = Offsets.Sky.SkyboxUp,
                SunTextureId = Offsets.Sky.SunTextureId,
            },
            Beam = {
                Texture = Offsets.Beam.Texture,
            },
            GuiText = {
                Text = Offsets.GuiObject.Text,
            },
            TextLabel = {
                Text = Offsets.TextLabel.Text,
            },
            TextButton = {
                Text = Offsets.TextButton.Text,
            },
            GuiImage = {
                Image = Offsets.GuiObject.Image,
            },
        },

        Reference = {
            DragDetector = {
                ReferenceInstance = Offsets.DragDetector.ReferenceInstance,
            },
            Player = {
                ModelInstance = Offsets.Player.ModelInstance,
                Mouse = { Offset = Offsets.Player.Mouse, ReadOnly = true },
            },
            Seat = {
                Occupant = { Offset = Offsets.Seat.Occupant, ReadOnly = true },
            },
            VehicleSeat = {
                Occupant = { Offset = Offsets.VehicleSeat.Occupant, ReadOnly = true },
            },
            MouseService = {
                InputObject = { Offset = Offsets.MouseService.InputObject, ReadOnly = true },
            },
            Weld = {
                Part0 = Offsets.Weld.Part0,
                Part1 = Offsets.Weld.Part1,
            },
            WeldConstraint = {
                Part0 = Offsets.WeldConstraint.Part0,
                Part1 = Offsets.WeldConstraint.Part1,
            },
            AnimationTrack = {
                Animation = { Offset = Offsets.AnimationTrack.Animation, ReadOnly = true },
                Animator = { Offset = Offsets.AnimationTrack.Animator, ReadOnly = true },
            },
            Beam = {
                Attachment0 = Offsets.Beam.Attachment0,
                Attachment1 = Offsets.Beam.Attachment1,
            },
        },

        Enum = {
            Humanoid = {
                DisplayDistanceType = { Offset = Offsets.Humanoid.DisplayDistanceType, EnumType = Enum.HumanoidDisplayDistanceType },
                HealthDisplayType = { Offset = Offsets.Humanoid.HealthDisplayType, EnumType = Enum.HumanoidHealthDisplayType },
                NameOcclusion = { Offset = Offsets.Humanoid.NameOcclusion, EnumType = Enum.NameOcclusion },
                RigType = { Offset = Offsets.Humanoid.RigType, EnumType = Enum.HumanoidRigType },
                FloorMaterial = { Offset = Offsets.Humanoid.FloorMaterial, EnumType = Enum.Material, ReadOnly = true },
            },
            Player = {
                CameraMode = { Offset = Offsets.Player.CameraMode, EnumType = Enum.CameraMode },
            },
            ProximityPrompt = {
                GamepadKeyCode = { Offset = Offsets.ProximityPrompt.GamepadKeyCode, EnumType = Enum.KeyCode },
                KeyCode = { Offset = Offsets.ProximityPrompt.KeyCode, EnumType = Enum.KeyCode },
                KeyboardKeyCode = { Offset = Offsets.ProximityPrompt.KeyboardKeyCode, EnumType = Enum.KeyCode },
            },
            TextLabel = {
                TextXAlignment = { Offset = Offsets.TextLabel.TextXAlignment, EnumType = Enum.TextXAlignment },
                TextYAlignment = { Offset = Offsets.TextLabel.TextYAlignment, EnumType = Enum.TextYAlignment },
            },
            TextButton = {
                TextXAlignment = { Offset = Offsets.TextButton.TextXAlignment, EnumType = Enum.TextXAlignment },
                TextYAlignment = { Offset = Offsets.TextButton.TextYAlignment, EnumType = Enum.TextYAlignment },
            },
            CharacterMesh = {
                BodyPart = { Offset = Offsets.CharacterMesh.BodyPart, EnumType = Enum.BodyPart },
            },
            ColorGradingEffect = {
                TonemapperPreset = { Offset = Offsets.ColorGradingEffect.TonemapperPreset, EnumType = Enum.TonemapperPreset },
            },
        },
    },

    Primitive = {
        Enum = {
            Material = Offsets.Primitive.Material,
        },
        Vector = {
            AssemblyLinearVelocity = Offsets.Primitive.AssemblyLinearVelocity,
            AssemblyAngularVelocity = Offsets.Primitive.AssemblyAngularVelocity,
        },
        Reference = {
            Owner = Offsets.Primitive.Owner,
        },
        Flags = {
            Anchored = Offsets.PrimitiveFlags.Anchored,
            CanCollide = Offsets.PrimitiveFlags.CanCollide,
            CanQuery = Offsets.PrimitiveFlags.CanQuery,
            CanTouch = Offsets.PrimitiveFlags.CanTouch,
        },
    },

    Terrain = {
        MaterialOrder = {
            Enum.Material.Grass, Enum.Material.Slate, Enum.Material.Concrete, Enum.Material.Brick,
            Enum.Material.Sand, Enum.Material.WoodPlanks, Enum.Material.Rock, Enum.Material.Glacier,
            Enum.Material.Snow, Enum.Material.Sandstone, Enum.Material.Mud, Enum.Material.Basalt,
            Enum.Material.Ground, Enum.Material.CrackedLava, Enum.Material.Asphalt, Enum.Material.Cobblestone,
            Enum.Material.Ice, Enum.Material.LeafyGrass, Enum.Material.Salt, Enum.Material.Limestone,
            Enum.Material.Pavement,
        },
    },

    WindowInputState = {
        Boolean = {
            CapsLock = Offsets.WindowInputState.CapsLock,
        },
        Reference = {
            CurrentTextBox = Offsets.WindowInputState.CurrentTextBox,
        },
    },

    Render = {
        RenderJob = {
            FakeDataModel = Offsets.RenderJob.FakeDataModel,
            RealDataModel = Offsets.RenderJob.RealDataModel,
            RenderView = Offsets.RenderJob.RenderView,
        },
        RenderView = {
            DeviceD3D11 = Offsets.RenderView.DeviceD3D11,
            LightingValid = Offsets.RenderView.LightingValid,
            SkyValid = Offsets.RenderView.SkyValid,
            VisualEngine = Offsets.RenderView.VisualEngine,
        },
        VisualEngine = {
            Dimensions = Offsets.VisualEngine.Dimensions,
            FakeDataModel = Offsets.VisualEngine.FakeDataModel,
            Pointer = Offsets.VisualEngine.Pointer,
            RenderView = Offsets.VisualEngine.RenderView,
            ViewMatrix = Offsets.VisualEngine.ViewMatrix,
        },
    },
}

-- // Helpers \\ --

-- The memory library has no native f32 accessor, so 32-bit floats are read and
-- written through their raw u32 representation, reinterpreted via a scratch
-- buffer (standard Luau `buffer` library).
function Global.Function:ReadFloat(Data, Offset)
    buffer.writeu32(ScratchBuffer, 0, memory.readu32(Data, Offset))
    return buffer.readf32(ScratchBuffer, 0)
end

function Global.Function:WriteFloat(Data, Offset, Value)
    buffer.writef32(ScratchBuffer, 0, Value)
    memory.writeu32(Data, Offset, buffer.readu32(ScratchBuffer, 0))
end

-- Float access at an absolute address (used past dereferenced pointers).
function Global.Function:ReadFloatAbsolute(Address)
    buffer.writeu32(ScratchBuffer, 0, memory.readu32(Address))
    return buffer.readf32(ScratchBuffer, 0)
end

function Global.Function:WriteFloatAbsolute(Address, Value)
    buffer.writef32(ScratchBuffer, 0, Value)
    memory.writeu32(Address, buffer.readu32(ScratchBuffer, 0))
end

-- 64-bit ids / pointers as a Lua number. Values up to 2^53 (all Roblox ids and
-- user-space pointers) are represented exactly; combine two 32-bit halves since
-- the double can't be read in one word.
function Global.Function:ReadU64Number(Data, Offset)
    local Low = memory.readu32(Data, Offset)
    local High = memory.readu32(Data, Offset + 4)
    return High * 4294967296 + Low
end

function Global.Function:WriteU64Number(Data, Offset, Value)
    memory.writeu32(Data, Offset, Value % 4294967296)
    memory.writeu32(Data, Offset + 4, math.floor(Value / 4294967296))
end

-- Same as ReadU64Number/WriteU64Number but for an absolute address (no offset),
-- used when following a dereferenced pointer such as a BasePart's Primitive.
function Global.Function:ReadPointer(Address)
    return memory.readu32(Address) + memory.readu32(Address + 4) * 4294967296
end

function Global.Function:WritePointer(Address, Value)
    memory.writeu32(Address, Value % 4294967296)
    memory.writeu32(Address + 4, math.floor(Value / 4294967296))
end

-- Normalises any 3-component value into a native `vector` for memory.writevector.
-- Accepts a native vector as-is (vector.create / vector.zero), and duck-types
-- everything else so Vector3 (.X/.Y/.Z), Color3 (.R/.G/.B) and plain {x,y,z}
-- tables all work. Missing components default to 0.
function Global.Function:ToComponents(Value)
    if typeof(Value) == "vector" then
        return Value
    end

    local X = Value.X or Value.x or Value.R or Value.r or 0
    local Y = Value.Y or Value.y or Value.G or Value.g or 0
    local Z = Value.Z or Value.z or Value.B or Value.b or 0
    return vector.create(X, Y, Z)
end

-- Normalises any 2-component value into (x, y). Accepts Vector2, native vector,
-- or a plain {x, y} table.
function Global.Function:ToVector2(Value)
    return (Value.X or Value.x or 0), (Value.Y or Value.y or 0)
end

-- Normalises a range into (min, max). Accepts a NumberRange, a single number
-- (min == max), or a {Min, Max} / {min, max} / {[1], [2]} table.
function Global.Function:ToRange(Value)
    if typeof(Value) == "NumberRange" then
        return Value.Min, Value.Max
    end
    if type(Value) == "number" then
        return Value, Value
    end

    local Min = Value.Min or Value.min or Value[1] or 0
    local Max = Value.Max or Value.max or Value[2] or Min
    return Min, Max
end

-- Normalises a UDim2-like value into (xScale, xOffset, yScale, yOffset). Accepts
-- a UDim2, or a {XScale, XOffset, YScale, YOffset} / positional {[1]..[4]} table.
function Global.Function:ToUDim2(Value)
    if typeof(Value) == "UDim2" then
        return Value.X.Scale, Value.X.Offset, Value.Y.Scale, Value.Y.Offset
    end

    return (Value.XScale or Value[1] or 0), (Value.XOffset or Value[2] or 0),
        (Value.YScale or Value[3] or 0), (Value.YOffset or Value[4] or 0)
end

-- Normalises a BrickColor-like value into its palette number. Accepts a
-- BrickColor, a number, or a Color3 (mapped to the nearest BrickColor).
function Global.Function:ToBrickColorNumber(Value)
    if typeof(Value) == "BrickColor" then
        return Value.Number
    end
    if type(Value) == "number" then
        return Value
    end
    if typeof(Value) == "Color3" then
        return BrickColor.new(Value).Number
    end
    return 0
end

-- Reads/writes an Instance reference at an absolute address (dereferenced
-- pointer -> Instance, and back).
function Global.Function:ReadReference(Address)
    local Pointer = Global.Function:ReadPointer(Address)
    return Pointer ~= 0 and pointer_to_userdata(Pointer) or nil
end

function Global.Function:WriteReference(Address, Value)
    Global.Function:WritePointer(Address, Value and Value.Data or 0)
end

-- Enum properties are stored as a 4-byte integer. Map that value back to a
-- proper EnumItem (falling back to the raw number if it's out of range), and
-- accept either an EnumItem or a number when writing.
function Global.Function:FromEnumValue(EnumType, Value)
    local Ok, Item = pcall(function()
        return EnumType:FromValue(Value)
    end)

    if Ok and Item then
        return Item
    end

    return Value
end

function Global.Function:ToEnumValue(Value)
    if typeof(Value) == "EnumItem" then
        return Value.Value
    end

    return Value
end

-- Resolve a field entry into its offset and read-only flag.
function Global.Function:Resolve(Info)
    if type(Info) == "table" then
        return Info.Offset, Info.ReadOnly == true
    end

    return Info, false
end

local Subclasses = {
    BasePart = { "Part", "MeshPart", "UnionOperation", "TrussPart" },
    GuiObject = { "Frame", "TextLabel", "TextButton", "TextBox", "ImageLabel", "ImageButton", "ScrollingFrame" },
    GuiBase2d = { "Frame", "TextLabel", "TextButton", "TextBox", "ImageLabel", "ImageButton", "ScrollingFrame" },
    -- GuiText (GuiObject-offset text members) now covers TextBox only; TextLabel
    -- and TextButton are declared per-class from jonah's offsets.
    GuiText = { "TextBox" },
    GuiImage = { "ImageLabel", "ImageButton" },
    Clothing = { "Shirt", "Pants" },
}

-- // Declaration Drivers \\ --

-- Declares `Callback` for `Name` on `Class`. Abstract bases (and the GuiText /
-- GuiImage pseudo-bases) expand to their concrete class list, declaring once per
-- class; concrete classes pass through unchanged. `class` must be a single string
-- per call -- the env silently ignores an array, so we loop.
function Global.Function:Declare(Class, Name, Callback)
    -- pcall each declare so one class/member the env rejects (e.g. a name that
    -- isn't a real Roblox member of that class) can't abort the whole batch.
    local Classes = Subclasses[Class]
    if not Classes then
        pcall(Instance.declare, { class = Class, name = Name, callback = Callback })
        return
    end
    for _, RealClass in Classes do
        pcall(Instance.declare, { class = RealClass, name = Name, callback = Callback })
    end
end

-- Declares every field in `ClassMap` (Class -> { Name = Info }) as a property,
-- reading / writing through the supplied Reader / Writer.
function Global.Function:DeclareScalar(ClassMap, Reader, Writer)
    for Class, Fields in ClassMap do
        for Name, Info in Fields do
            local Offset, ReadOnly = self:Resolve(Info)
            if Offset == nil then continue end   -- offset missing from the dump

            local Callback = {
                get = function(self)
                    return Reader(self.Data, Offset)
                end,
            }

            if not ReadOnly then
                Callback.set = function(self, Value)
                    Writer(self.Data, Offset, Value)
                end
            end

            Global.Function:Declare(Class, Name, Callback)
        end
    end
end

-- Declares every field in `ClassMap` as an Enum property.
function Global.Function:DeclareEnum(ClassMap)
    for Class, Fields in ClassMap do
        for Name, Info in Fields do
            local Offset = Info.Offset
            local EnumType = Info.EnumType
            if Offset == nil then continue end   -- offset missing from the dump

            local Callback = {
                get = function(self)
                    return Global.Function:FromEnumValue(EnumType, memory.readi32(self.Data, Offset))
                end,
            }

            if not Info.ReadOnly then
                Callback.set = function(self, Value)
                    memory.writei32(self.Data, Offset, Global.Function:ToEnumValue(Value))
                end
            end

            Global.Function:Declare(Class, Name, Callback)
        end
    end
end

-- Resolves the physics Primitive object behind a BasePart (0 if none).
function Global.Function:GetPrimitive(Object)
    return Global.Function:ReadU64Number(Object.Data, Offsets.BasePart.Primitive)
end

-- Declares properties that live on another object reached through a pointer
-- field on the instance (e.g. BasePart -> Primitive, UserInputService ->
-- WindowInputState). The pointer is dereferenced per access, then read/written
-- at the absolute address (Base + Offset). Reader/Writer take absolute addresses.
function Global.Function:DeclareIndirect(Class, PointerOffset, Fields, Reader, Writer)
    if PointerOffset == nil then return end   -- pointer namespace missing from the dump
    for Name, Info in Fields do
        local Offset, ReadOnly = self:Resolve(Info)
        if Offset == nil then continue end

        local Callback = {
            get = function(self)
                local Base = Global.Function:ReadU64Number(self.Data, PointerOffset)
                if Base == 0 then
                    return nil
                end
                return Reader(Base + Offset)
            end,
        }

        if not ReadOnly then
            Callback.set = function(self, Value)
                local Base = Global.Function:ReadU64Number(self.Data, PointerOffset)
                if Base ~= 0 then
                    Writer(Base + Offset, Value)
                end
            end
        end

        Global.Function:Declare(Class, Name, Callback)
    end
end

-- Follows a chain of pointer hops from an instance and returns the final base
-- address (0 if any hop is null). The first hop reads from the instance; the
-- rest read from absolute addresses.
function Global.Function:ResolveChain(Object, Hops)
    if Hops[1] == nil then return 0 end   -- first hop offset missing from the dump
    local Base = Global.Function:ReadU64Number(Object.Data, Hops[1])
    for Index = 2, #Hops do
        if Base == 0 then
            return 0
        end
        Base = Global.Function:ReadPointer(Base + Hops[Index])
    end
    return Base
end

-- Like DeclareIndirect, but resolves through multiple pointer hops.
function Global.Function:DeclareChain(Class, Hops, Fields, Reader, Writer)
    for Name, Info in Fields do
        local Offset, ReadOnly = self:Resolve(Info)
        if Offset == nil then continue end

        local Callback = {
            get = function(self)
                local Base = Global.Function:ResolveChain(self, Hops)
                if Base == 0 then
                    return nil
                end
                return Reader(Base + Offset)
            end,
        }

        if not ReadOnly then
            Callback.set = function(self, Value)
                local Base = Global.Function:ResolveChain(self, Hops)
                if Base ~= 0 then
                    Writer(Base + Offset, Value)
                end
            end
        end

        Global.Function:Declare(Class, Name, Callback)
    end
end

-- Declares BasePart booleans packed as bitmasks in the Primitive's Flags byte.
function Global.Function:DeclarePrimitiveFlags(Fields)
    for Name, Mask in Fields do
        Global.Function:Declare("BasePart", Name, {
            get = function(self)
                local Primitive = Global.Function:GetPrimitive(self)
                if Primitive == 0 then
                    return nil
                end
                return bit32.band(memory.readu8(Primitive + Offsets.Primitive.Flags), Mask) ~= 0
            end,
            set = function(self, Value)
                local Primitive = Global.Function:GetPrimitive(self)
                if Primitive == 0 then
                    return
                end
                local Address = Primitive + Offsets.Primitive.Flags
                local Bits = memory.readu8(Address)
                if Value then
                    Bits = bit32.bor(Bits, Mask)
                else
                    Bits = bit32.band(Bits, bit32.bnot(Mask))
                end
                memory.writeu8(Address, Bits)
            end,
        })
    end
end

-- // Property Registration \\ --

Global.Function:DeclareScalar(Global.Properties.Boolean,
    function(Data, Offset) return memory.readbool(Data, Offset) end,
    function(Data, Offset, Value) memory.writebool(Data, Offset, Value) end)

Global.Function:DeclareScalar(Global.Properties.Integer,
    function(Data, Offset) return memory.readi32(Data, Offset) end,
    function(Data, Offset, Value) memory.writei32(Data, Offset, Value) end)

Global.Function:DeclareScalar(Global.Properties.Float,
    function(Data, Offset) return Global.Function:ReadFloat(Data, Offset) end,
    function(Data, Offset, Value) Global.Function:WriteFloat(Data, Offset, Value) end)

Global.Function:DeclareScalar(Global.Properties.Long,
    function(Data, Offset) return Global.Function:ReadU64Number(Data, Offset) end,
    function(Data, Offset, Value) Global.Function:WriteU64Number(Data, Offset, Value) end)

Global.Function:DeclareScalar(Global.Properties.Vector,
    function(Data, Offset)
        local Components = memory.readvector(Data, Offset)
        return Vector3.new(Components.x, Components.y, Components.z)
    end,
    function(Data, Offset, Value)
        memory.writevector(Data, Offset, Global.Function:ToComponents(Value))
    end)

Global.Function:DeclareScalar(Global.Properties.Vector2,
    function(Data, Offset)
        return Vector2.new(Global.Function:ReadFloat(Data, Offset), Global.Function:ReadFloat(Data, Offset + 4))
    end,
    function(Data, Offset, Value)
        local X, Y = Global.Function:ToVector2(Value)
        Global.Function:WriteFloat(Data, Offset, X)
        Global.Function:WriteFloat(Data, Offset + 4, Y)
    end)

Global.Function:DeclareScalar(Global.Properties.Range,
    function(Data, Offset)
        return NumberRange.new(Global.Function:ReadFloat(Data, Offset), Global.Function:ReadFloat(Data, Offset + 4))
    end,
    function(Data, Offset, Value)
        local Min, Max = Global.Function:ToRange(Value)
        Global.Function:WriteFloat(Data, Offset, Min)
        Global.Function:WriteFloat(Data, Offset + 4, Max)
    end)

Global.Function:DeclareScalar(Global.Properties.UDim2,
    function(Data, Offset)
        return UDim2.new(
            Global.Function:ReadFloat(Data, Offset),
            memory.readi32(Data, Offset + 4),
            Global.Function:ReadFloat(Data, Offset + 8),
            memory.readi32(Data, Offset + 12)
        )
    end,
    function(Data, Offset, Value)
        local XScale, XOffset, YScale, YOffset = Global.Function:ToUDim2(Value)
        Global.Function:WriteFloat(Data, Offset, XScale)
        memory.writei32(Data, Offset + 4, XOffset)
        Global.Function:WriteFloat(Data, Offset + 8, YScale)
        memory.writei32(Data, Offset + 12, YOffset)
    end)

Global.Function:DeclareScalar(Global.Properties.Color,
    function(Data, Offset)
        local Components = memory.readvector(Data, Offset)
        return Color3.new(Components.x, Components.y, Components.z)
    end,
    function(Data, Offset, Value)
        memory.writevector(Data, Offset, Global.Function:ToComponents(Value))
    end)

Global.Function:DeclareScalar(Global.Properties.BrickColor,
    function(Data, Offset) return BrickColor.new(memory.readi32(Data, Offset)) end,
    function(Data, Offset, Value) memory.writei32(Data, Offset, Global.Function:ToBrickColorNumber(Value)) end)

Global.Function:DeclareScalar(Global.Properties.String,
    function(Data, Offset) return memory.readstring(Data, Offset) end,
    function(Data, Offset, Value) memory.writestring(Data, Offset, Value) end)

Global.Function:DeclareScalar(Global.Properties.Reference,
    function(Data, Offset)
        local Pointer = Global.Function:ReadU64Number(Data, Offset)
        return Pointer ~= 0 and pointer_to_userdata(Pointer) or nil
    end,
    function(Data, Offset, Value)
        Global.Function:WriteU64Number(Data, Offset, Value and Value.Data or 0)
    end)

Global.Function:DeclareEnum(Global.Properties.Enum)

-- Shared absolute-address reader/writer closures for indirect (pointer-chained)
-- properties.
local ReadVector3Absolute = function(Address)
    local Components = memory.readvector(Address)
    return Vector3.new(Components.x, Components.y, Components.z)
end
local WriteVector3Absolute = function(Address, Value)
    memory.writevector(Address, Global.Function:ToComponents(Value))
end
local ReadReferenceAbsolute = function(Address) return Global.Function:ReadReference(Address) end
local WriteReferenceAbsolute = function(Address, Value) Global.Function:WriteReference(Address, Value) end

-- Primitive-backed BasePart properties (addressed absolutely past the pointer).
Global.Function:DeclareIndirect("BasePart", Offsets.BasePart.Primitive, Global.Primitive.Vector,
    ReadVector3Absolute, WriteVector3Absolute)

Global.Function:DeclareIndirect("BasePart", Offsets.BasePart.Primitive, Global.Primitive.Enum,
    function(Address) return Global.Function:FromEnumValue(Enum.Material, memory.readi32(Address)) end,
    function(Address, Value) memory.writei32(Address, Global.Function:ToEnumValue(Value)) end)

Global.Function:DeclareIndirect("BasePart", Offsets.BasePart.Primitive, Global.Primitive.Reference,
    ReadReferenceAbsolute, WriteReferenceAbsolute)

Global.Function:DeclarePrimitiveFlags(Global.Primitive.Flags)

-- NOTE: BasePart.CFrame and BasePart.Position are NOT declared here. Severe
-- exposes them natively (read + write), and only the native setters actually move
-- a physics-simulated part / the local character -- a raw write to Primitive
-- +Position just gets overwritten by the sim (this is why part tweens didn't
-- move). Declaring them here would shadow the working native setters, so we
-- deliberately leave CFrame/Position/Size/Transparency to Severe.

-- UserInputService properties on its WindowInputState struct.
Global.Function:DeclareIndirect("UserInputService", Offsets.UserInputService.WindowInputState, Global.WindowInputState.Boolean,
    function(Address) return memory.readu8(Address) ~= 0 end,
    function(Address, Value) memory.writeu8(Address, Value and 1 or 0) end)

Global.Function:DeclareIndirect("UserInputService", Offsets.UserInputService.WindowInputState, Global.WindowInputState.Reference,
    ReadReferenceAbsolute, WriteReferenceAbsolute)

-- Workspace.GlobalWind / Workspace.AirDensity live on the physics World's
-- AirProperties struct: Workspace -> World -> AirProperties -> field.
local AirPropertiesChain = { Offsets.Workspace.World, Offsets.World.AirProperties }

Global.Function:DeclareChain("Workspace", AirPropertiesChain,
    { GlobalWind = Offsets.AirProperties.GlobalWind }, ReadVector3Absolute, WriteVector3Absolute)

Global.Function:DeclareChain("Workspace", AirPropertiesChain,
    { AirDensity = Offsets.AirProperties.AirDensity },
    function(Address) return Global.Function:ReadFloatAbsolute(Address) end,
    function(Address, Value) Global.Function:WriteFloatAbsolute(Address, Value) end)

-- Workspace.Gravity -- the WRITABLE gravity lives on the physics World, not the
Global.Function:DeclareChain("Workspace", { Offsets.Workspace.World },
    { Gravity = Offsets.World.Gravity },
    function(Address) return Global.Function:ReadFloatAbsolute(Address) end,
    function(Address, Value) Global.Function:WriteFloatAbsolute(Address, Value) end)

-- Team.TeamColor -- a Color3 view of the BrickColor palette number (Team.BrickColor
-- returns the BrickColor itself). Both read/write the same offset.
Global.Function:Declare("Team", "TeamColor", {
    get = function(self)
        return BrickColor.new(memory.readi32(self.Data, Offsets.Team.BrickColor)).Color
    end,
    set = function(self, Value)
        memory.writei32(self.Data, Offsets.Team.BrickColor, Global.Function:ToBrickColorNumber(Value))
    end,
})

-- Camera.FieldOfView -- the property is in DEGREES but the engine stores it in
-- RADIANS, so convert on the way in/out.
Global.Function:Declare("Camera", "FieldOfView", {
    get = function(self)
        return math.deg(Global.Function:ReadFloat(self.Data, Offsets.Camera.FieldOfView))
    end,
    set = function(self, Value)
        Global.Function:WriteFloat(self.Data, Offsets.Camera.FieldOfView, math.rad(Value))
    end,
})

-- // Methods \\ --
-- A `callback` carrying a `method` field declares a method. Only behaviour that
-- is expressible through memory is provided here.

-- Humanoid:TakeDamage(amount) -- lowers Health, clamped to a floor of 0.
-- Restricted to the LOCAL character's humanoid: the client only has authority over
-- its own character, so writing another humanoid's health does nothing useful (the
-- server owns it) and risks desync. Called on any other humanoid, it no-ops.
Instance.declare({ class = "Humanoid", name = "TakeDamage", callback = {
    method = function(self, Amount)
        local Player = game:GetService("Players").LocalPlayer
        local Character = Player and Player.Character
        local LocalHumanoid = Character and Character:FindFirstChild("Humanoid")
        if not LocalHumanoid or LocalHumanoid.Data ~= self.Data then
            return
        end

        local Current = Global.Function:ReadFloat(self.Data, Offsets.Humanoid.Health)
        Global.Function:WriteFloat(self.Data, Offsets.Humanoid.Health, math.max(0, Current - Amount))
    end,
}})

-- game:GetTickRate() -- reads worldStepsPerSec back (nil if the chain is null).
Instance.declare({ class = "DataModel", name = "GetTickRate", callback = {
    method = function(self)
        local World = Global.Function:ResolveChain(self, { Offsets.DataModel.Workspace, Offsets.Workspace.World })
        if World == 0 then
            return nil
        end
        return Global.Function:ReadFloatAbsolute(World + Offsets.World.worldStepsPerSec)
    end,
}})

-- Terrain:GetMaterialColor(material) / Terrain:SetMaterialColor(material, color)
-- Reads/writes the packed 3-byte (u8 R,G,B) entry for a material; returns and
-- expects a Color3. See Global.Terrain.MaterialOrder for the assumed layout.
Instance.declare({ class = "Terrain", name = "GetMaterialColor", callback = {
    method = function(self, Material)
        local Index = table.find(Global.Terrain.MaterialOrder, Material)
        if not Index then
            return nil
        end

        local Offset = Offsets.Terrain.MaterialColors + (Index - 1) * 3
        return Color3.fromRGB(
            memory.readu8(self.Data, Offset),
            memory.readu8(self.Data, Offset + 1),
            memory.readu8(self.Data, Offset + 2)
        )
    end,
}})

Instance.declare({ class = "Terrain", name = "SetMaterialColor", callback = {
    method = function(self, Material, Color)
        local Index = table.find(Global.Terrain.MaterialOrder, Material)
        if not Index then
            return
        end

        local Offset = Offsets.Terrain.MaterialColors + (Index - 1) * 3
        local Components = Global.Function:ToComponents(Color)
        memory.writeu8(self.Data, Offset, math.floor(Components.x * 255 + 0.5))
        memory.writeu8(self.Data, Offset + 1, math.floor(Components.y * 255 + 0.5))
        memory.writeu8(self.Data, Offset + 2, math.floor(Components.z * 255 + 0.5))
    end,
}})

-- Humanoid:MoveTo(position) -- walks the character toward a world point.
-- Returns a `signal` that fires once the destination is reached, mirroring
-- Roblox's Humanoid.MoveToFinished. A declared (Lua) method runs inside the
-- __namecall C boundary, so it cannot yield itself; to block, wait on the
-- returned signal from your own thread: `Humanoid:MoveTo(pos):wait()`.
Instance.declare({ class = "Humanoid", name = "MoveTo", callback = {
    method = function(self, Position)
        local Completed = signal()
        local HumanoidRootPart = self.Parent:FindFirstChild("HumanoidRootPart")

        if not HumanoidRootPart then
            task.spawn(function() Completed:fire() end)
            return Completed
        end

        task.spawn(function()
            while true do
                local Current = HumanoidRootPart.Position
                if math.abs(Current.X - Position.X) <= 1 and math.abs(Current.Z - Position.Z) <= 1 then
                    break
                end
                memory.writevector(self, Offsets.Humanoid.MoveToPoint, Position)
                memory.writeu8(self, Offsets.Humanoid.IsWalking, 1)
                task.wait()
            end
            Completed:fire()
            -- Also fire the persistent Humanoid.MoveToFinished event (reached).
            Global.Event.Fire(self, "MoveToFinished", true)
        end)

        return Completed
    end,
}})

-- // Instance Methods \\ --

-- Instance:GetFullName() -- dotted path from the topmost ancestor (excluding the
-- DataModel) down to this instance, e.g. "Model.Part.Fire".
Instance.declare({ class = "Instance", name = "GetFullName", callback = {
    method = function(self)
        local Segments = {}
        local Current = self

        while Current and Current ~= game do
            table.insert(Segments, 1, Current.Name)
            Current = Current.Parent
        end

        return table.concat(Segments, ".")
    end,
}})

-- // UserInputService Key Methods \\ --
-- getpressedkeys() returns key-name strings; this maps them to Roblox KeyCode
-- values (SDL-based, matching Enum.KeyCode.X.Value) so they can be compared.
local KeyNameToKeyCode = {
    A = 97, B = 98, C = 99, D = 100, E = 101, F = 102, G = 103, H = 104,
    I = 105, J = 106, K = 107, L = 108, M = 109, N = 110, O = 111, P = 112,
    Q = 113, R = 114, S = 115, T = 116, U = 117, V = 118, W = 119, X = 120,
    Y = 121, Z = 122,
    ["0"] = 48, ["1"] = 49, ["2"] = 50, ["3"] = 51, ["4"] = 52,
    ["5"] = 53, ["6"] = 54, ["7"] = 55, ["8"] = 56, ["9"] = 57,
    F1 = 282, F2 = 283, F3 = 284, F4 = 285, F5 = 286, F6 = 287,
    F7 = 288, F8 = 289, F9 = 290, F10 = 291, F11 = 292, F12 = 293,
    Space = 32, Backspace = 8, Tab = 9, Return = 13, Enter = 13, Escape = 27, Delete = 127,
    LeftShift = 304, RightShift = 303, LeftControl = 306, RightControl = 305,
    LeftAlt = 308, RightAlt = 307, CapsLock = 301,
    Up = 273, Down = 274, Left = 276, Right = 275,
    Insert = 277, Home = 278, End = 279, PageUp = 280, PageDown = 281,
    LeftBracket = 91, RightBracket = 93, BackSlash = 92, Slash = 47, Period = 46,
    Comma = 44, Quote = 39, Semicolon = 59, Minus = 45, Equals = 61, Backquote = 96,
    LeftMouse = 0, RightMouse = 0, MiddleMouse = 0,
}

-- Reverse lookup: numeric KeyCode -> name.
local KeyCodeToKeyName = {}
for KeyName, KeyValue in KeyNameToKeyCode do
    if KeyValue ~= 0 and not KeyCodeToKeyName[KeyValue] then
        KeyCodeToKeyName[KeyValue] = KeyName
    end
end

-- Resolves an Enum.KeyCode / number / name string to a key-name string. Works
-- regardless of how the env represents Enum.KeyCode (real EnumItem, a table with
-- a .Name, or a value that stringifies as "Enum.KeyCode.W").
function Global.Function:KeyName(Key)
    if type(Key) == "string" then
        return Key
    end
    if type(Key) == "number" then
        return KeyCodeToKeyName[Key]
    end

    -- Route an EnumItem through its KeyCode *value*, not its .Name: the Enum name
    -- diverges from the pressed-key (SDL) name for digit keys -- Enum.KeyCode.One
    -- is "One" but getpressedkeys() reports "1" -- so trusting .Name breaks them.
    local OkValue, Value = pcall(function() return Key.Value end)
    if OkValue and type(Value) == "number" and KeyCodeToKeyName[Value] then
        return KeyCodeToKeyName[Value]
    end

    -- Fall back to the Enum's textual name for keys not in the table.
    local Ok, Name = pcall(function() return Key.Name end)
    if Ok and type(Name) == "string" then
        return Name
    end
    return Global.Function:EnumName(Key)
end

-- UserInputService:IsKeyDown(keyCode) -- Enum.KeyCode, number, or key-name string.
-- Compares against getpressedkeys() by name.
Instance.declare({ class = "UserInputService", name = "IsKeyDown", callback = {
    method = function(self, KeyCode)
        local Target = Global.Function:KeyName(KeyCode)
        if not Target then
            return false
        end
        for Key, Value in getpressedkeys() do
            if type(Value) == "string" then
                if Value == Target then
                    return true
                end
            elseif Value == true and Key == Target then
                return true
            end
        end
        return false
    end,
}})

-- UserInputService:GetKeysPressed() -> { Enum.KeyCode } for the currently held
-- keys (mouse buttons excluded).
Instance.declare({ class = "UserInputService", name = "GetKeysPressed", callback = {
    method = function(self)
        local Result = {}
        for Key, Value in getpressedkeys() do
            local Name
            if type(Value) == "string" then
                Name = Value
            elseif Value == true then
                Name = Key
            end

            if Name and Name ~= "LeftMouse" and Name ~= "RightMouse" and Name ~= "MiddleMouse" then
                local KeyValue = KeyNameToKeyCode[Name]
                if KeyValue then
                    local Ok, Item = pcall(function() return Enum.KeyCode:FromValue(KeyValue) end)
                    table.insert(Result, (Ok and Item) or Name)
                else
                    table.insert(Result, Name)
                end
            end
        end
        return Result
    end,
}})

-- UserInputService:IsMouseButtonPressed(mouseButton) -- Enum.UserInputType
-- (MouseButton1/2) or a number (0 = left, 1 = right).
Instance.declare({ class = "UserInputService", name = "IsMouseButtonPressed", callback = {
    method = function(self, Button)
        local Name = Global.Function:EnumName(Button)
        if Name == "MouseButton1" or Button == 0 then
            return isleftpressed() and true or false
        end
        if Name == "MouseButton2" or Button == 1 then
            return isrightpressed() and true or false
        end
        
        return false
    end,
}})

-- UserInputService:GetMouseLocation() -> Vector2
Instance.declare({ class = "UserInputService", name = "GetMouseLocation", callback = {
    method = function(self)
        local Position = getmouseposition()
        return Vector2.new(Position.x, Position.y)
    end,
}})

-- // Easing (all Roblox EasingStyles) \\ --
-- Global.Easing[Style] is either a function (Linear) or { In, Out, InOut }.
-- Style keys match Enum.EasingStyle names; each function maps t in [0, 1] -> eased t.
Global.Easing = {
    Linear = function(t)
        return t
    end,
    Sine = {
        In = function(t) return 1 - math.cos((t * math.pi) / 2) end,
        Out = function(t) return math.sin((t * math.pi) / 2) end,
        InOut = function(t) return -(math.cos(math.pi * t) - 1) / 2 end,
    },
    Quad = {
        In = function(t) return t * t end,
        Out = function(t) return 1 - (1 - t) * (1 - t) end,
        InOut = function(t)
            if t < 0.5 then return 2 * t * t else return 1 - (-2 * t + 2) ^ 2 / 2 end
        end,
    },
    Cubic = {
        In = function(t) return t * t * t end,
        Out = function(t) return 1 - (1 - t) ^ 3 end,
        InOut = function(t)
            if t < 0.5 then return 4 * t * t * t else return 1 - (-2 * t + 2) ^ 3 / 2 end
        end,
    },
    Quart = {
        In = function(t) return t * t * t * t end,
        Out = function(t) return 1 - (1 - t) ^ 4 end,
        InOut = function(t)
            if t < 0.5 then return 8 * t * t * t * t else return 1 - (-2 * t + 2) ^ 4 / 2 end
        end,
    },
    Quint = {
        In = function(t) return t * t * t * t * t end,
        Out = function(t) return 1 - (1 - t) ^ 5 end,
        InOut = function(t)
            if t < 0.5 then return 16 * t * t * t * t * t else return 1 - (-2 * t + 2) ^ 5 / 2 end
        end,
    },
    Back = {
        In = function(t)
            local c1 = 1.70158
            return (c1 + 1) * t * t * t - c1 * t * t
        end,
        Out = function(t)
            local c1 = 1.70158
            return 1 + (c1 + 1) * (t - 1) ^ 3 + c1 * (t - 1) ^ 2
        end,
        InOut = function(t)
            local c2 = 1.70158 * 1.525
            if t < 0.5 then
                return ((2 * t) ^ 2 * ((c2 + 1) * 2 * t - c2)) / 2
            else
                return ((2 * t - 2) ^ 2 * ((c2 + 1) * (t * 2 - 2) + c2) + 2) / 2
            end
        end,
    },
    Circular = {
        In = function(t) return 1 - math.sqrt(1 - t ^ 2) end,
        Out = function(t) return math.sqrt(1 - (t - 1) ^ 2) end,
        InOut = function(t)
            if t < 0.5 then
                return (1 - math.sqrt(1 - (2 * t) ^ 2)) / 2
            else
                return (math.sqrt(1 - (-2 * t + 2) ^ 2) + 1) / 2
            end
        end,
    },
    Exponential = {
        In = function(t) return t == 0 and 0 or 2 ^ (10 * t - 10) end,
        Out = function(t) return t == 1 and 1 or 1 - 2 ^ (-10 * t) end,
        InOut = function(t)
            if t == 0 then return 0 elseif t == 1 then return 1
            elseif t < 0.5 then return 2 ^ (20 * t - 10) / 2
            else return (2 - 2 ^ (-20 * t + 10)) / 2 end
        end,
    },
    Elastic = {
        In = function(t)
            local c4 = (2 * math.pi) / 3
            if t == 0 then return 0 elseif t == 1 then return 1 end
            return -(2 ^ (10 * t - 10)) * math.sin((t * 10 - 10.75) * c4)
        end,
        Out = function(t)
            local c4 = (2 * math.pi) / 3
            if t == 0 then return 0 elseif t == 1 then return 1 end
            return 2 ^ (-10 * t) * math.sin((t * 10 - 0.75) * c4) + 1
        end,
        InOut = function(t)
            local c5 = (2 * math.pi) / 4.5
            if t == 0 then return 0 elseif t == 1 then return 1
            elseif t < 0.5 then return -(2 ^ (20 * t - 10) * math.sin((20 * t - 11.125) * c5)) / 2
            else return (2 ^ (-20 * t + 10) * math.sin((20 * t - 11.125) * c5)) / 2 + 1 end
        end,
    },
    Bounce = {
        Out = function(t)
            local n1, d1 = 7.5625, 2.75
            if t < 1 / d1 then
                return n1 * t * t
            elseif t < 2 / d1 then
                t = t - 1.5 / d1
                return n1 * t * t + 0.75
            elseif t < 2.5 / d1 then
                t = t - 2.25 / d1
                return n1 * t * t + 0.9375
            else
                t = t - 2.625 / d1
                return n1 * t * t + 0.984375
            end
        end,
    },
}

-- Bounce In/InOut derive from Bounce.Out.
Global.Easing.Bounce.In = function(t)
    return 1 - Global.Easing.Bounce.Out(1 - t)
end
Global.Easing.Bounce.InOut = function(t)
    if t < 0.5 then
        return (1 - Global.Easing.Bounce.Out(1 - 2 * t)) / 2
    else
        return (1 + Global.Easing.Bounce.Out(2 * t - 1)) / 2
    end
end

-- Aliases for the shorthand style names some code uses.
Global.Easing.Circ = Global.Easing.Circular
Global.Easing.Expo = Global.Easing.Exponential

-- Extracts a plain name from a string / EnumItem / "Enum.X.Y" value.
function Global.Function:EnumName(Value)
    if type(Value) == "string" then
        return Value
    end
    if typeof(Value) == "EnumItem" then
        return Value.Name
    end
    local Text = tostring(Value)
    return Text:match("%.([^%.]+)$") or Text
end

-- Returns the easing function for a style/direction (Enum.EasingStyle /
-- Enum.EasingDirection or their names). Falls back to Linear.
function Global.Function:GetEasingFunction(Style, Direction)
    local StyleName = Global.Function:EnumName(Style or "Linear")
    local DirectionName = Global.Function:EnumName(Direction or "Out")

    local Group = Global.Easing[StyleName]
    if type(Group) == "function" then
        return Group
    end
    if Group and Group[DirectionName] then
        return Group[DirectionName]
    end
    return Global.Easing.Linear
end

-- Exposed globally for convenience, in addition to the returned Global table.
_G.Easing = Global.Easing

-- // GetBoundingBox -> (CFrame, Vector3) \\ --
-- World-space bounding box, ORIENTATION-aware: each part's 8 oriented corners feed
-- the world min/max, so a rotated part (e.g. a turned tank) is bounded correctly --
-- plain Position +/- Size/2 would be wrong for anything rotated. Available as:
--   Model:GetBoundingBox()      -- over the model's direct-child BaseParts
--   BasePart:GetBoundingBox()   -- that single part
--   GetBoundingBox(part)        -- global, single part
--   GetBoundingBox({ parts })   -- global, an array of parts
-- Models use GetChildren (shallow) -- GetDescendants is expensive.
local BasePartClassSet = {
    Part = true, MeshPart = true, UnionOperation = true, TrussPart = true,
    WedgePart = true, CornerWedgePart = true, SpawnLocation = true,
    Seat = true, VehicleSeat = true,
}

-- World-space AABB over an array of BaseParts, accounting for each part's rotation.
local function ComputeBoundingBox(Parts)
    local MinX, MinY, MinZ = math.huge, math.huge, math.huge
    local MaxX, MaxY, MaxZ = -math.huge, -math.huge, -math.huge

    for _, Part in Parts do
        if Part and BasePartClassSet[Part.ClassName] then
            local PartCFrame = Part.CFrame
            local Position = PartCFrame.Position
            local Size = Part.Size
            local Right = PartCFrame.RightVector
            local Up = PartCFrame.UpVector
            local Look = PartCFrame.LookVector
            local HX, HY, HZ = Size.X * 0.5, Size.Y * 0.5, Size.Z * 0.5

            for SignX = -1, 1, 2 do
                for SignY = -1, 1, 2 do
                    for SignZ = -1, 1, 2 do
                        local X = Position.X + SignX * HX * Right.X + SignY * HY * Up.X + SignZ * HZ * Look.X
                        local Y = Position.Y + SignX * HX * Right.Y + SignY * HY * Up.Y + SignZ * HZ * Look.Y
                        local Z = Position.Z + SignX * HX * Right.Z + SignY * HY * Up.Z + SignZ * HZ * Look.Z
                        if X < MinX then MinX = X end
                        if X > MaxX then MaxX = X end
                        if Y < MinY then MinY = Y end
                        if Y > MaxY then MaxY = Y end
                        if Z < MinZ then MinZ = Z end
                        if Z > MaxZ then MaxZ = Z end
                    end
                end
            end
        end
    end

    if MinX == math.huge then
        return CFrame.new(0, 0, 0), Vector3.new(0, 0, 0)
    end

    local Center = CFrame.new((MinX + MaxX) * 0.5, (MinY + MaxY) * 0.5, (MinZ + MaxZ) * 0.5)
    return Center, Vector3.new(MaxX - MinX, MaxY - MinY, MaxZ - MinZ)
end

-- Collects a model's direct-child BaseParts (shallow).
local function ModelBaseParts(Model)
    local Parts = {}
    local Count = 0
    for _, Child in Model:GetChildren() do
        if BasePartClassSet[Child.ClassName] then
            Count += 1
            Parts[Count] = Child
        end
    end
    return Parts
end

-- Model:GetBoundingBox()
Instance.declare({ class = "Model", name = "GetBoundingBox", callback = {
    method = function(self)
        return ComputeBoundingBox(ModelBaseParts(self))
    end,
}})

-- BasePart:GetBoundingBox() -- that single part's own oriented box.
Global.Function:Declare("BasePart", "GetBoundingBox", {
    method = function(self)
        return ComputeBoundingBox({ self })
    end,
})

-- Global GetBoundingBox(Model | BasePart | { parts }) -> (CFrame, Vector3).
local function GetBoundingBox(Argument)
    if typeof(Argument) == "Instance" then
        if Argument.ClassName == "Model" then
            return ComputeBoundingBox(ModelBaseParts(Argument))
        end
        if BasePartClassSet[Argument.ClassName] then
            return ComputeBoundingBox({ Argument })
        end
        return CFrame.new(0, 0, 0), Vector3.new(0, 0, 0)
    end

    if type(Argument) == "table" then
        return ComputeBoundingBox(Argument)
    end

    return CFrame.new(0, 0, 0), Vector3.new(0, 0, 0)
end
_G.GetBoundingBox = GetBoundingBox

-- // Animator:GetPlayingAnimationTracks() -> { AnimationTrack } \\ --
-- Walks the Animator's intrusive active-animation list; each node holds a track
-- pointer at +0x10, converted back to a real AnimationTrack instance.
Instance.declare({ class = "Animator", name = "GetPlayingAnimationTracks", callback = {
    method = function(self)
        local Head = memory.readu64(self, Offsets.Animator.ActiveAnimations)
        if Head == 0 then
            return {}
        end

        local Result = {}
        local Node = memory.readu64(Head)
        local Guard = 0
        while Node ~= 0 and Node ~= Head and Guard < 256 do
            Guard += 1
            local TrackPointer = memory.readu64(Node + 0x10)
            if TrackPointer ~= 0 then
                table.insert(Result, pointer_to_userdata(TrackPointer))
            end
            Node = memory.readu64(Node)
        end
        return Result
    end,
}})

-- // TweenService \\ --

Global.Tween = {}

-- Registry of currently-playing tweens (used as a set), surfaced through
-- TweenService:GetActiveTweens().
Global.Tween.Active = {}

-- Enum.PlaybackState item by name, falling back to the name string if the enum
-- isn't present in this environment.
local function PlaybackState(Name)
    local Ok, Item = pcall(function() return Enum.PlaybackState[Name] end)
    return (Ok and Item) or Name
end


-- Type-aware interpolation between two same-typed values at Alpha in [0, 1].
-- Native `vector` (used by Drawings) and numbers are done arithmetically since
-- they have no :Lerp; Vector3 / Vector2 / CFrame / Color3 / UDim2 use :Lerp.
function Global.Tween:Lerp(Start, Goal, Alpha)
    local Kind = typeof(Start)

    if Kind == "number" then
        return Start + (Goal - Start) * Alpha
    end
    -- Native 3-component `vector` (Vector3 / Drawing positions / Color3). Build
    -- the result from components with Vector3.new(x, y, z) -- the exact form
    -- Tween.lua uses to move parts -- rather than native-vector arithmetic.
    if Kind == "vector" then
        return Vector3.new(
            Start.X + (Goal.X - Start.X) * Alpha,
            Start.Y + (Goal.Y - Start.Y) * Alpha,
            Start.Z + (Goal.Z - Start.Z) * Alpha
        )
    end

    -- UDim / UDim2 are interpolated component-wise through their constructors.
    if Kind == "UDim" then
        return UDim.new(
            Start.Scale + (Goal.Scale - Start.Scale) * Alpha,
            math.floor(Start.Offset + (Goal.Offset - Start.Offset) * Alpha + 0.5)
        )
    end
    if Kind == "UDim2" then
        local X = Global.Tween:Lerp(Start.X, Goal.X, Alpha)
        local Y = Global.Tween:Lerp(Start.Y, Goal.Y, Alpha)
        return UDim2.new(X.Scale, X.Offset, Y.Scale, Y.Offset)
    end

    local Ok, Result = pcall(function() return Start:Lerp(Goal, Alpha) end)
    if Ok then
        return Result
    end

    return Alpha >= 1 and Goal or Start
end

-- Reads a field from a real TweenInfo (userdata) or a plain table, with a
-- default. Accepting both means callers don't need a TweenInfo constructor.
local function InfoField(Info, Key, Default)
    if Info == nil then
        return Default
    end
    local Ok, Value = pcall(function() return Info[Key] end)
    if Ok and Value ~= nil then
        return Value
    end
    return Default
end

-- Normalises a TweenInfo / table into the fields the player loop needs.
function Global.Tween:ParseInfo(Info)
    return {
        Time = math.max(InfoField(Info, "Time", 1), 0),
        Style = InfoField(Info, "EasingStyle", "Linear"),
        Direction = InfoField(Info, "EasingDirection", "Out"),
        RepeatCount = InfoField(Info, "RepeatCount", 0),
        Reverses = InfoField(Info, "Reverses", false) and true or false,
        DelayTime = math.max(InfoField(Info, "DelayTime", 0), 0),
    }
end

function Global.Tween:Create(Object, Info, Goals)
    local Parsed = Global.Tween:ParseInfo(Info)
    local Ease = Global.Function:GetEasingFunction(Parsed.Style, Parsed.Direction)

    -- CFrame is an ALIAS for Position: tweening a live character's CFrame spins /
    -- inverts the rig, so a { CFrame = X } goal is rewritten to { Position = <X's
    -- position> }. X may be a CFrame (use its .Position) or a plain Vector3.
    if Goals.CFrame ~= nil then
        local Value = Goals.CFrame
        local Position = typeof(Value) == "CFrame" and Value.Position or Value
        local Rewritten = {}
        for Key, Goal in Goals do
            if Key ~= "CFrame" then
                Rewritten[Key] = Goal
            end
        end
        Rewritten.Position = Position
        Goals = Rewritten
    end

    local StatePlaying = PlaybackState("Playing")
    local StatePaused = PlaybackState("Paused")

    local Tween = {
        Instance = Object,
        TweenInfo = Info,
        PlaybackState = PlaybackState("Begin"),
        Completed = signal(),
        Finished = false,
    }

    local Active = false
    local Paused = false

    local function Alive()
        if typeof(Object) == "Instance" then
            return Object.Parent ~= nil
        end
        return true
    end

    function Tween:Play()
        if Active then
            Paused = false
            return Tween
        end
        Active = true
        Paused = false
        Global.Tween.Active[Tween] = true

        local Starts = {}
        for Property in Goals do
            local Ok, Value = pcall(function() return Object[Property] end)
            if Ok and Value ~= nil then
                Starts[Property] = Value
            else
                print(string.format(
                    "[TweenService] skipping '%s' -- not a readable property of %s",
                    tostring(Property), tostring(Object)
                ))
            end
        end

        Tween.PlaybackState = StatePlaying

        task.spawn(function()
            if Parsed.DelayTime > 0 then
                task.wait(Parsed.DelayTime)
            end

            local Elapsed = 0
            local Last = os.clock()
            local Forward = true
            local Cycle = 0

            while Active and Alive() do
                if Paused then
                    Tween.PlaybackState = StatePaused
                    task.wait()
                    Last = os.clock()
                    continue
                end
                Tween.PlaybackState = StatePlaying

                local Now = os.clock()
                Elapsed += Now - Last
                Last = Now

                local Alpha = Parsed.Time > 0 and math.min(Elapsed / Parsed.Time, 1) or 1
                local Eased = Ease(Forward and Alpha or (1 - Alpha))

                for Property, Goal in Goals do
                    local Start = Starts[Property]
                    if Start ~= nil then
                        pcall(function()
                            Object[Property] = Global.Tween:Lerp(Start, Goal, Eased)
                        end)
                    end
                end

                if Alpha >= 1 then
                    if Parsed.Reverses and Forward then
                        Forward = false
                        Elapsed = 0
                    else
                        Cycle += 1
                        if Parsed.RepeatCount >= 0 and Cycle > Parsed.RepeatCount then
                            break
                        end
                        Forward = true
                        Elapsed = 0
                    end
                end

                task.wait()
            end

            Active = false
            Global.Tween.Active[Tween] = nil
            local Final = PlaybackState("Completed")
            Tween.PlaybackState = Final
            Tween.Finished = true
            pcall(function() Tween.Completed:fire(Final) end)
        end)

        return Tween
    end

    function Tween:Pause()
        Paused = true
        return Tween
    end

    function Tween:Cancel()
        Active = false
        Paused = false
        Global.Tween.Active[Tween] = nil
        return Tween
    end

    return Tween
end

-- TweenService:Create(instance, tweenInfo, propertyTable) -> Tween
Global.Function:Declare("TweenService", "Create", {
    method = function(self, Object, Info, Goals)
        return Global.Tween:Create(Object, Info, Goals)
    end,
})

-- TweenService:GetValue(alpha, easingStyle, easingDirection) -> number
Global.Function:Declare("TweenService", "GetValue", {
    method = function(self, Alpha, Style, Direction)
        return Global.Function:GetEasingFunction(Style, Direction)(math.clamp(Alpha, 0, 1))
    end,
})

-- TweenService:GetActiveTweens() -> { Tween } (the tweens created here that are
-- currently playing). These are Module's own Tween tables, not engine tweens.
local function GetActiveTweens()
    local List = {}
    for Tween in Global.Tween.Active do
        table.insert(List, Tween)
    end
    return List
end

Global.Function:Declare("TweenService", "GetActiveTweens", {
    method = function(self)
        return GetActiveTweens()
    end,
})

-- Fallback global, in case game:GetService("TweenService") doesn't resolve to a
-- usable instance here. Use with a colon: TweenService:Create(...).
_G.TweenService = {
    Create = function(self, Object, Info, Goals)
        return Global.Tween:Create(Object, Info, Goals)
    end,
    GetValue = function(self, Alpha, Style, Direction)
        return Global.Function:GetEasingFunction(Style, Direction)(math.clamp(Alpha, 0, 1))
    end,
    GetActiveTweens = function(self)
        return GetActiveTweens()
    end,
}

-- // Notifications \\ --

Global.Notification = {}

local Notify = {
    Width = 136 * 1.5,
    BodyHeight = 60,
    Margin = 8,
    AnchorFraction = 0.90, 
    SwingInTime = 0.38,
    SwingOutTime = 0.30, 
    TitleSize = 18, -- title text size
    BodySize = 16, -- body text size
    LineGap = 3, -- vertical gap between title and body
    StackGap = 8 * 1.5,
    BackgroundColor = Color3.fromRGB(36, 36, 36),
    BackgroundOpacity = 0.65, 
    IconBuffer = 12 * 1.5, -- left gap before icon
    IconSize = 44 * 1.5, 
    IconGap = 8 * 1.5, -- gap between icon and text
    TitleColor = vector.create(1, 1, 1),
    BodyColor = vector.create(1, 1, 1),
    ButtonHeight = 30,
    ButtonTopGap = 2, -- gap between body bottom and button row
    ButtonSpacing = 2, -- gap between two buttons
    ButtonColor = Color3.fromRGB(36, 36, 36),
    ButtonOpacity = 0.65,
    ButtonTextColor = vector.create(1, 1, 1),
}

local ActiveNotifications = {}
local OffscreenOffset = Notify.Width + Notify.Margin + 24

function Global.Function:ResolveIconUrl(Icon)
    if type(Icon) ~= "string" or Icon == "" then
        return nil
    end

    local AssetId = Icon:match("rbxassetid://(%d+)") or Icon:match("^(%d+)$")
    if AssetId then
        local Endpoint = "https://thumbnails.roblox.com/v1/assets?assetIds=" .. AssetId
            .. "&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false"
        local Ok, Response = pcall(function() return http.get({ url = Endpoint }) end)
        if not Ok or type(Response) ~= "string" then return nil end

        local OkDecode, Decoded = pcall(function() return crypt.json.decode(Response) end)
        local Data = OkDecode and type(Decoded) == "table" and Decoded.data and Decoded.data[1]
        local ImageUrl = Data and Data.imageUrl
        if type(ImageUrl) ~= "string" then return nil end
        return ImageUrl
    end

    if Icon:match("^https?://") then
        return Icon
    end
    return nil
end

function Global.Function:NotificationHeight(Entry)
    if Entry.Buttons then
        return Notify.BodyHeight + Notify.ButtonTopGap + Notify.ButtonHeight
    end
    return Notify.BodyHeight
end

function Global.Function:PositionNotification(Entry)
    local X = Entry.RestX + (Entry.XOffset or 0)
    local Y = Entry.Y
    Entry.Panel.Position = vector.create(X, Y)
    Entry.Panel.Size = vector.create(Notify.Width, Notify.BodyHeight)

    local Centered = Entry.Icon == nil
    local TextX = X + Notify.Width * 0.5
    if Entry.Icon then
        Entry.Icon.Position = vector.create(X + Notify.IconBuffer, Y + (Notify.BodyHeight - Notify.IconSize) * 0.5)
        Entry.Icon.Size = vector.create(Notify.IconSize, Notify.IconSize)
        TextX = X + Notify.IconBuffer + Notify.IconSize + Notify.IconGap
    end

    Entry.Title.Center = Centered
    Entry.Body.Center = Centered
    
    local BlockHeight = Notify.TitleSize + Notify.LineGap + Notify.BodySize
    local BlockTop = Y + (Notify.BodyHeight - BlockHeight) * 0.5
    Entry.Title.Position = vector.create(TextX, BlockTop)
    Entry.Body.Position = vector.create(TextX, BlockTop + Notify.TitleSize + Notify.LineGap)

    if Entry.Buttons then
        local Count = #Entry.Buttons
        local ButtonY = Y + Notify.BodyHeight + Notify.ButtonTopGap
        local ButtonW = Count == 1 and Notify.Width or (Notify.Width - Notify.ButtonSpacing) * 0.5
        for Index, Button in Entry.Buttons do
            local ButtonX = X + (Index - 1) * (ButtonW + Notify.ButtonSpacing)
            Button.Panel.Position = vector.create(ButtonX, ButtonY)
            Button.Panel.Size = vector.create(ButtonW, Notify.ButtonHeight)
            Button.Label.Position = vector.create(ButtonX + ButtonW * 0.5, ButtonY + (Notify.ButtonHeight - 14) * 0.5)
            Button.Rect = { ButtonX, ButtonY, ButtonX + ButtonW, ButtonY + Notify.ButtonHeight }
        end
    end
end

function Global.Function:ReflowNotifications()
    local Screen = game.Workspace.CurrentCamera.ViewportSize
    local RestX = Screen.x - Notify.Width - Notify.Margin
    local Y = Screen.y * Notify.AnchorFraction
    for _, Entry in ActiveNotifications do
        Y = Y - Global.Function:NotificationHeight(Entry)
        Entry.RestX = RestX
        Entry.Y = Y
        Global.Function:PositionNotification(Entry)
        Y = Y - Notify.StackGap
    end
end

function Global.Function:AnimateNotificationX(Entry, FromOffset, ToOffset, Duration, Ease)
    local Start = os.clock()
    while not Entry.Removed do
        local T = math.min((os.clock() - Start) / Duration, 1)
        local Eased = Ease(T)
        Entry.XOffset = FromOffset + (ToOffset - FromOffset) * Eased
        Global.Function:PositionNotification(Entry)
        if T >= 1 then break end
        task.wait()
    end
    if not Entry.Removed then
        Entry.XOffset = ToOffset
        Global.Function:PositionNotification(Entry)
    end
end

function Global.Function:DismissNotification(Entry)
    if Entry.Dismissed then return end
    Entry.Dismissed = true

    Global.Function:AnimateNotificationX(Entry, Entry.XOffset or 0, OffscreenOffset,
        Notify.SwingOutTime, Global.Easing.Back.In)

    Entry.Removed = true
    local Index = table.find(ActiveNotifications, Entry)
    if Index then table.remove(ActiveNotifications, Index) end
    for _, Drawing in Entry.Drawings do
        pcall(function() Drawing:Remove() end)
    end
    Global.Function:ReflowNotifications()
end

function Global.Function:InvokeCallback(Callback, ButtonText)
    if type(Callback) == "function" then
        pcall(Callback, ButtonText)
    elseif type(Callback) == "table" or typeof(Callback) == "Instance" then
        pcall(function() Callback:Invoke(ButtonText) end)
    end
end

function Global.Function:BuildNotification(Config)
    if type(Config) ~= "table" then return end

    local TitleString = tostring(Config.Title or "")
    local BodyString = tostring(Config.Text or "")
    local Duration = tonumber(Config.Duration) or 5
    local IconUrl = Global.Function:ResolveIconUrl(Config.Icon)

    local Drawings = {}
    local Fadeable = {}

    local function Track(Drawing, BaseOpacity)
        Drawings[#Drawings + 1] = Drawing
        Fadeable[#Fadeable + 1] = { Drawing = Drawing, Base = BaseOpacity }
        return Drawing
    end

    local Panel = Square.new()
    Panel.Filled = true
    Panel.Rounding = 0
    Panel.Color = Notify.BackgroundColor
    Panel.Opacity = Notify.BackgroundOpacity
    Panel.ZIndex = 100
    Panel.Visible = true
    Track(Panel, Notify.BackgroundOpacity)

    local Icon
    if IconUrl then
        Icon = Image.new()
        Icon.Url = IconUrl
        Icon.Color = vector.create(1, 1, 1)
        Icon.Opacity = 1
        Icon.ZIndex = 101
        Icon.Visible = true
        Track(Icon, 1)
    end

    local Title = Text.new()
    Title.Text = TitleString
    Title.Size = Notify.TitleSize
    Title.Font = "Source-Sans-Pro"
    Title.Color = Notify.TitleColor
    Title.Outline = true
    Title.OutlineColor = vector.create(0, 0, 0)
    Title.ZIndex = 101
    Title.Visible = true
    Track(Title, 1)

    local Body = Text.new()
    Body.Text = BodyString
    Body.Size = Notify.BodySize
    Body.Font = "Source-Sans-Pro"
    Body.Color = Notify.BodyColor
    Body.Outline = true
    Body.OutlineColor = vector.create(0, 0, 0)
    Body.ZIndex = 101
    Body.Visible = true
    Track(Body, 1)

    local Buttons
    local Labels = {}
    if type(Config.Button1) == "string" and Config.Button1 ~= "" then Labels[#Labels + 1] = Config.Button1 end
    if type(Config.Button2) == "string" and Config.Button2 ~= "" then Labels[#Labels + 1] = Config.Button2 end

    if #Labels > 0 then
        Buttons = {}
        for _, ButtonText in Labels do
            local ButtonPanel = Square.new()
            ButtonPanel.Filled = true
            ButtonPanel.Rounding = 0
            ButtonPanel.Color = Notify.ButtonColor
            ButtonPanel.Opacity = Notify.ButtonOpacity
            ButtonPanel.ZIndex = 100
            ButtonPanel.Visible = true
            Track(ButtonPanel, Notify.ButtonOpacity)

            local ButtonLabel = Text.new()
            ButtonLabel.Text = ButtonText
            ButtonLabel.Size = 16
            ButtonLabel.Font = "Source-Sans-Pro"
            ButtonLabel.Center = true
            ButtonLabel.Color = Notify.ButtonTextColor
            ButtonLabel.Outline = true
            ButtonLabel.OutlineColor = vector.create(0, 0, 0)
            ButtonLabel.ZIndex = 101
            ButtonLabel.Visible = true
            Track(ButtonLabel, 1)

            Buttons[#Buttons + 1] = { Panel = ButtonPanel, Label = ButtonLabel, Text = ButtonText, Rect = { 0, 0, 0, 0 } }
        end
    end

    local Entry = {
        Drawings = Drawings,
        Fadeable = Fadeable,
        Panel = Panel,
        Icon = Icon,
        Title = Title,
        Body = Body,
        Buttons = Buttons,
        Callback = Config.Callback,
        XOffset = OffscreenOffset,
    }

    table.insert(ActiveNotifications, 1, Entry)
    Global.Function:ReflowNotifications()

    task.spawn(function()
        Global.Function:AnimateNotificationX(Entry, OffscreenOffset, 0,
            Notify.SwingInTime, Global.Easing.Back.Out)

        local Deadline = os.clock() + Duration
        while not Entry.Dismissed do
            if os.clock() >= Deadline then break end

            if Entry.Buttons then
                local OkClick, Clicked = pcall(isleftclicked)
                if OkClick and Clicked then
                    local OkMouse, Mouse = pcall(getmouseposition)
                    if OkMouse and Mouse then
                        for _, Button in Entry.Buttons do
                            local R = Button.Rect
                            if Mouse.x >= R[1] and Mouse.x <= R[3] and Mouse.y >= R[2] and Mouse.y <= R[4] then
                                Global.Function:InvokeCallback(Entry.Callback, Button.Text)
                                Global.Function:DismissNotification(Entry)
                                return
                            end
                        end
                    end
                end
            end

            task.wait()
        end
        Global.Function:DismissNotification(Entry)
    end)
end

function Global.Function:SendNotification(Config)
    task.spawn(function()
        Global.Function:BuildNotification(Config)
    end)
end

Global.Notification.Send = function(Config)
    Global.Function:SendNotification(Config)
end

_G.SendNotification = function(Config)
    Global.Function:SendNotification(Config)
end

_G.StarterGui = {
    SetCore = function(self, CoreType, Config)
        if CoreType == "SendNotification" then
            Global.Function:SendNotification(Config)
        end
    end,
}

-- // Events & Connections \\ --
-- Roblox-style events: `instance.SomeEvent:Connect(fn)` returns a connection with
-- :Disconnect(). There is no native event hook in this environment, so everything
-- is change-detected by polling. To keep that cheap and crash-safe:
--   * ONE shared poll loop runs every registered watcher; it sleeps entirely when
--     nothing is connected.
--   * A signal is created lazily per (instance, event) and only adds its watcher
--     WHILE it has live connections (activate on first Connect, deactivate on last
--     Disconnect), then drops itself from the store so destroyed instances leak
--     nothing.
--   * Every read is pcall-guarded; heavy watchers (descendants / attributes) are
--     throttled; handlers run in task.spawn so a slow/erroring one can't stall the
--     poller or the other handlers.
-- Events that can't be detected reliably here are intentionally omitted (see the
-- note at the end of this section).

Global.Event = {}

-- Connection-bearing signal. :Connect uses a capital C (as requested).
local function MakeSignal()
    local Signal = { Handlers = {}, Count = 0 }

    function Signal:Connect(Callback)
        assert(type(Callback) == "function", "Connect expects a function")
        local Connection = { Connected = true }

        Signal.Handlers[Connection] = Callback
        Signal.Count += 1
        if Signal.Count == 1 and Signal.OnActivate then
            Signal.OnActivate()
        end

        function Connection:Disconnect()
            if not self.Connected then
                return
            end
            self.Connected = false
            Signal.Handlers[self] = nil
            Signal.Count -= 1
            if Signal.Count == 0 and Signal.OnDeactivate then
                Signal.OnDeactivate()
            end
        end

        return Connection
    end

    function Signal:Fire(...)
        local Args = table.pack(...)
        -- Snapshot so a handler that (dis)connects during dispatch can't mutate
        -- the table we're iterating.
        local Snapshot, Count = {}, 0
        for Connection, Callback in Signal.Handlers do
            if Connection.Connected then
                Count += 1
                Snapshot[Count] = Callback
            end
        end
        for Index = 1, Count do
            local Callback = Snapshot[Index]
            task.spawn(function()
                Callback(table.unpack(Args, 1, Args.n))
            end)
        end
    end

    return Signal
end

-- Shared poll loop.
local ActiveWatchers = {}
local PollRunning = false

local function EnsurePoll()
    if PollRunning then
        return
    end
    PollRunning = true
    task.spawn(function()
        while next(ActiveWatchers) do
            -- Snapshot so a watcher/handler that adds or removes watchers during a
            -- tick can't mutate the set mid-iteration.
            local Snapshot, Count = {}, 0
            for Watcher in ActiveWatchers do
                Count += 1
                Snapshot[Count] = Watcher
            end
            for Index = 1, Count do
                local Watcher = Snapshot[Index]
                if ActiveWatchers[Watcher] then
                    pcall(Watcher)
                end
            end
            task.wait()
        end
        PollRunning = false
    end)
end

local function AddWatcher(Watcher)
    ActiveWatchers[Watcher] = true
    EnsurePoll()
end

local function RemoveWatcher(Watcher)
    ActiveWatchers[Watcher] = nil
end

-- Wraps a watcher so it only actually runs every `Interval` seconds (for the
-- heavier GetDescendants / GetAttributes scans).
local function Throttled(Interval, Watcher)
    local NextRun = 0
    return function()
        local Now = os.clock()
        if Now < NextRun then
            return
        end
        NextRun = Now + Interval
        Watcher()
    end
end

-- Normalises a value into a stable comparison key: Instances compare by pointer
-- (fresh userdata wrappers otherwise break identity), everything else by value
-- (native vectors / numbers / bools have value equality).
local function ValueKey(Value)
    if typeof(Value) == "Instance" then
        return Value.Data
    end
    return Value
end

-- Per-instance signal store, keyed by pointer then event name. Entries are removed
-- when their signal deactivates, so nothing accumulates.
local EventStore = {}

local function InstanceEvent(Object, Name, MakeWatcher)
    local Pointer = Object.Data
    local ByName = EventStore[Pointer]
    if not ByName then
        ByName = {}
        EventStore[Pointer] = ByName
    end

    local Signal = ByName[Name]
    if Signal then
        return Signal
    end

    Signal = MakeSignal()
    ByName[Name] = Signal

    local Watcher
    Signal.OnActivate = function()
        Watcher = MakeWatcher(Object, Signal)
        if Watcher then
            AddWatcher(Watcher)
        end
    end
    Signal.OnDeactivate = function()
        if Watcher then
            RemoveWatcher(Watcher)
            Watcher = nil
        end
        ByName[Name] = nil
        if not next(ByName) then
            EventStore[Pointer] = nil
        end
    end

    return Signal
end

-- Fires an instance event only if it currently exists (has connections). Used for
-- push-based events like MoveToFinished.
function Global.Event.Fire(Object, Name, ...)
    local ByName = EventStore[Object.Data]
    local Signal = ByName and ByName[Name]
    if Signal then
        Signal:Fire(...)
    end
end

-- Declares `Name` on `Class` as a read-only event property returning its signal.
local function DeclareEvent(Class, Name, MakeWatcher)
    Global.Function:Declare(Class, Name, {
        get = function(self)
            return InstanceEvent(self, Name, MakeWatcher)
        end,
    })
end

-- // Watcher factories \\ --

local function ReadProp(Object, Name)
    local Ok, Value = pcall(function() return Object[Name] end)
    if Ok then
        return Value
    end
    return nil
end

-- Property change -> fires (newValue). Mode "added" fires only nil->value with the
-- value; "removing" fires only value->nil with the old value.
local function WatchProperty(PropertyName, Mode)
    return function(Object, Signal)
        local Last = ReadProp(Object, PropertyName)
        local LastKey = ValueKey(Last)
        return function()
            local Value = ReadProp(Object, PropertyName)
            local Key = ValueKey(Value)
            if Key ~= LastKey then
                local Previous = Last
                LastKey, Last = Key, Value
                if Mode == "added" then
                    if Value ~= nil then Signal:Fire(Value) end
                elseif Mode == "removing" then
                    if Previous ~= nil then Signal:Fire(Previous) end
                else
                    Signal:Fire(Value)
                end
            end
        end
    end
end

-- Children set -> ChildAdded / ChildRemoved (keyed by pointer for stable identity).
local function WatchChildren(FireOnAdd)
    return function(Object, Signal)
        local Known = {}
        local Ok, Kids = pcall(function() return Object:GetChildren() end)
        if Ok then
            for _, Child in Kids do Known[Child.Data] = Child end
        end
        return function()
            local Ok, Kids = pcall(function() return Object:GetChildren() end)
            if not Ok then return end
            local Now = {}
            for _, Child in Kids do
                local Pointer = Child.Data
                Now[Pointer] = Child
                if FireOnAdd and not Known[Pointer] then
                    Signal:Fire(Child)
                end
            end
            if not FireOnAdd then
                for Pointer, Child in Known do
                    if not Now[Pointer] then
                        Signal:Fire(Child)
                    end
                end
            end
            Known = Now
        end
    end
end

-- Descendant set -> DescendantAdded / DescendantRemoving (throttled; heavy).
local function WatchDescendants(FireOnAdd)
    return function(Object, Signal)
        local Known = {}
        local Ok, Descendants = pcall(function() return Object:GetDescendants() end)
        if Ok then
            for _, Descendant in Descendants do Known[Descendant.Data] = Descendant end
        end
        return Throttled(0.1, function()
            local Ok, Descendants = pcall(function() return Object:GetDescendants() end)
            if not Ok then return end
            local Now = {}
            for _, Descendant in Descendants do
                local Pointer = Descendant.Data
                Now[Pointer] = Descendant
                if FireOnAdd and not Known[Pointer] then
                    Signal:Fire(Descendant)
                end
            end
            if not FireOnAdd then
                for Pointer, Descendant in Known do
                    if not Now[Pointer] then
                        Signal:Fire(Descendant)
                    end
                end
            end
            Known = Now
        end)
    end
end

-- AncestryChanged -> fires (child, newParent) when the direct Parent changes.
-- (Polling can only see the direct parent, not deeper ancestry moves.)
local function WatchAncestry(Object, Signal)
    local Last = ReadProp(Object, "Parent")
    local LastKey = ValueKey(Last)
    return function()
        local Parent = ReadProp(Object, "Parent")
        local Key = ValueKey(Parent)
        if Key ~= LastKey then
            LastKey = Key
            Signal:Fire(Object, Parent)
        end
    end
end

-- Destroying -> best-effort: fires once when the instance leaves the tree
-- (Parent goes nil), then stops. Not exactly :Destroy(), but polling can't see
-- that; reads are guarded so a freed instance can't crash the loop.
local function WatchDestroying(Object, Signal)
    local Fired = false
    local HadParent = ReadProp(Object, "Parent") ~= nil
    return function()
        if Fired then return end
        local Ok, Parent = pcall(function() return Object.Parent end)
        if not Ok then
            Fired = true
            Signal:Fire()
            return
        end
        if Parent ~= nil then
            HadParent = true
        elseif HadParent then
            Fired = true
            Signal:Fire()
        end
    end
end

-- Died -> fires EXACTLY once, on the alive->dead transition, then stops watching.
-- Matches Roblox: a dead Humanoid doesn't die again (a respawn gives a new
-- Humanoid instance). Firing once also avoids double-firing on the Health flicker
-- some death sequences produce.
local function WatchDied(Object, Signal)
    -- If it's already dead when we start watching, treat it as already-fired
    -- (Roblox wouldn't re-fire either).
    local WasAlive = (ReadProp(Object, "Health") or 0) > 0
    local Watcher
    Watcher = function()
        local Health = ReadProp(Object, "Health")
        if Health == nil then return end
        if Health <= 0 then
            if WasAlive then
                Signal:Fire()
            end
            RemoveWatcher(Watcher)
        else
            WasAlive = true
        end
    end
    return Watcher
end

-- Boolean rising edge (false->true) for a custom reader (window focus, etc).
local function WatchRisingEdge(Reader)
    return function(Object, Signal)
        local Ok, Value = pcall(Reader, Object)
        local Last = Ok and Value and true or false
        return function()
            local Ok, Value = pcall(Reader, Object)
            if not Ok then return end
            local Now = Value and true or false
            if Now and not Last then
                Signal:Fire()
            end
            Last = Now
        end
    end
end

-- IsPlaying true->false -> AnimationTrack Stopped / Ended.
local function WatchStopped(Object, Signal)
    local Was = ReadProp(Object, "IsPlaying") and true or false
    return function()
        local Playing = ReadProp(Object, "IsPlaying") and true or false
        if Was and not Playing then
            Signal:Fire()
        end
        Was = Playing
    end
end

-- AttributeChanged -> fires (attributeName). Needs Instance:GetAttributes(); if
-- that isn't available it disables itself after the first (failed) scan.
local function WatchAttributes(Object, Signal)
    local Known = {}
    local Alive = true
    local function ReadAll()
        local Ok, Attributes = pcall(function() return Object:GetAttributes() end)
        if not Ok or type(Attributes) ~= "table" then
            Alive = false
            return nil
        end
        return Attributes
    end
    local First = ReadAll()
    if First then for Key, Value in First do Known[Key] = Value end end
    return Throttled(0.1, function()
        if not Alive then return end
        local Attributes = ReadAll()
        if not Attributes then return end
        for Key, Value in Attributes do
            if Known[Key] ~= Value then
                Known[Key] = Value
                Signal:Fire(Key)
            end
        end
        for Key in Known do
            if Attributes[Key] == nil then
                Known[Key] = nil
                Signal:Fire(Key)
            end
        end
    end)
end

-- InputChanged (mouse movement only) -> fires a minimal InputObject-like table.
-- A full InputObject / keyboard input can't be synthesised here.
local function WatchMouseMovement(Object, Signal)
    local Ok, Position = pcall(getmouseposition)
    local LastX = Ok and Position and Position.x or 0
    local LastY = Ok and Position and Position.y or 0
    return function()
        local Ok, Position = pcall(getmouseposition)
        if not Ok or not Position then return end
        if Position.x ~= LastX or Position.y ~= LastY then
            local DeltaX, DeltaY = Position.x - LastX, Position.y - LastY
            LastX, LastY = Position.x, Position.y
            Signal:Fire({
                UserInputType = "MouseMovement",
                Position = Vector3.new(Position.x, Position.y, 0),
                Delta = Vector3.new(DeltaX, DeltaY, 0),
            })
        end
    end
end

-- // Declarations \\ --

-- Instance (universal): applies to Player / Model / Workspace / etc. too, so
-- Player.ChildAdded, Model.ChildAdded and Workspace.ChildAdded are all covered.
DeclareEvent("Instance", "ChildAdded", WatchChildren(true))
DeclareEvent("Instance", "ChildRemoved", WatchChildren(false))
DeclareEvent("Instance", "DescendantAdded", WatchDescendants(true))
DeclareEvent("Instance", "DescendantRemoving", WatchDescendants(false))
DeclareEvent("Instance", "AncestryChanged", WatchAncestry)
DeclareEvent("Instance", "Destroying", WatchDestroying)
DeclareEvent("Instance", "AttributeChanged", WatchAttributes)

-- Instance:GetPropertyChangedSignal(name) -> signal firing (newValue) on change.
Global.Function:Declare("Instance", "GetPropertyChangedSignal", {
    method = function(self, PropertyName)
        return InstanceEvent(self, "PropertyChanged:" .. tostring(PropertyName),
            WatchProperty(PropertyName))
    end,
})

-- Players service.
DeclareEvent("Players", "PlayerAdded", WatchChildren(true))
DeclareEvent("Players", "PlayerRemoving", WatchChildren(false))

-- Player.
DeclareEvent("Player", "CharacterAdded", WatchProperty("Character", "added"))
DeclareEvent("Player", "CharacterRemoving", WatchProperty("Character", "removing"))

-- Humanoid.
DeclareEvent("Humanoid", "HealthChanged", WatchProperty("Health"))
DeclareEvent("Humanoid", "Died", WatchDied)
DeclareEvent("Humanoid", "Jumping", WatchProperty("Jump"))
DeclareEvent("Humanoid", "Seated", WatchProperty("Sit"))
DeclareEvent("Humanoid", "MoveToFinished", function() return function() end end)

-- AnimationTrack.
DeclareEvent("AnimationTrack", "Stopped", WatchStopped)
DeclareEvent("AnimationTrack", "Ended", WatchStopped)

-- VehicleSeat.
DeclareEvent("VehicleSeat", "OccupantChanged", WatchProperty("Occupant"))

-- UserInputService.
DeclareEvent("UserInputService", "InputChanged", WatchMouseMovement)
DeclareEvent("UserInputService", "WindowFocused", WatchRisingEdge(function() return isrbxactive() end))
DeclareEvent("UserInputService", "TextBoxFocused", WatchProperty("CurrentTextBox", "added"))

-- NOT implemented (can't be detected reliably here, so omitted rather than faked):
--   Instance.Changed              -- would require polling every property.
--   Humanoid.Running / FreeFalling / Climbing / Swimming / StateChanged /
--   StateEnabledChanged           -- no reliable Humanoid state-machine offset.

return Global
