-- // Service and Module \\ --

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players") 

local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local Module = {
    Added = {},
    Function = {},

    Game = {
        Crates = Workspace.Buildings.Loots.Loots.Crates,
        Drops = Workspace.Buildings.Loots.Items,
        Tripwires = Workspace.Buildings.EnvInteractable.Mines.Tripmines,
        Barrels = Workspace.Buildings.EventObjects.ExplosiveBarrels,
        Sentries = Workspace.Buildings.EventObjects.Sentries,
        Entities = nil
    },

    Original = {
        GrassLength = nil,
        GrassDefault = 0.5
    },
    
    Stored = {
        Objects = {},
        Entities = {}
    }
}

local Items = {
    [".338 Lapua Magnum"] = {
        Tier = "Mythic",
        Category = "Ammo",
        Price = 0,
        SellPrice = 450
    },
    [".408 Cheyenne Tactical"] = {
        Tier = "Mythic",
        Category = "Ammo",
        Price = 0,
        SellPrice = 630
    },
    [".45 ACP"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 13
    },
    [".50 Action Express"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 15
    },
    ["0.2 BTC"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 248788,
        SellPrice = 129369
    },
    ["12 Gauge Buckshot"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 13
    },
    ["23x75mm Shrapnel-10"] = {
        Tier = "Mythic",
        Category = "Ammo",
        Price = 0,
        SellPrice = 337
    },
    ["23x75mm Zvezda flashbang round"] = {
        Tier = "Mythic",
        Category = "Ammo",
        Price = 0,
        SellPrice = 292
    },
    ["4.6x30mm"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 15
    },
    ["40x46mm M406 grenade"] = {
        Tier = "Mythic",
        Category = "Ammo",
        Price = 0,
        SellPrice = 1440
    },
    ["5.11 Hexgrid Plate Carrier"] = {
        Tier = "Mythic",
        Category = "Armor",
        Price = 7500,
        SellPrice = 3375
    },
    ["5.45x39mm"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 25
    },
    ["5.56x45 Beta C-Mag 100-round drum magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 650,
        SellPrice = 221
    },
    ["5.56x45 Colt AR-15 STANAG 20-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 120,
        SellPrice = 40
    },
    ["5.56x45 Colt AR-15 STANAG 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["5.56x45 Colt AR-15 STANAG 60-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 400,
        SellPrice = 136
    },
    ["5.56x45 PMAG 60-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 550,
        SellPrice = 187
    },
    ["5.56x45 TV 100-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 800,
        SellPrice = 272
    },
    ["5.56x45mm NATO"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 25
    },
    ["5.7x28mm"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 15
    },
    ["5.8x42mm"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 25
    },
    ["7.62x39mm"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 30
    },
    ["7.62x51mm NATO"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 40
    },
    ["7.62x54mmR"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 40
    },
    ["9x18mm"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 10
    },
    ["9x19mm"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 13
    },
    ["9x39 20-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 230,
        SellPrice = 78
    },
    ["9x39 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 400,
        SellPrice = 136
    },
    ["9x39mm"] = {
        Tier = "Uncommon",
        Category = "Ammo",
        Price = 0,
        SellPrice = 34
    },
    ["A7 Delta Riot Helmet"] = {
        Tier = "Common",
        Category = "Helmet",
        Price = 1800,
        SellPrice = 1026
    },
    ["AA Battery"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 150,
        SellPrice = 63
    },
    ["ACOG TA11D 3.5x35 riflescope"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 2400,
        SellPrice = 816
    },
    ["AK 7.62x39 40-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 200,
        SellPrice = 68
    },
    ["AK 7.62x39 Magpul PMAG 30 GEN M3 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["AK-1 Helm"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 17500,
        SellPrice = 7000
    },
    ["AK-74 5.45x39 6L20 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["AK-74 5.45x39 Magpul PMAG 30 GEN M3 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["Alien on a Rampage Book"] = {
        Tier = "Common",
        Category = "Documents",
        Price = 500,
        SellPrice = 210
    },
    ["Altyn bulletproof Helmet"] = {
        Tier = "Mythic",
        Category = "Helmet",
        Price = 6400,
        SellPrice = 2880
    },
    ["Altyn helmet face shield"] = {
        Tier = "Rare",
        Category = "Equipment",
        Price = 2850,
        SellPrice = 1624
    },
    ["Aluminium Nails"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 350,
        SellPrice = 147
    },
    ["Ammunition case"] = {
        Tier = "Usable",
        Category = "Container",
        Price = 0,
        SellPrice = 1
    },
    ["AN/PEQ-15 tactical device"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 850,
        SellPrice = 289
    },
    ["Angled foregrip"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 750,
        SellPrice = 255
    },
    ["Antique teapot"] = {
        Tier = "Rare",
        Category = "Households",
        Price = 3500,
        SellPrice = 1820
    },
    ["Awl"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 350,
        SellPrice = 147
    },
    ["AWP .338 Lapua Magnum 5-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 350,
        SellPrice = 119
    },
    ["Bad Guys"] = {
        Tier = "Common",
        Category = "Documents",
        Price = 500,
        SellPrice = 210
    },
    ["Beretta 92X 9x19 17-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 100,
        SellPrice = 34
    },
    ["Bimetallic Thermometer"] = {
        Tier = "Rare",
        Category = "Tools",
        Price = 3500,
        SellPrice = 1820
    },
    ["Blackberryz Wallet"] = {
        Tier = "Usable",
        Category = "Container",
        Price = 0,
        SellPrice = 11250
    },
    ["Blahaj Baja Blast Pen"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 15000,
        SellPrice = 6000
    },
    ["Box of Sugar"] = {
        Tier = "Common",
        Category = "Households",
        Price = 400,
        SellPrice = 280
    },
    ["Bramit 7.62x54R sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 1250,
        SellPrice = 425
    },
    ["Cables"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 250,
        SellPrice = 105
    },
    ["Can of Beef"] = {
        Tier = "Rare",
        Category = "Households",
        Price = 180,
        SellPrice = 93
    },
    ["Can of Mackerel"] = {
        Tier = "Common",
        Category = "Households",
        Price = 180,
        SellPrice = 125
    },
    ["Can of Salt"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["Can of Tuna"] = {
        Tier = "Common",
        Category = "Households",
        Price = 180,
        SellPrice = 125
    },
    ["Capacitors"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 550,
        SellPrice = 231
    },
    ["Car Battery"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 3200,
        SellPrice = 1344
    },
    ["Cash"] = {
        Tier = "Cash",
        Category = "Money",
        Price = 1,
        SellPrice = 1
    },
    ["Chemical Solution"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 650,
        SellPrice = 273
    },
    ["CJJ’s Guide to Making Money"] = {
        Tier = "Common",
        Category = "Documents",
        Price = 500,
        SellPrice = 210
    },
    ["CMT ZCOMP linear compensator"] = {
        Tier = "Mythic",
        Category = "Attachments",
        Price = 1450,
        SellPrice = 652
    },
    ["Colt 4x20 riflescope"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 1250,
        SellPrice = 425
    },
    ["Compact antenna"] = {
        Tier = "Rare",
        Category = "Buildings",
        Price = 3500,
        SellPrice = 1820
    },
    ["Conductor's Gold Pocket Watch"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 2800,
        SellPrice = 1456
    },
    ["Construction Measuring Tape"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 350,
        SellPrice = 147
    },
    ["Corrugated Tube"] = {
        Tier = "Rare",
        Category = "Buildings",
        Price = 1150,
        SellPrice = 598
    },
    ["Cottage Cache Key"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 1500,
        SellPrice = 525
    },
    ["Dawnscript Fragment"] = {
        Tier = "Rare",
        Category = "Documents",
        Price = 3100,
        SellPrice = 1612
    },
    ["DC 800 High Cut Combat Helmet"] = {
        Tier = "Rare",
        Category = "Helmet",
        Price = 2400,
        SellPrice = 1367
    },
    ["Deagle .50 AE 7-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 100,
        SellPrice = 34
    },
    ["Defibrillator monitor"] = {
        Tier = "Rare",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1664
    },
    ["Deluxe Pirate Hook"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 2850,
        SellPrice = 1482
    },
    ["Deodorant"] = {
        Tier = "Common",
        Category = "Households",
        Price = 450,
        SellPrice = 315
    },
    ["Diamond ring"] = {
        Tier = "Mythic",
        Category = "Valuables",
        Price = 3500,
        SellPrice = 1575
    },
    ["Diary"] = {
        Tier = "Rare",
        Category = "Documents",
        Price = 3500,
        SellPrice = 1820
    },
    ["Dogtag"] = {
        Tier = "Common",
        Category = "Valuables",
        Price = 0,
        SellPrice = 21
    },
    ["Domino Crown"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 3700,
        SellPrice = 1924
    },
    ["DP-27 7.62x54mmR 47-round pan magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["Duct tape"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 150,
        SellPrice = 63
    },
    ["Electric Drill"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 1250,
        SellPrice = 525
    },
    ["Empty dish"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["EOTech 553 holographic sight"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 850,
        SellPrice = 289
    },
    ["FAST MT Helmet"] = {
        Tier = "Rare",
        Category = "Helmet",
        Price = 3950,
        SellPrice = 2251
    },
    ["FAST multi-hit ballistic face shield"] = {
        Tier = "Rare",
        Category = "Equipment",
        Price = 1750,
        SellPrice = 997
    },
    ["Field repair kit"] = {
        Tier = "Mythic",
        Category = "Tools",
        Price = 3200,
        SellPrice = 1440
    },
    ["Flash Drive"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 200,
        SellPrice = 84
    },
    ["Flour"] = {
        Tier = "Common",
        Category = "Households",
        Price = 250,
        SellPrice = 175
    },
    ["FN P90 5.7x28 50-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 75,
        SellPrice = 25
    },
    ["FN SCAR-H 7.62x51 20-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["FN SCAR-H 7.62x51 50-round drum magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["Forest Green Ghillie Suit"] = {
        Tier = "Mythic",
        Category = "Armor",
        Price = 1700,
        SellPrice = 765
    },
    ["FORT-9 Heavy Assault Rig"] = {
        Tier = "Rare",
        Category = "Armor",
        Price = 5750,
        SellPrice = 3277
    },
    ["FORTIS Coastal Outpost Cache Key"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 1500,
        SellPrice = 525
    },
    ["FORTIS Level-0 keycard"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 2400,
        SellPrice = 840
    },
    ["FORTIS Level-1 keycard"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 1500,
        SellPrice = 525
    },
    ["FORTIS Level-2 keycard"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 2800,
        SellPrice = 979
    },
    ["FORTIS Level-3 keycard"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 3400,
        SellPrice = 1190
    },
    ["FORTIS Level-4 keycard"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 6500,
        SellPrice = 2275
    },
    ["FORTIS Level-5 keycard"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 35000,
        SellPrice = 12250
    },
    ["FORTIS Level-6 keycard"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 120000,
        SellPrice = 42000
    },
    ["FORTIS MK.II Gloves"] = {
        Tier = "Mythic",
        Category = "Equipment",
        Price = 2500,
        SellPrice = 1125
    },
    ["Gears"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 150,
        SellPrice = 63
    },
    ["Gemtech SFN-57 5.7x28 sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 1250,
        SellPrice = 425
    },
    ["Geolocator"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 950,
        SellPrice = 399
    },
    ["GL 9x19 17-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 100,
        SellPrice = 34
    },
    ["GL 9x19 33-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 350,
        SellPrice = 119
    },
    ["GL 9x19 50-round drum magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 350,
        SellPrice = 119
    },
    ["Glim Charm"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 3700,
        SellPrice = 1480
    },
    ["Glue"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 150,
        SellPrice = 63
    },
    ["Gold bar"] = {
        Tier = "Mythic",
        Category = "Valuables",
        Price = 3500,
        SellPrice = 1575
    },
    ["Gold Trophy"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 3500,
        SellPrice = 1820
    },
    ["Golden Cube"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 3500,
        SellPrice = 1820
    },
    ["Golden Skull"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 3500,
        SellPrice = 1820
    },
    ["Golden Smartphone"] = {
        Tier = "Rare",
        Category = "Electronics",
        Price = 3000,
        SellPrice = 1560
    },
    ["Golden Watch"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 1800,
        SellPrice = 936
    },
    ["Gorynych-S \"Sten\" Assault Rig"] = {
        Tier = "Mythic",
        Category = "Armor",
        Price = 14000,
        SellPrice = 6300
    },
    ["Graphics card"] = {
        Tier = "Rare",
        Category = "Electronics",
        Price = 7500,
        SellPrice = 3900
    },
    ["Gunpowder"] = {
        Tier = "Rare",
        Category = "Tools",
        Price = 350,
        SellPrice = 182
    },
    ["Gzhel-K Body Armor"] = {
        Tier = "Mythic",
        Category = "Armor",
        Price = 4400,
        SellPrice = 1980
    },
    ["Hand Wraps"] = {
        Tier = "Common",
        Category = "Equipment",
        Price = 750,
        SellPrice = 427
    },
    ["Havocola Cherry Burn"] = {
        Tier = "Common",
        Category = "Households",
        Price = 175,
        SellPrice = 122
    },
    ["Havocola Classic"] = {
        Tier = "Common",
        Category = "Households",
        Price = 175,
        SellPrice = 122
    },
    ["HK MP5 9x19 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 250,
        SellPrice = 85
    },
    ["HK MP5 9x19 50-round drum magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 350,
        SellPrice = 119
    },
    ["HK MP7 4.6x30 40-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 140,
        SellPrice = 47
    },
    ["HK MP7 SD 2 4.6x30 sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 850,
        SellPrice = 289
    },
    ["HK UMP .45 ACP 25-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 300,
        SellPrice = 102
    },
    ["Homemade Soap"] = {
        Tier = "Common",
        Category = "Households",
        Price = 250,
        SellPrice = 175
    },
    ["HVC Gen4 Body Armor"] = {
        Tier = "Mythic",
        Category = "Armor",
        Price = 9500,
        SellPrice = 4275
    },
    ["HVC Gen4 Body Armor (HMK)"] = {
        Tier = "Mythic",
        Category = "Armor",
        Price = 7800,
        SellPrice = 3510
    },
    ["HVC Plate Carrier"] = {
        Tier = "Rare",
        Category = "Armor",
        Price = 3700,
        SellPrice = 2109
    },
    ["HVC-10T Night Vision Goggles"] = {
        Tier = "Rare",
        Category = "Attachments",
        Price = 7500,
        SellPrice = 4275
    },
    ["iDog Bot"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 3700,
        SellPrice = 1480
    },
    ["Improvised plastic sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 350,
        SellPrice = 119
    },
    ["Insecticide spray"] = {
        Tier = "Common",
        Category = "Households",
        Price = 250,
        SellPrice = 175
    },
    ["Insects Spray"] = {
        Tier = "Common",
        Category = "Households",
        Price = 320,
        SellPrice = 224
    },
    ["Insulin pump"] = {
        Tier = "Common",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1344
    },
    ["Integrated Tactical Plate Carrier"] = {
        Tier = "Rare",
        Category = "Armor",
        Price = 4000,
        SellPrice = 2280
    },
    ["Intelligence folder"] = {
        Tier = "Rare",
        Category = "Documents",
        Price = 3500,
        SellPrice = 1820
    },
    ["Jiffy Domino Top Hat"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 13500,
        SellPrice = 5400
    },
    ["Ketchup"] = {
        Tier = "Common",
        Category = "Households",
        Price = 250,
        SellPrice = 175
    },
    ["Keycard holder case"] = {
        Tier = "Usable",
        Category = "Container",
        Price = 0,
        SellPrice = 12000
    },
    ["Korund-VM Body Armor"] = {
        Tier = "Rare",
        Category = "Armor",
        Price = 3750,
        SellPrice = 2137
    },
    ["Leupold Mark 8 8x24 riflescope"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 3750,
        SellPrice = 1275
    },
    ["Long Screwdriver"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 650,
        SellPrice = 273
    },
    ["LVPO 10x28 riflescope"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 2750,
        SellPrice = 935
    },
    ["M1911A1 .45 ACP 7-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 100,
        SellPrice = 34
    },
    ["M200 .408 Cheyenne Tactical 5-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 350,
        SellPrice = 119
    },
    ["M40 Gas Mask Filter"] = {
        Tier = "Rare",
        Category = "Attachments",
        Price = 750,
        SellPrice = 427
    },
    ["M40-1 Gas Mask"] = {
        Tier = "Common",
        Category = "Mask",
        Price = 1500,
        SellPrice = 854
    },
    ["M40-2 Gas Mask"] = {
        Tier = "Common",
        Category = "Mask",
        Price = 1500,
        SellPrice = 854
    },
    ["MAC-10 9x19 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 120,
        SellPrice = 40
    },
    ["MAC-10 sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 750,
        SellPrice = 255
    },
    ["Magic Lamp"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 2130,
        SellPrice = 1107
    },
    ["Magnet"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 450,
        SellPrice = 189
    },
    ["Makarov 9x18 8-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 100,
        SellPrice = 34
    },
    ["Mask"] = {
        Tier = "Common",
        Category = "Mask",
        Price = 150,
        SellPrice = 85
    },
    ["Maska-1SCh \"Voin\" face shield"] = {
        Tier = "Rare",
        Category = "Equipment",
        Price = 3200,
        SellPrice = 1823
    },
    ["Maska-1SCh \"Voin\" Helmet"] = {
        Tier = "Mythic",
        Category = "Helmet",
        Price = 6650,
        SellPrice = 2992
    },
    ["Maska-1SCh face shield"] = {
        Tier = "Rare",
        Category = "Equipment",
        Price = 2750,
        SellPrice = 1567
    },
    ["Maska-1SCh Helmet"] = {
        Tier = "Mythic",
        Category = "Helmet",
        Price = 4250,
        SellPrice = 1912
    },
    ["Mayonnaise"] = {
        Tier = "Common",
        Category = "Households",
        Price = 250,
        SellPrice = 175
    },
    ["MBC Plate Carrier"] = {
        Tier = "Common",
        Category = "Armor",
        Price = 1800,
        SellPrice = 1026
    },
    ["Measuring tape"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 150,
        SellPrice = 63
    },
    ["Meat grinder"] = {
        Tier = "Common",
        Category = "Households",
        Price = 250,
        SellPrice = 175
    },
    ["Medical bloodset"] = {
        Tier = "Common",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1344
    },
    ["Medical set"] = {
        Tier = "Rare",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1664
    },
    ["Metal Awl"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 350,
        SellPrice = 147
    },
    ["Metal Cutting Scissors"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 680,
        SellPrice = 285
    },
    ["Metal fuel tank"] = {
        Tier = "Common",
        Category = "Households",
        Price = 3200,
        SellPrice = 2240
    },
    ["Microcircuits"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 250,
        SellPrice = 105
    },
    ["Military Backpack"] = {
        Tier = "Mythic",
        Category = "Backpack",
        Price = 2750,
        SellPrice = 1237
    },
    ["Military Helmet"] = {
        Tier = "Common",
        Category = "Helmet",
        Price = 1550,
        SellPrice = 883
    },
    ["Mk14 7.62x51 10-round magazine"] = {
        Tier = "Common",
        Category = "Mags",
        Price = 150,
        SellPrice = 63
    },
    ["MOTR Concealable Reinforced Vest"] = {
        Tier = "Common",
        Category = "Armor",
        Price = 1500,
        SellPrice = 854
    },
    ["Mounting Foam"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 350,
        SellPrice = 147
    },
    ["MP34 9x19 32-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 75,
        SellPrice = 25
    },
    ["MP9 9x19 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 120,
        SellPrice = 40
    },
    ["MP9 9x19 sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 850,
        SellPrice = 289
    },
    ["MSA Paraclete Plate Carrier"] = {
        Tier = "Rare",
        Category = "Armor",
        Price = 3800,
        SellPrice = 2166
    },
    ["Mug"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["Nails"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 250,
        SellPrice = 105
    },
    ["NCStar AQPTLMG Compact Green Laser"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 650,
        SellPrice = 221
    },
    ["Nightforce ATACR 7-35x56"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 2250,
        SellPrice = 765
    },
    ["Nomad Route Notes"] = {
        Tier = "Rare",
        Category = "Documents",
        Price = 1,
        SellPrice = 1
    },
    ["North Dolphin Hospital Safe Key"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 1500,
        SellPrice = 525
    },
    ["Northmont Sparkling Cider"] = {
        Tier = "Rare",
        Category = "Households",
        Price = 3400,
        SellPrice = 1768
    },
    ["NovaTec reflex sight"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 750,
        SellPrice = 255
    },
    ["NovaTec RMR reflex sight"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 450,
        SellPrice = 153
    },
    ["ODWave 556 5.56x45 sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 850,
        SellPrice = 289
    },
    ["Oil Filter sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 350,
        SellPrice = 119
    },
    ["OKP-7 reflex sight"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 650,
        SellPrice = 221
    },
    ["Orange juice carton"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["Pack of matches"] = {
        Tier = "Common",
        Category = "Households",
        Price = 250,
        SellPrice = 175
    },
    ["Palmolive handwash"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["PBS-1 sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 1250,
        SellPrice = 425
    },
    ["Perfume"] = {
        Tier = "Common",
        Category = "Households",
        Price = 850,
        SellPrice = 595
    },
    ["PG-7V HEAT grenade"] = {
        Tier = "Mythic",
        Category = "Ammo",
        Price = 0,
        SellPrice = 11250
    },
    ["PICO-A1 Light Lower Body Armor"] = {
        Tier = "Common",
        Category = "Lower Armor",
        Price = 1200,
        SellPrice = 683
    },
    ["PICO-A2 Heavy Lower Body Armor"] = {
        Tier = "Rare",
        Category = "Lower Armor",
        Price = 3600,
        SellPrice = 2052
    },
    ["Pile of meds"] = {
        Tier = "Common",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1344
    },
    ["Pipe wrench"] = {
        Tier = "Rare",
        Category = "Tools",
        Price = 1550,
        SellPrice = 806
    },
    ["Pipecleaner"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 550,
        SellPrice = 231
    },
    ["Porcelain"] = {
        Tier = "Rare",
        Category = "Households",
        Price = 3500,
        SellPrice = 1820
    },
    ["Power unit"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 400,
        SellPrice = 168
    },
    ["Powerbank"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 1200,
        SellPrice = 504
    },
    ["Precisive Grips"] = {
        Tier = "Rare",
        Category = "Equipment",
        Price = 1250,
        SellPrice = 712
    },
    ["Printer Paper"] = {
        Tier = "Common",
        Category = "Documents",
        Price = 250,
        SellPrice = 105
    },
    ["PSO-1 4x24 scope"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 1650,
        SellPrice = 561
    },
    ["PU-1 3.5x riflescope"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 850,
        SellPrice = 289
    },
    ["PureFire X300 Ultra"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 650,
        SellPrice = 221
    },
    ["PX27 Headlamp"] = {
        Tier = "Rare",
        Category = "Equipment",
        Price = 550,
        SellPrice = 313
    },
    ["QDSS-NT4 5.56x45 sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 850,
        SellPrice = 289
    },
    ["RAM"] = {
        Tier = "Rare",
        Category = "Electronics",
        Price = 700,
        SellPrice = 364
    },
    ["Rapid Emergency AED Compact Tool"] = {
        Tier = "Mythic",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1440
    },
    ["Rat Poison"] = {
        Tier = "Rare",
        Category = "Households",
        Price = 750,
        SellPrice = 390
    },
    ["RK-1 tactical foregrip"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 720,
        SellPrice = 244
    },
    ["ROVER Motorcycle Helmet"] = {
        Tier = "Common",
        Category = "Helmet",
        Price = 850,
        SellPrice = 484
    },
    ["RPK-16 5.45x39 95-round drum magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 350,
        SellPrice = 119
    },
    ["S&M Backpack"] = {
        Tier = "Usable",
        Category = "Backpack",
        Price = 1350,
        SellPrice = 202
    },
    ["SA58/FAL 7.62x51 20-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["SA58/FAL 7.62x51 50-round drum magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["SAS drive"] = {
        Tier = "Rare",
        Category = "Electronics",
        Price = 3200,
        SellPrice = 1664
    },
    ["Scissors"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["Scrap Metal"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 250,
        SellPrice = 105
    },
    ["Screwdriver"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 150,
        SellPrice = 63
    },
    ["Scuba Gear"] = {
        Tier = "Common",
        Category = "Armor",
        Price = 1500,
        SellPrice = 854
    },
    ["Sealed black file"] = {
        Tier = "Rare",
        Category = "Documents",
        Price = 1,
        SellPrice = 1
    },
    ["Sealing Foam"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 450,
        SellPrice = 189
    },
    ["Sewing Kit"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 350,
        SellPrice = 147
    },
    ["Shampoo"] = {
        Tier = "Common",
        Category = "Households",
        Price = 220,
        SellPrice = 154
    },
    ["Shards in the Code: Season One"] = {
        Tier = "Common",
        Category = "Documents",
        Price = 500,
        SellPrice = 210
    },
    ["SHARK muzzle brake"] = {
        Tier = "Mythic",
        Category = "Attachments",
        Price = 1350,
        SellPrice = 607
    },
    ["SilKo Osprey 9 9x19 sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 750,
        SellPrice = 255
    },
    ["SilKo Salvo 12 12ga sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 1250,
        SellPrice = 425
    },
    ["Slick Plate Carrier"] = {
        Tier = "Mythic",
        Category = "Armor",
        Price = 4800,
        SellPrice = 2160
    },
    ["Sling Bag"] = {
        Tier = "Usable",
        Category = "Backpack",
        Price = 550,
        SellPrice = 82
    },
    ["Smartphone"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 1350,
        SellPrice = 567
    },
    ["Sodium Bicarbonate"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 450,
        SellPrice = 189
    },
    ["Sodium Chloride"] = {
        Tier = "Common",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1344
    },
    ["Spoon"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["Spork 777"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 3700,
        SellPrice = 1480
    },
    ["Sport Complex “Lych Zdorovya” Cache Key"] = {
        Tier = "Keys",
        Category = "Key",
        Price = 1500,
        SellPrice = 525
    },
    ["SSD"] = {
        Tier = "Rare",
        Category = "Electronics",
        Price = 1400,
        SellPrice = 728
    },
    ["Sticky Tape"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 250,
        SellPrice = 105
    },
    ["String"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 350,
        SellPrice = 147
    },
    ["SureFire 3-prong flash hider"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 750,
        SellPrice = 255
    },
    ["SureFire 4-prong flash hider"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 750,
        SellPrice = 255
    },
    ["Surgical kit"] = {
        Tier = "Rare",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1664
    },
    ["SV-98 7.62x51 10-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 120,
        SellPrice = 40
    },
    ["SV-98 7.62x54R sound suppressor"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 1250,
        SellPrice = 425
    },
    ["SVD 7.62x54mmR 10-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 450,
        SellPrice = 153
    },
    ["T-7 Thermal Goggles"] = {
        Tier = "Mythic",
        Category = "Attachments",
        Price = 75000,
        SellPrice = 33750
    },
    ["T178 Raid Backpack"] = {
        Tier = "Mythic",
        Category = "Backpack",
        Price = 7250,
        SellPrice = 3262
    },
    ["Tagilla's welding mask \"Gorilla\""] = {
        Tier = "Mythic",
        Category = "Helmet",
        Price = 88888,
        SellPrice = 39999
    },
    ["Tagilla's welding mask \"UBEY\""] = {
        Tier = "Mythic",
        Category = "Helmet",
        Price = 88888,
        SellPrice = 39999
    },
    ["Tank Battery"] = {
        Tier = "Rare",
        Category = "Electronics",
        Price = 12000,
        SellPrice = 6240
    },
    ["The 5th Annual Bloxy Award"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 7500,
        SellPrice = 3900
    },
    ["The Cap Of The Rebelled"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 7500,
        SellPrice = 3000
    },
    ["The Greatest Admin plushie"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 5500,
        SellPrice = 2200
    },
    ["Thraggorian Arms 3516"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 12500,
        SellPrice = 5000
    },
    ["Titanium Alloy Plate"] = {
        Tier = "Rare",
        Category = "Tools",
        Price = 350,
        SellPrice = 182
    },
    ["Toilet paper"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["Toothpaste"] = {
        Tier = "Common",
        Category = "Households",
        Price = 150,
        SellPrice = 105
    },
    ["Tube of cold welding"] = {
        Tier = "Common",
        Category = "Buildings",
        Price = 250,
        SellPrice = 105
    },
    ["Type 04-1 holographic sight"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 550,
        SellPrice = 187
    },
    ["Type 95 5.8x42mm 30-round magazine"] = {
        Tier = "Uncommon",
        Category = "Mags",
        Price = 150,
        SellPrice = 51
    },
    ["UH-1 holographic sight"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 850,
        SellPrice = 289
    },
    ["ULACH IIIA Helmet"] = {
        Tier = "Rare",
        Category = "Helmet",
        Price = 3850,
        SellPrice = 2194
    },
    ["USB extension cable"] = {
        Tier = "Common",
        Category = "Electronics",
        Price = 350,
        SellPrice = 147
    },
    ["Vanish 30 5.56x45 sound suppressor"] = {
        Tier = "Mythic",
        Category = "Attachments",
        Price = 2250,
        SellPrice = 1012
    },
    ["Vegetable oil"] = {
        Tier = "Common",
        Category = "Households",
        Price = 250,
        SellPrice = 175
    },
    ["Vertical foregrip"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 550,
        SellPrice = 187
    },
    ["Vintage Gold Crown"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 2700,
        SellPrice = 1404
    },
    ["Vitamins"] = {
        Tier = "Common",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1344
    },
    ["VSS modern stock"] = {
        Tier = "Mythic",
        Category = "Attachments",
        Price = 1890,
        SellPrice = 850
    },
    ["Watch"] = {
        Tier = "Common",
        Category = "Households",
        Price = 550,
        SellPrice = 385
    },
    ["Weapon case"] = {
        Tier = "Usable",
        Category = "Container",
        Price = 0,
        SellPrice = 1
    },
    ["Weapon parts"] = {
        Tier = "Rare",
        Category = "Tools",
        Price = 350,
        SellPrice = 182
    },
    ["White tube"] = {
        Tier = "Common",
        Category = "Medical",
        Price = 3200,
        SellPrice = 1344
    },
    ["Wrench"] = {
        Tier = "Common",
        Category = "Tools",
        Price = 350,
        SellPrice = 147
    },
    ["XDM's Red Helm"] = {
        Tier = "Rare",
        Category = "Valuables",
        Price = 11000,
        SellPrice = 4400
    },
    ["XLaser pointer module"] = {
        Tier = "Mythic",
        Category = "Tools",
        Price = 3500,
        SellPrice = 1575
    },
    ["Xtreme Motorcycle Helmet"] = {
        Tier = "Common",
        Category = "Helmet",
        Price = 855,
        SellPrice = 487
    },
    ["YMA95-1 3.5x riflescope"] = {
        Tier = "Uncommon",
        Category = "Attachments",
        Price = 1100,
        SellPrice = 374
    }
}

local ClassOptions, TypeOptions = {}, {}

do
    local ClassSet, TypeSet = {}, {}

    for _, Data in Items do
        if not ClassSet[Data.Tier] then
            ClassSet[Data.Tier] = true
            table.insert(ClassOptions, Data.Tier)
        end

        if not TypeSet[Data.Category] then
            TypeSet[Data.Category] = true
            table.insert(TypeOptions, Data.Category)
        end
    end

    table.sort(ClassOptions)
    table.sort(TypeOptions)
end

local Filters = {
    Class = nil,
    Type = nil
}

local function BuildFilter(Value)
    if typeof(Value) ~= "table" then return nil end

    local Set, Any = {}, false

    for Key, Entry in Value do
        if typeof(Entry) == "string" then
            Set[Entry] = true
            Any = true
        elseif Entry == true and typeof(Key) == "string" then
            Set[Key] = true
            Any = true
        end
    end

    return Any and Set or nil
end

Module.Game.Entities = (function() for _, m in Workspace:GetChildren() do if m:IsA("Model") and m.Name ~= "_weldobjects.temp.others" then return m end end end)()

local gc = luau.load(game:HttpGet("https://raw.githubusercontent.com/Sploiter13/severe/refs/heads/main/gc.luau",true),{debugName = "gc"})()
task.wait(2)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Interface/Source.lua"))()
local Offsets = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jimenth/goop/refs/heads/main/Resources/Offsets.lua"))()

-- // Interface \\ --

local Window = Library:Window({Name = "Goop | Havoc", Size = Vector2.new(625, 700)})

local WeaponsTab = Window:Page({Name = "Weapons", Columns = 2})
local VisualsTab = Window:Page({Name = "Visuals", Columns = 2})

local ModSection = WeaponsTab:Section({Name = "Modifiers", Side = 1})

local LootSection = VisualsTab:Section({Name = "Loot", Side = 1})
local DangerSection = VisualsTab:Section({Name = "Danger", Side = 2})
local WorldSection = VisualsTab:Section({Name = "World", Side = 1})

-- // Modifiers Section \\ --

ModSection:Button({ Name = "Remove Recoil", Callback = function() gc.setgc({vPunchBase = 0, hPunchBase = 0}) end })
ModSection:Button({ Name = "Remove Drop", Callback = function() gc.setgc({vel = 100000}) end })
ModSection:Button({ Name = "Remove Weight", Callback = function() gc.setgc({weight = 0, aimWeight = 0, unAimWeight = 0}) end })
ModSection:Button({ Name = "Remove Spread", Callback = function() gc.setgc({spreadReduce = 100}) end })

-- // Loot Section \\ --

LootSection:Toggle({Name = "Render Crates", Flag = "Render Crate", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Crate", Flag = "Crate Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})
LootSection:Slider({Name = "Maximum Render", Flag = "Crate Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

LootSection:Separator()

LootSection:Toggle({Name = "Render Drops", Flag = "Render Drop", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Drop", Flag = "Drop Color", Default = Color3.fromRGB(255, 255, 255), Callback = function(Color) end})

LootSection:Toggle({Name = "Show Item Class", Flag = "Drop Show Class", Default = false, Callback = function(Value) end})
LootSection:Toggle({Name = "Show Item Price", Flag = "Drop Show Price", Default = false, Callback = function(Value) end})

LootSection:Dropdown({Name = "Class Filter", Flag = "Drop Class Filter", Options = ClassOptions, Multi = true, Callback = function(Value) Filters.Class = BuildFilter(Value) end})
LootSection:Dropdown({Name = "Type Filter", Flag = "Drop Type Filter", Options = TypeOptions, Multi = true, Callback = function(Value) Filters.Type = BuildFilter(Value) end })

LootSection:Slider({Name = "Maximum Render", Flag = "Drop Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

-- // Danger Section \\ --

DangerSection:Toggle({Name = "Render Tripwires", Flag = "Render Tripwire", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Tripwire", Flag = "Tripwire Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(Color) end})
DangerSection:Slider({Name = "Maximum Render", Flag = "Tripwire Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

DangerSection:Separator()

DangerSection:Toggle({Name = "Render Explosive Barrels", Flag = "Render Explosive Barrel", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Explosive Barrel", Flag = "Explosive Barrel Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(Color) end})
DangerSection:Slider({Name = "Maximum Render", Flag = "Explosive Barrel Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

DangerSection:Separator()

DangerSection:Toggle({Name = "Render Sentries", Flag = "Render Sentry", Default = false, Callback = function(Value) end}):ColorPicker({Name = "Sentry", Flag = "Sentry Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(Color) end})
DangerSection:Slider({Name = "Maximum Render", Flag = "Sentry Render", Min = 0, Max = 1300, Default = 400, Callback = function(Value) end})

-- // World Section \\ --

WorldSection:Toggle({Name = "Remove Grass", Flag = "Remove Grass", Default = false, Callback = function(Value) end})

-- // Functions \\ --

function Module.Function.Cache()
    local Stored = Module.Stored.Objects
    local Entities = Module.Stored.Entities

    for Identifier, Entry in Stored do
        if not Entry or not Entry.Parent then
            Stored[Identifier] = nil
        end
    end

    for Identifier, Entry in Entities do
        if not Entry or not Entry.Parent or not Entry:FindFirstChild("HumanoidRootPart") then
            Entities[Identifier] = nil
        end
    end

    for _, Crate in Module.Game.Crates:GetChildren() do
        if Library.Flags["Render Crate"] then
            if Crate.Name ~= "X" then
                local Identifier = tostring(Crate)

                if not Stored[Identifier] then
                    Stored[Identifier] = {
                        Model = Crate,
                        Object = Crate:FindFirstChildOfClass("MeshPart"),
                        Name = Crate.Name,
                        Class = "Crate"
                    }
                end
            end
        end
    end

    for _, Drop in Module.Game.Drops:GetChildren() do
        if Library.Flags["Render Drop"] then
            local Identifier = tostring(Drop)

            if not Stored[Identifier] then
                Stored[Identifier] = {
                    Model = Drop,
                    Object = Drop:FindFirstChildOfClass("MeshPart"),
                    Name = Drop.Name,
                    Class = "Drop"
                }
            end
        end
    end

    for _, Tripwire in Module.Game.Tripwires:GetChildren() do
        if Library.Flags["Render Tripwire"] then
            local Identifier = tostring(Tripwire)

            if not Stored[Identifier] and #Tripwire:GetChildren() > 0 then
                Stored[Identifier] = {
                    Model = Tripwire,
                    Object = Tripwire:FindFirstChild("mainPart"),
                    Name = Tripwire.Name,
                    Class = "Tripwire"
                }
            end
        end
    end

    for _, Barrel in Module.Game.Barrels:GetChildren() do
        if Library.Flags["Render Explosive Barrel"] then
            local Identifier = tostring(Barrel)

            if not Stored[Identifier] and #Barrel:GetChildren() > 0 then
                Stored[Identifier] = {
                    Model = Barrel,
                    Object = Barrel:FindFirstChild("Base"),
                    Name = Barrel.Name,
                    Class = "Explosive Barrel"
                }
            end
        end
    end

    for _, Sentry in Module.Game.Sentries:GetChildren() do
        if Library.Flags["Render Sentry"] then
            local Identifier = tostring(Sentry)

            if not Stored[Identifier] and #Sentry:GetChildren() > 0 then
                Stored[Identifier] = {
                    Model = Sentry,
                    Object = Sentry:FindFirstChild("Base"),
                    Name = Sentry.Name,
                    Class = "Sentry"
                }
            end
        end
    end

    for _, Entity in Module.Game.Entities:GetChildren() do
        if Entity.Name ~= LocalPlayer.Name then
            local Identifier = tostring(Entity)

            if not Module.Stored.Entities[Identifier] then
                Module.Stored.Entities[Identifier] = Entity
            end
        end
    end
end

function Module.Function:GetPlayerInstance(Character)
    if not Character then return nil end

    return Players:FindFirstChild(Character.Name)
end

function Module.Function:GetBodyData(Character)
    if not Character then return nil end

    return {
		Head = Character:FindFirstChild("Head"),
		
		LeftLeg = Character:FindFirstChild("Left Leg") or Character:FindFirstChild("HumanoidRootPart"),
		RightLeg = Character:FindFirstChild("Right Leg") or Character:FindFirstChild("HumanoidRootPart"),
		LeftArm = Character:FindFirstChild("Left Arm") or Character:FindFirstChild("HumanoidRootPart"),
		RightArm = Character:FindFirstChild("Right Arm") or Character:FindFirstChild("HumanoidRootPart"),
		Torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("HumanoidRootPart"),
		
		HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart"),
	}
end

function Module.Function:EntityData(Entity, Parts)
    if not Entity then return nil end

    local Humanoid = Entity and Entity:FindFirstChild("Humanoid")
    if not Humanoid then return nil end

    local Health = Humanoid and Humanoid.Health 
    local MaxHealth = Humanoid and Humanoid.MaxHealth

    local Data = {
        Username = tostring(Entity),
        Displayname = Entity.Name,
        Userid = math.random(-999999, 999999),
        Character = Entity,
        PrimaryPart = Parts.HumanoidRootPart,
        Humanoid = Humanoid,
        Head = Parts.Head,
        Torso = Parts.Torso,
        LeftArm = Parts.LeftArm or Parts.HumanoidRootPart,
        LeftLeg = Parts.LeftLeg or Parts.HumanoidRootPart,
        RightArm = Parts.RightArm or Parts.HumanoidRootPart,
        RightLeg = Parts.RightLeg or Parts.HumanoidRootPart,
        BodyHeightScale = 1,
        RigType = 0,
        Teamname = "Enemies",
        Toolname = "Unknown",
        Whitelisted = false,
        Archenemies = false,
        Aimbot_Part = Parts.Head,
        Aimbot_TP_Part = Parts.Head,
        Triggerbot_Part = Parts.Head,
        Health = Health,
        MaxHealth = Humanoid and MaxHealth or 0,
        body_parts_data = {
            { name = "LowerTorso", part = Parts.Torso },
            { name = "LeftUpperLeg", part = Parts.LeftLeg },
            { name = "LeftLowerLeg", part = Parts.LeftLeg },
            { name = "RightUpperLeg", part = Parts.RightLeg },
            { name = "RightLowerLeg", part = Parts.RightLeg },
            { name = "LeftUpperArm", part = Parts.LeftArm },
            { name = "LeftLowerArm", part = Parts.LeftArm },
            { name = "RightUpperArm", part = Parts.RightArm },
            { name = "RightLowerArm", part = Parts.RightArm },
        },
        full_body_data = {
            { name = "Head", part = Parts.Head },
            { name = "UpperTorso", part = Parts.Torso },
            { name = "LowerTorso", part = Parts.Torso },
            { name = "HumanoidRootPart", part = Parts.HumanoidRootPart },
            { name = "LeftUpperArm", part = Parts.LeftArm },
            { name = "LeftLowerArm", part = Parts.LeftArm },
            { name = "LeftHand", part = Parts.LeftArm },
            { name = "RightUpperArm", part = Parts.RightArm },
            { name = "RightLowerArm", part = Parts.RightArm },
            { name = "RightHand", part = Parts.RightArm },
            { name = "LeftUpperLeg", part = Parts.LeftLeg },
            { name = "LeftLowerLeg", part = Parts.LeftLeg },
            { name = "LeftFoot", part = Parts.LeftLeg },
            { name = "RightUpperLeg", part = Parts.RightLeg },
            { name = "RightLowerLeg", part = Parts.RightLeg },
            { name = "RightFoot", part = Parts.RightLeg },
        }
    }

    return tostring(Entity), Data
end

function Module.Function:CharacterData(Character, Parts)
    if not Character then return nil end

    local Humanoid = Character and Character:FindFirstChild("Humanoid")
    if not Humanoid then return nil end

    local Health = Humanoid and Humanoid.Health 
    local MaxHealth = Humanoid and Humanoid.MaxHealth

    local Player = Module.Function:GetPlayerInstance(Character)
    if not Player then return nil end

    local Data = {
        Username = Player.Name,
        Displayname = Player.DisplayName,
        Userid = Player.UserId,
        Character = Character,
        PrimaryPart = Parts.HumanoidRootPart,
        Humanoid = Humanoid,
        Head = Parts.Head,
        Torso = Parts.Torso,
        LeftArm = Parts.LeftArm or Parts.HumanoidRootPart,
        LeftLeg = Parts.LeftLeg or Parts.HumanoidRootPart,
        RightArm = Parts.RightArm or Parts.HumanoidRootPart,
        RightLeg = Parts.RightLeg or Parts.HumanoidRootPart,
        BodyHeightScale = 1,
        RigType = 0,
        Teamname = Player.Team.Name,
        Toolname = "Unknown",
        Whitelisted = false,
        Archenemies = false,
        Aimbot_Part = Parts.Head,
        Aimbot_TP_Part = Parts.Head,
        Triggerbot_Part = Parts.Head,
        Health = Health,
        MaxHealth = Humanoid and Humanoid.MaxHealth or 0,
        body_parts_data = {
            { name = "LowerTorso", part = Parts.Torso },
            { name = "LeftUpperLeg", part = Parts.LeftLeg },
            { name = "LeftLowerLeg", part = Parts.LeftLeg },
            { name = "RightUpperLeg", part = Parts.RightLeg },
            { name = "RightLowerLeg", part = Parts.RightLeg },
            { name = "LeftUpperArm", part = Parts.LeftArm },
            { name = "LeftLowerArm", part = Parts.LeftArm },
            { name = "RightUpperArm", part = Parts.RightArm },
            { name = "RightLowerArm", part = Parts.RightArm },
        },
        full_body_data = {
            { name = "Head", part = Parts.Head },
            { name = "UpperTorso", part = Parts.Torso },
            { name = "LowerTorso", part = Parts.Torso },
            { name = "HumanoidRootPart", part = Parts.HumanoidRootPart },
            { name = "LeftUpperArm", part = Parts.LeftArm },
            { name = "LeftLowerArm", part = Parts.LeftArm },
            { name = "LeftHand", part = Parts.LeftArm },
            { name = "RightUpperArm", part = Parts.RightArm },
            { name = "RightLowerArm", part = Parts.RightArm },
            { name = "RightHand", part = Parts.RightArm },
            { name = "LeftUpperLeg", part = Parts.LeftLeg },
            { name = "LeftLowerLeg", part = Parts.LeftLeg },
            { name = "LeftFoot", part = Parts.LeftLeg },
            { name = "RightUpperLeg", part = Parts.RightLeg },
            { name = "RightLowerLeg", part = Parts.RightLeg },
            { name = "RightFoot", part = Parts.RightLeg },
        }
    }

    return tostring(Character), Data
end

function Module.Function.PostLocal()
    local Seen = {}

    for _, Entity in Module.Stored.Entities do
        local Humanoid = Entity:FindFirstChild("Humanoid")
        if Humanoid and Entity.Parent then
            local Key = tostring(Entity)
            local Parts = Module.Function:GetBodyData(Entity)

            if not Parts or not Parts.Head or not Parts.HumanoidRootPart then
                continue
            end

            if Parts and Parts.Head and Parts.HumanoidRootPart then
                if not Module.Added[Key] then
                    local ID, Data = Module.Function:EntityData(Entity, Parts)

                    if ID and Data then
                        add_model_data(Data, ID)
                        Module.Added[ID] = Entity
                    end
                else
                    edit_model_data({ Health = Humanoid.Health }, Key)
                end
                Seen[Key] = true
            end
        end
    end

    for Key, Model in pairs(Module.Added) do
        local HumanoidRootPart = Model:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart or not Seen[Key] then
            remove_model_data(Key)
            Module.Added[Key] = nil
        end
    end
end

function Module.Function.Render()
    for _, Entry in Module.Stored.Objects do
        if Library.Flags["Render ".. Entry.Class] then
            if Entry and Entry.Model then
                local Primary = Entry.Object
                if not Primary then continue end

                local Text = Entry.Name

                if Entry.Class == "Drop" then
                    local Info = Items[Entry.Name]

                    if Filters.Class or Filters.Type then
                        if not Info then continue end
                        if Filters.Class and not Filters.Class[Info.Tier] then continue end
                        if Filters.Type and not Filters.Type[Info.Category] then continue end
                    end

                    if Info then
                        if Library.Flags["Drop Show Class"] then
                            Text = Text.. " | ".. Info.Tier
                        end
                        if Library.Flags["Drop Show Price"] then
                            Text = Text.. " | ".. Info.Price
                        end
                    end
                end

                local Distance = vector.magnitude(Camera.Position - Primary.Position)
                if Distance <= Library.Flags[Entry.Class.. " Render"].Value then
                    local Screen, Visible = Camera:WorldToScreenPoint(Primary.Position)

                    if Visible then
                        DrawingImmediate.OutlinedText(Screen, 13, Library.Flags[Entry.Class.. " Color"].Color, Library.Flags[Entry.Class.. " Color"].Alpha, Text, true, "Pixel")
                    end
                end
            end
        end
    end
end

-- // Initalize \\ --
Library:Watermark("Goop")
Library:NavigationBar(Library.Windows[1], Library:StyleWindow(), Library:ConfigWindow())
task.spawn(function()
    while true do
        task.wait(0.8)
        Module.Function:Cache()

        local Removing = Library.Flags["Remove Grass"]
        local Current  = memory.readf32(Workspace.Terrain, Offsets.Terrain.GrassLength)

        if Removing then
            if Module.Original.GrassLength == nil and Current > -1 then
                Module.Original.GrassLength = Current
            end
            if Current == -1 then
            elseif Current > -1 then
                memory.writef32(Workspace.Terrain, Offsets.Terrain.GrassLength, -1)
            end
        elseif Module.Original.GrassLength ~= nil then
            memory.writef32(Workspace.Terrain, Offsets.Terrain.GrassLength, Module.Original.GrassLength)
            Module.Original.GrassLength = nil
        end
    end
end)
RunService.PostLocal:Connect(Module.Function.PostLocal)
RunService.Render:Connect(Module.Function.Render)
