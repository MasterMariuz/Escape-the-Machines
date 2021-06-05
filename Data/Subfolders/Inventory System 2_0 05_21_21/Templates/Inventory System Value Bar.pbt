Assets {
  Id: 17899892339828223354
  Name: "Inventory System Value Bar"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 1774429245390154851
      Objects {
        Id: 1774429245390154851
        Name: "Inventory System Value Bar"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4781671109827199097
        ChildIds: 12662355177422495446
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 35
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Text {
            Label: "Value name"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 16
            Justification {
              Value: "mc:etextjustify:left"
            }
            Font {
              Id: 10980552376476642174
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
          }
        }
      }
      Objects {
        Id: 12662355177422495446
        Name: "Background"
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
        ParentId: 1774429245390154851
        ChildIds: 5362431551464737467
        ChildIds: 7735066021786860224
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 2
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              A: 0.65
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:bottomleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:bottomleft"
              }
            }
          }
        }
      }
      Objects {
        Id: 5362431551464737467
        Name: "Bar"
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
        ParentId: 12662355177422495446
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 100
          Height: 2
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
          }
        }
      }
      Objects {
        Id: 7735066021786860224
        Name: "Value"
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
        ParentId: 12662355177422495446
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 35
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Text {
            Label: "Value"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 16
            Justification {
              Value: "mc:etextjustify:right"
            }
            Font {
              Id: 10980552376476642174
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:bottomright"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:bottomright"
              }
            }
          }
        }
      }
    }
    Assets {
      Id: 10980552376476642174
      Name: "Oswald Extra Light"
      PlatformAssetType: 28
      PrimaryAsset {
        AssetType: "FontAssetRef"
        AssetId: "OswaldExtraLight_ref"
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
