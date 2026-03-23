import QtQuick
import QtQuick3D
import QtQuick.Timeline 1.0
import Quick3DAssets.Lane 1.0
Node {
    id: rootNode
    property bool running: false
    property int lanespeed: 0
    Node {
        id: lane
        eulerRotation.z: 0
        eulerRotation.y: 0
        eulerRotation.x: 0
        Model {
            id: lane_1
            x: 0
            y: 0
            source: "meshes/lane.mesh"
            materials: material__442_material
            pivot.z: 0
            pivot.y: 0
            pivot.x: 0
            z: 0
            eulerRotation.z: 0
            eulerRotation.y: 0
            eulerRotation.x: 0
        }
        Model {
            id: lane_Outside
            x: 2.67457e-05
            y: 0
            source: "meshes/lane_Outside.mesh"
            eulerRotation.z: 0
            eulerRotation.y: 0
            eulerRotation.x: 0
            materials: material__442_material
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
                duration: 2000
                to: 1000
                from: 0
            },
            TimelineAnimation {
                id: moveAnimation1
                target: move
                running: rootNode.lanespeed >= 100
                loops: -1
                duration: 1000
                to: 1000
                from: 0
            }
        ]
        endFrame: 1000
        startFrame: 0

        KeyframeGroup {
            target: lane1
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
            id: material__442_material
            property alias map: material__442_material.diffuseMap
            opacity: 1
            diffuseMap: lane1
            opacityMap: lane_inside_mask
            Texture {
                id: lane1
                source: "../../../images/Lane.png"
                positionU: 0
                positionV: 0
            }

            Texture {
                id: lane_inside_mask
                source: "../../../images/Lane_inside_mask.png"
            }
            lighting: DefaultMaterial.NoLighting
            diffuseColor: "#ffffff"
            objectName: "material__442_material"
        }
    }
}
