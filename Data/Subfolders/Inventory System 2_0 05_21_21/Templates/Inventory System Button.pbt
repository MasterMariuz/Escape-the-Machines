Assets {
  Id: 3038254500740011310
  Name: "Inventory System Button"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 11703560911806414667
      Objects {
        Id: 11703560911806414667
        Name: "Inventory System Button"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 13574136920730619400
        ChildIds: 10085745054922034258
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
          Height: 100
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Button {
            FontColor {
              A: 1
            }
            FontSize: 20
            ButtonColor {
              R: 0.5
              G: 0.5
              B: 0.5
              A: 0.25
            }
            HoveredColor {
              R: 0.5
              G: 0.5
              B: 0.5
              A: 0.31
            }
            PressedColor {
              R: 0.5
              G: 0.5
              B: 0.5
              A: 0.5
            }
            DisabledColor {
              R: 0.5
              G: 0.5
              B: 0.5
              A: 0.05
            }
            Brush {
              Id: 2437060505070699581
            }
            IsButtonEnabled: true
            Font {
            }
            Justification {
              Value: "mc:etextjustify:center"
            }
            VerticalJustification {
              Value: "mc:everticaljustification:center"
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
        Id: 10085745054922034258
        Name: "Frame"
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
        ParentId: 11703560911806414667
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
          Height: 200
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Image {
            Brush {
              Id: 2048567116031212071
            }
            Color {
              R: 1
              G: 1
              B: 1
              A: 0.3
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
    }
    Assets {
      Id: 2437060505070699581
      Name: "BG Flat 001"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "BackgroundNoOutline_020"
      }
    }
    Assets {
      Id: 2048567116031212071
      Name: "Frame Outline Thin 001"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "FrameOutline_020"
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
