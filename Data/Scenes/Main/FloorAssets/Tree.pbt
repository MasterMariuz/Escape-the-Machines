Name: "FloorAssets"
RootId: 8641810105033289747
Objects {
  Id: 8645365627582347205
  Name: "NormalContext"
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
  ParentId: 8641810105033289747
  ChildIds: 4881677574496800761
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  EditorIndicatorVisibility {
    Value: "mc:eindicatorvisibility:visiblewhenselected"
  }
  Folder {
    IsGroup: true
  }
}
Objects {
  Id: 4881677574496800761
  Name: "SpawnLevel"
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
  ParentId: 8645365627582347205
  UnregisteredParameters {
    Overrides {
      Name: "cs:Floor01"
      AssetReference {
        Id: 6805850117970200519
      }
    }
    Overrides {
      Name: "cs:Door2x1"
      AssetReference {
        Id: 7900614132534527931
      }
    }
    Overrides {
      Name: "cs:Door4x1"
      AssetReference {
        Id: 1687323197551734109
      }
    }
    Overrides {
      Name: "cs:Wall01"
      AssetReference {
        Id: 2074187361203777797
      }
    }
    Overrides {
      Name: "cs:Corner01"
      AssetReference {
        Id: 3795649255963037061
      }
    }
    Overrides {
      Name: "cs:NewFolder"
      AssetReference {
        Id: 6494725811928177792
      }
    }
    Overrides {
      Name: "cs:TriggerRoom"
      AssetReference {
        Id: 12802208505368749406
      }
    }
    Overrides {
      Name: "cs:FloorFolder"
      AssetReference {
        Id: 16962570200718933532
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
  EditorIndicatorVisibility {
    Value: "mc:eindicatorvisibility:visiblewhenselected"
  }
  Script {
    ScriptAsset {
      Id: 7228378144789719592
    }
  }
}
Objects {
  Id: 8241001250266720364
  Name: "ClientContext"
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
  ParentId: 8641810105033289747
  ChildIds: 15891078139384035645
  UnregisteredParameters {
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:forceoff"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  EditorIndicatorVisibility {
    Value: "mc:eindicatorvisibility:visiblewhenselected"
  }
  NetworkContext {
  }
}
Objects {
  Id: 15891078139384035645
  Name: "MinimapContainer"
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
  ParentId: 8241001250266720364
  ChildIds: 7429732955363601403
  UnregisteredParameters {
    Overrides {
      Name: "cs:MinimapPanel"
      AssetReference {
        Id: 8949298828942513446
      }
    }
    Overrides {
      Name: "cs:MinimapBlock"
      AssetReference {
        Id: 7169633771664624214
      }
    }
    Overrides {
      Name: "cs:NewGroup"
      AssetReference {
        Id: 7757243214136105654
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:forceon"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  EditorIndicatorVisibility {
    Value: "mc:eindicatorvisibility:visiblewhenselected"
  }
  Control {
    RenderTransformPivot {
      Anchor {
        Value: "mc:euianchor:middlecenter"
      }
    }
    Canvas {
      ContentType {
        Value: "mc:ecanvascontenttype:dynamic"
      }
      Opacity: 1
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
  Id: 7429732955363601403
  Name: "MinimapScript"
  Transform {
    Location {
      X: -5904.3418
      Y: 1166.72571
    }
    Rotation {
      Yaw: -44.9999924
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 15891078139384035645
  UnregisteredParameters {
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
  EditorIndicatorVisibility {
    Value: "mc:eindicatorvisibility:visiblewhenselected"
  }
  Script {
    ScriptAsset {
      Id: 3478030028041158234
    }
  }
}
Objects {
  Id: 10230383160422371595
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
  ParentId: 8641810105033289747
  ChildIds: 17099071354881318680
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  EditorIndicatorVisibility {
    Value: "mc:eindicatorvisibility:visiblewhenselected"
  }
  NetworkContext {
    Type: Server
  }
}
Objects {
  Id: 17099071354881318680
  Name: "MasterScript"
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
  ParentId: 10230383160422371595
  UnregisteredParameters {
    Overrides {
      Name: "cs:NewFolder"
      AssetReference {
        Id: 6494725811928177792
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
  EditorIndicatorVisibility {
    Value: "mc:eindicatorvisibility:visiblewhenselected"
  }
  Script {
    ScriptAsset {
      Id: 2647337265739975871
    }
  }
}
