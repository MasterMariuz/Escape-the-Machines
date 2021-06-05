Assets {
  Id: 11383823266058791513
  Name: "Inventory System Pickup"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 2581789164090885910
      Objects {
        Id: 2581789164090885910
        Name: "Inventory System Pickup"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4781671109827199097
        ChildIds: 232377608531609555
        ChildIds: 2807697253695557447
        UnregisteredParameters {
          Overrides {
            Name: "cs:ItemID"
            Int: 1
          }
          Overrides {
            Name: "cs:Amount"
            Int: 0
          }
          Overrides {
            Name: "cs:FloatAnimation"
            Bool: true
          }
          Overrides {
            Name: "cs:RotateAnimation"
            Bool: true
          }
          Overrides {
            Name: "cs:FloatRange"
            Int: 50
          }
          Overrides {
            Name: "cs:FloatReduction"
            Float: 200
          }
          Overrides {
            Name: "cs:RotateSpeed"
            Float: 1
          }
          Overrides {
            Name: "cs:Model"
            ObjectReference {
              SubObjectId: 4701895932125274662
            }
          }
          Overrides {
            Name: "cs:Amount:isrep"
            Bool: true
          }
        }
        WantsNetworking: true
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Folder {
          IsGroup: true
        }
      }
      Objects {
        Id: 232377608531609555
        Name: "Client"
        Transform {
          Location {
            Z: 50
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 2581789164090885910
        ChildIds: 11211935218752569849
        ChildIds: 4701895932125274662
        UnregisteredParameters {
        }
        WantsNetworking: true
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        NetworkContext {
        }
      }
      Objects {
        Id: 11211935218752569849
        Name: "InventorySystemPickupClient"
        Transform {
          Location {
            Z: -50
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 232377608531609555
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Script {
          ScriptAsset {
            Id: 12936620915206711100
          }
        }
      }
      Objects {
        Id: 4701895932125274662
        Name: "Model"
        Transform {
          Location {
          }
          Rotation {
            Pitch: -15
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 232377608531609555
        ChildIds: 13691004300840293328
        ChildIds: 17589991313793566047
        ChildIds: 6452454397793537297
        ChildIds: 4264927198791561900
        ChildIds: 15763161417716486782
        ChildIds: 12180331924967360017
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Folder {
          IsGroup: true
        }
      }
      Objects {
        Id: 13691004300840293328
        Name: "Point Light"
        Transform {
          Location {
            Z: -1.39524078
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4701895932125274662
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Light {
          Intensity: 0.873558223
          Color {
            R: 1
            G: 1
            B: 1
            A: 1
          }
          CastShadows: true
          VolumetricIntensity: 82.4202271
          TeamSettings {
          }
          Light {
            Temperature: 10000
            LocalLight {
              AttenuationRadius: 321.349091
              PointLight {
                FallOffExponent: 8
              }
            }
            MaxDrawDistance: 5000
            MaxDistanceFadeRange: 1000
          }
          CastVolumetricShadows: true
        }
      }
      Objects {
        Id: 17589991313793566047
        Name: "Steam Volume VFX"
        Transform {
          Location {
          }
          Rotation {
            Pitch: 6.83018879e-06
          }
          Scale {
            X: 0.22402589
            Y: 0.22402589
            Z: 0.22402589
          }
        }
        ParentId: 4701895932125274662
        UnregisteredParameters {
          Overrides {
            Name: "bp:color"
            Color {
              G: 0.95
              B: 0.205833361
              A: 0.0990000069
            }
          }
          Overrides {
            Name: "bp:Particle Scale Multiplier"
            Float: 0.673256159
          }
          Overrides {
            Name: "bp:Density"
            Float: 0.594744205
          }
          Overrides {
            Name: "bp:Color"
            Color {
              R: 1
              G: 1
              B: 1
              A: 0.0990000069
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 5496924415542348294
          }
          TeamSettings {
          }
          Vfx {
            AutoPlay: true
          }
        }
        Relevance {
          Value: "mc:eproxyrelevance:critical"
        }
      }
      Objects {
        Id: 6452454397793537297
        Name: "Cube"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 0.25
            Y: 0.25
            Z: 0.25
          }
        }
        ParentId: 4701895932125274662
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:smart"
            Bool: false
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              R: 15
              G: 15
              B: 15
              A: 1
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 6301372582205539896
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:utile"
            Float: 1
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:vtile"
            Float: 1
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        CoreMesh {
          MeshAsset {
            Id: 12095835209017042614
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          StaticMesh {
            Physics {
              Mass: 100
              LinearDamping: 0.01
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 4264927198791561900
        Name: "Cube"
        Transform {
          Location {
          }
          Rotation {
            Pitch: 6.83018879e-06
          }
          Scale {
            X: 0.249
            Y: 0.249
            Z: 0.249
          }
        }
        ParentId: 4701895932125274662
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:smart"
            Bool: false
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              A: 1
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 132672053610873933
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        CoreMesh {
          MeshAsset {
            Id: 12095835209017042614
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          StaticMesh {
            Physics {
              Mass: 100
              LinearDamping: 0.01
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 15763161417716486782
        Name: "Callout Sparkle"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4701895932125274662
        UnregisteredParameters {
          Overrides {
            Name: "bp:Particle Scale Multiplier"
            Float: 0.973060668
          }
          Overrides {
            Name: "bp:Color"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Emissive Boost"
            Float: 27.2285976
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 6008636272127062024
          }
          TeamSettings {
          }
          Vfx {
            AutoPlay: true
          }
        }
        Relevance {
          Value: "mc:eproxyrelevance:medium"
        }
      }
      Objects {
        Id: 12180331924967360017
        Name: "Callout Sparkle"
        Transform {
          Location {
          }
          Rotation {
            Pitch: 6.83018879e-06
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4701895932125274662
        UnregisteredParameters {
          Overrides {
            Name: "bp:Particle Scale Multiplier"
            Float: 1.82022345
          }
          Overrides {
            Name: "bp:Color"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Emissive Boost"
            Float: 27.2285976
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 6008636272127062024
          }
          TeamSettings {
          }
          Vfx {
            AutoPlay: true
          }
        }
        Relevance {
          Value: "mc:eproxyrelevance:medium"
        }
      }
      Objects {
        Id: 2807697253695557447
        Name: "Trigger"
        Transform {
          Location {
            Z: 50
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 2581789164090885910
        ChildIds: 2714206565509565097
        WantsNetworking: true
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Trigger {
          Interactable: true
          InteractionLabel: "Pick up"
          TeamSettings {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          TriggerShape_v2 {
            Value: "mc:etriggershape:box"
          }
        }
      }
      Objects {
        Id: 2714206565509565097
        Name: "InventorySystemPickupServer"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 2807697253695557447
        WantsNetworking: true
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Script {
          ScriptAsset {
            Id: 14468536740499620006
          }
        }
      }
    }
    Assets {
      Id: 5496924415542348294
      Name: "Steam Volume VFX"
      PlatformAssetType: 8
      PrimaryAsset {
        AssetType: "VfxBlueprintAssetRef"
        AssetId: "fxbp_steam_volume_vfx"
      }
    }
    Assets {
      Id: 12095835209017042614
      Name: "Cube"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_cube_002"
      }
    }
    Assets {
      Id: 6301372582205539896
      Name: "Grid Lines Emissive"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "fxmi_grid_unlit_emissive"
      }
    }
    Assets {
      Id: 132672053610873933
      Name: "Plastic Matte"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "plastic_matte_001"
      }
    }
    Assets {
      Id: 6008636272127062024
      Name: "Callout Sparkle"
      PlatformAssetType: 8
      PrimaryAsset {
        AssetType: "VfxBlueprintAssetRef"
        AssetId: "fxbp_sparkles_volume_vfx"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  Marketplace {
    Description: "Read the README script for more info, setup process etc.\r\n\r\nAn advanced and flexible inventory system.\r\nSupports custom items, item dropping, equipping, all that stuff.\r\nShould basically fit in any game. \r\n\r\nThe Inventory System has been completely overhauled. (yesssss)\r\nNote: THIS UPDATE IS COMPLETELY INCOMPATIBLE WITH 1.0\r\n\r\nChangelog for 2.0:\r\n    - A new, cleaner UI\r\n    - Out of the box storage persistence (enabled through the config)\r\n    - Added support for stackable items\r\n    - Added support for consumable items\r\n    - Removed the slot cap (can be adjusted manually)\r\n    - Removed the cap for currently equipped items\r\n    - A better item pickup system\r\n    - Item dropping\r\n    - Cleaner documentation\r\n    - A better tooltip system\r\n    - MUCH more reliable networking\r\n    - The config process now takes place in a script instead of custom properties (much cleaner, easier setup)\r\n    - A pretty fleshed out new API (for custom item shops, item spawning etc. etc.)\r\n    - Item creation process also much cleaner\r\n\r\n...and likely more stuff that I don\'t remember."
  }
  SerializationVersion: 87
  DirectlyPublished: true
}
