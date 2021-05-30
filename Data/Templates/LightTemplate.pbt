Assets {
  Id: 17636633798461745750
  Name: "LightTemplate"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 18206207095859064854
      Objects {
        Id: 18206207095859064854
        Name: "Point Light"
        Transform {
          Scale {
            X: 4
            Y: 4
            Z: 4
          }
        }
        ParentId: 1417101517565729141
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
        Light {
          Intensity: 5.25618696
          Color {
            R: 1
            G: 1
            B: 1
            A: 1
          }
          VolumetricIntensity: 5
          TeamSettings {
          }
          Light {
            UseTemperature: true
            Temperature: 1913.49219
            LocalLight {
              AttenuationRadius: 1000
              PointLight {
                SourceRadius: 20
                SoftSourceRadius: 20
                FallOffExponent: 8
                UseFallOffExponent: true
              }
            }
            MaxDrawDistance: 5000
            MaxDistanceFadeRange: 1000
          }
        }
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 85
}
