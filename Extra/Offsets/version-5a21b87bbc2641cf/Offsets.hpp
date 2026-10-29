/*
 * Github: https://git.jonah.cool/jonah/roblox-dumper
 * Roblox Version: version-5a21b87bbc2641cf
 * Time Taken: 8905 ms (8.905000 seconds)
 * Total Offsets: 496
 */

#pragma once
#include <cstdint>

// clang-format off
namespace offsets {
    inline constexpr const char* roblox_version = "version-5a21b87bbc2641cf";

    namespace AirProperties {
        inline constexpr uintptr_t AirDensity = 0x18;
        inline constexpr uintptr_t GlobalWind = 0x3C;
    }

    namespace AnimationTrack {
        inline constexpr uintptr_t Animation = 0xA0;
        inline constexpr uintptr_t Animator = 0xF8;
        inline constexpr uintptr_t IsPlaying = 0xA10;
        inline constexpr uintptr_t Looped = 0xCD;
        inline constexpr uintptr_t Speed = 0xBC;
        inline constexpr uintptr_t TimePosition = 0xC0;
    }

    namespace Animator {
        inline constexpr uintptr_t ActiveAnimations = 0x900;
    }

    namespace Atmosphere {
        inline constexpr uintptr_t Color = 0xA0;
        inline constexpr uintptr_t Decay = 0xAC;
        inline constexpr uintptr_t Density = 0xB8;
        inline constexpr uintptr_t Glare = 0xBC;
        inline constexpr uintptr_t Haze = 0xC0;
        inline constexpr uintptr_t Offset = 0xC4;
    }

    namespace Attachment {
        inline constexpr uintptr_t Position = 0xAC;
    }

    namespace BasePart {
        inline constexpr uintptr_t CastShadow = 0x120;
        inline constexpr uintptr_t Color3 = 0x11C;
        inline constexpr uintptr_t Locked = 0x121;
        inline constexpr uintptr_t Massless = 0x122;
        inline constexpr uintptr_t Primitive = 0x178;
        inline constexpr uintptr_t Reflectance = 0xF4;
        inline constexpr uintptr_t Shape = 0x1A0;
        inline constexpr uintptr_t Transparency = 0x118;
    }

    namespace Beam {
        inline constexpr uintptr_t Attachment0 = 0x148;
        inline constexpr uintptr_t Attachment1 = 0x158;
        inline constexpr uintptr_t Brightness = 0x168;
        inline constexpr uintptr_t CurveSize0 = 0x16C;
        inline constexpr uintptr_t CurveSize1 = 0x170;
        inline constexpr uintptr_t LightEmission = 0x174;
        inline constexpr uintptr_t LightInfluence = 0x178;
        inline constexpr uintptr_t Texture = 0x128;
        inline constexpr uintptr_t TextureLength = 0x184;
        inline constexpr uintptr_t TextureSpeed = 0x18C;
        inline constexpr uintptr_t Width0 = 0x190;
        inline constexpr uintptr_t Width1 = 0x194;
        inline constexpr uintptr_t ZOffset = 0x198;
    }

    namespace BloomEffect {
        inline constexpr uintptr_t Enabled = 0x98;
        inline constexpr uintptr_t Intensity = 0xA0;
        inline constexpr uintptr_t Size = 0xA4;
        inline constexpr uintptr_t Threshold = 0xA8;
    }

    namespace BlurEffect {
        inline constexpr uintptr_t Enabled = 0x98;
        inline constexpr uintptr_t Size = 0xA0;
    }

    namespace ByteCode {
        inline constexpr uintptr_t Pointer = 0x10;
        inline constexpr uintptr_t Size = 0x28;
    }

    namespace CachedItem {
        inline constexpr uintptr_t FileMeshData = 0x28;
    }

    namespace Camera {
        inline constexpr uintptr_t CFrame = 0xC0;
        inline constexpr uintptr_t CameraSubject = 0xB0;
        inline constexpr uintptr_t CameraType = 0x120;
        inline constexpr uintptr_t FieldOfView = 0x128;
        inline constexpr uintptr_t ImagePlaneDepth = 0x2D4;
        inline constexpr uintptr_t Position = 0xE4;
        inline constexpr uintptr_t Rotation = 0xC0;
        inline constexpr uintptr_t ViewportInt16 = 0x284;
        inline constexpr uintptr_t ViewportSize = 0x2C4;
    }

    namespace CharacterMesh {
        inline constexpr uintptr_t BaseTextureId = 0xB0;
        inline constexpr uintptr_t BodyPart = 0x130;
        inline constexpr uintptr_t MeshId = 0xE0;
        inline constexpr uintptr_t OverlayTextureId = 0x110;
    }

    namespace ClassDescriptor {
        inline constexpr uintptr_t ClassName = 0x8;
        inline constexpr uintptr_t Creator = 0x238; // ICreator vtable, [0] = create fn
        inline constexpr uintptr_t EventDescriptors = 0x88;
        inline constexpr uintptr_t FunctionDescriptors = 0xD0;
        inline constexpr uintptr_t PropertyDescriptors = 0x40;
    }

    namespace ClickDetector {
        inline constexpr uintptr_t MaxActivationDistance = 0xD0;
        inline constexpr uintptr_t MouseIcon = 0xB0;
    }

    namespace Clothing {
        inline constexpr uintptr_t Color3 = 0x108;
        inline constexpr uintptr_t Template = 0xE8;
    }

    namespace ColorCorrectionEffect {
        inline constexpr uintptr_t Brightness = 0xAC;
        inline constexpr uintptr_t Contrast = 0xB0;
        inline constexpr uintptr_t Enabled = 0x98;
        inline constexpr uintptr_t TintColor = 0xA0;
    }

    namespace ColorGradingEffect {
        inline constexpr uintptr_t Enabled = 0x98;
        inline constexpr uintptr_t TonemapperPreset = 0xA0;
    }

    namespace Creator {
        inline constexpr uintptr_t MapEnd = 0x8522B00;
        inline constexpr uintptr_t MapStart = 0x8522AF8;
    }

    namespace DataModel {
        inline constexpr uintptr_t CreatorId = 0x170;
        inline constexpr uintptr_t GameId = 0x178;
        inline constexpr uintptr_t GameLoaded = 0x588;
        inline constexpr uintptr_t JobId = 0x108;
        inline constexpr uintptr_t PlaceId = 0x180;
        inline constexpr uintptr_t PlaceVersion = 0x19C;
        inline constexpr uintptr_t PrimitiveCount = 0x410;
        inline constexpr uintptr_t ScriptContext = 0x440;
        inline constexpr uintptr_t ServerIP = 0x570;
        inline constexpr uintptr_t ToRenderView1 = 0x1B8;
        inline constexpr uintptr_t ToRenderView2 = 0x8;
        inline constexpr uintptr_t ToRenderView3 = 0x28;
        inline constexpr uintptr_t Workspace = 0x148;
    }

    namespace DepthOfFieldEffect {
        inline constexpr uintptr_t Enabled = 0x98;
        inline constexpr uintptr_t FarIntensity = 0xA0;
        inline constexpr uintptr_t FocusDistance = 0xA4;
        inline constexpr uintptr_t InFocusRadius = 0xA8;
        inline constexpr uintptr_t NearIntensity = 0xAC;
    }

    namespace Descriptor {
        inline constexpr uintptr_t Name = 0x8;
    }

    namespace DragDetector {
        inline constexpr uintptr_t ActivatedCursorIcon = 0x188;
        inline constexpr uintptr_t CursorIcon = 0xB0;
        inline constexpr uintptr_t MaxActivationDistance = 0xD0;
        inline constexpr uintptr_t MaxDragAngle = 0x270;
        inline constexpr uintptr_t MaxDragTranslation = 0x234;
        inline constexpr uintptr_t MaxForce = 0x274;
        inline constexpr uintptr_t MaxTorque = 0x278;
        inline constexpr uintptr_t MinDragAngle = 0x27C;
        inline constexpr uintptr_t MinDragTranslation = 0x240;
        inline constexpr uintptr_t ReferenceInstance = 0x1B8;
        inline constexpr uintptr_t Responsiveness = 0x288;
    }

    namespace FakeDataModel {
        inline constexpr uintptr_t Pointer = 0x8D06600;
        inline constexpr uintptr_t RealDataModel = 0x1F8;
    }

    namespace FileMeshData {
        inline constexpr uintptr_t AabbMax = 0x18C;
        inline constexpr uintptr_t AabbMin = 0x180;
        inline constexpr uintptr_t Faces = 0x30;
        inline constexpr uintptr_t FacesEnd = 0x38;
        inline constexpr uintptr_t Vertices = 0x0;
        inline constexpr uintptr_t VerticesEnd = 0x8;
    }

    namespace Fire {
        inline constexpr uintptr_t FireProximityPrompt = 0x30A8980;
    }

    namespace FunctionDescriptor {
        inline constexpr uintptr_t Function = 0x80;
    }

    namespace Functions {
        inline constexpr uintptr_t FindPartOnRay = 0xFFFF8229681BA050; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t FindPartOnRayWithIgnoreList = 0xFFFF8229681BA3D0; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t FindPartOnRayWithWhitelist = 0xFFFF8229684021F0; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t FireServer = 0xFFFF8229683B24F0; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t Print = 0x1C50690;
        inline constexpr uintptr_t RaisePropertyChanged = 0xDD3510;
        inline constexpr uintptr_t Raycast = 0xFFFF822968402C70; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t SetParent = 0xCE4CE0;
        inline constexpr uintptr_t SetParentInternal = 0x1C9F520;
        inline constexpr uintptr_t Shapecast = 0xFFFF8229682E8D20; // better to resolve at runtime via func descriptors
    }

    namespace GuiBase2D {
        inline constexpr uintptr_t AbsolutePosition = 0xF0;
        inline constexpr uintptr_t AbsoluteRotation = 0xD0;
        inline constexpr uintptr_t AbsoluteSize = 0xFC;
    }

    namespace GuiObject {
        inline constexpr uintptr_t Active = 0x570;
        inline constexpr uintptr_t AnchorPoint = 0x520;
        inline constexpr uintptr_t AutomaticSize = 0x528;
        inline constexpr uintptr_t BackgroundColor3 = 0x508;
        inline constexpr uintptr_t BackgroundTransparency = 0x52C;
        inline constexpr uintptr_t BorderColor3 = 0x514;
        inline constexpr uintptr_t BorderMode = 0x530;
        inline constexpr uintptr_t BorderSizePixel = 0x534;
        inline constexpr uintptr_t ClipsDescendants = 0x571;
        inline constexpr uintptr_t GuiState = 0x540;
        inline constexpr uintptr_t Image = 0x9A8;
        inline constexpr uintptr_t Interactable = 0x573;
        inline constexpr uintptr_t LayoutOrder = 0x544;
        inline constexpr uintptr_t Position = 0x4D8;
        inline constexpr uintptr_t RichText = 0xBA0;
        inline constexpr uintptr_t Rotation = 0xD0;
        inline constexpr uintptr_t ScreenGui_Enabled = 0x48C;
        inline constexpr uintptr_t Selectable = 0x574;
        inline constexpr uintptr_t SelectionOrder = 0x560;
        inline constexpr uintptr_t Size = 0x4F8;
        inline constexpr uintptr_t SizeConstraint = 0x568;
        inline constexpr uintptr_t Text = 0xE08;
        inline constexpr uintptr_t TextColor3 = 0xEB8;
        inline constexpr uintptr_t Visible = 0x575;
        inline constexpr uintptr_t ZIndex = 0x56C;
    }

    namespace Highlight {
        inline constexpr uintptr_t Adornee = 0xA0;
        inline constexpr uintptr_t DepthMode = 0xC8;
        inline constexpr uintptr_t Enabled = 0xDC;
        inline constexpr uintptr_t FillColor = 0xB0;
        inline constexpr uintptr_t FillTransparency = 0xCC;
        inline constexpr uintptr_t OutlineColor = 0xBC;
        inline constexpr uintptr_t OutlineTransparency = 0xD4;
    }

    namespace HopperBin {
        inline constexpr uintptr_t BinType = 0x450;
    }

    namespace Humanoid {
        inline constexpr uintptr_t AutoJumpEnabled = 0x1C8;
        inline constexpr uintptr_t AutoRotate = 0x1C9;
        inline constexpr uintptr_t AutomaticScalingEnabled = 0x1CA;
        inline constexpr uintptr_t BreakJointsOnDeath = 0x1CC;
        inline constexpr uintptr_t CameraOffset = 0x110;
        inline constexpr uintptr_t DisplayDistanceType = 0x174;
        inline constexpr uintptr_t DisplayName = 0xA0;
        inline constexpr uintptr_t EvaluateStateMachine = 0x1CD;
        inline constexpr uintptr_t FloorMaterial = 0x178;
        inline constexpr uintptr_t Health = 0x184;
        inline constexpr uintptr_t HealthDisplayDistance = 0x17C;
        inline constexpr uintptr_t HealthDisplayType = 0x180;
        inline constexpr uintptr_t HipHeight = 0x188;
        inline constexpr uintptr_t HumanoidRootPart = 0x460;
        inline constexpr uintptr_t HumanoidState = 0x8A8;
        inline constexpr uintptr_t HumanoidStateID = 0x20;
        inline constexpr uintptr_t IsWalking = 0xA2E;
        inline constexpr uintptr_t Jump = 0x1D0;
        inline constexpr uintptr_t JumpHeight = 0x194;
        inline constexpr uintptr_t JumpPower = 0x198;
        inline constexpr uintptr_t MaxHealth = 0x19C;
        inline constexpr uintptr_t MaxSlopeAngle = 0x1A0;
        inline constexpr uintptr_t MoveDirection = 0x134;
        inline constexpr uintptr_t MoveToPart = 0x100;
        inline constexpr uintptr_t NameDisplayDistance = 0x1A4;
        inline constexpr uintptr_t NameOcclusion = 0x1A8;
        inline constexpr uintptr_t PlatformStand = 0x1D2;
        inline constexpr uintptr_t PlatformStatePointer = 0x0;
        inline constexpr uintptr_t RequiresNeck = 0x1D3;
        inline constexpr uintptr_t RigType = 0x1B4;
        inline constexpr uintptr_t SeatPart = 0xF0;
        inline constexpr uintptr_t Sit = 0x1D4;
        inline constexpr uintptr_t TargetPoint = 0x140;
        inline constexpr uintptr_t UseJumpPower = 0x1D6;
        inline constexpr uintptr_t WalkSpeed = 0x1C4;
        inline constexpr uintptr_t WalkSpeedCheck = 0x39C;
        inline constexpr uintptr_t WalkToPoint = 0x158;
    }

    namespace ICreator {
        inline constexpr uintptr_t Create = 0x0;
    }

    namespace InputObject {
        inline constexpr uintptr_t MousePosition = 0xD4;
    }

    namespace Instance {
        inline constexpr uintptr_t ChildrenEnd = 0x8;
        inline constexpr uintptr_t ChildrenStart = 0x70;
        inline constexpr uintptr_t ClassBase = 0x1B0;
        inline constexpr uintptr_t ClassDescriptor = 0x18;
        inline constexpr uintptr_t Name = 0x0;
        inline constexpr uintptr_t NameContainer = 0x68;
        inline constexpr uintptr_t Parent = 0x60;
    }

    namespace LRUHolder {
        inline constexpr uintptr_t MemEnforcedLRUCache = 0x20;
    }

    namespace LRUNode {
        inline constexpr uintptr_t AssetID = 0x10;
        inline constexpr uintptr_t CachedItem = 0x40;
        inline constexpr uintptr_t Next = 0x0;
    }

    namespace Lighting {
        inline constexpr uintptr_t Ambient = 0xB8;
        inline constexpr uintptr_t Atmosphere = 0x1C0;
        inline constexpr uintptr_t Brightness = 0x100;
        inline constexpr uintptr_t ClockTime = 0xB0;
        inline constexpr uintptr_t ColorShift_Bottom = 0xC4;
        inline constexpr uintptr_t ColorShift_Top = 0xD0;
        inline constexpr uintptr_t EnvironmentDiffuseScale = 0x104;
        inline constexpr uintptr_t EnvironmentSpecularScale = 0x108;
        inline constexpr uintptr_t ExposureCompensation = 0x10C;
        inline constexpr uintptr_t FogColor = 0xDC;
        inline constexpr uintptr_t FogEnd = 0x114;
        inline constexpr uintptr_t FogStart = 0x118;
        inline constexpr uintptr_t GeographicLatitude = 0x11C;
        inline constexpr uintptr_t GlobalShadows = 0x12C;
        inline constexpr uintptr_t GradientBottom = 0x178;
        inline constexpr uintptr_t GradientTop = 0x138;
        inline constexpr uintptr_t LightColor = 0x144;
        inline constexpr uintptr_t LightDirection = 0x150;
        inline constexpr uintptr_t MoonPosition = 0x16C;
        inline constexpr uintptr_t OutdoorAmbient = 0xE8;
        inline constexpr uintptr_t ShadowSoftness = 0x124;
        inline constexpr uintptr_t Sky = 0x1B0;
        inline constexpr uintptr_t Source = 0x15C;
        inline constexpr uintptr_t SunPosition = 0x160;
    }

    namespace LightingParameters { // these are in the lighting service
        inline constexpr uintptr_t GeographicLatitude = 0x11C;
        inline constexpr uintptr_t LightColor = 0x144;
        inline constexpr uintptr_t LightDirection = 0x150;
        inline constexpr uintptr_t SkyAmbient = 0x138;
        inline constexpr uintptr_t SkyAmbient2 = 0x120;
        inline constexpr uintptr_t Source = 0x15C;
        inline constexpr uintptr_t TrueMoonPosition = 0x16C;
        inline constexpr uintptr_t TrueSunPosition = 0x160;
    }

    namespace LocalScript {
        inline constexpr uintptr_t ByteCode = 0x0;
        inline constexpr uintptr_t GUID = 0xB8;
        inline constexpr uintptr_t Hash = 0x188;
    }

    namespace LruHolder {
        inline constexpr uintptr_t MemEnforcedLRUCache = 0x20;
    }

    namespace LruNode {
        inline constexpr uintptr_t CachedItem = 0x38;
        inline constexpr uintptr_t MeshId = 0x10;
        inline constexpr uintptr_t Next = 0x0;
    }

    namespace MaterialColors {
        inline constexpr uintptr_t Asphalt = 0x90;
        inline constexpr uintptr_t Basalt = 0x87;
        inline constexpr uintptr_t Brick = 0x6F;
        inline constexpr uintptr_t Cobblestone = 0x93;
        inline constexpr uintptr_t Concrete = 0x6C;
        inline constexpr uintptr_t CrackedLava = 0x8D;
        inline constexpr uintptr_t Glacier = 0x7B;
        inline constexpr uintptr_t Grass = 0x66;
        inline constexpr uintptr_t Ground = 0x8A;
        inline constexpr uintptr_t Ice = 0x96;
        inline constexpr uintptr_t LeafyGrass = 0x99;
        inline constexpr uintptr_t Limestone = 0x9F;
        inline constexpr uintptr_t Mud = 0x84;
        inline constexpr uintptr_t Pavement = 0xA2;
        inline constexpr uintptr_t Rock = 0x78;
        inline constexpr uintptr_t Salt = 0x9C;
        inline constexpr uintptr_t Sand = 0x72;
        inline constexpr uintptr_t Sandstone = 0x81;
        inline constexpr uintptr_t Slate = 0x69;
        inline constexpr uintptr_t Snow = 0x7E;
        inline constexpr uintptr_t WoodPlanks = 0x75;
    }

    namespace MemEnforcedLRUCache {
        inline constexpr uintptr_t Head = 0x8;
    }

    namespace MeshContentProvider {
        inline constexpr uintptr_t LruHolder = 0xC0;
    }

    namespace MeshPart {
        inline constexpr uintptr_t MeshId = 0x2F8;
        inline constexpr uintptr_t TextureId = 0x328;
    }

    namespace Misc {
        inline constexpr uintptr_t Adornee = 0xD8;
        inline constexpr uintptr_t AnimationId = 0xA8;
        inline constexpr uintptr_t StringLength = 0x10;
        inline constexpr uintptr_t Value = 0xA0;
    }

    namespace Model {
        inline constexpr uintptr_t PrimaryPart = 0x240;
        inline constexpr uintptr_t Scale = 0x12C;
    }

    namespace ModuleScript {
        inline constexpr uintptr_t ByteCode = 0x0;
        inline constexpr uintptr_t GUID = 0xB8;
        inline constexpr uintptr_t Hash = 0x348;
        inline constexpr uintptr_t IsRobloxScript = 0x150;
    }

    namespace MouseService {
        inline constexpr uintptr_t InputObject = 0xE8;
        inline constexpr uintptr_t InputObject2 = 0xF8;
        inline constexpr uintptr_t MousePosition = 0xBC;
        inline constexpr uintptr_t SensitivityPointer = 0x0;
    }

    namespace ParticleEmitter {
        inline constexpr uintptr_t Acceleration = 0x1C8;
        inline constexpr uintptr_t Brightness = 0x204;
        inline constexpr uintptr_t Drag = 0x208;
        inline constexpr uintptr_t Lifetime = 0x1DC;
        inline constexpr uintptr_t LightEmission = 0x220;
        inline constexpr uintptr_t LightInfluence = 0x224;
        inline constexpr uintptr_t Rate = 0x230;
        inline constexpr uintptr_t RotSpeed = 0x1E4;
        inline constexpr uintptr_t Rotation = 0x1EC;
        inline constexpr uintptr_t Speed = 0x1F4;
        inline constexpr uintptr_t SpreadAngle = 0x1FC;
        inline constexpr uintptr_t Texture = 0x1A8;
        inline constexpr uintptr_t TimeScale = 0x244;
        inline constexpr uintptr_t VelocityInheritance = 0x248;
        inline constexpr uintptr_t ZOffset = 0x24C;
    }

    namespace Player {
        inline constexpr uintptr_t AccountAge = 0x364;
        inline constexpr uintptr_t CameraMode = 0x378;
        inline constexpr uintptr_t Character = 0x2A0;
        inline constexpr uintptr_t DisplayName = 0x120;
        inline constexpr uintptr_t HealthDisplayDistance = 0x3A0;
        inline constexpr uintptr_t LocalPlayer = 0x118;
        inline constexpr uintptr_t LocaleId = 0x740;
        inline constexpr uintptr_t MaxZoomDistance = 0x370;
        inline constexpr uintptr_t MinZoomDistance = 0x374;
        inline constexpr uintptr_t Mouse = 0x11F0;
        inline constexpr uintptr_t NameDisplayDistance = 0x3B0;
        inline constexpr uintptr_t Team = 0x2E0;
        inline constexpr uintptr_t TeamColor = 0x3B8;
        inline constexpr uintptr_t UserId = 0xB8;
    }

    namespace PlayerConfigurer {
        inline constexpr uintptr_t Pointer = 0x0;
    }

    namespace PlayerMouse {
        inline constexpr uintptr_t Icon = 0xB0;
        inline constexpr uintptr_t Workspace = 0x138;
    }

    namespace Players {
        inline constexpr uintptr_t LocalPlayer = 0x118;
    }

    namespace Primitive {
        inline constexpr uintptr_t AssemblyAngularVelocity = 0xEC;
        inline constexpr uintptr_t AssemblyLinearVelocity = 0xE0;
        inline constexpr uintptr_t CFrame = 0xB0;
        inline constexpr uintptr_t Material = 0x24E;
        inline constexpr uintptr_t Orientation = 0xB0;
        inline constexpr uintptr_t Part = 0x218;
        inline constexpr uintptr_t Position = 0xD4;
        inline constexpr uintptr_t PrimitiveFlags = 0x1BE;
        inline constexpr uintptr_t Rotation = 0xB0;
        inline constexpr uintptr_t Size = 0x1C4;
        inline constexpr uintptr_t Validate = 0x6;
    }

    namespace PrimitiveFlags {
        inline constexpr uintptr_t Anchored = 0x2;
        inline constexpr uintptr_t CanCollide = 0x8;
        inline constexpr uintptr_t CanQuery = 0x20;
        inline constexpr uintptr_t CanTouch = 0x10;
    }

    namespace PropertyDescriptor {
        inline constexpr uintptr_t GetSetImpl = 0xB0;
        inline constexpr uintptr_t TType = 0x70;
    }

    namespace ProximityPrompt {
        inline constexpr uintptr_t ActionText = 0x98;
        inline constexpr uintptr_t Enabled = 0x11E;
        inline constexpr uintptr_t GamepadKeyCode = 0x104;
        inline constexpr uintptr_t HoldDuration = 0x108;
        inline constexpr uintptr_t KeyboardKeyCode = 0x10C;
        inline constexpr uintptr_t MaxActivationDistance = 0x110;
        inline constexpr uintptr_t ObjectText = 0xB8;
        inline constexpr uintptr_t RequiresLineOfSight = 0x11F;
    }

    namespace RenderJob {
        inline constexpr uintptr_t FakeDataModel = 0x38;
        inline constexpr uintptr_t RealDataModel = 0x1F0;
        inline constexpr uintptr_t RenderView = 0x1E0;
    }

    namespace RenderView {
        inline constexpr uintptr_t DeviceD3D11 = 0x8;
        inline constexpr uintptr_t LightingValid = 0x278;
        inline constexpr uintptr_t SkyValid = 0x0;
        inline constexpr uintptr_t SkyboxValid = 0x28D;
    }

    namespace RunService {
        inline constexpr uintptr_t HeartbeatFPS = 0xF4;
        inline constexpr uintptr_t HeartbeatTask = 0x9668;
    }

    namespace Script {
        inline constexpr uintptr_t ByteCode = 0x0;
        inline constexpr uintptr_t GUID = 0xB8;
        inline constexpr uintptr_t Hash = 0x188;
    }

    namespace ScriptContext {
        inline constexpr uintptr_t RequireBypass = 0xB50;
    }

    namespace Seat {
        inline constexpr uintptr_t Occupant = 0x200;
    }

    namespace Sky {
        inline constexpr uintptr_t MoonAngularSize = 0x22C;
        inline constexpr uintptr_t MoonTextureId = 0xB0;
        inline constexpr uintptr_t SkyboxBk = 0xE0;
        inline constexpr uintptr_t SkyboxDn = 0x110;
        inline constexpr uintptr_t SkyboxFt = 0x140;
        inline constexpr uintptr_t SkyboxLf = 0x170;
        inline constexpr uintptr_t SkyboxOrientation = 0x220;
        inline constexpr uintptr_t SkyboxRt = 0x1A0;
        inline constexpr uintptr_t SkyboxUp = 0x1D0;
        inline constexpr uintptr_t StarCount = 0x230;
        inline constexpr uintptr_t SunAngularSize = 0x234;
        inline constexpr uintptr_t SunTextureId = 0x200;
    }

    namespace Sound {
        inline constexpr uintptr_t IsPlaying = 0x128;
        inline constexpr uintptr_t Looped = 0x125;
        inline constexpr uintptr_t PlaybackSpeed = 0x104;
        inline constexpr uintptr_t RollOffMaxDistance = 0x108;
        inline constexpr uintptr_t RollOffMinDistance = 0x10C;
        inline constexpr uintptr_t SoundGroup = 0xD0;
        inline constexpr uintptr_t SoundId = 0xB0;
        inline constexpr uintptr_t Volume = 0x118;
    }

    namespace SpawnLocation {
        inline constexpr uintptr_t AllowTeamChangeOnTouch = 0x1D8;
        inline constexpr uintptr_t Enabled = 0x1D9;
        inline constexpr uintptr_t ForcefieldDuration = 0x1D0;
        inline constexpr uintptr_t Neutral = 0x1DA;
        inline constexpr uintptr_t TeamColor = 0x1D4;
    }

    namespace SpecialMesh {
        inline constexpr uintptr_t MeshId = 0xE0;
        inline constexpr uintptr_t Offset = 0xA0;
        inline constexpr uintptr_t Scale = 0xAC;
        inline constexpr uintptr_t TextureId = 0x110;
    }

    namespace StatsItem {
        inline constexpr uintptr_t Value = 0x1422A;
    }

    namespace SunRaysEffect {
        inline constexpr uintptr_t Enabled = 0x98;
        inline constexpr uintptr_t Intensity = 0xA0;
        inline constexpr uintptr_t Spread = 0xA4;
    }

    namespace SurfaceAppearance {
        inline constexpr uintptr_t AlphaMode = 0x1D8;
        inline constexpr uintptr_t Color = 0x1C0;
        inline constexpr uintptr_t ColorMap = 0xB0;
        inline constexpr uintptr_t EmissiveMaskContent = 0xE0;
        inline constexpr uintptr_t EmissiveStrength = 0x1DC;
        inline constexpr uintptr_t EmissiveTint = 0x1CC;
        inline constexpr uintptr_t MetalnessMap = 0x110;
        inline constexpr uintptr_t NormalMap = 0x140;
        inline constexpr uintptr_t RoughnessMap = 0x170;
    }

    namespace TaskScheduler {
        inline constexpr uintptr_t JobEnd = 0xD0;
        inline constexpr uintptr_t JobName = 0x18;
        inline constexpr uintptr_t JobStart = 0xC8;
        inline constexpr uintptr_t MaxFPS = 0xB0;
        inline constexpr uintptr_t Pointer = 0x8C9D698;
    }

    namespace Team {
        inline constexpr uintptr_t TeamColor = 0xA0;
    }

    namespace Terrain {
        inline constexpr uintptr_t GrassLength = 0x1D8;
        inline constexpr uintptr_t MaterialColors = 0x278;
        inline constexpr uintptr_t WaterColor = 0x1C8;
        inline constexpr uintptr_t WaterReflectance = 0x1E0;
        inline constexpr uintptr_t WaterTransparency = 0x1E4;
        inline constexpr uintptr_t WaterWaveSize = 0x1E8;
        inline constexpr uintptr_t WaterWaveSpeed = 0x1EC;
    }

    namespace TextButton {
        inline constexpr uintptr_t AutoButtonColor = 0x9E4;
        inline constexpr uintptr_t ContentText = 0xE20;
        inline constexpr uintptr_t LineHeight = 0xF38;
        inline constexpr uintptr_t LocalizedText = 0xE20;
        inline constexpr uintptr_t MaxVisibleGraphemes = 0x1154;
        inline constexpr uintptr_t Modal = 0x9E5;
        inline constexpr uintptr_t RichText = 0x1036;
        inline constexpr uintptr_t Selected = 0x9E6;
        inline constexpr uintptr_t Text = 0xE20;
        inline constexpr uintptr_t TextColor3 = 0x1138;
        inline constexpr uintptr_t TextDirection = 0xFD8;
        inline constexpr uintptr_t TextScaled = 0x102E;
        inline constexpr uintptr_t TextSize = 0x115C;
        inline constexpr uintptr_t TextStrokeColor3 = 0x1144;
        inline constexpr uintptr_t TextStrokeTransparency = 0x1160;
        inline constexpr uintptr_t TextTransparency = 0x1164;
        inline constexpr uintptr_t TextTruncate = 0x1168;
        inline constexpr uintptr_t TextWrapped = 0x1030;
        inline constexpr uintptr_t TextXAlignment = 0x116C;
        inline constexpr uintptr_t TextYAlignment = 0xF80;
    }

    namespace TextLabel {
        inline constexpr uintptr_t ContentText = 0xBA0;
        inline constexpr uintptr_t LineHeight = 0xCB8;
        inline constexpr uintptr_t LocalizedText = 0xBA0;
        inline constexpr uintptr_t MaxVisibleGraphemes = 0xED4;
        inline constexpr uintptr_t RichText = 0xDB6;
        inline constexpr uintptr_t Text = 0xBA0;
        inline constexpr uintptr_t TextColor3 = 0xEB8;
        inline constexpr uintptr_t TextDirection = 0xD58;
        inline constexpr uintptr_t TextScaled = 0xDAE;
        inline constexpr uintptr_t TextSize = 0xEDC;
        inline constexpr uintptr_t TextStrokeColor3 = 0xEC4;
        inline constexpr uintptr_t TextStrokeTransparency = 0xEE0;
        inline constexpr uintptr_t TextTransparency = 0xEE4;
        inline constexpr uintptr_t TextTruncate = 0xEE8;
        inline constexpr uintptr_t TextWrapped = 0xDB0;
        inline constexpr uintptr_t TextXAlignment = 0xEEC;
        inline constexpr uintptr_t TextYAlignment = 0xD00;
    }

    namespace Textures {
        inline constexpr uintptr_t Decal_Texture = 0x1C8;
    }

    namespace Tool {
        inline constexpr uintptr_t CanBeDropped = 0x4A0;
        inline constexpr uintptr_t Enabled = 0x4A1;
        inline constexpr uintptr_t Grip = 0x470;
        inline constexpr uintptr_t GripForward = 0x488;
        inline constexpr uintptr_t GripPos = 0x494;
        inline constexpr uintptr_t GripRight = 0x470;
        inline constexpr uintptr_t GripUp = 0x47C;
        inline constexpr uintptr_t ManualActivationOnly = 0x4A2;
        inline constexpr uintptr_t RequiresHandle = 0x4A3;
        inline constexpr uintptr_t TextureId = 0x348;
        inline constexpr uintptr_t Tooltip = 0x450;
    }

    namespace Types {
        inline constexpr uintptr_t AllTypes = 0x8C88868;
    }

    namespace UnionOperation {
        inline constexpr uintptr_t AssetId = 0x2F8;
    }

    namespace UserInputService {
        inline constexpr uintptr_t WindowInputState = 0x288;
    }

    namespace Value {
        inline constexpr uintptr_t Value = 0xA0;
    }

    namespace VehicleSeat {
        inline constexpr uintptr_t MaxSpeed = 0x210;
        inline constexpr uintptr_t Occupant = 0x1F0;
        inline constexpr uintptr_t SteerFloat = 0x214;
        inline constexpr uintptr_t ThrottleFloat = 0x218;
        inline constexpr uintptr_t Torque = 0x21C;
        inline constexpr uintptr_t TurnSpeed = 0x220;
    }

    namespace VisualEngine {
        inline constexpr uintptr_t Dimensions = 0xB10;
        inline constexpr uintptr_t FakeDataModel = 0xAF0;
        inline constexpr uintptr_t Pointer = 0x879A218;
        inline constexpr uintptr_t RenderView = 0xC40;
        inline constexpr uintptr_t ViewMatrix = 0x1B0;
    }

    namespace Weld {
        inline constexpr uintptr_t Part0 = 0x100;
        inline constexpr uintptr_t Part1 = 0x110;
    }

    namespace WeldConstraint {
        inline constexpr uintptr_t Part0 = 0xA0;
        inline constexpr uintptr_t Part1 = 0xB0;
    }

    namespace WindowInputState {
        inline constexpr uintptr_t CapsLock = 0x40;
        inline constexpr uintptr_t CurrentTextBox = 0x48;
    }

    namespace Workspace {
        inline constexpr uintptr_t CurrentCamera = 0x4A0;
        inline constexpr uintptr_t DistributedGameTime = 0x4C0;
        inline constexpr uintptr_t ReadOnlyGravity = 0x9C0;
        inline constexpr uintptr_t World = 0x3F8;
    }

    namespace World {
        inline constexpr uintptr_t AirProperties = 0x230;
        inline constexpr uintptr_t FallenPartsDestroyHeight = 0x20C;
        inline constexpr uintptr_t Gravity = 0x218;
        inline constexpr uintptr_t Primitives = 0x2A0;
        inline constexpr uintptr_t WorldSteps = 0x858;
    }

} // namespace offsets

namespace enums {
    enum class ReflectionType : int {
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
    };

} // namespace enums
