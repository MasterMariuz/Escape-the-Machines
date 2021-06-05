Assets {
  Id: 13940275703008700460
  Name: "NPCHealthBarDataProviderClient"
  PlatformAssetType: 3
  TextAsset {
    CustomParameters {
      Overrides {
        Name: "cs:Root"
        ObjectReference {
        }
      }
      Overrides {
        Name: "cs:HealthBarTemplate"
        AssetReference {
          Id: 14202341709520104131
        }
      }
      Overrides {
        Name: "cs:Root:tooltip"
        String: "A reference to the root of the template, where most of the NPC\'s custom properties are set."
      }
      Overrides {
        Name: "cs:HealthBarTemplate:tooltip"
        String: "Asset reference to the template that will be spawned as the health bar. The position of the health bar depends on the position of this script. Commonly, the script\'s Z position should be adjusted on a per-NPC basis."
      }
    }
  }
  SerializationVersion: 87
}
