/*
 * Github: https://git.jonah.cool/jonah/roblox-dumper
 * Roblox Version: version-9ac8595712b447a7
 * Time Taken: 4601 ms (4.601000 seconds)
 * Total Offsets: 497
 */

#pragma once
#include <cstdint>

// clang-format off
#pragma pack(push, 1)
namespace structs {

    struct AirProperties {
        char pad_0[0x18];
        float AirDensity;  // 0x18
        char pad_1[0x20];
        Vector3 GlobalWind;  // 0x3C
    };  // sizeof = 0x48

    struct Atmosphere {
        char pad_0[0xA0];
        Color3 Color;  // 0xA0
        Color3 Decay;  // 0xAC
        float Density;  // 0xB8
        float Glare;  // 0xBC
        float Haze;  // 0xC0
        float Offset;  // 0xC4
    };  // sizeof = 0xC8

    struct BasePart {
        char pad_0[0xF4];
        float Reflectance;  // 0xF4
        char pad_1[0x20];
        float Transparency;  // 0x118
        char pad_2[0x4];
        bool CastShadow;  // 0x120
        bool Locked;  // 0x121
        bool Massless;  // 0x122
        char pad_3[0x55];
        uintptr_t Primitive;  // 0x178
        char pad_4[0x20];
        uint8_t Shape;  // 0x1A0
        char pad_5[0x3];
        Color3 Color3;  // 0x1A4
    };  // sizeof = 0x1B0

    struct BloomEffect {
        char pad_0[0xA0];
        float Intensity;  // 0xA0
        float Size;  // 0xA4
        float Threshold;  // 0xA8
    };  // sizeof = 0xAC

    struct CachedItem {
        char pad_0[0x28];
        uintptr_t FileMeshData;  // 0x28
    };  // sizeof = 0x30

    struct Camera {
        char pad_0[0xB0];
        uintptr_t CameraSubject;  // 0xB0
        char pad_1[0x8];
        CFrame CFrame;  // 0xC0
        char pad_2[0x38];
        float FieldOfView;  // 0x128
        char pad_3[0x198];
        Vector2 ViewportSize;  // 0x2C4
    };  // sizeof = 0x2CC

    struct CharacterMesh {
        char pad_0[0x130];
        uint8_t BodyPart;  // 0x130
    };  // sizeof = 0x131

    struct ClassDescriptor {
        char pad_0[0x40];
        uintptr_t PropertyDescriptors;  // 0x40
        char pad_1[0x40];
        uintptr_t EventDescriptors;  // 0x88
        char pad_2[0x40];
        uintptr_t FunctionDescriptors;  // 0xD0
        char pad_3[0x158];
        uintptr_t Creator;  // 0x230  ICreator vtable, [0] = create fn
    };  // sizeof = 0x238

    struct DataModel {
        char pad_0[0x108];
        uintptr_t JobId;  // 0x108
        char pad_1[0x38];
        uintptr_t Workspace;  // 0x148
        char pad_2[0x20];
        uint64_t CreatorId;  // 0x170
        uint64_t GameId;  // 0x178
        uint64_t PlaceId;  // 0x180
        char pad_3[0x428];
        uintptr_t ServerIP;  // 0x5B0
        char pad_4[0x10];
        uint32_t GameLoaded;  // 0x5C8
    };  // sizeof = 0x5CC

    struct Descriptor {
        char pad_0[0x8];
        uintptr_t Name;  // 0x8
    };  // sizeof = 0x10

    struct FakeDataModel {
        char pad_0[0x1F8];
        uintptr_t RealDataModel;  // 0x1F8
    };  // sizeof = 0x200

    struct FileMeshData {
        uintptr_t Vertices;  // 0x0
        uintptr_t VerticesEnd;  // 0x8
        char pad_0[0x20];
        uintptr_t Faces;  // 0x30
        uintptr_t FacesEnd;  // 0x38
        char pad_1[0x140];
        Vector3 AabbMin;  // 0x180
        Vector3 AabbMax;  // 0x18C
    };  // sizeof = 0x198

    struct FunctionDescriptor {
        char pad_0[0x80];
        uintptr_t Function;  // 0x80
    };  // sizeof = 0x88

    struct GuiBase2D {
        char pad_0[0xD0];
        float AbsoluteRotation;  // 0xD0
        char pad_1[0x1C];
        Vector2 AbsolutePosition;  // 0xF0
        char pad_2[0x4];
        Vector2 AbsoluteSize;  // 0xFC
    };  // sizeof = 0x104

    struct GuiObject {
        char pad_0[0xD0];
        float Rotation;  // 0xD0
        char pad_1[0x454];
        Color3 BackgroundColor3;  // 0x528
        Color3 BorderColor3;  // 0x534
        Vector2 AnchorPoint;  // 0x540
        uint8_t AutomaticSize;  // 0x548
        char pad_2[0x3];
        float BackgroundTransparency;  // 0x54C
        uint8_t BorderMode;  // 0x550
        char pad_3[0x3];
        int32_t BorderSizePixel;  // 0x554
        char pad_4[0x8];
        uint8_t GuiState;  // 0x560
        char pad_5[0x3];
        int32_t LayoutOrder;  // 0x564
        char pad_6[0x18];
        int32_t SelectionOrder;  // 0x580
        char pad_7[0x4];
        uint8_t SizeConstraint;  // 0x588
        char pad_8[0x3];
        int32_t ZIndex;  // 0x58C
        bool Active;  // 0x590
        bool ClipsDescendants;  // 0x591
        char pad_9[0x1];
        bool Interactable;  // 0x593
        bool Selectable;  // 0x594
        bool Visible;  // 0x595
    };  // sizeof = 0x596

    struct Highlight {
        char pad_0[0xA0];
        uintptr_t Adornee;  // 0xA0
        char pad_1[0x8];
        Color3 FillColor;  // 0xB0
        Color3 OutlineColor;  // 0xBC
        uint8_t DepthMode;  // 0xC8
        char pad_2[0x3];
        float FillTransparency;  // 0xCC
        char pad_3[0x4];
        float OutlineTransparency;  // 0xD4
        char pad_4[0x4];
        bool Enabled;  // 0xDC
    };  // sizeof = 0xDD

    struct HopperBin {
        char pad_0[0x450];
        uint32_t BinType;  // 0x450
    };  // sizeof = 0x454

    struct Humanoid {
        char pad_0[0xF0];
        uintptr_t SeatPart;  // 0xF0
        char pad_1[0x18];
        Vector3 CameraOffset;  // 0x110
        char pad_2[0x24];
        Vector3 TargetPoint;  // 0x140
        char pad_3[0xC];
        Vector3 WalkToPoint;  // 0x158
        char pad_4[0x10];
        uint8_t DisplayDistanceType;  // 0x174
        char pad_5[0x7];
        float HealthDisplayDistance;  // 0x17C
        uint8_t HealthDisplayType;  // 0x180
        char pad_6[0x3];
        float Health;  // 0x184
        float HipHeight;  // 0x188
        char pad_7[0x8];
        float JumpHeight;  // 0x194
        float JumpPower;  // 0x198
        float MaxHealth;  // 0x19C
        float MaxSlopeAngle;  // 0x1A0
        float NameDisplayDistance;  // 0x1A4
        uint8_t NameOcclusion;  // 0x1A8
        char pad_8[0xB];
        uint8_t RigType;  // 0x1B4
        char pad_9[0xF];
        float WalkSpeed;  // 0x1C4
        bool AutoJumpEnabled;  // 0x1C8
        bool AutoRotate;  // 0x1C9
        bool AutomaticScalingEnabled;  // 0x1CA
        bool BreakJointsOnDeath;  // 0x1CB
        bool EvaluateStateMachine;  // 0x1CC
        char pad_10[0x5];
        bool RequiresNeck;  // 0x1D2
        bool Sit;  // 0x1D3
        char pad_11[0x1];
        bool UseJumpPower;  // 0x1D5
        char pad_12[0x1C6];
        float WalkSpeedCheck;  // 0x39C
    };  // sizeof = 0x3A0

    struct InputObject {
        char pad_0[0xD4];
        Vector2 MousePosition;  // 0xD4
    };  // sizeof = 0xDC

    struct Instance {
        char pad_0[0x18];
        uintptr_t ClassDescriptor;  // 0x18
        char pad_1[0x40];
        uintptr_t Parent;  // 0x60
        uintptr_t NameContainer;  // 0x68
        uintptr_t ChildrenStart;  // 0x70
    };  // sizeof = 0x78

    struct Lighting {
        char pad_0[0xB0];
        uint64_t ClockTime;  // 0xB0
        Color3 Ambient;  // 0xB8
        Color3 ColorShift_Bottom;  // 0xC4
        Color3 ColorShift_Top;  // 0xD0
        Color3 FogColor;  // 0xDC
        Color3 OutdoorAmbient;  // 0xE8
        char pad_1[0xC];
        float Brightness;  // 0x100
        float EnvironmentDiffuseScale;  // 0x104
        float EnvironmentSpecularScale;  // 0x108
        float ExposureCompensation;  // 0x10C
        char pad_2[0x4];
        float FogEnd;  // 0x114
        float FogStart;  // 0x118
        char pad_3[0x8];
        float ShadowSoftness;  // 0x124
        char pad_4[0x88];
        uintptr_t Sky;  // 0x1B0
        char pad_5[0x8];
        uintptr_t Atmosphere;  // 0x1C0
    };  // sizeof = 0x1C8

    struct LightingParameters {
        char pad_0[0x11C];
        float GeographicLatitude;  // 0x11C
        Vector3 SkyAmbient2;  // 0x120
        char pad_1[0xC];
        Vector3 SkyAmbient;  // 0x138
        Vector3 LightColor;  // 0x144
        Vector3 LightDirection;  // 0x150
        uint8_t Source;  // 0x15C
        char pad_2[0x3];
        Vector3 TrueSunPosition;  // 0x160
        Vector3 TrueMoonPosition;  // 0x16C
    };  // sizeof = 0x178

    struct LruHolder {
        char pad_0[0x20];
        uintptr_t MemEnforcedLRUCache;  // 0x20
    };  // sizeof = 0x28

    struct LruNode {
        uintptr_t Next;  // 0x0
        char pad_0[0x8];
        uintptr_t MeshId;  // 0x10
        char pad_1[0x20];
        uintptr_t CachedItem;  // 0x38
    };  // sizeof = 0x40

    struct MemEnforcedLRUCache {
        char pad_0[0x8];
        uintptr_t Head;  // 0x8
    };  // sizeof = 0x10

    struct MeshContentProvider {
        char pad_0[0xC0];
        uintptr_t LruHolder;  // 0xC0
    };  // sizeof = 0xC8

    struct Model {
        char pad_0[0x12C];
        float Scale;  // 0x12C
        char pad_1[0x110];
        uintptr_t PrimaryPart;  // 0x240
    };  // sizeof = 0x248

    struct MouseService {
        char pad_0[0xE8];
        uintptr_t InputObject;  // 0xE8
    };  // sizeof = 0xF0

    struct Player {
        char pad_0[0xB8];
        uint64_t UserId;  // 0xB8
        char pad_1[0x1D0];
        uintptr_t Character;  // 0x290
        char pad_2[0x38];
        uintptr_t Team;  // 0x2D0
        char pad_3[0x7C];
        uint32_t AccountAge;  // 0x354
        char pad_4[0x34];
        float HealthDisplayDistance;  // 0x38C
        char pad_5[0xC];
        float NameDisplayDistance;  // 0x39C
        char pad_6[0x8];
        uint32_t TeamColor;  // 0x3A8
    };  // sizeof = 0x3AC

    struct Players {
        char pad_0[0x118];
        uintptr_t LocalPlayer;  // 0x118
    };  // sizeof = 0x120

    struct Primitive {
        char pad_0[0xB0];
        CFrame CFrame;  // 0xB0
        Vector3 AssemblyLinearVelocity;  // 0xE0
        Vector3 AssemblyAngularVelocity;  // 0xEC
        char pad_1[0xC6];
        uint8_t PrimitiveFlags;  // 0x1BE
        char pad_2[0x5];
        Vector3 Size;  // 0x1C4
        char pad_3[0x48];
        uintptr_t Part;  // 0x218
        char pad_4[0x2E];
        uint16_t Material;  // 0x24E
    };  // sizeof = 0x250

    struct PropertyDescriptor {
        char pad_0[0x70];
        uintptr_t TType;  // 0x70
        char pad_1[0x30];
        uintptr_t GetSetImpl;  // 0xA8
    };  // sizeof = 0xB0

    struct ProximityPrompt {
        char pad_0[0x108];
        float HoldDuration;  // 0x108
        uint32_t KeyboardKeyCode;  // 0x10C
        float MaxActivationDistance;  // 0x110
        char pad_1[0xA];
        bool Enabled;  // 0x11E
        bool RequiresLineOfSight;  // 0x11F
    };  // sizeof = 0x120

    struct RenderView {
        char pad_0[0x8];
        uintptr_t DeviceD3D11;  // 0x8
        char pad_1[0x268];
        uint16_t LightingValid;  // 0x278
        char pad_2[0x13];
        uint16_t SkyboxValid;  // 0x28D
    };  // sizeof = 0x28F

    struct Seat {
        char pad_0[0x200];
        uintptr_t Occupant;  // 0x200
    };  // sizeof = 0x208

    struct Sky {
        char pad_0[0x220];
        Vector3 SkyboxOrientation;  // 0x220
        float MoonAngularSize;  // 0x22C
        uint32_t StarCount;  // 0x230
        float SunAngularSize;  // 0x234
    };  // sizeof = 0x238

    struct SpecialMesh {
        char pad_0[0xA0];
        Vector3 Offset;  // 0xA0
        Vector3 Scale;  // 0xAC
    };  // sizeof = 0xB8

    struct TaskScheduler {
        char pad_0[0xC8];
        uintptr_t JobStart;  // 0xC8
        uintptr_t JobEnd;  // 0xD0
    };  // sizeof = 0xD8

    struct Team {
        char pad_0[0xA0];
        uint32_t TeamColor;  // 0xA0
    };  // sizeof = 0xA4

    struct Terrain {
        char pad_0[0x1C8];
        Color3 WaterColor;  // 0x1C8
        char pad_1[0x4];
        float GrassLength;  // 0x1D8
        char pad_2[0x4];
        float WaterReflectance;  // 0x1E0
        float WaterTransparency;  // 0x1E4
        float WaterWaveSize;  // 0x1E8
        float WaterWaveSpeed;  // 0x1EC
        char pad_3[0x88];
        uintptr_t MaterialColors;  // 0x278
    };  // sizeof = 0x280

    struct TextButton {
        char pad_0[0xA14];
        bool AutoButtonColor;  // 0xA14
        bool Modal;  // 0xA15
        bool Selected;  // 0xA16
        char pad_1[0x551];
        float LineHeight;  // 0xF68
        char pad_2[0x44];
        uint8_t TextYAlignment;  // 0xFB0
        char pad_3[0x57];
        uint8_t TextDirection;  // 0x1008
        char pad_4[0x55];
        bool TextScaled;  // 0x105E
        char pad_5[0x1];
        bool TextWrapped;  // 0x1060
        char pad_6[0x5];
        bool RichText;  // 0x1066
        char pad_7[0x101];
        Color3 TextColor3;  // 0x1168
        Color3 TextStrokeColor3;  // 0x1174
        char pad_8[0x4];
        int32_t MaxVisibleGraphemes;  // 0x1184
        char pad_9[0x4];
        float TextSize;  // 0x118C
        float TextStrokeTransparency;  // 0x1190
        float TextTransparency;  // 0x1194
        uint8_t TextTruncate;  // 0x1198
        char pad_10[0x3];
        uint8_t TextXAlignment;  // 0x119C
    };  // sizeof = 0x119D

    struct TextLabel {
        char pad_0[0xCE8];
        float LineHeight;  // 0xCE8
        char pad_1[0x44];
        uint8_t TextYAlignment;  // 0xD30
        char pad_2[0x57];
        uint8_t TextDirection;  // 0xD88
        char pad_3[0x55];
        bool TextScaled;  // 0xDDE
        char pad_4[0x1];
        bool TextWrapped;  // 0xDE0
        char pad_5[0x5];
        bool RichText;  // 0xDE6
        char pad_6[0x101];
        Color3 TextColor3;  // 0xEE8
        Color3 TextStrokeColor3;  // 0xEF4
        char pad_7[0x4];
        int32_t MaxVisibleGraphemes;  // 0xF04
        char pad_8[0x4];
        float TextSize;  // 0xF0C
        float TextStrokeTransparency;  // 0xF10
        float TextTransparency;  // 0xF14
        uint8_t TextTruncate;  // 0xF18
        char pad_9[0x3];
        uint8_t TextXAlignment;  // 0xF1C
    };  // sizeof = 0xF1D

    struct Tool {
        char pad_0[0x470];
        CFrame Grip;  // 0x470
        bool CanBeDropped;  // 0x4A0
        bool Enabled;  // 0x4A1
        bool ManualActivationOnly;  // 0x4A2
        bool RequiresHandle;  // 0x4A3
    };  // sizeof = 0x4A4

    struct VehicleSeat {
        char pad_0[0x1F0];
        uintptr_t Occupant;  // 0x1F0
        char pad_1[0x18];
        float MaxSpeed;  // 0x210
        float SteerFloat;  // 0x214
        float ThrottleFloat;  // 0x218
        float Torque;  // 0x21C
        float TurnSpeed;  // 0x220
    };  // sizeof = 0x224

    struct VisualEngine {
        char pad_0[0x1B0];
        Matrix4x4 ViewMatrix;  // 0x1B0
        char pad_1[0x900];
        uintptr_t FakeDataModel;  // 0xAF0
        char pad_2[0x18];
        Vector2 Dimensions;  // 0xB10
        char pad_3[0x128];
        uintptr_t RenderView;  // 0xC40
    };  // sizeof = 0xC48

    struct Workspace {
        char pad_0[0x3F8];
        uintptr_t World;  // 0x3F8
        char pad_1[0xA0];
        uintptr_t CurrentCamera;  // 0x4A0
        char pad_2[0x520];
        float ReadOnlyGravity;  // 0x9C8
    };  // sizeof = 0x9CC

    struct World {
        char pad_0[0x220];
        float Gravity;  // 0x220
        char pad_1[0x14];
        uintptr_t AirProperties;  // 0x238
        char pad_2[0x68];
        uintptr_t Primitives;  // 0x2A8
        char pad_3[0x5B0];
        float WorldSteps;  // 0x860
    };  // sizeof = 0x864

} // namespace structs
#pragma pack(pop)
