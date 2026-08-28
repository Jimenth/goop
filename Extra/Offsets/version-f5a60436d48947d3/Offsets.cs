/*
 * Github: https://git.jonah.cool/jonah/roblox-dumper
 * Roblox Version: version-f5a60436d48947d3
 * Time Taken: 7581 ms (7.581000 seconds)
 * Total Offsets: 498
 */

using System;

namespace RobloxOffsets
{
    public static class Metadata
    {
        public const string RobloxVersion = "version-f5a60436d48947d3";
    }

    public static class AirProperties
    {
        public const ulong AirDensity = 0x18;
        public const ulong GlobalWind = 0x3C;
    }

    public static class AnimationTrack
    {
        public const ulong Animation = 0xB8;
        public const ulong Animator = 0x110;
        public const ulong IsPlaying = 0xA58;
        public const ulong Looped = 0xE5;
        public const ulong Speed = 0xD4;
        public const ulong TimePosition = 0xD8;
    }

    public static class Animator
    {
        public const ulong ActiveAnimations = 0xB50;
    }

    public static class Atmosphere
    {
        public const ulong Color = 0xB8;
        public const ulong Decay = 0xC4;
        public const ulong Density = 0xD0;
        public const ulong Glare = 0xD4;
        public const ulong Haze = 0xD8;
        public const ulong Offset = 0xDC;
    }

    public static class Attachment
    {
        public const ulong Position = 0xC4;
    }

    public static class BasePart
    {
        public const ulong CastShadow = 0x135;
        public const ulong Color3 = 0x1A8;
        public const ulong Locked = 0x136;
        public const ulong Massless = 0x137;
        public const ulong Primitive = 0x188;
        public const ulong Reflectance = 0x10C;
        public const ulong Shape = 0x1B9;
        public const ulong Transparency = 0x130;
    }

    public static class Beam
    {
        public const ulong Attachment0 = 0x160;
        public const ulong Attachment1 = 0x170;
        public const ulong Brightness = 0x180;
        public const ulong CurveSize0 = 0x184;
        public const ulong CurveSize1 = 0x188;
        public const ulong LightEmission = 0x18C;
        public const ulong LightInfluence = 0x190;
        public const ulong Texture = 0x140;
        public const ulong TextureLength = 0x19C;
        public const ulong TextureSpeed = 0x1A4;
        public const ulong Width0 = 0x1A8;
        public const ulong Width1 = 0x1AC;
        public const ulong ZOffset = 0x1B0;
    }

    public static class BloomEffect
    {
        public const ulong Enabled = 0xB0;
        public const ulong Intensity = 0xB8;
        public const ulong Size = 0xBC;
        public const ulong Threshold = 0xC0;
    }

    public static class BlurEffect
    {
        public const ulong Enabled = 0xB0;
        public const ulong Size = 0xB8;
    }

    public static class ByteCode
    {
        public const ulong Pointer = 0x10;
        public const ulong Size = 0x28;
    }

    public static class CachedItem
    {
        public const ulong FileMeshData = 0x40;
    }

    public static class Camera
    {
        public const ulong CFrame = 0xD8;
        public const ulong CameraSubject = 0xC8;
        public const ulong CameraType = 0x138;
        public const ulong FieldOfView = 0x140;
        public const ulong ImagePlaneDepth = 0x2D4;
        public const ulong Position = 0xFC;
        public const ulong Rotation = 0xD8;
        public const ulong ViewportInt16 = 0x28C;
        public const ulong ViewportSize = 0x2CC;
    }

    public static class CharacterMesh
    {
        public const ulong BaseTextureId = 0xC8;
        public const ulong BodyPart = 0x148;
        public const ulong MeshId = 0xF8;
        public const ulong OverlayTextureId = 0x128;
    }

    public static class ClassDescriptor
    {
        public const ulong ClassName = 0x8;
        public const ulong Creator = 0x230;
        public const ulong EventDescriptors = 0x88;
        public const ulong FunctionDescriptors = 0xD0;
        public const ulong PropertyDescriptors = 0x40;
    }

    public static class ClickDetector
    {
        public const ulong MaxActivationDistance = 0xE8;
        public const ulong MouseIcon = 0xC8;
    }

    public static class Clothing
    {
        public const ulong Color3 = 0x120;
        public const ulong Template = 0x100;
    }

    public static class ColorCorrectionEffect
    {
        public const ulong Brightness = 0xC4;
        public const ulong Contrast = 0xC8;
        public const ulong Enabled = 0xB0;
        public const ulong TintColor = 0xB8;
    }

    public static class ColorGradingEffect
    {
        public const ulong Enabled = 0xB0;
        public const ulong TonemapperPreset = 0xB8;
    }

    public static class Creator
    {
        public const ulong MapEnd = 0x83403D8;
        public const ulong MapStart = 0x83403D0;
    }

    public static class DataModel
    {
        public const ulong CreatorId = 0x180;
        public const ulong GameId = 0x188;
        public const ulong GameLoaded = 0x5D0;
        public const ulong JobId = 0x118;
        public const ulong PlaceId = 0x190;
        public const ulong PlaceVersion = 0x1AC;
        public const ulong PrimitiveCount = 0x418;
        public const ulong ScriptContext = 0x440;
        public const ulong ServerIP = 0x5B8;
        public const ulong ToRenderView1 = 0x1C8;
        public const ulong ToRenderView2 = 0x8;
        public const ulong ToRenderView3 = 0x28;
        public const ulong Workspace = 0x158;
    }

    public static class DepthOfFieldEffect
    {
        public const ulong Enabled = 0xB0;
        public const ulong FarIntensity = 0xB8;
        public const ulong FocusDistance = 0xBC;
        public const ulong InFocusRadius = 0xC0;
        public const ulong NearIntensity = 0xC4;
    }

    public static class Descriptor
    {
        public const ulong Name = 0x8;
    }

    public static class DragDetector
    {
        public const ulong ActivatedCursorIcon = 0x1C0;
        public const ulong CursorIcon = 0xC8;
        public const ulong MaxActivationDistance = 0xE8;
        public const ulong MaxDragAngle = 0x2A8;
        public const ulong MaxDragTranslation = 0x26C;
        public const ulong MaxForce = 0x2AC;
        public const ulong MaxTorque = 0x2B0;
        public const ulong MinDragAngle = 0x2B4;
        public const ulong MinDragTranslation = 0x278;
        public const ulong ReferenceInstance = 0x1F0;
        public const ulong Responsiveness = 0x2C0;
    }

    public static class FakeDataModel
    {
        public const ulong Pointer = 0x8CA9CC8;
        public const ulong RealDataModel = 0x1F8;
    }

    public static class FileMeshData
    {
        public const ulong AabbMax = 0x2BC;
        public const ulong AabbMin = 0x2B0;
        public const ulong Faces = 0x30;
        public const ulong FacesEnd = 0x38;
        public const ulong Vertices = 0x0;
        public const ulong VerticesEnd = 0x8;
    }

    public static class Fire
    {
        public const ulong FireProximityPrompt = 0x309BD00;
    }

    public static class FunctionDescriptor
    {
        public const ulong Function = 0x80;
    }

    public static class Functions
    {
        public const ulong Clone = 0x1619170;
        public const ulong Destroy = 0x1619190;
        public const ulong FindPartOnRay = 0xEB3460;
        public const ulong FindPartOnRayWithIgnoreList = 0xEB34E0;
        public const ulong FindPartOnRayWithWhitelist = 0xEB3570;
        public const ulong FireServer = 0xC99010;
        public const ulong Print = 0x1C68FE0;
        public const ulong RaisePropertyChanged = 0x1C92510;
        public const ulong Raycast = 0xEAAA10;
        public const ulong SetParent = 0xEA4D6C;
        public const ulong SetParentInternal = 0x1CB1AD0;
        public const ulong Shapecast = 0xEAC3D0;
    }

    public static class GuiBase2D
    {
        public const ulong AbsolutePosition = 0x108;
        public const ulong AbsoluteRotation = 0xE8;
        public const ulong AbsoluteSize = 0x114;
    }

    public static class GuiObject
    {
        public const ulong Active = 0x5A8;
        public const ulong AnchorPoint = 0x558;
        public const ulong AutomaticSize = 0x560;
        public const ulong BackgroundColor3 = 0x540;
        public const ulong BackgroundTransparency = 0x564;
        public const ulong BorderColor3 = 0x54C;
        public const ulong BorderMode = 0x568;
        public const ulong BorderSizePixel = 0x56C;
        public const ulong ClipsDescendants = 0x5A9;
        public const ulong GuiState = 0x578;
        public const ulong Image = 0x988;
        public const ulong Interactable = 0x5AB;
        public const ulong LayoutOrder = 0x580;
        public const ulong Position = 0x510;
        public const ulong RichText = 0xB88;
        public const ulong Rotation = 0xE8;
        public const ulong ScreenGui_Enabled = 0x4C4;
        public const ulong Selectable = 0x5AC;
        public const ulong SelectionOrder = 0x59C;
        public const ulong Size = 0x530;
        public const ulong SizeConstraint = 0x5A0;
        public const ulong Text = 0xDF0;
        public const ulong TextColor3 = 0xEA0;
        public const ulong Visible = 0x5AD;
        public const ulong ZIndex = 0x5A4;
    }

    public static class Highlight
    {
        public const ulong Adornee = 0xB8;
        public const ulong DepthMode = 0xE0;
        public const ulong Enabled = 0xF4;
        public const ulong FillColor = 0xC8;
        public const ulong FillTransparency = 0xE4;
        public const ulong OutlineColor = 0xD4;
        public const ulong OutlineTransparency = 0xEC;
    }

    public static class HopperBin
    {
        public const ulong BinType = 0x468;
    }

    public static class Humanoid
    {
        public const ulong AutoJumpEnabled = 0x1D4;
        public const ulong AutoRotate = 0x1D5;
        public const ulong AutomaticScalingEnabled = 0x1D6;
        public const ulong BreakJointsOnDeath = 0x1D7;
        public const ulong CameraOffset = 0x128;
        public const ulong DisplayDistanceType = 0x180;
        public const ulong DisplayName = 0xB8;
        public const ulong EvaluateStateMachine = 0x1D8;
        public const ulong FloorMaterial = 0x184;
        public const ulong Health = 0x190;
        public const ulong HealthDisplayDistance = 0x188;
        public const ulong HealthDisplayType = 0x18C;
        public const ulong HipHeight = 0x194;
        public const ulong HumanoidRootPart = 0x478;
        public const ulong HumanoidState = 0x8C0;
        public const ulong HumanoidStateID = 0x20;
        public const ulong IsWalking = 0x967;
        public const ulong Jump = 0x1DA;
        public const ulong JumpHeight = 0x1A0;
        public const ulong JumpPower = 0x1A4;
        public const ulong MaxHealth = 0x1A8;
        public const ulong MaxSlopeAngle = 0x1AC;
        public const ulong MoveDirection = 0x140;
        public const ulong MoveToPart = 0x118;
        public const ulong NameDisplayDistance = 0x1B0;
        public const ulong NameOcclusion = 0x1B4;
        public const ulong PlatformStand = 0x1DC;
        public const ulong PlatformStatePointer = 0x0;
        public const ulong RequiresNeck = 0x1DD;
        public const ulong RigType = 0x1C0;
        public const ulong SeatPart = 0x108;
        public const ulong Sit = 0x1DE;
        public const ulong TargetPoint = 0x14C;
        public const ulong UseJumpPower = 0x1E0;
        public const ulong WalkSpeed = 0x1D0;
        public const ulong WalkSpeedCheck = 0x3BC;
        public const ulong WalkTimer = 0x408;
        public const ulong WalkToPoint = 0x164;
    }

    public static class ICreator
    {
        public const ulong Create = 0x0;
    }

    public static class InputObject
    {
        public const ulong MousePosition = 0xD4;
    }

    public static class Instance
    {
        public const ulong ChildrenEnd = 0x8;
        public const ulong ChildrenStart = 0x78;
        public const ulong ClassBase = 0x1B0;
        public const ulong ClassDescriptor = 0x18;
        public const ulong Name = 0x8;
        public const ulong NameContainer = 0x70;
        public const ulong Parent = 0x68;
    }

    public static class Lighting
    {
        public const ulong Ambient = 0xD0;
        public const ulong Atmosphere = 0x1D8;
        public const ulong Brightness = 0x118;
        public const ulong ClockTime = 0xC8;
        public const ulong ColorShift_Bottom = 0xDC;
        public const ulong ColorShift_Top = 0xE8;
        public const ulong EnvironmentDiffuseScale = 0x11C;
        public const ulong EnvironmentSpecularScale = 0x120;
        public const ulong ExposureCompensation = 0x124;
        public const ulong FogColor = 0xF4;
        public const ulong FogEnd = 0x12C;
        public const ulong FogStart = 0x130;
        public const ulong GeographicLatitude = 0x134;
        public const ulong GlobalShadows = 0x144;
        public const ulong GradientBottom = 0x190;
        public const ulong GradientTop = 0x150;
        public const ulong LightColor = 0x15C;
        public const ulong LightDirection = 0x168;
        public const ulong MoonPosition = 0x184;
        public const ulong OutdoorAmbient = 0x100;
        public const ulong ShadowSoftness = 0x13C;
        public const ulong Sky = 0x1C8;
        public const ulong Source = 0x174;
        public const ulong SunPosition = 0x178;
    }

    // these are in the lighting service
    public static class LightingParameters
    {
        public const ulong GeographicLatitude = 0x134;
        public const ulong LightColor = 0x15C;
        public const ulong LightDirection = 0x168;
        public const ulong SkyAmbient = 0x150;
        public const ulong SkyAmbient2 = 0x138;
        public const ulong Source = 0x174;
        public const ulong TrueMoonPosition = 0x184;
        public const ulong TrueSunPosition = 0x178;
    }

    public static class LocalScript
    {
        public const ulong ByteCode = 0x0;
        public const ulong Bytecode = 0x190;
        public const ulong Hash = 0xD0;
    }

    public static class LruHolder
    {
        public const ulong MemEnforcedLRUCache = 0x20;
    }

    public static class LruNode
    {
        public const ulong CachedItem = 0x40;
        public const ulong MeshId = 0x10;
        public const ulong Next = 0x0;
    }

    public static class MaterialColors
    {
        public const ulong Asphalt = 0x30;
        public const ulong Basalt = 0x27;
        public const ulong Brick = 0xF;
        public const ulong Cobblestone = 0x33;
        public const ulong Concrete = 0xC;
        public const ulong CrackedLava = 0x2D;
        public const ulong Glacier = 0x1B;
        public const ulong Grass = 0x6;
        public const ulong Ground = 0x2A;
        public const ulong Ice = 0x36;
        public const ulong LeafyGrass = 0x39;
        public const ulong Limestone = 0x3F;
        public const ulong Mud = 0x24;
        public const ulong Pavement = 0x42;
        public const ulong Rock = 0x18;
        public const ulong Salt = 0x3C;
        public const ulong Sand = 0x12;
        public const ulong Sandstone = 0x21;
        public const ulong Slate = 0x9;
        public const ulong Snow = 0x1E;
        public const ulong WoodPlanks = 0x15;
    }

    public static class MemEnforcedLRUCache
    {
        public const ulong Head = 0x8;
    }

    public static class MeshContentProvider
    {
        public const ulong LruHolder = 0xD8;
    }

    public static class MeshData
    {
        public const ulong FaceEnd = 0x38;
        public const ulong FaceStart = 0x30;
        public const ulong VertexEnd = 0x8;
        public const ulong VertexStart = 0x0;
    }

    public static class MeshPart
    {
        public const ulong MeshId = 0x310;
        public const ulong TextureId = 0x340;
    }

    public static class Misc
    {
        public const ulong Adornee = 0xF0;
        public const ulong AnimationId = 0xC0;
        public const ulong StringLength = 0x10;
        public const ulong Value = 0xB8;
    }

    public static class Model
    {
        public const ulong PrimaryPart = 0x258;
        public const ulong Scale = 0x144;
    }

    public static class ModuleScript
    {
        public const ulong ByteCode = 0x0;
        public const ulong Bytecode = 0x138;
        public const ulong Hash = 0xD0;
        public const ulong IsRobloxScript = 0x168;
    }

    public static class MouseService
    {
        public const ulong InputObject = 0x100;
        public const ulong MousePosition = 0xD4;
        public const ulong SensitivityPointer = 0x0;
    }

    public static class ParticleEmitter
    {
        public const ulong Acceleration = 0x1E0;
        public const ulong Brightness = 0x21C;
        public const ulong Drag = 0x220;
        public const ulong Lifetime = 0x1F4;
        public const ulong LightEmission = 0x238;
        public const ulong LightInfluence = 0x23C;
        public const ulong Rate = 0x248;
        public const ulong RotSpeed = 0x1FC;
        public const ulong Rotation = 0x204;
        public const ulong Speed = 0x20C;
        public const ulong SpreadAngle = 0x214;
        public const ulong Texture = 0x1C0;
        public const ulong TimeScale = 0x25C;
        public const ulong VelocityInheritance = 0x260;
        public const ulong ZOffset = 0x264;
    }

    public static class Player
    {
        public const ulong AccountAge = 0x35C;
        public const ulong CameraMode = 0x370;
        public const ulong Character = 0x298;
        public const ulong DisplayName = 0x138;
        public const ulong HealthDisplayDistance = 0x394;
        public const ulong LocalPlayer = 0x130;
        public const ulong LocaleId = 0x748;
        public const ulong MaxZoomDistance = 0x368;
        public const ulong MinZoomDistance = 0x36C;
        public const ulong Mouse = 0x1208;
        public const ulong NameDisplayDistance = 0x3A4;
        public const ulong Team = 0x2D8;
        public const ulong TeamColor = 0x3B0;
        public const ulong UserId = 0xD0;
    }

    public static class PlayerConfigurer
    {
        public const ulong Pointer = 0x0;
    }

    public static class PlayerMouse
    {
        public const ulong Icon = 0xC8;
        public const ulong Workspace = 0x150;
    }

    public static class Players
    {
        public const ulong LocalPlayer = 0x130;
    }

    public static class Primitive
    {
        public const ulong AssemblyAngularVelocity = 0x104;
        public const ulong AssemblyLinearVelocity = 0xF8;
        public const ulong CFrame = 0xC8;
        public const ulong Material = 0x246;
        public const ulong Orientation = 0xC8;
        public const ulong Part = 0x210;
        public const ulong Position = 0xEC;
        public const ulong PrimitiveFlags = 0x1B6;
        public const ulong Rotation = 0xC8;
        public const ulong Size = 0x1BC;
        public const ulong Validate = 0x6;
    }

    public static class PrimitiveFlags
    {
        public const ulong Anchored = 0x2;
        public const ulong CanCollide = 0x8;
        public const ulong CanQuery = 0x20;
        public const ulong CanTouch = 0x10;
    }

    public static class PropertyDescriptor
    {
        public const ulong GetSetImpl = 0x90;
        public const ulong TType = 0x68;
    }

    public static class ProximityPrompt
    {
        public const ulong ActionText = 0xB0;
        public const ulong Enabled = 0x136;
        public const ulong GamepadKeyCode = 0x11C;
        public const ulong HoldDuration = 0x120;
        public const ulong KeyboardKeyCode = 0x124;
        public const ulong MaxActivationDistance = 0x128;
        public const ulong ObjectText = 0xD0;
        public const ulong RequiresLineOfSight = 0x137;
    }

    public static class RenderJob
    {
        public const ulong FakeDataModel = 0x38;
        public const ulong RealDataModel = 0x1F0;
        public const ulong RenderView = 0x1D8;
    }

    public static class RenderView
    {
        public const ulong DeviceD3D11 = 0x8;
        public const ulong LightingValid = 0x228;
        public const ulong SkyboxValid = 0x28D;
        public const ulong VisualEngine = 0x10;
    }

    public static class RunService
    {
        public const ulong HeartbeatFPS = 0xF4;
        public const ulong HeartbeatTask = 0x3B8;
    }

    public static class Script
    {
        public const ulong ByteCode = 0x0;
        public const ulong GUID = 0xD0;
        public const ulong Hash = 0x1A0;
    }

    public static class ScriptContext
    {
        public const ulong RequireBypass = 0xA00;
    }

    public static class Seat
    {
        public const ulong Occupant = 0x210;
    }

    public static class Sky
    {
        public const ulong MoonAngularSize = 0x244;
        public const ulong MoonTextureId = 0xC8;
        public const ulong SkyboxBk = 0xF8;
        public const ulong SkyboxDn = 0x128;
        public const ulong SkyboxFt = 0x158;
        public const ulong SkyboxLf = 0x188;
        public const ulong SkyboxOrientation = 0x238;
        public const ulong SkyboxRt = 0x1B8;
        public const ulong SkyboxUp = 0x1E8;
        public const ulong StarCount = 0x248;
        public const ulong SunAngularSize = 0x24C;
        public const ulong SunTextureId = 0x218;
    }

    public static class Sound
    {
        public const ulong IsPlaying = 0x140;
        public const ulong Looped = 0x13D;
        public const ulong PlaybackSpeed = 0x11C;
        public const ulong RollOffMaxDistance = 0x120;
        public const ulong RollOffMinDistance = 0x124;
        public const ulong SoundGroup = 0xE8;
        public const ulong SoundId = 0xC8;
        public const ulong Volume = 0x130;
    }

    public static class SpawnLocation
    {
        public const ulong AllowTeamChangeOnTouch = 0x1E8;
        public const ulong Enabled = 0x1E9;
        public const ulong ForcefieldDuration = 0x1E0;
        public const ulong Neutral = 0x1EA;
        public const ulong TeamColor = 0x1E4;
    }

    public static class SpecialMesh
    {
        public const ulong MeshId = 0xF8;
        public const ulong Offset = 0xB8;
        public const ulong Scale = 0xC4;
        public const ulong TextureId = 0x128;
    }

    public static class StatsItem
    {
        public const ulong Value = 0xC8;
    }

    public static class SunRaysEffect
    {
        public const ulong Enabled = 0xB0;
        public const ulong Intensity = 0xB8;
        public const ulong Spread = 0xBC;
    }

    public static class SurfaceAppearance
    {
        public const ulong AlphaMode = 0x1F0;
        public const ulong Color = 0x1D8;
        public const ulong ColorMap = 0xC8;
        public const ulong EmissiveMaskContent = 0xF8;
        public const ulong EmissiveStrength = 0x1F4;
        public const ulong EmissiveTint = 0x1E4;
        public const ulong MetalnessMap = 0x128;
        public const ulong NormalMap = 0x158;
        public const ulong RoughnessMap = 0x188;
    }

    public static class TaskScheduler
    {
        public const ulong JobEnd = 0xD0;
        public const ulong JobName = 0x18;
        public const ulong JobStart = 0xC8;
        public const ulong MaxFPS = 0xB0;
        public const ulong Pointer = 0x8A44D68;
    }

    public static class Team
    {
        public const ulong TeamColor = 0xB8;
    }

    public static class Terrain
    {
        public const ulong GrassLength = 0x1E8;
        public const ulong MaterialColors = 0x4B0;
        public const ulong WaterColor = 0x1D8;
        public const ulong WaterReflectance = 0x1F0;
        public const ulong WaterTransparency = 0x1F4;
        public const ulong WaterWaveSize = 0x1F8;
        public const ulong WaterWaveSpeed = 0x1FC;
    }

    public static class TextButton
    {
        public const ulong AutoButtonColor = 0x9C4;
        public const ulong ContentText = 0xE08;
        public const ulong LineHeight = 0xF20;
        public const ulong LocalizedText = 0xE08;
        public const ulong MaxVisibleGraphemes = 0x113C;
        public const ulong Modal = 0x9C5;
        public const ulong RichText = 0x1018;
        public const ulong Selected = 0x9C6;
        public const ulong Text = 0xE08;
        public const ulong TextColor3 = 0x1120;
        public const ulong TextDirection = 0xFC0;
        public const ulong TextScaled = 0xDF1;
        public const ulong TextSize = 0x1144;
        public const ulong TextStrokeColor3 = 0x112C;
        public const ulong TextStrokeTransparency = 0x1148;
        public const ulong TextTransparency = 0x114C;
        public const ulong TextTruncate = 0x1150;
        public const ulong TextWrapped = 0x1018;
        public const ulong TextXAlignment = 0x1154;
        public const ulong TextYAlignment = 0xF68;
    }

    public static class TextLabel
    {
        public const ulong ContentText = 0xB88;
        public const ulong LineHeight = 0xCA0;
        public const ulong LocalizedText = 0xB88;
        public const ulong MaxVisibleGraphemes = 0xEBC;
        public const ulong RichText = 0xD9E;
        public const ulong Text = 0xB88;
        public const ulong TextColor3 = 0xEA0;
        public const ulong TextDirection = 0xD40;
        public const ulong TextScaled = 0xB71;
        public const ulong TextSize = 0xEC4;
        public const ulong TextStrokeColor3 = 0xEAC;
        public const ulong TextStrokeTransparency = 0xEC8;
        public const ulong TextTransparency = 0xECC;
        public const ulong TextTruncate = 0xED0;
        public const ulong TextWrapped = 0xD98;
        public const ulong TextXAlignment = 0xED4;
        public const ulong TextYAlignment = 0xCE8;
    }

    public static class Textures
    {
        public const ulong Decal_Texture = 0x1B0;
    }

    public static class Tool
    {
        public const ulong CanBeDropped = 0x4B8;
        public const ulong Enabled = 0x4B9;
        public const ulong Grip = 0x488;
        public const ulong GripForward = 0x4A0;
        public const ulong GripPos = 0x4AC;
        public const ulong GripRight = 0x488;
        public const ulong GripUp = 0x494;
        public const ulong ManualActivationOnly = 0x4BA;
        public const ulong RequiresHandle = 0x4BB;
        public const ulong TextureId = 0x360;
        public const ulong Tooltip = 0x468;
    }

    public static class Types
    {
        public const ulong AllTypes = 0x8836AD8;
    }

    public static class UnionOperation
    {
        public const ulong AssetId = 0x310;
    }

    public static class UserInputService
    {
        public const ulong WindowInputState = 0x2C0;
    }

    public static class Value
    {
        public const ulong Value = 0xB8;
    }

    public static class VehicleSeat
    {
        public const ulong MaxSpeed = 0x228;
        public const ulong Occupant = 0x208;
        public const ulong SteerFloat = 0x22C;
        public const ulong ThrottleFloat = 0x230;
        public const ulong Torque = 0x234;
        public const ulong TurnSpeed = 0x238;
    }

    public static class VisualEngine
    {
        public const ulong Dimensions = 0xAE0;
        public const ulong FakeDataModel = 0xAC0;
        public const ulong Pointer = 0x82E2128;
        public const ulong RenderView = 0xC00;
        public const ulong ViewMatrix = 0x180;
    }

    public static class Weld
    {
        public const ulong Part0 = 0x118;
        public const ulong Part1 = 0x128;
    }

    public static class WeldConstraint
    {
        public const ulong Part0 = 0xB8;
        public const ulong Part1 = 0xC8;
    }

    public static class WindowInputState
    {
        public const ulong CapsLock = 0x40;
        public const ulong CurrentTextBox = 0x48;
    }

    public static class Workspace
    {
        public const ulong CurrentCamera = 0x498;
        public const ulong DistributedGameTime = 0x4B8;
        public const ulong ReadOnlyGravity = 0x9C8;
        public const ulong World = 0x3F0;
    }

    public static class World
    {
        public const ulong AirProperties = 0x238;
        public const ulong FallenPartsDestroyHeight = 0x0;
        public const ulong Gravity = 0x228;
        public const ulong Primitives = 0x2A8;
        public const ulong WorldSteps = 0x720;
    }

    public enum ReflectionType
    {
        Null = 0x0,
        Bool = 0x1,
        Int = 0x2,
        Int64 = 0x3,
        Float = 0x4,
        Double = 0x5,
        String = 0x6,
        ProtectedString = 0x7,
        Instance = 0x8,
        Instances = 0x9,
        Ray = 0xA,
        Vector2 = 0xB,
        Vector3 = 0xC,
        Vector2int16 = 0xD,
        Vector3int16 = 0xE,
        Rect2D = 0xF,
        CoordinateFrame = 0x10,
        Color3 = 0x11,
        Color3uint8 = 0x12,
        UDim = 0x13,
        UDim2 = 0x14,
        Faces = 0x15,
        Axes = 0x16,
        Region3 = 0x17,
        Region3int16 = 0x18,
        CellId = 0x19,
        GuidData = 0x1A,
        PhysicalProperties = 0x1B,
        BrickColor = 0x1C,
        SystemAddress = 0x1D,
        BinaryString = 0x1E,
        Surface = 0x1F,
        CollectionHandle = 0x20,
        Enum = 0x21,
        Property = 0x22,
        Tuple = 0x23,
        Array = 0x24,
        Dictionary = 0x25,
        Map = 0x26,
        Variant = 0x27,
        GenericFunction = 0x28,
        Function = 0x29,
        ColorSequence = 0x2A,
        ColorSequenceKeypoint = 0x2B,
        NumberRange = 0x2C,
        NumberSequence = 0x2D,
        NumberSequenceKeypoint = 0x2E,
        Connection = 0x30,
        ContentId = 0x31,
        DescribedBase = 0x32,
        RefType = 0x33,
        EventInstance = 0x36,
        TweenInfo = 0x37,
        DockWidgetPluginGuiInfo = 0x38,
        PluginDrag = 0x39,
        Random = 0x3A,
        PathWaypoint = 0x3B,
        FloatCurveKey = 0x3C,
        RotationCurveKey = 0x3D,
        ValueCurveKey = 0x3E,
        SharedString = 0x3F,
        DateTime = 0x40,
        RaycastParams = 0x41,
        RaycastResult = 0x42,
        OverlapParams = 0x43,
        LazyTable = 0x44,
        DebugTable = 0x45,
        CatalogSearchParams = 0x46,
        OptionalCoordinateFrame = 0x47,
        CSGPropertyData = 0x48,
        UniqueId = 0x49,
        Font = 0x4A,
        SharedTable = 0x4B,
        SharedTableIterator = 0x4C,
        AnimationMask = 0x4D,
        AnimationPose = 0x4E,
        ClipEvaluator = 0x4F,
        OpenCloudModel = 0x50,
        InstanceRef = 0x51,
        SecurityCapabilities = 0x52,
        ArticulatedJoint = 0x53,
        AnimationContext = 0x54,
        Secret = 0x55,
        Buffer = 0x56,
        Integer = 0x57,
        Path2DControlPoint = 0x58,
        ReplicationPV = 0x59,
        FacsReplicationData = 0x5A,
        AnimationMaskModifier = 0x5B,
        Content = 0x5C,
        NetAssetHandle = 0x5D,
        NetAssetRef = 0x5E,
        Object = 0x5F,
        AdReward = 0x60,
        AssetContentMap = 0x61,
        SlimReplicationData = 0x62,
        User = 0x63,
        WebViewParams = 0x64,
        AnimTrackPlayState = 0x65,
        AnimTrackMetadata = 0x66,
        AnimTrackWeight = 0x67,
        ScopedInstanceIdentity = 0x68,
    }

} // namespace RobloxOffsets
