Assets {
  Id: 7200105788851128850
  Name: "HealthPickup"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 3753859580931769970
      Objects {
        Id: 3753859580931769970
        Name: "HealthPickup"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 8568336417442047963
        ChildIds: 7522106652532519616
        ChildIds: 16655370026056986950
        ChildIds: 5608200327804418303
        ChildIds: 1603438502442247984
        UnregisteredParameters {
          Overrides {
            Name: "cs:HealthChange"
            Float: 100
          }
          Overrides {
            Name: "cs:Resource"
            String: "Gems"
          }
          Overrides {
            Name: "cs:ResourceChange"
            Int: 1
          }
          Overrides {
            Name: "cs:MaxResource"
            Int: 0
          }
          Overrides {
            Name: "cs:PickupEffects"
            AssetReference {
              Id: 841534158063459245
            }
          }
          Overrides {
            Name: "cs:HealthChange:tooltip"
            String: "The amount to add to the player\'s health (negative for damage)"
          }
          Overrides {
            Name: "cs:ResourceChange:tooltip"
            String: "The amount to add to the resource (negative to remove, cannot go negative)"
          }
          Overrides {
            Name: "cs:Resource:tooltip"
            String: "The resource to modify (or blank if none)"
          }
          Overrides {
            Name: "cs:PickupEffects:tooltip"
            String: "On pick up, spawns this template"
          }
          Overrides {
            Name: "cs:MaxResource:tooltip"
            String: "A player cannot  have more than this amount of this resource (0 for unbounded)"
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
        Id: 7522106652532519616
        Name: "Trigger"
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
        ParentId: 3753859580931769970
        UnregisteredParameters {
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
        Trigger {
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
        Id: 16655370026056986950
        Name: "ResourcePickupServer"
        Transform {
          Location {
          }
          Rotation {
            Yaw: -1.02452823e-05
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 3753859580931769970
        UnregisteredParameters {
          Overrides {
            Name: "cs:ComponentRoot"
            ObjectReference {
              SubObjectId: 3753859580931769970
            }
          }
          Overrides {
            Name: "cs:Trigger"
            ObjectReference {
              SubObjectId: 7522106652532519616
            }
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
        Script {
          ScriptAsset {
            Id: 3699656315272254187
          }
        }
      }
      Objects {
        Id: 5608200327804418303
        Name: "Geo_ClientContext"
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
        ParentId: 3753859580931769970
        ChildIds: 15165271140466229069
        ChildIds: 14910169053483179717
        ChildIds: 12884136036270551162
        ChildIds: 13627057348497805043
        ChildIds: 11130934123713661625
        ChildIds: 12407069809368056459
        ChildIds: 103190138843135251
        ChildIds: 7130768079712302936
        UnregisteredParameters {
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
        NetworkContext {
        }
      }
      Objects {
        Id: 15165271140466229069
        Name: "Sci-fi Base Capsule 01 Base"
        Transform {
          Location {
            X: -7.24102783
            Z: -3.87039185
          }
          Rotation {
            Pitch: -33.75
          }
          Scale {
            X: 0.1
            Y: 0.1
            Z: 0.1
          }
        }
        ParentId: 5608200327804418303
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceon"
        }
        CoreMesh {
          MeshAsset {
            Id: 12381939234011723748
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          InteractWithTriggers: true
          StaticMesh {
            Physics {
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 14910169053483179717
        Name: "Cylinder"
        Transform {
          Location {
            X: 28.8710327
            Z: 50.1751404
          }
          Rotation {
            Pitch: -33.75
          }
          Scale {
            X: 0.3
            Y: 0.3
            Z: 0.8
          }
        }
        ParentId: 5608200327804418303
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 6640175192592813417
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              R: 0.0519204661
              G: 0.98
              A: 1
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
          Value: "mc:ecollisionsetting:forceon"
        }
        CoreMesh {
          MeshAsset {
            Id: 1137112816547272582
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          InteractWithTriggers: true
          StaticMesh {
            Physics {
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 12884136036270551162
        Name: "Cylinder"
        Transform {
          Location {
            X: 28.8710327
            Z: 50.1751404
          }
          Rotation {
            Pitch: -33.75
          }
          Scale {
            X: 0.4
            Y: 0.4
            Z: 0.8
          }
        }
        ParentId: 5608200327804418303
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 16630259605395466384
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              R: 0.0429349914
              G: 0.28125
              B: 0.198293015
              A: 0.541
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
          Value: "mc:ecollisionsetting:forceon"
        }
        CoreMesh {
          MeshAsset {
            Id: 1137112816547272582
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          InteractWithTriggers: true
          StaticMesh {
            Physics {
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 13627057348497805043
        Name: "Sci-fi Base Capsule 01 Base"
        Transform {
          Location {
            X: 67.7609863
            Z: 108.378021
          }
          Rotation {
            Pitch: 33.7498932
            Yaw: -179.999954
            Roll: -179.999893
          }
          Scale {
            X: 0.1
            Y: 0.1
            Z: 0.1
          }
        }
        ParentId: 5608200327804418303
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceon"
        }
        CoreMesh {
          MeshAsset {
            Id: 12381939234011723748
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          InteractWithTriggers: true
          StaticMesh {
            Physics {
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 11130934123713661625
        Name: "Text 03: +"
        Transform {
          Location {
            X: -10
            Y: -30
            Z: 10
          }
          Rotation {
            Pitch: -33.75
          }
          Scale {
            X: 0.3
            Y: 0.3
            Z: 0.3
          }
        }
        ParentId: 5608200327804418303
        UnregisteredParameters {
          Overrides {
            Name: "ma:Font.Faces:id"
            AssetReference {
              Id: 16522517444528657102
            }
          }
          Overrides {
            Name: "ma:Font.Bevel:id"
            AssetReference {
              Id: 16522517444528657102
            }
          }
          Overrides {
            Name: "ma:Font.Sides:id"
            AssetReference {
              Id: 16522517444528657102
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
          Value: "mc:ecollisionsetting:forceon"
        }
        CoreMesh {
          MeshAsset {
            Id: 11859808292493770586
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          InteractWithTriggers: true
          StaticMesh {
            Physics {
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 12407069809368056459
        Name: "Text 03: +"
        Transform {
          Location {
            X: 42.7791748
            Y: -30
            Z: 88.989624
          }
          Rotation {
            Pitch: -33.75
          }
          Scale {
            X: 0.3
            Y: 0.3
            Z: 0.3
          }
        }
        ParentId: 5608200327804418303
        UnregisteredParameters {
          Overrides {
            Name: "ma:Font.Faces:id"
            AssetReference {
              Id: 16522517444528657102
            }
          }
          Overrides {
            Name: "ma:Font.Bevel:id"
            AssetReference {
              Id: 16522517444528657102
            }
          }
          Overrides {
            Name: "ma:Font.Sides:id"
            AssetReference {
              Id: 16522517444528657102
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
          Value: "mc:ecollisionsetting:forceon"
        }
        CoreMesh {
          MeshAsset {
            Id: 11859808292493770586
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          InteractWithTriggers: true
          StaticMesh {
            Physics {
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 103190138843135251
        Name: "Text 03: +"
        Transform {
          Location {
            X: 42.7791748
            Y: 20
            Z: 88.989624
          }
          Rotation {
            Pitch: -33.75
          }
          Scale {
            X: 0.3
            Y: 0.3
            Z: 0.3
          }
        }
        ParentId: 5608200327804418303
        UnregisteredParameters {
          Overrides {
            Name: "ma:Font.Faces:id"
            AssetReference {
              Id: 16522517444528657102
            }
          }
          Overrides {
            Name: "ma:Font.Bevel:id"
            AssetReference {
              Id: 16522517444528657102
            }
          }
          Overrides {
            Name: "ma:Font.Sides:id"
            AssetReference {
              Id: 16522517444528657102
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
          Value: "mc:ecollisionsetting:forceon"
        }
        CoreMesh {
          MeshAsset {
            Id: 11859808292493770586
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          InteractWithTriggers: true
          StaticMesh {
            Physics {
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 7130768079712302936
        Name: "Text 03: +"
        Transform {
          Location {
            X: -10
            Y: 20
            Z: 10
          }
          Rotation {
            Pitch: -33.75
          }
          Scale {
            X: 0.3
            Y: 0.3
            Z: 0.3
          }
        }
        ParentId: 5608200327804418303
        UnregisteredParameters {
          Overrides {
            Name: "ma:Font.Faces:id"
            AssetReference {
              Id: 16522517444528657102
            }
          }
          Overrides {
            Name: "ma:Font.Bevel:id"
            AssetReference {
              Id: 16522517444528657102
            }
          }
          Overrides {
            Name: "ma:Font.Sides:id"
            AssetReference {
              Id: 16522517444528657102
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
          Value: "mc:ecollisionsetting:forceon"
        }
        CoreMesh {
          MeshAsset {
            Id: 11859808292493770586
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          InteractWithTriggers: true
          StaticMesh {
            Physics {
            }
            BoundsScale: 1
          }
        }
      }
      Objects {
        Id: 1603438502442247984
        Name: "ServerContext"
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
        ParentId: 3753859580931769970
        ChildIds: 15314741914679365363
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
        NetworkContext {
          Type: Server
        }
      }
      Objects {
        Id: 15314741914679365363
        Name: "Object Rotator Continuous"
        Transform {
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 1603438502442247984
        UnregisteredParameters {
          Overrides {
            Name: "cs:Object"
            ObjectReference {
              SubObjectId: 5608200327804418303
            }
          }
          Overrides {
            Name: "cs:RotateVelocity"
            Rotator {
              Yaw: 30
            }
          }
          Overrides {
            Name: "cs:RotationMultiplier"
            Float: 2.5
          }
          Overrides {
            Name: "cs:LocalSpace"
            Bool: true
          }
          Overrides {
            Name: "cs:StartDelayRange"
            Vector2 {
            }
          }
          Overrides {
            Name: "cs:RotationMultiplier:tooltip"
            String: "Optional multiplier for very fast rotations."
          }
          Overrides {
            Name: "cs:StartDelayRange:tooltip"
            String: "Random delay range for the object to take action at the start of the game."
          }
          Overrides {
            Name: "cs:LocalSpace:tooltip"
            String: "Whether RotateTo is in local space"
          }
          Overrides {
            Name: "cs:Object:tooltip"
            String: "Object to transform"
          }
          Overrides {
            Name: "cs:RotateVelocity:tooltip"
            String: "Smoothly rotates the object over time by the given angular velocity."
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
        Script {
          ScriptAsset {
            Id: 5817711270485681102
          }
        }
      }
    }
    Assets {
      Id: 12381939234011723748
      Name: "Sci-fi Base Capsule 01 Base"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_ts_scf_base_acc_cap_bot_001_ref"
      }
    }
    Assets {
      Id: 1137112816547272582
      Name: "Cylinder"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_cylinder_002"
      }
    }
    Assets {
      Id: 6640175192592813417
      Name: "Energy Tube Glow"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "Energy_Tube_Glow"
      }
    }
    Assets {
      Id: 16630259605395466384
      Name: "Frosted Glass"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "fxma_frosted_glass"
      }
    }
    Assets {
      Id: 11859808292493770586
      Name: "Text 03: +"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "F5_Text_050"
      }
    }
    Assets {
      Id: 16522517444528657102
      Name: "Emissive Glow Transparent"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_basic_emissive_001"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  Marketplace {
    Description: "A rotating scifi themed health pickup"
  }
  SerializationVersion: 87
  DirectlyPublished: true
}
