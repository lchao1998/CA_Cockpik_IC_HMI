import QtQuick
import QtQuick3D
import Quick3DAssets.SpeedMeter 1.0
Node {
    id: rootNode
    property real speedValue: 0
    Node {
        id: speedMeter
        x: 1.10847
        y: 1.95
        eulerRotation.z: 30.87
        eulerRotation.y: 22.73
        eulerRotation.x: -21.82
        z: 0.7
        scale.y: 1

        Model {
            id: speedMeter_Bar_Bg
            x: 0
            y: 0
            source: "meshes/speedMeter_Bar.mesh"
            z: 0
            eulerRotation.z: -40
            materials: [
                material__27_material
            ]
        }

        Model {
            id: speedMeter_Bg
            x: 0
            y: 0
            source: "meshes/speedMeter_Bg.mesh"
            z: 0
            materials: material__26sf_material
        }


        Model {
            id: speedMeter_Bar_Fg
            source: "meshes/speedMeter_Bar.mesh"
            eulerRotation.z: -40
            materials: [
                material__27_material1
            ]
        }

        Model {
            id: speedMeter_Bg1
            x: -1.716
            y: 0
            opacity: 1
            visible: rootNode.speedValue != 0 && gaugedatamodel.gauge_SpecialEffects_Switch == 1
            source: "meshes/speedMeter_Bg.mesh"
            materials: newMaterial
            receivesShadows: true
            castsShadows: true
            eulerRotation.z: -91.75901
            eulerRotation.y: 0
            eulerRotation.x: -0.00001
            z: 0.45
        }


    }

    Node {
        id: __materialLibrary__
        DefaultMaterial {
            id: material__27_material
            blendMode: DefaultMaterial.SourceOver
            Texture {
                id: progress_Bg
                source: "../../../images/progress_Bg.png"
            }
            diffuseColor: "#ffffff"
            diffuseMap: progress_Bg
            objectName: "material__27_material"
        }

        DefaultMaterial {
            id: material__26sf_material
            opacity: 1
            blendMode: DefaultMaterial.SourceOver
            Texture {
                id: speed_Bg
                source: "../../../images/Speed_Bg.png"
            }
            diffuseColor: "#ffffff"
            diffuseMap: speed_Bg
            objectName: "material__26sf_material"
        }

        DefaultMaterial {
            id: material__27_material1
            diffuseMap: progress_Fg
            Texture {
                id: progress_Fg
                source: "../../../images/progress_Fg.png"
                tilingModeVertical: Texture.ClampToEdge
                Behavior on positionV {
                    SmoothedAnimation{velocity: 1.6}
                }
                positionV: 0.8 - (rootNode.speedValue / 180) * 0.6
            }
            diffuseColor: "#ffffff"
            objectName: "material__27_material1"
        }

        CustomMaterial {
            id: newMaterial
            property real kzTime: 10
            NumberAnimation on kzTime { from: 0; to: 100; duration: 20000; loops: -1 }
            property real grow2: -2.5+rootNode.speedValue/180*2.2
            property real textureOffsetU: texture1.positionU
            property real textureOffsetV: texture1.positionV

            destinationBlend: CustomMaterial.One
            sourceBlend: CustomMaterial.One
            vertexShader: "../../../shader/glow2.vert.glsl"
            fragmentShader: "../../../shader/glow2.frag.glsl"
            shadingMode: CustomMaterial.Unshaded
            objectName: "New Material"

            Texture {
                id: texture1
                scaleU: 1
                scaleV: 1
                positionV: 0
                positionU: 0.1
            }
        }
    }
}
