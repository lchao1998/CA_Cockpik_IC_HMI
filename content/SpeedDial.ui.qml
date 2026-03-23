import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D
import Quick3DAssets.SpeedMeter 1.0
import QtQuick.Timeline 1.0

Rectangle {
    id: root
    width: 546
    height: 546
    color: "#00000000"
    border.color: "#00000000"

    View3D {
        id: view3D
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            aoStrength: 0
            depthTestEnabled: true
            backgroundMode: SceneEnvironment.Transparent
            clearColor: "#585858"
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: scene
            DirectionalLight {
                id: directionalLight
                color: "#ffffff"
                ambientColor: "#f0f0f0"
            }

            PerspectiveCamera {
                id: camera
                z: 15
            }

            SpeedMeter {
                id: speedMeter
                eulerRotation.x: 0
                speedValue: gaugedatamodel.gauge_ESP_VehicleSpeed
            }
        }
    }

    Image {
        id: left_line
        x: 0
        y: 0
        visible: true
        source: "../images/left_line.png"
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: __materialLibrary__
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                running: false
                loops: -1
                duration: 200
                to: 200
                from: 0
            }
        ]
        enabled: false
        endFrame: 200
        startFrame: 0

        KeyframeGroup {
            target: speedMeter
            property: "eulerRotation.y"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 100
                value: 1.5
            }

            Keyframe {
                frame: 200
                value: 0
            }
        }
    }
    states: [
        State {
            name: "shake"
            when: speedMeter.speedValue >= 100
                  && gaugedatamodel.gauge_SpecialEffects_Switch == 1

            PropertyChanges {
                target: timeline
                enabled: true
            }

            PropertyChanges {
                target: timelineAnimation
                running: true
            }

            PropertyChanges {
                target: speedMeter
                eulerRotation.z: 0
                eulerRotation.y: 0
                eulerRotation.x: 0
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:546;width:546}D{i:6}
}
##^##*/

