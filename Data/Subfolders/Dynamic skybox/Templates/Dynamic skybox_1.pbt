Assets {
  Id: 1422796895265036754
  Name: "Dynamic skybox"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 1128437842510144268
      Objects {
        Id: 1128437842510144268
        Name: "Dynamic skybox ambiances"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4781671109827199097
        ChildIds: 15761334910859688939
        ChildIds: 18197212160352598830
        ChildIds: 3031501963838946655
        ChildIds: 3042865002528215611
        ChildIds: 6996312495465530585
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
        Id: 15761334910859688939
        Name: "Base Skybox"
        Transform {
          Location {
            X: 204.179443
            Y: -1471.73987
            Z: -946.338867
          }
          Rotation {
          }
          Scale {
            X: 1.64207149
            Y: 1.64207149
            Z: 1.64207149
          }
        }
        ParentId: 1128437842510144268
        ChildIds: 11805361466721794119
        ChildIds: 16160687230437932474
        ChildIds: 9286628204015967203
        ChildIds: 18381942604806312401
        ChildIds: 755156618111400479
        ChildIds: 2095538159041274445
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
        Folder {
          IsGroup: true
        }
      }
      Objects {
        Id: 11805361466721794119
        Name: "Sky Dome"
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
        ParentId: 15761334910859688939
        UnregisteredParameters {
          Overrides {
            Name: "bp:Zenith Color"
            Color {
              R: 0.0243181027
              G: 0.0633459091
              B: 0.212230757
              A: 1
            }
          }
          Overrides {
            Name: "bp:Horizon Color"
            Color {
              R: 0.489468127
              G: 0.480969489
              B: 0.623960376
              A: 1
            }
          }
          Overrides {
            Name: "bp:Haze Color"
            Color {
              R: 0.590618849
              G: 0.590618849
              B: 0.701101899
              A: 1
            }
          }
          Overrides {
            Name: "bp:Use Sun Color for Cloud Color"
            Bool: false
          }
          Overrides {
            Name: "bp:Cloud Ambient Brightness"
            Float: 3
          }
          Overrides {
            Name: "bp:Cloud Rim Brightness"
            Float: 50
          }
          Overrides {
            Name: "bp:Cloud Opacity"
            Float: 0.10037148
          }
          Overrides {
            Name: "bp:Cloud Ambient Color"
            Color {
              R: 2
              G: 2
              B: 2
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Color"
            Color {
              R: 2
              G: 2
              B: 2
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Shape"
            Enum {
              Value: "mc:ecloudshapes:2"
            }
          }
          Overrides {
            Name: "bp:Cloud Lighting Brightness"
            Float: 2
          }
          Overrides {
            Name: "bp:Cloud Wisp Opacity"
            Float: 0.4
          }
          Overrides {
            Name: "bp:Cloud Speed"
            Float: 1
          }
          Overrides {
            Name: "bp:Brightness"
            Float: 1.51692688
          }
          Overrides {
            Name: "bp:Background Clouds"
            Bool: true
          }
          Overrides {
            Name: "bp:High Cloud Index"
            Enum {
              Value: "mc:ehighaltitudecloudshapes:1"
            }
          }
          Overrides {
            Name: "bp:High Cloud Opacity"
            Float: 0
          }
          Overrides {
            Name: "bp:High Cloud Noise Amount"
            Float: 0.1
          }
          Overrides {
            Name: "bp:High Cloud Noise Scale"
            Float: 0.2
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
            Id: 7887238662729938253
          }
        }
      }
      Objects {
        Id: 16160687230437932474
        Name: "Star Dome"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 0.608986914
            Y: 0.608986914
            Z: 0.608986914
          }
        }
        ParentId: 15761334910859688939
        UnregisteredParameters {
          Overrides {
            Name: "bp:Star Brightness"
            Float: -1
          }
          Overrides {
            Name: "bp:Star Visibility"
            Float: 0
          }
          Overrides {
            Name: "bp:Star Color Intensity"
            Float: 0.25
          }
          Overrides {
            Name: "bp:Twinkle"
            Bool: false
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
            Id: 2422797529040544929
          }
          TeamSettings {
          }
        }
      }
      Objects {
        Id: 9286628204015967203
        Name: "Skylight"
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
        ParentId: 15761334910859688939
        UnregisteredParameters {
          Overrides {
            Name: "bp:Index"
            Int: 3
          }
          Overrides {
            Name: "bp:Occlusion Contrast"
            Float: 0
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 2.16470981
          }
          Overrides {
            Name: "bp:Lower Hemisphere Color"
            Color {
              G: 0.0215629078
              B: 0.088000007
              A: 1
            }
          }
          Overrides {
            Name: "bp:Occlusion Tint"
            Color {
              R: 0.0274509825
              G: 0.0274509825
              B: 0.0392156877
              A: 1
            }
          }
          Overrides {
            Name: "bp:Occlusion Exponent"
            Float: 0.4
          }
          Overrides {
            Name: "bp:Cast Shadows"
            Bool: true
          }
          Overrides {
            Name: "bp:Cast Volumetric Shadows"
            Bool: false
          }
          Overrides {
            Name: "bp:Tint Color"
            Color {
              R: 0.502886474
              G: 0.48514995
              B: 0.752942204
              A: 1
            }
          }
          Overrides {
            Name: "bp:Blend Target Image"
            Enum {
              Value: "mc:eambientcubemapssmall:0"
            }
          }
          Overrides {
            Name: "bp:Indirect Intensity"
            Float: 0.712928772
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
            Id: 11515840070784317904
          }
        }
      }
      Objects {
        Id: 18381942604806312401
        Name: "Sun Light"
        Transform {
          Location {
          }
          Rotation {
            Pitch: -45.8452454
            Yaw: 33.9371681
            Roll: 8.92734146
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 15761334910859688939
        UnregisteredParameters {
          Overrides {
            Name: "bp:Use Temperature"
            Bool: false
          }
          Overrides {
            Name: "bp:Light Color"
            Color {
              R: 1
              G: 0.892384112
              B: 0.59375
              A: 1
            }
          }
          Overrides {
            Name: "bp:Shape"
            Int: 1
          }
          Overrides {
            Name: "bp:Size"
            Float: 30
          }
          Overrides {
            Name: "bp:Light Shaft Bloom"
            Bool: true
          }
          Overrides {
            Name: "bp:Cast Volumetric Shadows"
            Bool: false
          }
          Overrides {
            Name: "bp:Light Shaft Mask Darkness"
            Float: 0.5
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 4
          }
          Overrides {
            Name: "bp:Sun Disc Color"
            Color {
              R: 3
              G: 3
              B: 3
              A: 1
            }
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Scale"
            Float: 0.2
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Threshold"
            Float: 0.05
          }
          Overrides {
            Name: "bp:Light Shaft Occlusion"
            Bool: true
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Tint"
            Color {
              R: 1
              G: 0.998476863
              B: 0.77
              A: 1
            }
          }
          Overrides {
            Name: "bp:Distance Fadeout Percentage"
            Float: 0.1
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
            Id: 16910278292812118833
          }
        }
      }
      Objects {
        Id: 755156618111400479
        Name: "Environment Fog Default VFX"
        Transform {
          Location {
            Z: 700
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 15761334910859688939
        UnregisteredParameters {
          Overrides {
            Name: "bp:Volumetric Fog"
            Bool: true
          }
          Overrides {
            Name: "bp:Layered Fog Density"
            Float: 1.40560293
          }
          Overrides {
            Name: "bp:Layered Fog Offset Height"
            Float: 7.358
          }
          Overrides {
            Name: "bp:Directional Inscattering Color"
            Color {
              R: 0.220000029
              G: 0.426622212
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Layered Fog Falloff"
            Float: 4
          }
          Overrides {
            Name: "bp:color"
            Color {
              R: 0.290000021
              G: 0.393443286
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Fog Density"
            Float: 3.06271195
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
            Id: 5773220180086757772
          }
        }
      }
      Objects {
        Id: 2095538159041274445
        Name: "Post Processing"
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
        ParentId: 15761334910859688939
        ChildIds: 9976019556730491181
        ChildIds: 17708619771308952385
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
        Id: 9976019556730491181
        Name: "Central Advanced Color Grading Post Process"
        Transform {
          Location {
            X: -419.589111
            Z: 5240
          }
          Rotation {
          }
          Scale {
            X: 122.139458
            Y: 115.500046
            Z: 266.485046
          }
        }
        ParentId: 2095538159041274445
        UnregisteredParameters {
          Overrides {
            Name: "bp:Color Saturation"
            Color {
              R: 1.3
              G: 1.3
              B: 1.3
              A: 1
            }
          }
          Overrides {
            Name: "bp:Color Contrast"
            Color {
              R: 1.2
              G: 1.2
              B: 1.2
              A: 1
            }
          }
          Overrides {
            Name: "bp:Unbounded"
            Bool: false
          }
          Overrides {
            Name: "bp:Volume Type"
            Enum {
              Value: "mc:evolumetype:2"
            }
          }
          Overrides {
            Name: "bp:Blend Radius"
            Float: 1000
          }
          Overrides {
            Name: "bp:Midtones Saturation"
            Color {
              R: 1.1
              G: 1.1
              B: 1.1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Highlights Min"
            Float: 0.5
          }
          Overrides {
            Name: "bp:Shadow Gain"
            Color {
              R: 0.97
              G: 0.971390724
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Scene Tint"
            Color {
              R: 1.1
              G: 1.1
              B: 1.1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Blend Weight"
            Float: 0.436940908
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
            Id: 7936187315447154565
          }
        }
      }
      Objects {
        Id: 17708619771308952385
        Name: "Central Bloom Post Process"
        Transform {
          Location {
            X: -419.589111
            Z: 5240
          }
          Rotation {
          }
          Scale {
            X: 122.350853
            Y: 115.699951
            Z: 266.946259
          }
        }
        ParentId: 2095538159041274445
        UnregisteredParameters {
          Overrides {
            Name: "bp:Threshold"
            Float: -1
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 3
          }
          Overrides {
            Name: "bp:Unbounded"
            Bool: false
          }
          Overrides {
            Name: "bp:Volume Type"
            Enum {
              Value: "mc:evolumetype:2"
            }
          }
          Overrides {
            Name: "bp:Blend Weight"
            Float: 0.436940908
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
            Id: 10151547298258526858
          }
        }
      }
      Objects {
        Id: 18197212160352598830
        Name: "Adjusted magical atmosphere 1"
        Transform {
          Location {
            X: -8638.91797
            Y: -472.936157
            Z: 342.16626
          }
          Rotation {
            Yaw: 100.218658
          }
          Scale {
            X: 0.574674785
            Y: 0.574674785
            Z: 0.574674785
          }
        }
        ParentId: 1128437842510144268
        ChildIds: 5827689454881225510
        ChildIds: 14864341994155984642
        ChildIds: 12083365574079130737
        ChildIds: 7339110514968976550
        ChildIds: 13274411245643590751
        ChildIds: 15130363165262744501
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
        Id: 5827689454881225510
        Name: "Centre of atmosphere (turn invis+ColisOFF)"
        Transform {
          Location {
            X: 783.342
            Y: 1407.70581
            Z: -638.004944
          }
          Rotation {
            Yaw: -100.218658
          }
          Scale {
            X: 87.9232941
            Y: 83.4119873
            Z: 3.63159704
          }
        }
        ParentId: 18197212160352598830
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 9748238970305884976
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:smart"
            Bool: false
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:utile"
            Float: 17.4406528
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:vtile"
            Float: 11.0356207
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
            Id: 7882895811213908562
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
        Id: 14864341994155984642
        Name: "Sky Adjustment Volume"
        Transform {
          Location {
            X: 319.899872
            Y: 1774.70471
            Z: 719.966614
          }
          Rotation {
            Yaw: -9.2232666
          }
          Scale {
            X: 171.233719
            Y: 154.855209
            Z: 151.639175
          }
        }
        ParentId: 18197212160352598830
        UnregisteredParameters {
          Overrides {
            Name: "bp:Sky Object"
            ObjectReference {
              SubObjectId: 11805361466721794119
            }
          }
          Overrides {
            Name: "bp:Cloud Wisp Opacity"
            Float: 1
          }
          Overrides {
            Name: "bp:Cloud Wisp Speed"
            Float: 0.2
          }
          Overrides {
            Name: "bp:Cloud Ambient Brightness"
            Float: 2
          }
          Overrides {
            Name: "bp:Cloud Sun Behind Transmission"
            Float: 2
          }
          Overrides {
            Name: "bp:Brightness"
            Float: 0.867886364
          }
          Overrides {
            Name: "bp:Cloud Wisp Color"
            Color {
              R: 1
              G: 0.350000024
              B: 0.944039583
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Rim Color"
            Color {
              R: 0.55
              G: 0.749668896
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Ambient Color"
            Color {
              R: 0.83973527
              G: 0.45
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Haze Falloff"
            Float: 3
          }
          Overrides {
            Name: "bp:Horizon Falloff"
            Float: 6
          }
          Overrides {
            Name: "bp:Cloud Lighting Brightness"
            Float: 10
          }
          Overrides {
            Name: "bp:Cloud Opacity"
            Float: 1
          }
          Overrides {
            Name: "bp:Cloud Color"
            Color {
              R: 0.839999914
              G: 2.53199935
              B: 3
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Color"
            Color {
              R: 3.33333492
              B: 10
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Opacity"
            Float: 0.216216102
          }
          Overrides {
            Name: "bp:High Cloud Brightness"
            Float: 0.458219588
          }
          Overrides {
            Name: "bp:Haze Color"
            Color {
              R: 1.50000095
              B: 5
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Noise Scale"
            Float: 0.2
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.78
              B: 0.697350502
              A: 1
            }
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
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
            Id: 9648877314680910022
          }
        }
      }
      Objects {
        Id: 12083365574079130737
        Name: "Skylight Adjustment Volume"
        Transform {
          Location {
            X: 319.899872
            Y: 1774.70471
            Z: 719.966614
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 171.233719
            Y: 154.855209
            Z: 151.639175
          }
        }
        ParentId: 18197212160352598830
        UnregisteredParameters {
          Overrides {
            Name: "bp:Skylight Object"
            ObjectReference {
              SubObjectId: 9286628204015967203
            }
          }
          Overrides {
            Name: "bp:Indirect Intensity"
            Float: 0.830229759
          }
          Overrides {
            Name: "bp:Blend Amount"
            Float: 0.657875955
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 2.20969653
          }
          Overrides {
            Name: "bp:Occlusion Contrast"
            Float: 0.973852217
          }
          Overrides {
            Name: "bp:Occlusion Exponent"
            Float: 1
          }
          Overrides {
            Name: "bp:Volumetric Intensity"
            Float: 0.191081882
          }
          Overrides {
            Name: "bp:Lower Hemisphere Color"
            Color {
              R: 0.529801905
              B: 0.64
              A: 1
            }
          }
          Overrides {
            Name: "bp:Occlusion Tint"
            Color {
              R: 0.278000027
              G: 0.0925739929
              B: 0.180989012
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Tint Color"
            Color {
              R: 0.423100233
              G: 0.358999968
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
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
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 1903351858187431298
          }
        }
      }
      Objects {
        Id: 7339110514968976550
        Name: "Sun Adjustment Volume"
        Transform {
          Location {
            X: 319.899872
            Y: 1774.70471
            Z: 719.966614
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 171.233719
            Y: 154.855209
            Z: 151.639175
          }
        }
        ParentId: 18197212160352598830
        UnregisteredParameters {
          Overrides {
            Name: "bp:Sun Object"
            ObjectReference {
              SubObjectId: 18381942604806312401
            }
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 1.94941676
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Light Color"
            Color {
              R: 1
              G: 0.322999954
              B: 0.695349813
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Rotation"
            Rotator {
              Pitch: -21.9754829
              Yaw: 135.660599
            }
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Threshold"
            Float: 2.91296744
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Scale"
            Float: 0
          }
          Overrides {
            Name: "bp:Light Shaft Mask Darkness"
            Float: 1
          }
          Overrides {
            Name: "bp:Temperature"
            Float: 3837.95264
          }
          Overrides {
            Name: "bp:Size"
            Float: 20
          }
          Overrides {
            Name: "bp:Indirect Lighting Intensity"
            Float: 0.833094776
          }
          Overrides {
            Name: "bp:Volumetric Intensity"
            Float: 1.2587502
          }
          Overrides {
            Name: "bp:Sun Disc Color"
            Color {
              R: 0.23103
              G: 0.765000045
              B: 0.729402065
              A: 1
            }
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Distance Fadeout Percentage"
            Float: 0.1
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
            Id: 7786429434059921876
          }
        }
      }
      Objects {
        Id: 13274411245643590751
        Name: "Fog Adjustment Volume"
        Transform {
          Location {
            X: 319.899872
            Y: 1774.70471
            Z: 719.966614
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 171.233719
            Y: 154.855209
            Z: 151.639175
          }
        }
        ParentId: 18197212160352598830
        UnregisteredParameters {
          Overrides {
            Name: "bp:Fog Object"
            ObjectReference {
              SubObjectId: 755156618111400479
            }
          }
          Overrides {
            Name: "bp:Fog Density"
            Float: 8.51475239
          }
          Overrides {
            Name: "bp:Falloff"
            Float: 0.553979397
          }
          Overrides {
            Name: "bp:Start"
            Float: 2000
          }
          Overrides {
            Name: "bp:Opacity"
            Float: 0.322092623
          }
          Overrides {
            Name: "bp:Layered Fog Density"
            Float: 5.33845663
          }
          Overrides {
            Name: "bp:Layered Fog Falloff"
            Float: 2.44867015
          }
          Overrides {
            Name: "bp:Layered Fog Offset Height"
            Float: 18.6461563
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:color"
            Color {
              R: 0.828000069
              G: 0.159803987
              B: 0.237759948
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Albedo"
            Color {
              R: 0.979000032
              G: 0.554766715
              A: 1
            }
          }
          Overrides {
            Name: "bp:Light Absorption Amount"
            Float: 0.167622507
          }
          Overrides {
            Name: "bp:Beam View Direction"
            Float: 0.05
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Color"
            Color {
              R: 0.410000026
              G: 0.0533
              B: 0.180861622
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
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 8497683954571070335
          }
        }
      }
      Objects {
        Id: 15130363165262744501
        Name: "atmosphere box"
        Transform {
          Location {
            X: 199.259064
            Y: 2052.97339
          }
          Rotation {
            Yaw: -8.92843628
          }
          Scale {
            X: 173.269
            Y: 158.72374
            Z: 102.159859
          }
        }
        ParentId: 18197212160352598830
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 13865444176083240483
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              R: 0.154000014
              G: 0.154000014
              B: 0.154000014
              A: 0.107000008
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        CoreMesh {
          MeshAsset {
            Id: 5694757505926352082
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          DisableCastShadows: true
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
        Id: 3031501963838946655
        Name: "Adjusted warm atmosphere 2"
        Transform {
          Location {
            X: 6693.94
            Y: 32.8094482
            Z: 2295.77563
          }
          Rotation {
            Yaw: 100.218674
          }
          Scale {
            X: 0.936584771
            Y: 0.936584771
            Z: 0.936584771
          }
        }
        ParentId: 1128437842510144268
        ChildIds: 14227061658981100849
        ChildIds: 9847015939557845074
        ChildIds: 9544456886051595013
        ChildIds: 5252342031242989022
        ChildIds: 5959948915500892631
        ChildIds: 13247399941755401440
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
        Id: 14227061658981100849
        Name: "Centre of atmosphere (turn invis+ColisOFF)"
        Transform {
          Location {
            X: 8.45030689
            Y: 55.3247223
            Z: -2461.15625
          }
          Rotation {
            Yaw: -100.218658
          }
          Scale {
            X: 47.4556465
            Y: 49.6806908
            Z: 6.77947617
          }
        }
        ParentId: 3031501963838946655
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 9748238970305884976
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:smart"
            Bool: false
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:utile"
            Float: 17.4406528
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:vtile"
            Float: 11.0356207
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
            Id: 7882895811213908562
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
        Id: 9847015939557845074
        Name: "Sky Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.2232666
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 3031501963838946655
        UnregisteredParameters {
          Overrides {
            Name: "bp:Sky Object"
            ObjectReference {
              SubObjectId: 11805361466721794119
            }
          }
          Overrides {
            Name: "bp:Cloud Wisp Opacity"
            Float: 1
          }
          Overrides {
            Name: "bp:Cloud Wisp Speed"
            Float: 0.2
          }
          Overrides {
            Name: "bp:Cloud Ambient Brightness"
            Float: 2
          }
          Overrides {
            Name: "bp:Cloud Sun Behind Transmission"
            Float: 2
          }
          Overrides {
            Name: "bp:Brightness"
            Float: 0.317648262
          }
          Overrides {
            Name: "bp:Cloud Wisp Color"
            Color {
              R: 1
              G: 0.646622479
              B: 0.0799999833
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Rim Color"
            Color {
              R: 0.49
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Ambient Color"
            Color {
              R: 0.89
              G: 0.618874192
              A: 1
            }
          }
          Overrides {
            Name: "bp:Haze Falloff"
            Float: 3
          }
          Overrides {
            Name: "bp:Horizon Falloff"
            Float: 6
          }
          Overrides {
            Name: "bp:Cloud Lighting Brightness"
            Float: 10
          }
          Overrides {
            Name: "bp:Cloud Opacity"
            Float: 1
          }
          Overrides {
            Name: "bp:Cloud Color"
            Color {
              R: 2
              G: 1.15231788
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Color"
            Color {
              R: 3
              G: 3
              B: 3
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Opacity"
            Float: 0.709062219
          }
          Overrides {
            Name: "bp:High Cloud Brightness"
            Float: 0.754915416
          }
          Overrides {
            Name: "bp:Haze Color"
            Color {
              R: 4
              G: 3.19629169
              B: 0.72
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Noise Scale"
            Float: 0.2
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Zenith Color"
            Color {
              A: 0.6
            }
          }
          Overrides {
            Name: "bp:Horizon Color"
            Color {
              R: 0.201288626
              G: 0.214000016
              B: 0.214000016
              A: 0.9
            }
          }
          Overrides {
            Name: "bp:Overall Tint"
            Color {
              R: 1
              G: 0.204132378
              B: 0.187999964
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
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 9648877314680910022
          }
        }
      }
      Objects {
        Id: 9544456886051595013
        Name: "Skylight Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 3031501963838946655
        UnregisteredParameters {
          Overrides {
            Name: "bp:Skylight Object"
            ObjectReference {
              SubObjectId: 9286628204015967203
            }
          }
          Overrides {
            Name: "bp:Indirect Intensity"
            Float: 0.830229759
          }
          Overrides {
            Name: "bp:Blend Amount"
            Float: 0.174186215
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 0.2302773
          }
          Overrides {
            Name: "bp:Occlusion Contrast"
            Float: 0
          }
          Overrides {
            Name: "bp:Occlusion Exponent"
            Float: 0.5
          }
          Overrides {
            Name: "bp:Volumetric Intensity"
            Float: 1.22541308
          }
          Overrides {
            Name: "bp:Lower Hemisphere Color"
            Color {
              R: 0.529801905
              B: 0.64
              A: 1
            }
          }
          Overrides {
            Name: "bp:Occlusion Tint"
            Color {
              R: 0.269999981
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Tint Color"
            Color {
              R: 0.100000024
              A: 1
            }
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
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
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 1903351858187431298
          }
        }
      }
      Objects {
        Id: 5252342031242989022
        Name: "Sun Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 3031501963838946655
        UnregisteredParameters {
          Overrides {
            Name: "bp:Sun Object"
            ObjectReference {
              SubObjectId: 18381942604806312401
            }
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 1.85436034
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Light Color"
            Color {
              R: 1
              G: 0.515894055
              B: 0.139999986
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Rotation"
            Rotator {
              Pitch: -21.9754829
              Yaw: 135.660599
            }
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Threshold"
            Float: 2.91296744
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Scale"
            Float: 0
          }
          Overrides {
            Name: "bp:Light Shaft Mask Darkness"
            Float: 1
          }
          Overrides {
            Name: "bp:Temperature"
            Float: 3837.95264
          }
          Overrides {
            Name: "bp:Size"
            Float: 20
          }
          Overrides {
            Name: "bp:Indirect Lighting Intensity"
            Float: 0.833094776
          }
          Overrides {
            Name: "bp:Volumetric Intensity"
            Float: 1.2587502
          }
          Overrides {
            Name: "bp:Sun Disc Color"
            Color {
              R: 0.23103
              G: 0.765000045
              B: 0.729402065
              A: 1
            }
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Distance Fadeout Percentage"
            Float: 0.167994767
          }
          Overrides {
            Name: "bp:Shadow Bias"
            Float: 1013.81531
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
            Id: 7786429434059921876
          }
        }
      }
      Objects {
        Id: 5959948915500892631
        Name: "Fog Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 3031501963838946655
        UnregisteredParameters {
          Overrides {
            Name: "bp:Fog Object"
            ObjectReference {
              SubObjectId: 755156618111400479
            }
          }
          Overrides {
            Name: "bp:Fog Density"
            Float: 0.258499235
          }
          Overrides {
            Name: "bp:Falloff"
            Float: 0.0992039
          }
          Overrides {
            Name: "bp:Start"
            Float: 1574.02527
          }
          Overrides {
            Name: "bp:Opacity"
            Float: 0.68613565
          }
          Overrides {
            Name: "bp:Layered Fog Density"
            Float: 5.57746792
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:color"
            Color {
              R: 0.828000069
              G: 0.159803987
              B: 0.237759948
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Albedo"
            Color {
              R: 2
              G: 0.436000019
              A: 1
            }
          }
          Overrides {
            Name: "bp:Light Absorption Amount"
            Float: 1.08222854
          }
          Overrides {
            Name: "bp:Beam View Direction"
            Float: 0.05
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Color"
            Color {
              R: 0.700000048
              G: 3.33786033e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Directional Inscattering Exponent"
            Float: 12.9842548
          }
          Overrides {
            Name: "bp:Directional Inscattering Color"
            Color {
              R: 0.36
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
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 8497683954571070335
          }
        }
      }
      Objects {
        Id: 13247399941755401440
        Name: "atmosphere box"
        Transform {
          Location {
            X: 78.7607727
            Y: 33.3621902
            Z: -2438.3
          }
          Rotation {
            Yaw: -8.92843628
          }
          Scale {
            X: 103.800438
            Y: 97.3905869
            Z: 62.6838036
          }
        }
        ParentId: 3031501963838946655
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 13865444176083240483
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              R: 0.154000014
              G: 0.154000014
              B: 0.154000014
              A: 0.107000008
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        CoreMesh {
          MeshAsset {
            Id: 5694757505926352082
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          DisableCastShadows: true
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
        Id: 3042865002528215611
        Name: "Adjusted night atmosphere 3"
        Transform {
          Location {
            X: -1189.42725
            Y: 11477.9238
            Z: 2295.77563
          }
          Rotation {
            Yaw: 100.218697
          }
          Scale {
            X: 0.936584771
            Y: 0.936584771
            Z: 0.936584771
          }
        }
        ParentId: 1128437842510144268
        ChildIds: 16345711495437464595
        ChildIds: 18397641568761616805
        ChildIds: 5212027605158878935
        ChildIds: 13843662491289196036
        ChildIds: 18361751991733104926
        ChildIds: 6366389900523374416
        ChildIds: 17831769553063790454
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
        Id: 16345711495437464595
        Name: "Centre of atmosphere (turn invis+ColisOFF)"
        Transform {
          Location {
            X: 8.45062828
            Y: 55.3246574
            Z: -2487.11987
          }
          Rotation {
            Yaw: -100.218658
          }
          Scale {
            X: 47.4556465
            Y: 49.6806908
            Z: 4.437006
          }
        }
        ParentId: 3042865002528215611
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 9748238970305884976
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:smart"
            Bool: false
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:utile"
            Float: 17.4406528
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:vtile"
            Float: 11.0356207
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
            Id: 7882895811213908562
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
        Id: 18397641568761616805
        Name: "Star Dome"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1.06770897
            Y: 1.06770897
            Z: 1.06770897
          }
        }
        ParentId: 3042865002528215611
        UnregisteredParameters {
          Overrides {
            Name: "bp:Star Brightness"
            Float: 1.66226244
          }
          Overrides {
            Name: "bp:Color Gradient"
            Enum {
              Value: "mc:ecolorgradients:11"
            }
          }
          Overrides {
            Name: "bp:Star Color Cycle"
            Float: 66.5928802
          }
          Overrides {
            Name: "bp:Real Stars"
            Bool: false
          }
          Overrides {
            Name: "bp:Star Color Intensity"
            Float: 0.25
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
            Id: 2422797529040544929
          }
          TeamSettings {
          }
        }
      }
      Objects {
        Id: 5212027605158878935
        Name: "Sky Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.2232666
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 3042865002528215611
        UnregisteredParameters {
          Overrides {
            Name: "bp:Sky Object"
            ObjectReference {
              SubObjectId: 11805361466721794119
            }
          }
          Overrides {
            Name: "bp:Cloud Wisp Opacity"
            Float: 1
          }
          Overrides {
            Name: "bp:Cloud Wisp Speed"
            Float: 0.562332094
          }
          Overrides {
            Name: "bp:Cloud Ambient Brightness"
            Float: 2
          }
          Overrides {
            Name: "bp:Cloud Sun Behind Transmission"
            Float: 2
          }
          Overrides {
            Name: "bp:Brightness"
            Float: 0.693644285
          }
          Overrides {
            Name: "bp:Cloud Wisp Color"
            Color {
              R: 0.0499999523
              G: 1.85297823
              B: 5
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Rim Color"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Ambient Color"
            Color {
              R: 5
              G: 5
              B: 5
              A: 1
            }
          }
          Overrides {
            Name: "bp:Haze Falloff"
            Float: 12.499176
          }
          Overrides {
            Name: "bp:Horizon Falloff"
            Float: 6
          }
          Overrides {
            Name: "bp:Cloud Lighting Brightness"
            Float: 2.44443464
          }
          Overrides {
            Name: "bp:Cloud Opacity"
            Float: 0.475211054
          }
          Overrides {
            Name: "bp:Cloud Color"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Color"
            Color {
              R: 3
              G: 3
              B: 3
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Opacity"
            Float: 0.709062219
          }
          Overrides {
            Name: "bp:High Cloud Brightness"
            Float: 0.754915416
          }
          Overrides {
            Name: "bp:Haze Color"
            Color {
              R: 0.00995114539
              B: 0.063
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Noise Scale"
            Float: 0.337651521
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Zenith Color"
            Color {
              G: 0.0554039404
              B: 0.089
              A: 0.6
            }
          }
          Overrides {
            Name: "bp:Horizon Color"
            Color {
              R: 1
              G: 0.199999988
              B: 0.501986265
              A: 0.9
            }
          }
          Overrides {
            Name: "bp:Overall Tint"
            Color {
              G: 0.119801328
              B: 0.269999981
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Rim Brightness"
            Float: 4
          }
          Overrides {
            Name: "bp:High Cloud Speed"
            Float: 0.530234873
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
            Id: 9648877314680910022
          }
        }
      }
      Objects {
        Id: 13843662491289196036
        Name: "Skylight Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 3042865002528215611
        UnregisteredParameters {
          Overrides {
            Name: "bp:Skylight Object"
            ObjectReference {
              SubObjectId: 9286628204015967203
            }
          }
          Overrides {
            Name: "bp:Indirect Intensity"
            Float: 0.830229759
          }
          Overrides {
            Name: "bp:Blend Amount"
            Float: 0.270989478
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 1.55738807
          }
          Overrides {
            Name: "bp:Occlusion Contrast"
            Float: 0
          }
          Overrides {
            Name: "bp:Occlusion Exponent"
            Float: 1.00320601
          }
          Overrides {
            Name: "bp:Volumetric Intensity"
            Float: 0.820897102
          }
          Overrides {
            Name: "bp:Lower Hemisphere Color"
            Color {
              R: 0.529801905
              B: 0.64
              A: 1
            }
          }
          Overrides {
            Name: "bp:Occlusion Tint"
            Color {
              R: 0.035749983
              G: 0.108634092
              B: 0.275
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Tint Color"
            Color {
              R: 0.0456500091
              G: 0.158167243
              B: 0.415000021
              A: 1
            }
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
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
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 1903351858187431298
          }
        }
      }
      Objects {
        Id: 18361751991733104926
        Name: "Sun Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 3042865002528215611
        UnregisteredParameters {
          Overrides {
            Name: "bp:Sun Object"
            ObjectReference {
              SubObjectId: 18381942604806312401
            }
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 0.740128219
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Light Color"
            Color {
              R: 0.109199978
              G: 0.34786731
              B: 0.700000048
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Rotation"
            Rotator {
              Pitch: -21.9754829
              Yaw: 135.660599
            }
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Threshold"
            Float: 2.91296744
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Scale"
            Float: 0
          }
          Overrides {
            Name: "bp:Light Shaft Mask Darkness"
            Float: 1
          }
          Overrides {
            Name: "bp:Temperature"
            Float: 3837.95264
          }
          Overrides {
            Name: "bp:Size"
            Float: 20
          }
          Overrides {
            Name: "bp:Indirect Lighting Intensity"
            Float: 0.833094776
          }
          Overrides {
            Name: "bp:Volumetric Intensity"
            Float: 1.2587502
          }
          Overrides {
            Name: "bp:Sun Disc Color"
            Color {
              R: 0.23103
              G: 0.765000045
              B: 0.729402065
              A: 1
            }
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Distance Fadeout Percentage"
            Float: 0.200091988
          }
          Overrides {
            Name: "bp:Shadow Bias"
            Float: 1013.81531
          }
          Overrides {
            Name: "bp:Dynamic Shadow Distance"
            Float: 4.53407812
          }
          Overrides {
            Name: "bp:Cascade Distribution Adjustment"
            Float: 1.25889969
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
            Id: 7786429434059921876
          }
        }
      }
      Objects {
        Id: 6366389900523374416
        Name: "Fog Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 3042865002528215611
        UnregisteredParameters {
          Overrides {
            Name: "bp:Fog Object"
            ObjectReference {
              SubObjectId: 755156618111400479
            }
          }
          Overrides {
            Name: "bp:Fog Density"
            Float: 4.98137617
          }
          Overrides {
            Name: "bp:Falloff"
            Float: 1.42481911
          }
          Overrides {
            Name: "bp:Start"
            Float: 345.160187
          }
          Overrides {
            Name: "bp:Opacity"
            Float: 0.539405465
          }
          Overrides {
            Name: "bp:Layered Fog Density"
            Float: 2.13847947
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:color"
            Color {
              R: 0.828000069
              G: 0.159803987
              B: 0.237759948
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Albedo"
            Color {
              R: 0.511921048
              G: 0.329999983
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Light Absorption Amount"
            Float: 1.08222854
          }
          Overrides {
            Name: "bp:Beam View Direction"
            Float: 0.05
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Color"
            Color {
              G: 0.09849
              B: 0.286
              A: 1
            }
          }
          Overrides {
            Name: "bp:Directional Inscattering Exponent"
            Float: 18.9543381
          }
          Overrides {
            Name: "bp:Directional Inscattering Color"
            Color {
              G: 0.130529732
              B: 0.269999981
              A: 1
            }
          }
          Overrides {
            Name: "bp:Layered Fog Falloff"
            Float: 26.7796249
          }
          Overrides {
            Name: "bp:Layered Fog Offset Height"
            Float: -11.5233994
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
            Id: 8497683954571070335
          }
        }
      }
      Objects {
        Id: 17831769553063790454
        Name: "atmosphere box"
        Transform {
          Location {
            X: 78.7607727
            Y: 33.3621902
            Z: -2438.3
          }
          Rotation {
            Yaw: -8.92843628
          }
          Scale {
            X: 103.800438
            Y: 97.3905869
            Z: 62.6838036
          }
        }
        ParentId: 3042865002528215611
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 13865444176083240483
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              R: 0.154000014
              G: 0.154000014
              B: 0.154000014
              A: 0.107000008
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        CoreMesh {
          MeshAsset {
            Id: 5694757505926352082
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          DisableCastShadows: true
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
        Id: 6996312495465530585
        Name: "Adjusted morning atmosphere 3"
        Transform {
          Location {
            X: -1189.42725
            Y: -12799.3828
            Z: 2295.77563
          }
          Rotation {
            Yaw: 100.218719
          }
          Scale {
            X: 0.936584771
            Y: 0.936584771
            Z: 0.936584771
          }
        }
        ParentId: 1128437842510144268
        ChildIds: 9995689365569335431
        ChildIds: 8835656454548729400
        ChildIds: 2427768182052486085
        ChildIds: 11100062019925729545
        ChildIds: 6408749196582731303
        ChildIds: 5692760258695124192
        ChildIds: 10384691911849326666
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
        Id: 9995689365569335431
        Name: "Centre of atmosphere (turn invis+ColisOFF)"
        Transform {
          Location {
            X: 8.45062828
            Y: 55.3246574
            Z: -2487.11987
          }
          Rotation {
            Yaw: -100.218658
          }
          Scale {
            X: 47.4556465
            Y: 49.6806908
            Z: 4.437006
          }
        }
        ParentId: 6996312495465530585
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 9748238970305884976
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:smart"
            Bool: false
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:utile"
            Float: 17.4406528
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:vtile"
            Float: 11.0356207
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
            Id: 7882895811213908562
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
        Id: 8835656454548729400
        Name: "Star Dome"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1.06770897
            Y: 1.06770897
            Z: 1.06770897
          }
        }
        ParentId: 6996312495465530585
        UnregisteredParameters {
          Overrides {
            Name: "bp:Star Brightness"
            Float: 1.66226244
          }
          Overrides {
            Name: "bp:Color Gradient"
            Enum {
              Value: "mc:ecolorgradients:11"
            }
          }
          Overrides {
            Name: "bp:Star Color Cycle"
            Float: 66.5928802
          }
          Overrides {
            Name: "bp:Real Stars"
            Bool: false
          }
          Overrides {
            Name: "bp:Star Color Intensity"
            Float: 0.25
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
            Id: 2422797529040544929
          }
          TeamSettings {
          }
        }
      }
      Objects {
        Id: 2427768182052486085
        Name: "Sky Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.2232666
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 6996312495465530585
        UnregisteredParameters {
          Overrides {
            Name: "bp:Sky Object"
            ObjectReference {
              SubObjectId: 11805361466721794119
            }
          }
          Overrides {
            Name: "bp:Cloud Wisp Opacity"
            Float: 0.264286429
          }
          Overrides {
            Name: "bp:Cloud Wisp Speed"
            Float: 0.401845962
          }
          Overrides {
            Name: "bp:Cloud Ambient Brightness"
            Float: 1.03295779
          }
          Overrides {
            Name: "bp:Cloud Sun Behind Transmission"
            Float: 1.67490232
          }
          Overrides {
            Name: "bp:Brightness"
            Float: 0.54691416
          }
          Overrides {
            Name: "bp:Cloud Wisp Color"
            Color {
              R: 4
              G: 4
              B: 4
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Rim Color"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Ambient Color"
            Color {
              R: 3
              G: 3
              B: 3
              A: 1
            }
          }
          Overrides {
            Name: "bp:Haze Falloff"
            Float: 12.499176
          }
          Overrides {
            Name: "bp:Horizon Falloff"
            Float: 6
          }
          Overrides {
            Name: "bp:Cloud Lighting Brightness"
            Float: 4.40465784
          }
          Overrides {
            Name: "bp:Cloud Opacity"
            Float: 0.0854590535
          }
          Overrides {
            Name: "bp:Cloud Color"
            Color {
              R: 4
              G: 4
              B: 4
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Color"
            Color {
              R: 3
              G: 3
              B: 3
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Opacity"
            Float: 0.232189208
          }
          Overrides {
            Name: "bp:High Cloud Brightness"
            Float: 1
          }
          Overrides {
            Name: "bp:Haze Color"
            Color {
              R: 0.87
              G: 0.276556313
              A: 1
            }
          }
          Overrides {
            Name: "bp:High Cloud Noise Scale"
            Float: 0.470625728
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Zenith Color"
            Color {
              R: 1
              G: 1
              B: 0.627
              A: 1
            }
          }
          Overrides {
            Name: "bp:Horizon Color"
            Color {
              G: 1
              B: 0.98
              A: 1
            }
          }
          Overrides {
            Name: "bp:Overall Tint"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
          }
          Overrides {
            Name: "bp:Cloud Rim Brightness"
            Float: 20
          }
          Overrides {
            Name: "bp:High Cloud Speed"
            Float: 0.530234873
          }
          Overrides {
            Name: "bp:Sky Influence On Clouds"
            Float: 1
          }
          Overrides {
            Name: "bp:High Cloud Noise Amount"
            Float: 0.443113834
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
            Id: 9648877314680910022
          }
        }
      }
      Objects {
        Id: 11100062019925729545
        Name: "Skylight Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 6996312495465530585
        UnregisteredParameters {
          Overrides {
            Name: "bp:Skylight Object"
            ObjectReference {
              SubObjectId: 9286628204015967203
            }
          }
          Overrides {
            Name: "bp:Indirect Intensity"
            Float: 0.830229759
          }
          Overrides {
            Name: "bp:Blend Amount"
            Float: 0.270989478
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 1.55738807
          }
          Overrides {
            Name: "bp:Occlusion Contrast"
            Float: 0
          }
          Overrides {
            Name: "bp:Occlusion Exponent"
            Float: 1.00320601
          }
          Overrides {
            Name: "bp:Volumetric Intensity"
            Float: 0.820897102
          }
          Overrides {
            Name: "bp:Lower Hemisphere Color"
            Color {
              R: 0.529801905
              B: 0.64
              A: 1
            }
          }
          Overrides {
            Name: "bp:Occlusion Tint"
            Color {
              R: 0.253000021
              G: 0.185852841
              B: 0.0172039904
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Tint Color"
            Color {
              R: 1
              G: 0.820596039
              B: 0.37
              A: 1
            }
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
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
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Blueprint {
          BlueprintAsset {
            Id: 1903351858187431298
          }
        }
      }
      Objects {
        Id: 6408749196582731303
        Name: "Sun Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 6996312495465530585
        UnregisteredParameters {
          Overrides {
            Name: "bp:Sun Object"
            ObjectReference {
              SubObjectId: 18381942604806312401
            }
          }
          Overrides {
            Name: "bp:Intensity"
            Float: 3.23683357
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:Light Color"
            Color {
              R: 1
              G: 0.732980132
              B: 0.37
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Rotation"
            Rotator {
              Pitch: -21.9754829
              Yaw: 135.660599
            }
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Threshold"
            Float: 2.7570374
          }
          Overrides {
            Name: "bp:Light Shaft Bloom Scale"
            Float: 0
          }
          Overrides {
            Name: "bp:Light Shaft Mask Darkness"
            Float: 1
          }
          Overrides {
            Name: "bp:Temperature"
            Float: 2518.21191
          }
          Overrides {
            Name: "bp:Size"
            Float: 20
          }
          Overrides {
            Name: "bp:Indirect Lighting Intensity"
            Float: 0.684473693
          }
          Overrides {
            Name: "bp:Volumetric Intensity"
            Float: 1.32120216
          }
          Overrides {
            Name: "bp:Sun Disc Color"
            Color {
              R: 0.23103
              G: 0.765000045
              B: 0.729402065
              A: 1
            }
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Distance Fadeout Percentage"
            Float: 0
          }
          Overrides {
            Name: "bp:Shadow Bias"
            Float: 1527.37085
          }
          Overrides {
            Name: "bp:Dynamic Shadow Distance"
            Float: 5.23563147
          }
          Overrides {
            Name: "bp:Cascade Distribution Adjustment"
            Float: 1.03880453
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
            Id: 7786429434059921876
          }
        }
      }
      Objects {
        Id: 5692760258695124192
        Name: "Fog Adjustment Volume"
        Transform {
          Location {
            X: 10.7140017
            Y: 59.5234795
            Z: 440.065277
          }
          Rotation {
            Yaw: -9.22323608
          }
          Scale {
            X: 101.006447
            Y: 91.3452072
            Z: 89.4480896
          }
        }
        ParentId: 6996312495465530585
        UnregisteredParameters {
          Overrides {
            Name: "bp:Fog Object"
            ObjectReference {
              SubObjectId: 755156618111400479
            }
          }
          Overrides {
            Name: "bp:Fog Density"
            Float: 2.00091982
          }
          Overrides {
            Name: "bp:Falloff"
            Float: 1.07312524
          }
          Overrides {
            Name: "bp:Start"
            Float: 556.084778
          }
          Overrides {
            Name: "bp:Opacity"
            Float: 0.15423882
          }
          Overrides {
            Name: "bp:Layered Fog Density"
            Float: 2.13847947
          }
          Overrides {
            Name: "bp:Blend Duration"
            Float: 0.436940908
          }
          Overrides {
            Name: "bp:color"
            Color {
              R: 0.828000069
              G: 0.159803987
              B: 0.237759948
              A: 1
            }
          }
          Overrides {
            Name: "bp:Enabled"
            Bool: true
          }
          Overrides {
            Name: "bp:Albedo"
            Color {
              R: 1
              G: 0.820596039
              B: 0.37
              A: 1
            }
          }
          Overrides {
            Name: "bp:Light Absorption Amount"
            Float: 1.08222854
          }
          Overrides {
            Name: "bp:Beam View Direction"
            Float: 0.05
          }
          Overrides {
            Name: "bp:Volume Color"
            Color {
              R: 0.919999957
              G: 4.38690165e-07
              A: 1
            }
          }
          Overrides {
            Name: "bp:Color"
            Color {
              R: 1
              G: 0.799808
              B: 0.511000037
              A: 1
            }
          }
          Overrides {
            Name: "bp:Directional Inscattering Exponent"
            Float: 18.9543381
          }
          Overrides {
            Name: "bp:Directional Inscattering Color"
            Color {
              G: 0.130529732
              B: 0.269999981
              A: 1
            }
          }
          Overrides {
            Name: "bp:Layered Fog Falloff"
            Float: 26.7796249
          }
          Overrides {
            Name: "bp:Layered Fog Offset Height"
            Float: -11.5233994
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
            Id: 8497683954571070335
          }
        }
      }
      Objects {
        Id: 10384691911849326666
        Name: "atmosphere box"
        Transform {
          Location {
            X: 78.7607727
            Y: 33.3621902
            Z: -2438.3
          }
          Rotation {
            Yaw: -8.92843628
          }
          Scale {
            X: 103.800438
            Y: 97.3905869
            Z: 62.6838036
          }
        }
        ParentId: 6996312495465530585
        UnregisteredParameters {
          Overrides {
            Name: "ma:Shared_BaseMaterial:id"
            AssetReference {
              Id: 13865444176083240483
            }
          }
          Overrides {
            Name: "ma:Shared_BaseMaterial:color"
            Color {
              R: 0.154000014
              G: 0.154000014
              B: 0.154000014
              A: 0.107000008
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:forceoff"
        }
        CoreMesh {
          MeshAsset {
            Id: 5694757505926352082
          }
          Teams {
            IsTeamCollisionEnabled: true
            IsEnemyCollisionEnabled: true
          }
          DisableCastShadows: true
          StaticMesh {
            Physics {
              Mass: 100
              LinearDamping: 0.01
            }
            BoundsScale: 1
          }
        }
      }
    }
    Assets {
      Id: 7887238662729938253
      Name: "Sky Dome"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "CORESKY_Sky"
      }
    }
    Assets {
      Id: 2422797529040544929
      Name: "Star Dome"
      PlatformAssetType: 19
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "CORESKY_StarDome"
      }
    }
    Assets {
      Id: 11515840070784317904
      Name: "Skylight"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "CORESKY_Skylight"
      }
    }
    Assets {
      Id: 16910278292812118833
      Name: "Sun Light"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "CORESKY_SunLight"
      }
    }
    Assets {
      Id: 5773220180086757772
      Name: "Environment Fog Default VFX"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "fxbp_env_fog_default"
      }
    }
    Assets {
      Id: 7936187315447154565
      Name: "Advanced Color Grading Post Process"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "fxbp_post_process_advanced_color_grading"
      }
    }
    Assets {
      Id: 10151547298258526858
      Name: "Bloom Post Process"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "fxbp_post_process_bloom"
      }
    }
    Assets {
      Id: 7882895811213908562
      Name: "Sphere"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_sphere_002"
      }
    }
    Assets {
      Id: 9748238970305884976
      Name: "Asphalt 01"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "mi_gen_asphault_001"
      }
    }
    Assets {
      Id: 9648877314680910022
      Name: "Sky Dome Adjustment Volume"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "fxbp_skydome_adjstment"
      }
    }
    Assets {
      Id: 1903351858187431298
      Name: "Skylight Adjustment Volume"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "fxbp_skylight_adjustment"
      }
    }
    Assets {
      Id: 7786429434059921876
      Name: "Sun Adjustment Volume"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "fxbp_sun_adjustment"
      }
    }
    Assets {
      Id: 8497683954571070335
      Name: "Fog Adjustment Volume"
      PlatformAssetType: 6
      PrimaryAsset {
        AssetType: "BlueprintAssetRef"
        AssetId: "fxbp_fog_adjustment"
      }
    }
    Assets {
      Id: 5694757505926352082
      Name: "Container - Square Thin 01"
      PlatformAssetType: 1
      PrimaryAsset {
        AssetType: "StaticMeshAssetRef"
        AssetId: "sm_container_square_thin_ref"
      }
    }
    Assets {
      Id: 13865444176083240483
      Name: "Edgeline Wavy Object Fade Advanced"
      PlatformAssetType: 2
      PrimaryAsset {
        AssetType: "MaterialAssetRef"
        AssetId: "fxma_add_edgeline_local"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  Marketplace {
    Description: "Move from one skybox into the other with this CC!\r\n\r\nAlways wanted to make a dark atmosphere for your dungeon and have the outside of the dungeon be sunny and bright?\r\nLook no further! :D\r\n\r\nYou can make as many as you want and adjust them as such.\r\nMake sure they are connected to your Base Skybox else it wont work!\r\n\r\nIf you have any questions feel free to contact me on discord!\r\nStaypunny#4062"
  }
  SerializationVersion: 87
  DirectlyPublished: true
}
