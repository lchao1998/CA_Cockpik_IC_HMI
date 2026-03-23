import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D
import Quick3DAssets.Lane 1.0
import Quick3DAssets.Car 1.0
import QtQuick.Timeline 1.0

Item {
    id: item1
    width: 1920
    height: 720
    visible: false
    state: statusdatamodel.status_adas_status

    View3D {
        id: view3D
        anchors.fill: parent
        SceneEnvironment {
            id: sceneEnvironment
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: scene

            PerspectiveCamera {
                id: camera
                z: 39
            }

            Lane {
                id: lane
                x: 0
                y: -12
                eulerRotation.z: 180
                eulerRotation.x: -70
                z: -58
            }

            Car {
                id: car
                x: 0
                y: -10
                eulerRotation.z: 0
                eulerRotation.y: 180
                eulerRotation.x: -20
                z: -37
            }
        }
        environment: sceneEnvironment
    }

    Timeline {
        id: timeline_right
        animations: [
            TimelineAnimation {
                id: toright
                loops: -1
                duration: 5000
                running: false
                to: 1000
                from: 0
            }
        ]
        enabled: false
        startFrame: 0
        endFrame: 1000

        KeyframeGroup {
            target: car
            property: "x"
            Keyframe {
                value: 25
                frame: 1000
            }
        }

        KeyframeGroup {
            target: radar
            property: "x"
            Keyframe {
                frame: 1000
                value: 840
            }
        }
    }

    Image {
        id: obstacle
        x: adasdatamodel.adas_obstacle_x
        y: adasdatamodel.adas_obstacle_y
        visible: adasdatamodel.adas_obstacle_on
        source: adasdatamodel.adas_obstacle_image
        cache: false
        z: 2
        fillMode: Image.PreserveAspectFit
    }

    Timeline {
        id: timeline_left
        animations: [
            TimelineAnimation {
                id: toleft
                loops: -1
                duration: 5000
                running: false
                to: 1000
                from: 0
            }
        ]
        enabled: false
        startFrame: 0
        endFrame: 1000

        KeyframeGroup {
            target: car
            property: "x"
            Keyframe {
                value: -25
                frame: 1000
            }
        }

        KeyframeGroup {
            target: radar
            property: "x"
            Keyframe {
                frame: 1000
                value: 520
            }
        }
    }

    Image {
        id: radar
        x: 680
        y: 205
        visible: adasdatamodel.adas_obstacle_on
        source: "../images/adas/1.png"
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
                target: lane
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
                target: lane
                running: true
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
                target: lane
                running: true
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:720;width:1920}D{i:6}
}
##^##*/

