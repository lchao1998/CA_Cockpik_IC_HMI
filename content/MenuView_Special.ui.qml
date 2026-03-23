import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Timeline 1.0

Item {
    id: root
    width: 490
    height: 331
    visible: true
    state: statusdatamodel.status_tripcomputer_menu

    Item {
        id: trip
        width: 490
        height: 298
        visible: root.status == "Trip"
        z: 0

        Image {
            id: menu_bg
            anchors.fill: parent
            source: "../images/menu/menu_bg.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: icon
            x: 95
            y: 72
            anchors.left: parent.left
            anchors.top: parent.top
            source: "../images/menu/icon_trip.png"
            asynchronous: true
            anchors.topMargin: 72
            anchors.leftMargin: 95
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: lab
            x: 249
            y: 78
            width: 125
            height: 30
            color: "#ffffff"
            text: "行驶里程"
            anchors.left: icon.right
            anchors.top: parent.top
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Source Han Sans CN Normal"
            anchors.topMargin: 78
            anchors.leftMargin: 33
        }

        Text {
            id: value
            x: 249
            y: 140
            width: 151
            height: 46
            color: "#ffffff"
            text: "300"
            anchors.left: icon.right
            anchors.top: lab.bottom
            font.pixelSize: 60
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 32
            anchors.leftMargin: 33
            font.family: "Source Han Sans CN Normal"
        }
    }

    Item {
        id: speed
        width: 490
        height: 298
        visible: root.status == "Speed"
        z: 0
        Image {
            id: menu_bg1
            anchors.fill: parent
            source: "../images/menu/menu_bg.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: icon1
            x: 95
            y: 72
            anchors.left: parent.left
            anchors.top: parent.top
            source: "../images/menu/icon_shisu.png"
            asynchronous: true
            anchors.leftMargin: 95
            fillMode: Image.PreserveAspectFit
            anchors.topMargin: 72
        }

        Text {
            id: lab1
            x: 249
            y: 78
            width: 125
            height: 30
            color: "#ffffff"
            text: "平均速度"
            anchors.left: icon1.right
            anchors.top: parent.top
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 33
            font.family: "Source Han Sans CN Normal"
            anchors.topMargin: 78
        }

        Text {
            id: value1
            x: 249
            y: 140
            width: 151
            height: 46
            color: "#ffffff"
            text: "80"
            anchors.left: icon1.right
            anchors.top: lab1.bottom
            font.pixelSize: 60
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 33
            font.family: "Source Han Sans CN Normal"
            anchors.topMargin: 32
        }
    }

    Item {
        id: time
        width: 490
        height: 298
        visible: root.status == "Time"
        Image {
            id: menu_bg2
            anchors.fill: parent
            source: "../images/menu/menu_bg.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: icon2
            x: 95
            y: 72
            anchors.left: parent.left
            anchors.top: parent.top
            source: "../images/menu/icon_time.png"
            asynchronous: true
            anchors.leftMargin: 95
            fillMode: Image.PreserveAspectFit
            anchors.topMargin: 72
        }

        Text {
            id: lab2
            x: 249
            y: 78
            width: 125
            height: 30
            color: "#ffffff"
            text: "行驶时间"
            anchors.left: icon2.right
            anchors.top: parent.top
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 33
            font.family: "Source Han Sans CN Normal"
            anchors.topMargin: 78
        }

        Text {
            id: value2
            x: 249
            y: 140
            width: 151
            height: 46
            color: "#ffffff"
            text: "50:23"
            anchors.left: icon2.right
            anchors.top: lab2.bottom
            font.pixelSize: 60
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 33
            font.family: "Source Han Sans CN Normal"
            anchors.topMargin: 32
        }
    }
    Row {
        id: navigation
        width: 68
        height: 12
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 16
        anchors.topMargin: 319

        Image {
            id: point_1
            x: 0
            y: 0
            source: "../images/menu/porint_sel.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: point_2
            x: 0
            y: 0
            source: "../images/menu/point_normal.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: point_3
            x: 0
            y: 0
            source: "../images/menu/point_normal.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                duration: 1000
                running: false
                loops: 1
                to: 1000
                from: 0
            }
        ]
        enabled: false
        startFrame: 0
        endFrame: 500
    }

    Timeline {
        id: timeline1
        animations: [
            TimelineAnimation {
                id: timelineAnimation1
                loops: 1
                duration: 500
                to: 500
                from: 0
            }
        ]
        endFrame: 500
        startFrame: 0

        KeyframeGroup {
            target: trip
            property: "x"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 500
                value: -40
            }
        }

        KeyframeGroup {
            target: trip
            property: "y"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 500
                value: -37
            }
        }

        KeyframeGroup {
            target: speed
            property: "x"
            Keyframe {
                frame: 0
                value: -40
            }

            Keyframe {
                frame: 500
                value: 0
            }
        }

        KeyframeGroup {
            target: speed
            property: "y"
            Keyframe {
                frame: 0
                value: -37
            }

            Keyframe {
                frame: 500
                value: 0
            }
        }

        KeyframeGroup {
            target: trip
            property: "visible"

            Keyframe {
                frame: 250
                value: false
            }
        }
    }

    Timeline {
        id: timeline2
        animations: [
            TimelineAnimation {
                id: timelineAnimation2
                paused: false
                loops: 1
                duration: 500
                to: 500
                from: 0
            }
        ]
        endFrame: 500
        startFrame: 0

        KeyframeGroup {
            target: speed
            property: "x"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 500
                value: -40
            }
        }

        KeyframeGroup {
            target: speed
            property: "y"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                frame: 500
                value: -37
            }
        }

        KeyframeGroup {
            target: speed
            property: "visible"

            Keyframe {
                frame: 250
                value: false
            }
        }

        KeyframeGroup {
            target: time
            property: "x"
            Keyframe {
                frame: 0
                value: -40
            }

            Keyframe {
                frame: 500
                value: 0
            }
        }

        KeyframeGroup {
            target: time
            property: "y"
            Keyframe {
                frame: 0
                value: -37
            }

            Keyframe {
                frame: 500
                value: 0
            }
        }
    }

    states: [
        State {
            name: "Trip"

            PropertyChanges {
                target: timeline
                enabled: true
            }

            PropertyChanges {
                target: timelineAnimation
                running: true
            }

            PropertyChanges {
                target: time
                visible: false
            }

            PropertyChanges {
                target: speed
                visible: false
            }

            PropertyChanges {
                target: trip
                visible: true
            }
        },
        State {
            name: "Speed"

            PropertyChanges {
                target: timeline
                enabled: false
            }

            PropertyChanges {
                target: timelineAnimation
                running: true
            }

            PropertyChanges {
                target: timeline1
                enabled: true
            }

            PropertyChanges {
                target: trip
                visible: true
            }

            PropertyChanges {
                target: speed
                visible: true
            }

            PropertyChanges {
                target: time
                visible: false
            }

            PropertyChanges {
                target: timelineAnimation2
                running: true
            }

            PropertyChanges {
                target: timelineAnimation1
                running: true
            }

            PropertyChanges {
                target: point_2
                source: "../images/menu/porint_sel.png"
            }

            PropertyChanges {
                target: point_1
                source: "../images/menu/point_normal.png"
            }
        },
        State {
            name: "Time"

            PropertyChanges {
                target: timeline
            }

            PropertyChanges {
                target: timelineAnimation
                running: true
            }

            PropertyChanges {
                target: timeline2
                enabled: true
            }

            PropertyChanges {
                target: timelineAnimation2
                running: true
            }

            PropertyChanges {
                target: speed
                visible: true
            }

            PropertyChanges {
                target: time
                visible: true
            }

            PropertyChanges {
                target: point_1
                source: "../images/menu/point_normal.png"
            }

            PropertyChanges {
                target: point_3
                source: "../images/menu/porint_sel.png"
            }
        },
        State {
            name: "default"

            PropertyChanges {
                target: navigation
                visible: false
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:331;width:490}
}
##^##*/

