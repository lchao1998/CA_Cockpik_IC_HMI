import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D
import Quick3DAssets.Lane 1.0
import Quick3DAssets.Car 1.0
import QtQuick.Timeline 1.0
import Quick3DAssets.Effect 1.0
import Quick3DAssets.Lane1 1.0
import Quick3DAssets.Bar 1.0
import Quick3DAssets.Car1 1.0

Item {
    id: item1
    width: 1920
    height: 720
    visible: false
    state: statusdatamodel.status_adas_status
    property alias view3D: view3D

    View3D {
        id: view3D
        anchors.fill: parent
        SceneEnvironment {
            id: sceneEnvironment
            clearColor: "#000000"
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: scene

            PerspectiveCamera {
                id: camera
                z: 39
            }

            Lane1 {
                id: lane1
                x: 0
                y: -84.031
                visible: true
                z: 141.5587
                eulerRotation.z: -20
                eulerRotation.y: -89.99999
                eulerRotation.x: 0.00001
                lanespeed: gaugedatamodel.gauge_ESP_VehicleSpeed
                scale.z: 1.22634
                scale.y: 1
                scale.x: 1
            }

            Car1 {
                id: car1
                x: -0
                y: -20.553
                visible: true
                pivot.x: 0
                scale.z: 3
                scale.y: 3
                scale.x: 3
                z: -35.73307
                eulerRotation.z: 20
                eulerRotation.y: 90

                Effect {
                    id: effect
                    x: -0
                    y: 2.74
                    visible: gaugedatamodel.gauge_ESP_VehicleSpeed >= 100
                    eulerRotation.z: 0.4338
                    eulerRotation.y: -90
                    scale.z: 0.2
                    scale.y: 0.1
                    scale.x: 0.2
                    z: 0.02412
                    eulerRotation.x: -0.76721
                }
            }
        }
        environment: sceneEnvironment
    }

    Timeline {
        id: timeline_right
        animations: [
            TimelineAnimation {
                id: toright
                loops: 1
                duration: 5050
                running: false
                to: 5050
                from: 0
            }
        ]
        enabled: false
        startFrame: 0
        endFrame: 5050

        KeyframeGroup {
            target: radar
            property: "x"
            Keyframe {
                frame: 4999
                value: 840
            }
        }

        KeyframeGroup {
            target: lane1
            property: "curve"
            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: 1
                frame: 2500
            }

            Keyframe {
                value: 1
                frame: 3000
            }

            Keyframe {
                value: 0
                frame: 5048
            }
        }

        KeyframeGroup {
            target: car1
            property: "x"
            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: 27
                frame: 5000
            }
        }
    }

    Image {
        id: obstacle
        x: adasdatamodel.adas_obstacle_x
        y: adasdatamodel.adas_obstacle_y
        visible: adasdatamodel.adas_obstacle_on
        source: adasdatamodel.adas_obstacle_image
        asynchronous: true
        cache: true
        z: 2
        fillMode: Image.PreserveAspectFit
    }

    Timeline {
        id: timeline_left
        animations: [
            TimelineAnimation {
                id: toleft
                loops: 1
                duration: 5050
                running: false
                to: 5050
                from: 0
            }
        ]
        enabled: false
        startFrame: 0
        endFrame: 5050

        KeyframeGroup {
            target: radar
            property: "x"
            Keyframe {
                frame: 5000
                value: 520
            }
        }

        KeyframeGroup {
            target: lane1
            property: "curve"
            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: -1
                frame: 2500
            }

            Keyframe {
                value: -1
                frame: 3000
            }

            Keyframe {
                value: 0
                frame: 5048
            }
        }

        KeyframeGroup {
            target: car1
            property: "x"
            Keyframe {
                value: 0
                frame: 0
            }

            Keyframe {
                value: -27
                frame: 5000
            }
        }
    }

    Image {
        id: radar
        x: 680
        y: 247
        visible: true
        source: "../images/adas/1.png"
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: __materialLibrary__
    }

    states: [
        State {
            name: "static"

            PropertyChanges {
                target: item1
                visible: true
            }
        },
        State {
            name: "forward"
            PropertyChanges {
                target: item1
                visible: true
            }

            PropertyChanges {
                target: lane1
                running: true
            }
        },
        State {
            name: "toright"
            PropertyChanges {
                target: item1
                visible: true
            }

            PropertyChanges {
                target: timeline_right
                enabled: true
            }

            PropertyChanges {
                target: toright
                running: true
            }

            PropertyChanges {
                target: lane1
                curve: 0
                running: true
            }

            PropertyChanges {
                target: obstacle
                visible: false
            }

            PropertyChanges {
                target: radar
                visible: false
            }
        },
        State {
            name: "toleft"
            PropertyChanges {
                target: item1
                visible: true
            }

            PropertyChanges {
                target: timeline_left
                enabled: true
            }

            PropertyChanges {
                target: toleft
                running: true
            }

            PropertyChanges {
                target: lane1
                running: true
            }

            PropertyChanges {
                target: obstacle
                visible: false
            }

            PropertyChanges {
                target: radar
                visible: false
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5;height:720;width:1920}D{i:5}D{i:7}D{i:6}D{i:8}
}
##^##*/

