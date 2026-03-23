import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Timeline 1.0

Item {
    id: root
    width: 540
    height: 88
    layer.enabled: true

    Image {
        id: pop_bg
        x: 0
        y: 0
        source: "../images/warning/pop_bg.png"
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: item1
        x: 540
        y: 0
        width: 540
        height: 88

        Image {
            id: warning_icon
            x: 35
            y: 16
            width: 56
            height: 56
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: warningdatamodel.warning_icon
            asynchronous: true
            anchors.leftMargin: 35
            fillMode: Image.PreserveAspectFit
        }

        Item {
            id: text_range
            x: 91
            y: 0
            anchors.left: warning_icon.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Text {
                id: warning_message
                color: "#ee2121"
                text: warningdatamodel.warning_message
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 32
                anchors.horizontalCenterOffset: -10
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Source Han Sans CN Normal"
            }
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                running: false
                loops: -1
                duration: 5900
                to: 5000
                from: 0
            }
        ]
        endFrame: 5000
        enabled: false
        startFrame: 0

        KeyframeGroup {
            target: item1
            property: "x"
            Keyframe {
                value: 540
                frame: 0
            }

            Keyframe {
                value: 0
                frame: 1497
            }

            Keyframe {
                value: 0
                frame: 3499
            }

            Keyframe {
                value: -540
                frame: 5003
            }
        }
    }

    states: [
        State {
            name: "running"
            when: warningdatamodel.warning_visibility
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
                target: item1
                x: 540
                y: 0
                opacity: 1
                clip: false
                anchors.leftMargin: 540
                z: 0
            }

            PropertyChanges {
                target: root
                width: 540
            }
        },
        State {
            name: "stopping"
            when: gaugedatamodel.gauge_SpecialEffects_Switch == 0

            PropertyChanges {
                target: item1
                x: 0
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:88;width:540}
}
##^##*/

