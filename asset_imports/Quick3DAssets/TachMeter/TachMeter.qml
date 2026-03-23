import QtQuick
import QtQuick3D
import Quick3DAssets.TachMeter 1.0
Node {
    id: rootNode
    property real tachoValue: 0
    Node {
        id: tachSpeedMeter
        x: -1.1427
        y: 1.87371
        z: 0.6288
        rotation: Qt.quaternion(0.936355, -0.133453, -0.243229, -0.215103)
        scale.z: 1
        Model {
            id: tachSpeedMeter_Bar_Bg
            source: "meshes/tachSpeedMeter_Bar.mesh"
            eulerRotation.z: 40
            materials: [
                material__27_material
            ]
        }
        Model {
            id: tachSpeedMeter_Bg
            source: "meshes/tachSpeedMeter_Bg.mesh"
            materials: [
                material__26_material
            ]
        }

        Model {
            id: tachSpeedMeter_Bar_Fg
            source: "meshes/tachSpeedMeter_Bar.mesh"
            eulerRotation.z: 40
            materials: [
                material__27_material1
            ]
        }

        Model {
            id: tachSpeedMeter_Bg1
            x: 1.721
            y: -0.031
            visible: rootNode.tachoValue!=0 && gaugedatamodel.gauge_SpecialEffects_Switch == 1
            source: "meshes/tachSpeedMeter_Bg.mesh"
            z: 0.45
            eulerRotation.z: 91.0474
            eulerRotation.y: -0
            eulerRotation.x: -0
            materials: newMaterial
        }
    }

    Node {
        id: __materialLibrary__
        DefaultMaterial {
            id: material__27_material
            Texture {
                id: progress_Bg
                source: "../../../images/progress_Bg.png"
            }
            objectName: "material__27_material"
            diffuseColor: "#ffffff"
            diffuseMap: progress_Bg
        }

        DefaultMaterial {
            id: material__26_material
            Texture {
                id: tachSpeed_Bg
                source: "../../../images/TachSpeed_Bg.png"
            }
            objectName: "material__26_material"
            diffuseColor: "#ffffff"
            diffuseMap: tachSpeed_Bg
        }

        DefaultMaterial {
            id: material__27_material1
            Texture {
                id: progress_Fg
                source: "../../../images/progress_Fg.png"
                tilingModeVertical: Texture.ClampToEdge
                Behavior on positionV {
                    SmoothedAnimation{velocity: 1.6}
                }
                positionV: 0.8 - (rootNode.tachoValue / 5.5) * 0.6
            }
            objectName: "material__27_material1"
            diffuseColor: "#ffffff"
            diffuseMap: progress_Fg
        }

        CustomMaterial {
            id: newMaterial
            Texture {
                id: texture1
                scaleU: 1
                positionU: 0.1
                positionV: 0
                scaleV: 1
            }
            sourceBlend: CustomMaterial.One
            vertexShader: "../../../shader/glow2.vert.glsl"
            fragmentShader: "../../../shader/glow2.frag.glsl"
            property real kzTime: 10
            NumberAnimation on kzTime { from: 0; to: 100; duration: 20000; loops: -1 }
            property real grow2: -2.5+rootNode.tachoValue/5.5*2.2
            property real textureOffsetU: texture1.positionU
            property real textureOffsetV: texture1.positionV

            destinationBlend: CustomMaterial.One
            shadingMode: CustomMaterial.Unshaded
            objectName: "New Material"
        }
    }
}
