import QtQuick
import QtQuick3D
import QtQuick.Timeline 1.0

Node {
    id: rootNode
    // Materials
    // end of Materials
    property bool running: false
    property int lanespeed: 0
    property alias curve: newMaterial.curvature

    Node {
        id: lane1_obj
        Model {
            id: lane1
            x: -0
            y: 0
            source: "meshes/lane1.mesh"
            z: -0.00004
            scale.z: 0.5
            scale.y: 0.5
            scale.x: 0.5
            eulerRotation.z: 0.00003
            eulerRotation.y: 0.00002
            eulerRotation.x: 0
            materials: newMaterial
        }
    }

    Timeline {
        id: move
        enabled: rootNode.running
        animations: [
            TimelineAnimation {
                id: moveAnimation
                target: move
                running: rootNode.lanespeed < 100
                loops: -1
                duration: 3000
                to: 1000
                from: 0
            },
            TimelineAnimation {
                id: moveAnimation1
                target: move
                running: rootNode.lanespeed >= 100
                loops: -1
                duration: 1500
                to: 1000
                from: 0
            }
        ]
        endFrame: 1000
        startFrame: 0

        KeyframeGroup {
            target: texture1
            property: "positionV"
            Keyframe {
                value: 1
                frame: 1000
            }
        }
    }

    Node {
        id: __materialLibrary__

        DefaultMaterial {
            id: default_material
            diffuseColor: "#999999"
            objectName: "default_material"
        }

        CustomMaterial {
            id: newMaterial
            property vector2d textureTiling: Qt.vector2d(2,2.25)
            property real blendIntensity: 1
            property TextureInput textureMask: textureInputMask
             property TextureInput texture1: textureInput1
            property real curvature: 0
            property real textureOffsetU: texture1.positionU
            property real textureOffsetV: texture1.positionV
            shadingMode: CustomMaterial.Unshaded
            destinationBlend: CustomMaterial.One
            sourceBlend: CustomMaterial.One
            fragmentShader: "../../../shader/lanecurve.frag.glsl"
            vertexShader: "../../../shader/lanecurve.vert.glsl"
            objectName: "New Material"

            TextureInput {
                id: textureInput1
                texture: texture1
            }

            TextureInput {
                id: textureInputMask
                texture: textureMask
            }

            Texture {
                id: texture1
                source: "../../../images/Lane.png"
                tilingModeVertical: Texture.MirroredRepeat
                tilingModeHorizontal: Texture.MirroredRepeat
            }

            Texture {
                id: textureMask
                source: "../../../images/Lane.png"
                tilingModeVertical: Texture.MirroredRepeat
                tilingModeHorizontal: Texture.MirroredRepeat
            }
        }
    }
}
