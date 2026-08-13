/*
 * Github: https://git.jonah.cool/jonah/roblox-dumper
 * Roblox Version: version-ddf602d9cfe44005
 * Time Taken: 5968 ms (5.968000 seconds)
 * Total Offsets: 500
 */

#pragma once
#include <cstdint>

// clang-format off
namespace offsets {
    inline constexpr const char* roblox_version = "version-ddf602d9cfe44005";

    namespace AirProperties {
        inline constexpr uintptr_t AirDensity = 0x18;
        inline constexpr uintptr_t GlobalWind = 0x3C;
    }

    namespace AnimationTrack {
        inline constexpr uintptr_t Animation = 0xB8;
        inline constexpr uintptr_t Animator = 0x108;
        inline constexpr uintptr_t IsPlaying = 0xA90;
        inline constexpr uintptr_t Looped = 0xE5;
        inline constexpr uintptr_t Speed = 0xD4;
        inline constexpr uintptr_t TimePosition = 0xD8;
    }

    namespace Animator {
        inline constexpr uintptr_t ActiveAnimations = 0xB80;
    }

    namespace Atmosphere {
        inline constexpr uintptr_t Color = 0xB8;
        inline constexpr uintptr_t Decay = 0xC4;
        inline constexpr uintptr_t Density = 0xD0;
        inline constexpr uintptr_t Glare = 0xD4;
        inline constexpr uintptr_t Haze = 0xD8;
        inline constexpr uintptr_t Offset = 0xDC;
    }

    namespace Attachment {
        inline constexpr uintptr_t Position = 0xC4;
    }

    namespace BasePart {
        inline constexpr uintptr_t CastShadow = 0x135;
        inline constexpr uintptr_t Color3 = 0x1A8;
        inline constexpr uintptr_t Locked = 0x136;
        inline constexpr uintptr_t Massless = 0x137;
        inline constexpr uintptr_t Primitive = 0x188;
        inline constexpr uintptr_t Reflectance = 0x10C;
        inline constexpr uintptr_t Shape = 0x1B9;
        inline constexpr uintptr_t Transparency = 0x130;
    }

    namespace Beam {
        inline constexpr uintptr_t Attachment0 = 0x160;
        inline constexpr uintptr_t Attachment1 = 0x170;
        inline constexpr uintptr_t Brightness = 0x180;
        inline constexpr uintptr_t CurveSize0 = 0x184;
        inline constexpr uintptr_t CurveSize1 = 0x188;
        inline constexpr uintptr_t LightEmission = 0x18C;
        inline constexpr uintptr_t LightInfluence = 0x190;
        inline constexpr uintptr_t Texture = 0x140;
        inline constexpr uintptr_t TextureLength = 0x19C;
        inline constexpr uintptr_t TextureSpeed = 0x1A4;
        inline constexpr uintptr_t Width0 = 0x1A8;
        inline constexpr uintptr_t Width1 = 0x1AC;
        inline constexpr uintptr_t ZOffset = 0x1B0;
    }

    namespace BloomEffect {
        inline constexpr uintptr_t Enabled = 0xB0;
        inline constexpr uintptr_t Intensity = 0xB8;
        inline constexpr uintptr_t Size = 0xBC;
        inline constexpr uintptr_t Threshold = 0xC0;
    }

    namespace BlurEffect {
        inline constexpr uintptr_t Enabled = 0xB0;
        inline constexpr uintptr_t Size = 0xB8;
    }

    namespace ByteCode {
        inline constexpr uintptr_t Pointer = 0x10;
        inline constexpr uintptr_t Size = 0x28;
    }

    namespace CachedItem {
        inline constexpr uintptr_t FileMeshData = 0x40;
    }

    namespace Camera {
        inline constexpr uintptr_t CFrame = 0xD8;
        inline constexpr uintptr_t CameraSubject = 0xC8;
        inline constexpr uintptr_t CameraType = 0x138;
        inline constexpr uintptr_t FieldOfView = 0x140;
        inline constexpr uintptr_t ImagePlaneDepth = 0x2D4;
        inline constexpr uintptr_t Position = 0xFC;
        inline constexpr uintptr_t Rotation = 0xD8;
        inline constexpr uintptr_t ViewportInt16 = 0x28C;
        inline constexpr uintptr_t ViewportSize = 0x2CC;
    }

    namespace CharacterMesh {
        inline constexpr uintptr_t BaseTextureId = 0xC8;
        inline constexpr uintptr_t BodyPart = 0x148;
        inline constexpr uintptr_t MeshId = 0xF8;
        inline constexpr uintptr_t OverlayTextureId = 0x128;
    }

    namespace ClassDescriptor {
        inline constexpr uintptr_t ClassName = 0x8;
        inline constexpr uintptr_t Creator = 0x230; // ICreator vtable, [0] = create fn
        inline constexpr uintptr_t EventDescriptors = 0x88;
        inline constexpr uintptr_t FunctionDescriptors = 0xD0;
        inline constexpr uintptr_t PropertyDescriptors = 0x40;
    }

    namespace ClickDetector {
        inline constexpr uintptr_t MaxActivationDistance = 0xE8;
        inline constexpr uintptr_t MouseIcon = 0xC8;
    }

    namespace Clothing {
        inline constexpr uintptr_t Color3 = 0x120;
        inline constexpr uintptr_t Template = 0x100;
    }

    namespace ColorCorrectionEffect {
        inline constexpr uintptr_t Brightness = 0xC4;
        inline constexpr uintptr_t Contrast = 0xC8;
        inline constexpr uintptr_t Enabled = 0xB0;
        inline constexpr uintptr_t TintColor = 0xB8;
    }

    namespace ColorGradingEffect {
        inline constexpr uintptr_t Enabled = 0xB0;
        inline constexpr uintptr_t TonemapperPreset = 0xB8;
    }

    namespace Creator {
        inline constexpr uintptr_t MapEnd = 0x7EEB340;
        inline constexpr uintptr_t MapStart = 0x7EEB338;
    }

    namespace DataModel {
        inline constexpr uintptr_t CreatorId = 0x178;
        inline constexpr uintptr_t GameId = 0x180;
        inline constexpr uintptr_t GameLoaded = 0x570;
        inline constexpr uintptr_t JobId = 0x118;
        inline constexpr uintptr_t PlaceId = 0x188;
        inline constexpr uintptr_t PlaceVersion = 0x1A4;
        inline constexpr uintptr_t PrimitiveCount = 0x3B8;
        inline constexpr uintptr_t ScriptContext = 0x440;
        inline constexpr uintptr_t ServerIP = 0x558;
        inline constexpr uintptr_t ToRenderView1 = 0x1C0;
        inline constexpr uintptr_t ToRenderView2 = 0x8;
        inline constexpr uintptr_t ToRenderView3 = 0x28;
        inline constexpr uintptr_t Workspace = 0x158;
    }

    namespace DepthOfFieldEffect {
        inline constexpr uintptr_t Enabled = 0xB0;
        inline constexpr uintptr_t FarIntensity = 0xB8;
        inline constexpr uintptr_t FocusDistance = 0xBC;
        inline constexpr uintptr_t InFocusRadius = 0xC0;
        inline constexpr uintptr_t NearIntensity = 0xC4;
    }

    namespace Descriptor {
        inline constexpr uintptr_t Name = 0x8;
    }

    namespace DragDetector {
        inline constexpr uintptr_t ActivatedCursorIcon = 0x1C0;
        inline constexpr uintptr_t CursorIcon = 0xC8;
        inline constexpr uintptr_t MaxActivationDistance = 0xE8;
        inline constexpr uintptr_t MaxDragAngle = 0x2A8;
        inline constexpr uintptr_t MaxDragTranslation = 0x26C;
        inline constexpr uintptr_t MaxForce = 0x2AC;
        inline constexpr uintptr_t MaxTorque = 0x2B0;
        inline constexpr uintptr_t MinDragAngle = 0x2B4;
        inline constexpr uintptr_t MinDragTranslation = 0x278;
        inline constexpr uintptr_t ReferenceInstance = 0x1F0;
        inline constexpr uintptr_t Responsiveness = 0x2C0;
    }

    namespace FakeDataModel {
        inline constexpr uintptr_t Pointer = 0x8B79B58;
        inline constexpr uintptr_t RealDataModel = 0x1D8;
    }

    namespace FileMeshData {
        inline constexpr uintptr_t AabbMax = 0x2BC;
        inline constexpr uintptr_t AabbMin = 0x2B0;
        inline constexpr uintptr_t Faces = 0x30;
        inline constexpr uintptr_t FacesEnd = 0x38;
        inline constexpr uintptr_t Vertices = 0x0;
        inline constexpr uintptr_t VerticesEnd = 0x8;
    }

    namespace FunctionDescriptor {
        inline constexpr uintptr_t Function = 0x80;
    }

    namespace Functions {
        inline constexpr uintptr_t Clone = 0x880E00; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t Destroy = 0x880E20; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t FindPartOnRay = 0x25098C0; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t FindPartOnRayWithIgnoreList = 0x2509940; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t FindPartOnRayWithWhitelist = 0x25099D0; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t FireServer = 0x21502A0; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t Print = 0x92C340;
        inline constexpr uintptr_t RaisePropertyChanged = 0x8C5C30;
        inline constexpr uintptr_t Raycast = 0x2500AA0; // better to resolve at runtime via func descriptors
        inline constexpr uintptr_t SetParent = 0x8C6380;
        inline constexpr uintptr_t SetParentInternal = 0x8C57A0;
        inline constexpr uintptr_t Shapecast = 0x2502430; // better to resolve at runtime via func descriptors
    }

    namespace GuiBase2D {
        inline constexpr uintptr_t AbsolutePosition = 0x108;
        inline constexpr uintptr_t AbsoluteRotation = 0xE8;
        inline constexpr uintptr_t AbsoluteSize = 0x114;
    }

    namespace GuiObject {
        inline constexpr uintptr_t Active = 0x5A8;
        inline constexpr uintptr_t AnchorPoint = 0x558;
        inline constexpr uintptr_t AutomaticSize = 0x560;
        inline constexpr uintptr_t BackgroundColor3 = 0x540;
        inline constexpr uintptr_t BackgroundTransparency = 0x564;
        inline constexpr uintptr_t BorderColor3 = 0x54C;
        inline constexpr uintptr_t BorderMode = 0x568;
        inline constexpr uintptr_t BorderSizePixel = 0x56C;
        inline constexpr uintptr_t ClipsDescendants = 0x5A9;
        inline constexpr uintptr_t GuiState = 0x578;
        inline constexpr uintptr_t Image = 0x988;
        inline constexpr uintptr_t Interactable = 0x5AB;
        inline constexpr uintptr_t LayoutOrder = 0x580;
        inline constexpr uintptr_t Position = 0x510;
        inline constexpr uintptr_t RichText = 0xB88;
        inline constexpr uintptr_t Rotation = 0xE8;
        inline constexpr uintptr_t ScreenGui_Enabled = 0x4C4;
        inline constexpr uintptr_t Selectable = 0x5AC;
        inline constexpr uintptr_t SelectionOrder = 0x59C;
        inline constexpr uintptr_t Size = 0x530;
        inline constexpr uintptr_t SizeConstraint = 0x5A0;
        inline constexpr uintptr_t Text = 0xDF8;
        inline constexpr uintptr_t TextColor3 = 0xEA8;
        inline constexpr uintptr_t Visible = 0x5AD;
        inline constexpr uintptr_t ZIndex = 0x5A4;
    }

    namespace Highlight {
        inline constexpr uintptr_t Adornee = 0xB8;
        inline constexpr uintptr_t DepthMode = 0xAD;
        inline constexpr uintptr_t Enabled = 0xBD;
        inline constexpr uintptr_t FillColor = 0xC8;
        inline constexpr uintptr_t FillTransparency = 0xE4;
        inline constexpr uintptr_t OutlineColor = 0xD4;
        inline constexpr uintptr_t OutlineTransparency = 0xEC;
    }

    namespace HopperBin {
        inline constexpr uintptr_t BinType = 0x468;
    }

    namespace Humanoid {
        inline constexpr uintptr_t AutoJumpEnabled = 0x1D4;
        inline constexpr uintptr_t AutoRotate = 0x1D5;
        inline constexpr uintptr_t AutomaticScalingEnabled = 0x1D6;
        inline constexpr uintptr_t BreakJointsOnDeath = 0x1D7;
        inline constexpr uintptr_t CameraOffset = 0x128;
        inline constexpr uintptr_t DisplayDistanceType = 0x180;
        inline constexpr uintptr_t DisplayName = 0xB8;
        inline constexpr uintptr_t EvaluateStateMachine = 0x1D8;
        inline constexpr uintptr_t FloorMaterial = 0x184;
        inline constexpr uintptr_t Health = 0x190;
        inline constexpr uintptr_t HealthDisplayDistance = 0x188;
        inline constexpr uintptr_t HealthDisplayType = 0x18C;
        inline constexpr uintptr_t HipHeight = 0x194;
        inline constexpr uintptr_t HumanoidRootPart = 0x478;
        inline constexpr uintptr_t HumanoidState = 0x898;
        inline constexpr uintptr_t HumanoidStateID = 0x20;
        inline constexpr uintptr_t IsWalking = 0x93F;
        inline constexpr uintptr_t Jump = 0x1DA;
        inline constexpr uintptr_t JumpHeight = 0x1A0;
        inline constexpr uintptr_t JumpPower = 0x1A4;
        inline constexpr uintptr_t MaxHealth = 0x1A8;
        inline constexpr uintptr_t MaxSlopeAngle = 0x1AC;
        inline constexpr uintptr_t MoveDirection = 0x140;
        inline constexpr uintptr_t MoveToPart = 0x118;
        inline constexpr uintptr_t NameDisplayDistance = 0x1B0;
        inline constexpr uintptr_t NameOcclusion = 0x1B4;
        inline constexpr uintptr_t PlatformStand = 0xC5;
        inline constexpr uintptr_t PlatformStatePointer = 0x9246A6E6;
        inline constexpr uintptr_t RequiresNeck = 0x1DD;
        inline constexpr uintptr_t RigType = 0x1C0;
        inline constexpr uintptr_t SeatPart = 0x108;
        inline constexpr uintptr_t Sit = 0x1DE;
        inline constexpr uintptr_t TargetPoint = 0x14C;
        inline constexpr uintptr_t UseJumpPower = 0x1E0;
        inline constexpr uintptr_t WalkSpeed = 0x1D0;
        inline constexpr uintptr_t WalkSpeedCheck = 0x3BC;
        inline constexpr uintptr_t WalkTimer = 0x408;
        inline constexpr uintptr_t WalkToPoint = 0x164;
    }

    namespace ICreator {
        inline constexpr uintptr_t Create = 0x0;
    }

    namespace InputObject {
        inline constexpr uintptr_t MousePosition = 0xD4;
    }

    namespace Instance {
        inline constexpr uintptr_t ChildrenEnd = 0x8;
        inline constexpr uintptr_t ChildrenStart = 0x78;
        inline constexpr uintptr_t ClassBase = 0x1B0;
        inline constexpr uintptr_t ClassDescriptor = 0x18;
        inline constexpr uintptr_t Name = 0x8;
        inline constexpr uintptr_t NameContainer = 0x70;
        inline constexpr uintptr_t Parent = 0x68;
    }

    namespace Lighting {
        inline constexpr uintptr_t Ambient = 0xD0;
        inline constexpr uintptr_t Atmosphere = 0x1D8;
        inline constexpr uintptr_t Brightness = 0x118;
        inline constexpr uintptr_t ClockTime = 0xC8;
        inline constexpr uintptr_t ColorShift_Bottom = 0xDC;
        inline constexpr uintptr_t ColorShift_Top = 0xE8;
        inline constexpr uintptr_t EnvironmentDiffuseScale = 0x11C;
        inline constexpr uintptr_t EnvironmentSpecularScale = 0x120;
        inline constexpr uintptr_t ExposureCompensation = 0x124;
        inline constexpr uintptr_t FogColor = 0xF4;
        inline constexpr uintptr_t FogEnd = 0x12C;
        inline constexpr uintptr_t FogStart = 0x130;
        inline constexpr uintptr_t GeographicLatitude = 0x134;
        inline constexpr uintptr_t GlobalShadows = 0x144;
        inline constexpr uintptr_t GradientBottom = 0x190;
        inline constexpr uintptr_t GradientTop = 0x150;
        inline constexpr uintptr_t LightColor = 0x15C;
        inline constexpr uintptr_t LightDirection = 0x168;
        inline constexpr uintptr_t MoonPosition = 0x184;
        inline constexpr uintptr_t OutdoorAmbient = 0x100;
        inline constexpr uintptr_t ShadowSoftness = 0x13C;
        inline constexpr uintptr_t Sky = 0x1C8;
        inline constexpr uintptr_t Source = 0x174;
        inline constexpr uintptr_t SunPosition = 0x178;
    }

    namespace LightingParameters { // these are in the lighting service
        inline constexpr uintptr_t GeographicLatitude = 0x134;
        inline constexpr uintptr_t LightColor = 0x15C;
        inline constexpr uintptr_t LightDirection = 0x168;
        inline constexpr uintptr_t SkyAmbient = 0x150;
        inline constexpr uintptr_t SkyAmbient2 = 0x138;
        inline constexpr uintptr_t Source = 0x174;
        inline constexpr uintptr_t TrueMoonPosition = 0x184;
        inline constexpr uintptr_t TrueSunPosition = 0x178;
    }

    namespace LocalScript {
        inline constexpr uintptr_t ByteCode = 0x0;
        inline constexpr uintptr_t Bytecode = 0x190;
        inline constexpr uintptr_t Hash = 0xD0;
    }

    namespace LruHolder {
        inline constexpr uintptr_t MemEnforcedLRUCache = 0x20;
    }

    namespace LruNode {
        inline constexpr uintptr_t CachedItem = 0x40;
        inline constexpr uintptr_t MeshId = 0x10;
        inline constexpr uintptr_t Next = 0x0;
    }

    namespace MaterialColors {
        inline constexpr uintptr_t Asphalt = 0x30;
        inline constexpr uintptr_t Basalt = 0x27;
        inline constexpr uintptr_t Brick = 0xF;
        inline constexpr uintptr_t Cobblestone = 0x33;
        inline constexpr uintptr_t Concrete = 0xC;
        inline constexpr uintptr_t CrackedLava = 0x2D;
        inline constexpr uintptr_t Glacier = 0x1B;
        inline constexpr uintptr_t Grass = 0x6;
        inline constexpr uintptr_t Ground = 0x2A;
        inline constexpr uintptr_t Ice = 0x36;
        inline constexpr uintptr_t LeafyGrass = 0x39;
        inline constexpr uintptr_t Limestone = 0x3F;
        inline constexpr uintptr_t Mud = 0x24;
        inline constexpr uintptr_t Pavement = 0x42;
        inline constexpr uintptr_t Rock = 0x18;
        inline constexpr uintptr_t Salt = 0x3C;
        inline constexpr uintptr_t Sand = 0x12;
        inline constexpr uintptr_t Sandstone = 0x21;
        inline constexpr uintptr_t Slate = 0x9;
        inline constexpr uintptr_t Snow = 0x1E;
        inline constexpr uintptr_t WoodPlanks = 0x15;
    }

    namespace MemEnforcedLRUCache {
        inline constexpr uintptr_t Head = 0x8;
    }

    namespace MeshContentProvider {
        inline constexpr uintptr_t LruHolder = 0xD8;
    }

    namespace MeshData {
        inline constexpr uintptr_t FaceEnd = 0x38;
        inline constexpr uintptr_t FaceStart = 0x30;
        inline constexpr uintptr_t VertexEnd = 0x8;
        inline constexpr uintptr_t VertexStart = 0x0;
    }

    namespace MeshPart {
        inline constexpr uintptr_t MeshId = 0x308;
        inline constexpr uintptr_t TextureId = 0x338;
    }

    namespace Misc {
        inline constexpr uintptr_t Adornee = 0xF0;
        inline constexpr uintptr_t AnimationId = 0xC0;
        inline constexpr uintptr_t StringLength = 0x10;
        inline constexpr uintptr_t Value = 0xB8;
    }

    namespace Model {
        inline constexpr uintptr_t PrimaryPart = 0x258;
        inline constexpr uintptr_t Scale = 0x144;
    }

    namespace ModuleScript {
        inline constexpr uintptr_t ByteCode = 0x0;
        inline constexpr uintptr_t Bytecode = 0x138;
        inline constexpr uintptr_t GUID = 0xD0;
        inline constexpr uintptr_t Hash = 0x148;
        inline constexpr uintptr_t IsRobloxScript = 0x168;
    }

    namespace MouseService {
        inline constexpr uintptr_t InputObject = 0x100;
        inline constexpr uintptr_t MousePosition = 0xD4;
        inline constexpr uintptr_t SensitivityPointer = 0x0;
    }

    namespace ParticleEmitter {
        inline constexpr uintptr_t Acceleration = 0x1E0;
        inline constexpr uintptr_t Brightness = 0x21C;
        inline constexpr uintptr_t Drag = 0x220;
        inline constexpr uintptr_t Lifetime = 0x1F4;
        inline constexpr uintptr_t LightEmission = 0x238;
        inline constexpr uintptr_t LightInfluence = 0x23C;
        inline constexpr uintptr_t Rate = 0x248;
        inline constexpr uintptr_t RotSpeed = 0x1FC;
        inline constexpr uintptr_t Rotation = 0x204;
        inline constexpr uintptr_t Speed = 0x20C;
        inline constexpr uintptr_t SpreadAngle = 0x214;
        inline constexpr uintptr_t Texture = 0x1C0;
        inline constexpr uintptr_t TimeScale = 0x25C;
        inline constexpr uintptr_t VelocityInheritance = 0x260;
        inline constexpr uintptr_t ZOffset = 0x264;
    }

    namespace Player {
        inline constexpr uintptr_t AccountAge = 0x35C;
        inline constexpr uintptr_t CameraMode = 0x370;
        inline constexpr uintptr_t Character = 0x298;
        inline constexpr uintptr_t DisplayName = 0x138;
        inline constexpr uintptr_t HealthDisplayDistance = 0x394;
        inline constexpr uintptr_t LocalPlayer = 0x130;
        inline constexpr uintptr_t LocaleId = 0x740;
        inline constexpr uintptr_t MaxZoomDistance = 0x368;
        inline constexpr uintptr_t MinZoomDistance = 0x36C;
        inline constexpr uintptr_t Mouse = 0x11F0;
        inline constexpr uintptr_t NameDisplayDistance = 0x3A4;
        inline constexpr uintptr_t Team = 0x2D8;
        inline constexpr uintptr_t TeamColor = 0x3B0;
        inline constexpr uintptr_t UserId = 0x300;
    }

    namespace PlayerConfigurer {
        inline constexpr uintptr_t Pointer = 0x0;
    }

    namespace PlayerMouse {
        inline constexpr uintptr_t Icon = 0xC8;
        inline constexpr uintptr_t Workspace = 0x150;
    }

    namespace Players {
        inline constexpr uintptr_t LocalPlayer = 0x130;
    }

    namespace Primitive {
        inline constexpr uintptr_t AssemblyAngularVelocity = 0x104;
        inline constexpr uintptr_t AssemblyLinearVelocity = 0xF8;
        inline constexpr uintptr_t CFrame = 0xC8;
        inline constexpr uintptr_t Material = 0x246;
        inline constexpr uintptr_t Orientation = 0xC8;
        inline constexpr uintptr_t Part = 0x210;
        inline constexpr uintptr_t Position = 0xEC;
        inline constexpr uintptr_t PrimitiveFlags = 0x1B6;
        inline constexpr uintptr_t Rotation = 0xC8;
        inline constexpr uintptr_t Size = 0x1BC;
        inline constexpr uintptr_t Validate = 0x6;
    }

    namespace PrimitiveFlags {
        inline constexpr uintptr_t Anchored = 0x2;
        inline constexpr uintptr_t CanCollide = 0x8;
        inline constexpr uintptr_t CanQuery = 0x20;
        inline constexpr uintptr_t CanTouch = 0x10;
    }

    namespace PropertyDescriptor {
        inline constexpr uintptr_t GetSetImpl = 0x90;
        inline constexpr uintptr_t TType = 0x68;
    }

    namespace ProximityPrompt {
        inline constexpr uintptr_t ActionText = 0xB0;
        inline constexpr uintptr_t Enabled = 0x136;
        inline constexpr uintptr_t GamepadKeyCode = 0x11C;
        inline constexpr uintptr_t HoldDuration = 0x120;
        inline constexpr uintptr_t KeyboardKeyCode = 0x124;
        inline constexpr uintptr_t MaxActivationDistance = 0x128;
        inline constexpr uintptr_t ObjectText = 0xD0;
        inline constexpr uintptr_t RequiresLineOfSight = 0xD;
    }

    namespace RenderJob {
        inline constexpr uintptr_t FakeDataModel = 0x38;
        inline constexpr uintptr_t RealDataModel = 0x1D0;
        inline constexpr uintptr_t RenderView = 0x1D8;
    }

    namespace RenderView {
        inline constexpr uintptr_t DeviceD3D11 = 0x8;
        inline constexpr uintptr_t LightingValid = 0x228;
        inline constexpr uintptr_t SkyboxValid = 0x28D;
        inline constexpr uintptr_t VisualEngine = 0x10;
    }

    namespace RunService {
        inline constexpr uintptr_t HeartbeatFPS = 0xF4;
        inline constexpr uintptr_t HeartbeatTask = 0x3B8;
    }

    namespace Script {
        inline constexpr uintptr_t ByteCode = 0x0;
        inline constexpr uintptr_t GUID = 0xD0;
        inline constexpr uintptr_t Hash = 0x1A0;
    }

    namespace ScriptContext {
        inline constexpr uintptr_t RequireBypass = 0x898;
    }

    namespace Seat {
        inline constexpr uintptr_t Occupant = 0x210;
    }

    namespace Sky {
        inline constexpr uintptr_t MoonAngularSize = 0x244;
        inline constexpr uintptr_t MoonTextureId = 0xC8;
        inline constexpr uintptr_t SkyboxBk = 0xF8;
        inline constexpr uintptr_t SkyboxDn = 0x128;
        inline constexpr uintptr_t SkyboxFt = 0x158;
        inline constexpr uintptr_t SkyboxLf = 0x188;
        inline constexpr uintptr_t SkyboxOrientation = 0x238;
        inline constexpr uintptr_t SkyboxRt = 0x1B8;
        inline constexpr uintptr_t SkyboxUp = 0x1E8;
        inline constexpr uintptr_t StarCount = 0x248;
        inline constexpr uintptr_t SunAngularSize = 0x24C;
        inline constexpr uintptr_t SunTextureId = 0x218;
    }

    namespace Sound {
        inline constexpr uintptr_t IsPlaying = 0x140;
        inline constexpr uintptr_t Looped = 0x13D;
        inline constexpr uintptr_t PlaybackSpeed = 0x11C;
        inline constexpr uintptr_t RollOffMaxDistance = 0x120;
        inline constexpr uintptr_t RollOffMinDistance = 0x124;
        inline constexpr uintptr_t SoundGroup = 0xE8;
        inline constexpr uintptr_t SoundId = 0xC8;
        inline constexpr uintptr_t Volume = 0x130;
    }

    namespace SpawnLocation {
        inline constexpr uintptr_t AllowTeamChangeOnTouch = 0x3D;
        inline constexpr uintptr_t Enabled = 0x1E9;
        inline constexpr uintptr_t ForcefieldDuration = 0x1E0;
        inline constexpr uintptr_t Neutral = 0x1EA;
        inline constexpr uintptr_t TeamColor = 0x1E4;
    }

    namespace SpecialMesh {
        inline constexpr uintptr_t MeshId = 0xF8;
        inline constexpr uintptr_t Offset = 0xB8;
        inline constexpr uintptr_t Scale = 0xC4;
        inline constexpr uintptr_t TextureId = 0x128;
    }

    namespace StatsItem {
        inline constexpr uintptr_t Value = 0xC8;
    }

    namespace SunRaysEffect {
        inline constexpr uintptr_t Enabled = 0xB0;
        inline constexpr uintptr_t Intensity = 0xB8;
        inline constexpr uintptr_t Spread = 0xBC;
    }

    namespace SurfaceAppearance {
        inline constexpr uintptr_t AlphaMode = 0x290;
        inline constexpr uintptr_t Color = 0x278;
        inline constexpr uintptr_t ColorMap = 0xC8;
        inline constexpr uintptr_t EmissiveMaskContent = 0xF8;
        inline constexpr uintptr_t EmissiveStrength = 0x294;
        inline constexpr uintptr_t EmissiveTint = 0x284;
        inline constexpr uintptr_t MetalnessMap = 0x128;
        inline constexpr uintptr_t NormalMap = 0x158;
        inline constexpr uintptr_t RoughnessMap = 0x188;
    }

    namespace TaskScheduler {
        inline constexpr uintptr_t JobEnd = 0xD0;
        inline constexpr uintptr_t JobName = 0x18;
        inline constexpr uintptr_t JobStart = 0xC8;
        inline constexpr uintptr_t MaxFps = 0xB0;
        inline constexpr uintptr_t Pointer = 0x88B64C8;
    }

    namespace Team {
        inline constexpr uintptr_t TeamColor = 0xB8;
    }

    namespace Terrain {
        inline constexpr uintptr_t GrassLength = 0x1E8;
        inline constexpr uintptr_t MaterialColors = 0x490;
        inline constexpr uintptr_t WaterColor = 0x1D8;
        inline constexpr uintptr_t WaterReflectance = 0x1F0;
        inline constexpr uintptr_t WaterTransparency = 0x1F4;
        inline constexpr uintptr_t WaterWaveSize = 0x1F8;
        inline constexpr uintptr_t WaterWaveSpeed = 0x1FC;
    }

    namespace TextButton {
        inline constexpr uintptr_t AutoButtonColor = 0x9C4;
        inline constexpr uintptr_t ContentText = 0xE08;
        inline constexpr uintptr_t Font = 0x1140;
        inline constexpr uintptr_t LineHeight = 0xF20;
        inline constexpr uintptr_t LocalizedText = 0xE08;
        inline constexpr uintptr_t MaxVisibleGraphemes = 0x114C;
        inline constexpr uintptr_t Modal = 0x9C5;
        inline constexpr uintptr_t RichText = 0x101E;
        inline constexpr uintptr_t Selected = 0x9C6;
        inline constexpr uintptr_t Text = 0xE08;
        inline constexpr uintptr_t TextColor3 = 0x1128;
        inline constexpr uintptr_t TextDirection = 0xFC0;
        inline constexpr uintptr_t TextScaled = 0xDF1;
        inline constexpr uintptr_t TextSize = 0x1154;
        inline constexpr uintptr_t TextStrokeColor3 = 0x1134;
        inline constexpr uintptr_t TextStrokeTransparency = 0x1158;
        inline constexpr uintptr_t TextTransparency = 0x115C;
        inline constexpr uintptr_t TextTruncate = 0x1160;
        inline constexpr uintptr_t TextWrapped = 0x1018;
        inline constexpr uintptr_t TextXAlignment = 0x1164;
        inline constexpr uintptr_t TextYAlignment = 0xF68;
    }

    namespace TextLabel {
        inline constexpr uintptr_t ContentText = 0xB88;
        inline constexpr uintptr_t Font = 0xEC0;
        inline constexpr uintptr_t LineHeight = 0xCA0;
        inline constexpr uintptr_t LocalizedText = 0xB88;
        inline constexpr uintptr_t MaxVisibleGraphemes = 0xECC;
        inline constexpr uintptr_t RichText = 0xD9E;
        inline constexpr uintptr_t Text = 0xB88;
        inline constexpr uintptr_t TextColor3 = 0xEA8;
        inline constexpr uintptr_t TextDirection = 0xD40;
        inline constexpr uintptr_t TextScaled = 0xB71;
        inline constexpr uintptr_t TextSize = 0xED4;
        inline constexpr uintptr_t TextStrokeColor3 = 0xEB4;
        inline constexpr uintptr_t TextStrokeTransparency = 0xED8;
        inline constexpr uintptr_t TextTransparency = 0xEDC;
        inline constexpr uintptr_t TextTruncate = 0xEE0;
        inline constexpr uintptr_t TextWrapped = 0xD98;
        inline constexpr uintptr_t TextXAlignment = 0xEE4;
        inline constexpr uintptr_t TextYAlignment = 0xCE8;
    }

    namespace Textures {
        inline constexpr uintptr_t Decal_Texture = 0x180;
    }

    namespace Tool {
        inline constexpr uintptr_t CanBeDropped = 0x4B8;
        inline constexpr uintptr_t Enabled = 0x4B9;
        inline constexpr uintptr_t Grip = 0x488;
        inline constexpr uintptr_t GripForward = 0x4A0;
        inline constexpr uintptr_t GripPos = 0x4AC;
        inline constexpr uintptr_t GripRight = 0x488;
        inline constexpr uintptr_t GripUp = 0x494;
        inline constexpr uintptr_t ManualActivationOnly = 0x4BA;
        inline constexpr uintptr_t RequiresHandle = 0x4BB;
        inline constexpr uintptr_t TextureId = 0x360;
        inline constexpr uintptr_t Tooltip = 0x468;
    }

    namespace Types {
        inline constexpr uintptr_t AllTypes = 0x86AD1F8;
    }

    namespace UnionOperation {
        inline constexpr uintptr_t AssetId = 0x308;
    }

    namespace UserInputService {
        inline constexpr uintptr_t WindowInputState = 0x2C0;
    }

    namespace Value {
        inline constexpr uintptr_t Value = 0xB8;
    }

    namespace VehicleSeat {
        inline constexpr uintptr_t MaxSpeed = 0x228;
        inline constexpr uintptr_t Occupant = 0x208;
        inline constexpr uintptr_t SteerFloat = 0x22C;
        inline constexpr uintptr_t ThrottleFloat = 0x230;
        inline constexpr uintptr_t Torque = 0x234;
        inline constexpr uintptr_t TurnSpeed = 0x238;
    }

    namespace VisualEngine {
        inline constexpr uintptr_t Dimensions = 0xAE0;
        inline constexpr uintptr_t FakeDataModel = 0xAC0;
        inline constexpr uintptr_t Pointer = 0x8136228;
        inline constexpr uintptr_t RenderView = 0xC00;
        inline constexpr uintptr_t ViewMatrix = 0x180;
    }

    namespace Weld {
        inline constexpr uintptr_t Part0 = 0x118;
        inline constexpr uintptr_t Part1 = 0x128;
    }

    namespace WeldConstraint {
        inline constexpr uintptr_t Part0 = 0xB8;
        inline constexpr uintptr_t Part1 = 0xC8;
    }

    namespace WindowInputState {
        inline constexpr uintptr_t CapsLock = 0x40;
        inline constexpr uintptr_t CurrentTextBox = 0x48;
    }

    namespace Workspace {
        inline constexpr uintptr_t CurrentCamera = 0x498;
        inline constexpr uintptr_t DistributedGameTime = 0x4B8;
        inline constexpr uintptr_t ReadOnlyGravity = 0x9C0;
        inline constexpr uintptr_t World = 0x3F0;
    }

    namespace World {
        inline constexpr uintptr_t AirProperties = 0x220;
        inline constexpr uintptr_t FallenPartsDestroyHeight = 0x208;
        inline constexpr uintptr_t Gravity = 0x210;
        inline constexpr uintptr_t Primitives = 0x290;
        inline constexpr uintptr_t WorldSteps = 0x708;
    }

} // namespace offsets

namespace enums {
    enum class ReflectionType : int {
        Void = 0x0,
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
        Vector2Int16 = 0xD,
        Vector3Int16 = 0xE,
        Rect2d = 0xF,
        CoordinateFrame = 0x10,
        Color3 = 0x11,
        Color3uint8 = 0x12,
        UDim = 0x13,
        UDim2 = 0x14,
        Faces = 0x15,
        Axes = 0x16,
        Region3 = 0x17,
        Region3Int16 = 0x18,
        CellId = 0x19,
        GuidData = 0x1A,
        PhysicalProperties = 0x1B,
        BrickColor = 0x1C,
        SystemAddress = 0x1D,
        BinaryString = 0x1E,
        Surface = 0x1F,
        Enum = 0x20,
        Property = 0x21,
        Tuple = 0x22,
        ValueArray = 0x23,
        ValueTable = 0x24,
        ValueMap = 0x25,
        Variant = 0x26,
        GenericFunction = 0x27,
        WeakFunctionRef = 0x28,
        ColorSequence = 0x29,
        ColorSequenceKeypoint = 0x2A,
        NumberRange = 0x2B,
        NumberSequence = 0x2C,
        NumberSequenceKeypoint = 0x2D,
        InputObject = 0x2E,
        Connection = 0x2F,
        ContentId = 0x30,
        DescribedBase = 0x31,
        RefType = 0x32,
        QFont = 0x33,
        QDir = 0x34,
        EventInstance = 0x35,
        TweenInfo = 0x36,
        DockWidgetPluginGuiInfo = 0x37,
        PluginDrag = 0x38,
        Random = 0x39,
        PathWaypoint = 0x3A,
        FloatCurveKey = 0x3B,
        RotationCurveKey = 0x3C,
        SharedString = 0x3D,
        DateTime = 0x3E,
        RaycastParams = 0x3F,
        RaycastResult = 0x40,
        OverlapParams = 0x41,
        LazyTable = 0x42,
        DebugTable = 0x43,
        CatalogSearchParams = 0x44,
        OptionalCoordinateFrame = 0x45,
        CSGPropertyData = 0x46,
        UniqueId = 0x47,
        Font = 0x48,
        Blackboard = 0x49,
        Max = 0x4A,
    };

} // namespace enums
