/*
 * Github: https://git.jonah.cool/jonah/roblox-dumper
 * Roblox Version: version-2366ba214ec740ca
 * Time Taken: 6467 ms (6.467000 seconds)
 * Total Offsets: 495
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
        char pad_0[0xA8];
        Color3 Color;  // 0xA8
        Color3 Decay;  // 0xB4
        float Density;  // 0xC0
        float Glare;  // 0xC4
        float Haze;  // 0xC8
        float Offset;  // 0xCC
    };  // sizeof = 0xD0

    struct BasePart {
        char pad_0[0xFC];
        float Reflectance;  // 0xFC
        char pad_1[0x20];
        float Transparency;  // 0x120
        char pad_2[0x1];
        bool CastShadow;  // 0x125
        bool Locked;  // 0x126
        bool Massless;  // 0x127
        char pad_3[0x50];
        uintptr_t Primitive;  // 0x178
        char pad_4[0x18];
        Color3 Color3;  // 0x198
        char pad_5[0x4];
        uint8_t Shape;  // 0x1A8
    };  // sizeof = 0x1A9

    struct BloomEffect {
        char pad_0[0xA8];
        float Intensity;  // 0xA8
        float Size;  // 0xAC
        float Threshold;  // 0xB0
    };  // sizeof = 0xB4

    struct CachedItem {
        char pad_0[0x40];
        uintptr_t FileMeshData;  // 0x40
    };  // sizeof = 0x48

    struct Camera {
        char pad_0[0xB8];
        uintptr_t CameraSubject;  // 0xB8
        char pad_1[0x8];
        CFrame CFrame;  // 0xC8
        char pad_2[0x38];
        float FieldOfView;  // 0x130
        char pad_3[0x188];
        Vector2 ViewportSize;  // 0x2BC
    };  // sizeof = 0x2C4

    struct CharacterMesh {
        char pad_0[0x138];
        uint8_t BodyPart;  // 0x138
    };  // sizeof = 0x139

    struct ClassDescriptor {
        char pad_0[0x40];
        uintptr_t PropertyDescriptors;  // 0x40
        char pad_1[0x40];
        uintptr_t EventDescriptors;  // 0x88
        char pad_2[0x40];
        uintptr_t FunctionDescriptors;  // 0xD0
    };  // sizeof = 0xD8

    struct DataModel {
        char pad_0[0x110];
        uintptr_t JobId;  // 0x110
        char pad_1[0x38];
        uintptr_t Workspace;  // 0x150
        char pad_2[0x20];
        uint64_t CreatorId;  // 0x178
        uint64_t GameId;  // 0x180
        uint64_t PlaceId;  // 0x188
        char pad_3[0x428];
        uintptr_t ServerIP;  // 0x5B8
        char pad_4[0x10];
        uint32_t GameLoaded;  // 0x5D0
    };  // sizeof = 0x5D4

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
        char pad_0[0xD8];
        float AbsoluteRotation;  // 0xD8
        char pad_1[0x1C];
        Vector2 AbsolutePosition;  // 0xF8
        char pad_2[0x4];
        Vector2 AbsoluteSize;  // 0x104
    };  // sizeof = 0x10C

    struct GuiObject {
        char pad_0[0xD8];
        float Rotation;  // 0xD8
        char pad_1[0x454];
        Color3 BackgroundColor3;  // 0x530
        Color3 BorderColor3;  // 0x53C
        Vector2 AnchorPoint;  // 0x548
        uint8_t AutomaticSize;  // 0x550
        char pad_2[0x3];
        float BackgroundTransparency;  // 0x554
        uint8_t BorderMode;  // 0x558
        char pad_3[0x3];
        int32_t BorderSizePixel;  // 0x55C
        char pad_4[0x8];
        uint8_t GuiState;  // 0x568
        char pad_5[0x3];
        int32_t LayoutOrder;  // 0x56C
        char pad_6[0x18];
        int32_t SelectionOrder;  // 0x588
        char pad_7[0x4];
        uint8_t SizeConstraint;  // 0x590
        char pad_8[0x3];
        int32_t ZIndex;  // 0x594
        bool Active;  // 0x598
        bool ClipsDescendants;  // 0x599
        char pad_9[0x1];
        bool Interactable;  // 0x59B
        bool Selectable;  // 0x59C
        bool Visible;  // 0x59D
    };  // sizeof = 0x59E

    struct Highlight {
        char pad_0[0xA8];
        uintptr_t Adornee;  // 0xA8
        char pad_1[0x8];
        Color3 FillColor;  // 0xB8
        Color3 OutlineColor;  // 0xC4
        uint8_t DepthMode;  // 0xD0
        char pad_2[0x3];
        float FillTransparency;  // 0xD4
        char pad_3[0x4];
        float OutlineTransparency;  // 0xDC
        char pad_4[0x4];
        bool Enabled;  // 0xE4
    };  // sizeof = 0xE5

    struct HopperBin {
        char pad_0[0x458];
        uint32_t BinType;  // 0x458
    };  // sizeof = 0x45C

    struct Humanoid {
        char pad_0[0xF8];
        uintptr_t SeatPart;  // 0xF8
        char pad_1[0x18];
        Vector3 CameraOffset;  // 0x118
        char pad_2[0x18];
        Vector3 TargetPoint;  // 0x13C
        char pad_3[0xC];
        Vector3 WalkToPoint;  // 0x154
        char pad_4[0x10];
        uint8_t DisplayDistanceType;  // 0x170
        char pad_5[0x7];
        float HealthDisplayDistance;  // 0x178
        uint8_t HealthDisplayType;  // 0x17C
        char pad_6[0x3];
        float Health;  // 0x180
        float HipHeight;  // 0x184
        char pad_7[0x8];
        float JumpHeight;  // 0x190
        float JumpPower;  // 0x194
        float MaxHealth;  // 0x198
        float MaxSlopeAngle;  // 0x19C
        float NameDisplayDistance;  // 0x1A0
        uint8_t NameOcclusion;  // 0x1A4
        char pad_8[0xB];
        uint8_t RigType;  // 0x1B0
        char pad_9[0xF];
        float WalkSpeed;  // 0x1C0
        bool AutoJumpEnabled;  // 0x1C4
        bool AutoRotate;  // 0x1C5
        bool AutomaticScalingEnabled;  // 0x1C6
        bool BreakJointsOnDeath;  // 0x1C7
        bool EvaluateStateMachine;  // 0x1C8
        char pad_10[0x4];
        bool RequiresNeck;  // 0x1CD
        bool Sit;  // 0x1CE
        char pad_11[0x1];
        bool UseJumpPower;  // 0x1D0
        char pad_12[0x1CB];
        float WalkSpeedCheck;  // 0x39C
    };  // sizeof = 0x3A0

    struct InputObject {
        char pad_0[0xD4];
        Vector2 MousePosition;  // 0xD4
    };  // sizeof = 0xDC

    struct Instance {
        char pad_0[0x18];
        uintptr_t ClassDescriptor;  // 0x18
        char pad_1[0x48];
        uintptr_t Parent;  // 0x68
        uintptr_t NameContainer;  // 0x70
        uintptr_t ChildrenStart;  // 0x78
    };  // sizeof = 0x80

    struct Lighting {
        char pad_0[0xB8];
        uint64_t ClockTime;  // 0xB8
        Color3 Ambient;  // 0xC0
        Color3 ColorShift_Bottom;  // 0xCC
        Color3 ColorShift_Top;  // 0xD8
        Color3 FogColor;  // 0xE4
        Color3 OutdoorAmbient;  // 0xF0
        char pad_1[0xC];
        float Brightness;  // 0x108
        float EnvironmentDiffuseScale;  // 0x10C
        float EnvironmentSpecularScale;  // 0x110
        float ExposureCompensation;  // 0x114
        char pad_2[0x4];
        float FogEnd;  // 0x11C
        float FogStart;  // 0x120
        char pad_3[0x8];
        float ShadowSoftness;  // 0x12C
        char pad_4[0x88];
        uintptr_t Sky;  // 0x1B8
        char pad_5[0x8];
        uintptr_t Atmosphere;  // 0x1C8
    };  // sizeof = 0x1D0

    struct LightingParameters {
        char pad_0[0x124];
        float GeographicLatitude;  // 0x124
        Vector3 SkyAmbient2;  // 0x128
        char pad_1[0xC];
        Vector3 SkyAmbient;  // 0x140
        Vector3 LightColor;  // 0x14C
        Vector3 LightDirection;  // 0x158
        uint8_t Source;  // 0x164
        char pad_2[0x3];
        Vector3 TrueSunPosition;  // 0x168
        Vector3 TrueMoonPosition;  // 0x174
    };  // sizeof = 0x180

    struct LruHolder {
        char pad_0[0x20];
        uintptr_t MemEnforcedLRUCache;  // 0x20
    };  // sizeof = 0x28

    struct LruNode {
        uintptr_t Next;  // 0x0
        char pad_0[0x8];
        uintptr_t MeshId;  // 0x10
        char pad_1[0x28];
        uintptr_t CachedItem;  // 0x40
    };  // sizeof = 0x48

    struct MemEnforcedLRUCache {
        char pad_0[0x8];
        uintptr_t Head;  // 0x8
    };  // sizeof = 0x10

    struct MeshContentProvider {
        char pad_0[0xC8];
        uintptr_t LruHolder;  // 0xC8
    };  // sizeof = 0xD0

    struct Model {
        char pad_0[0x134];
        float Scale;  // 0x134
        char pad_1[0x110];
        uintptr_t PrimaryPart;  // 0x248
    };  // sizeof = 0x250

    struct MouseService {
        char pad_0[0xF0];
        uintptr_t InputObject;  // 0xF0
    };  // sizeof = 0xF8

    struct Player {
        char pad_0[0xC0];
        uint64_t UserId;  // 0xC0
        char pad_1[0x1C0];
        uintptr_t Character;  // 0x288
        char pad_2[0x38];
        uintptr_t Team;  // 0x2C8
        char pad_3[0x7C];
        uint32_t AccountAge;  // 0x34C
        char pad_4[0x34];
        float HealthDisplayDistance;  // 0x384
        char pad_5[0xC];
        float NameDisplayDistance;  // 0x394
        char pad_6[0x8];
        uint32_t TeamColor;  // 0x3A0
    };  // sizeof = 0x3A4

    struct Players {
        char pad_0[0x120];
        uintptr_t LocalPlayer;  // 0x120
    };  // sizeof = 0x128

    struct Primitive {
        char pad_0[0xB0];
        CFrame CFrame;  // 0xB0
        Vector3 AssemblyLinearVelocity;  // 0xE0
        Vector3 AssemblyAngularVelocity;  // 0xEC
        char pad_1[0xBE];
        uint8_t PrimitiveFlags;  // 0x1B6
        char pad_2[0x5];
        Vector3 Size;  // 0x1BC
        char pad_3[0x48];
        uintptr_t Part;  // 0x210
        char pad_4[0x2E];
        uint16_t Material;  // 0x246
    };  // sizeof = 0x248

    struct PropertyDescriptor {
        char pad_0[0x68];
        uintptr_t TType;  // 0x68
        char pad_1[0x20];
        uintptr_t GetSetImpl;  // 0x90
    };  // sizeof = 0x98

    struct ProximityPrompt {
        char pad_0[0x110];
        float HoldDuration;  // 0x110
        uint32_t KeyboardKeyCode;  // 0x114
        float MaxActivationDistance;  // 0x118
        char pad_1[0xA];
        bool Enabled;  // 0x126
        bool RequiresLineOfSight;  // 0x127
    };  // sizeof = 0x128

    struct RenderView {
        char pad_0[0x8];
        uintptr_t DeviceD3D11;  // 0x8
        char pad_1[0x268];
        uint16_t LightingValid;  // 0x278
        char pad_2[0x13];
        uint16_t SkyboxValid;  // 0x28D
    };  // sizeof = 0x28F

    struct Seat {
        char pad_0[0x208];
        uintptr_t Occupant;  // 0x208
    };  // sizeof = 0x210

    struct Sky {
        char pad_0[0x228];
        Vector3 SkyboxOrientation;  // 0x228
        float MoonAngularSize;  // 0x234
        uint32_t StarCount;  // 0x238
        float SunAngularSize;  // 0x23C
    };  // sizeof = 0x240

    struct SpecialMesh {
        char pad_0[0xA8];
        Vector3 Offset;  // 0xA8
        Vector3 Scale;  // 0xB4
    };  // sizeof = 0xC0

    struct TaskScheduler {
        char pad_0[0xC8];
        uintptr_t JobStart;  // 0xC8
        uintptr_t JobEnd;  // 0xD0
    };  // sizeof = 0xD8

    struct Team {
        char pad_0[0xA8];
        uint32_t TeamColor;  // 0xA8
    };  // sizeof = 0xAC

    struct Terrain {
        char pad_0[0x1D0];
        Color3 WaterColor;  // 0x1D0
        char pad_1[0x4];
        float GrassLength;  // 0x1E0
        char pad_2[0x4];
        float WaterReflectance;  // 0x1E8
        float WaterTransparency;  // 0x1EC
        float WaterWaveSize;  // 0x1F0
        float WaterWaveSpeed;  // 0x1F4
        char pad_3[0x2B0];
        uintptr_t MaterialColors;  // 0x4A8
    };  // sizeof = 0x4B0

    struct TextButton {
        char pad_0[0x9CC];
        bool AutoButtonColor;  // 0x9CC
        bool Modal;  // 0x9CD
        bool Selected;  // 0x9CE
        char pad_1[0x422];
        bool TextScaled;  // 0xDF1
        char pad_2[0x12E];
        float LineHeight;  // 0xF20
        char pad_3[0x44];
        uint8_t TextYAlignment;  // 0xF68
        char pad_4[0x57];
        uint8_t TextDirection;  // 0xFC0
        char pad_5[0x57];
        bool TextWrapped;  // 0x1018
        char pad_6[0x5];
        bool RichText;  // 0x101E
        char pad_7[0x101];
        Color3 TextColor3;  // 0x1120
        Color3 TextStrokeColor3;  // 0x112C
        char pad_8[0x4];
        int32_t MaxVisibleGraphemes;  // 0x113C
        char pad_9[0x4];
        float TextSize;  // 0x1144
        float TextStrokeTransparency;  // 0x1148
        float TextTransparency;  // 0x114C
        uint8_t TextTruncate;  // 0x1150
        char pad_10[0x3];
        uint8_t TextXAlignment;  // 0x1154
    };  // sizeof = 0x1155

    struct TextLabel {
        char pad_0[0xCA0];
        float LineHeight;  // 0xCA0
        char pad_1[0x44];
        uint8_t TextYAlignment;  // 0xCE8
        char pad_2[0x57];
        uint8_t TextDirection;  // 0xD40
        char pad_3[0x55];
        bool TextScaled;  // 0xD96
        char pad_4[0x1];
        bool TextWrapped;  // 0xD98
        char pad_5[0x5];
        bool RichText;  // 0xD9E
        char pad_6[0x101];
        Color3 TextColor3;  // 0xEA0
        Color3 TextStrokeColor3;  // 0xEAC
        char pad_7[0x4];
        int32_t MaxVisibleGraphemes;  // 0xEBC
        char pad_8[0x4];
        float TextSize;  // 0xEC4
        float TextStrokeTransparency;  // 0xEC8
        float TextTransparency;  // 0xECC
        uint8_t TextTruncate;  // 0xED0
        char pad_9[0x3];
        uint8_t TextXAlignment;  // 0xED4
    };  // sizeof = 0xED5

    struct Tool {
        char pad_0[0x478];
        CFrame Grip;  // 0x478
        bool CanBeDropped;  // 0x4A8
        bool Enabled;  // 0x4A9
        bool ManualActivationOnly;  // 0x4AA
        bool RequiresHandle;  // 0x4AB
    };  // sizeof = 0x4AC

    struct VehicleSeat {
        char pad_0[0x1F8];
        uintptr_t Occupant;  // 0x1F8
        char pad_1[0x18];
        float MaxSpeed;  // 0x218
        float SteerFloat;  // 0x21C
        float ThrottleFloat;  // 0x220
        float Torque;  // 0x224
        float TurnSpeed;  // 0x228
    };  // sizeof = 0x22C

    struct VisualEngine {
        char pad_0[0x1B0];
        Matrix4x4 ViewMatrix;  // 0x1B0
        char pad_1[0x900];
        uintptr_t FakeDataModel;  // 0xAF0
        char pad_2[0x18];
        Vector2 Dimensions;  // 0xB10
        char pad_3[0x118];
        uintptr_t RenderView;  // 0xC30
    };  // sizeof = 0xC38

    struct Workspace {
        char pad_0[0x400];
        uintptr_t World;  // 0x400
        char pad_1[0xA0];
        uintptr_t CurrentCamera;  // 0x4A8
        char pad_2[0x540];
        float ReadOnlyGravity;  // 0x9F0
    };  // sizeof = 0x9F4

    struct World {
        char pad_0[0x228];
        float Gravity;  // 0x228
        char pad_1[0x14];
        uintptr_t AirProperties;  // 0x240
        char pad_2[0x68];
        uintptr_t Primitives;  // 0x2B0
        char pad_3[0x470];
        float WorldSteps;  // 0x728
    };  // sizeof = 0x72C

} // namespace structs
#pragma pack(pop)
