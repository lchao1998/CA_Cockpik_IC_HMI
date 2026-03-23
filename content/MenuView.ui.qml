import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 490
    height: 331
    visible: false
    state: statusdatamodel.status_tripcomputer_menu

    Item {
        id: menu
        width: 490
        height: 298
        anchors.top: parent.top

        Image {
            id: menu_bg
            anchors.fill: parent
            source: "../images/menu/menu_bg.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: icon
            x: 95
            y: 72
            anchors.left: parent.left
            anchors.top: parent.top
            source: "../images/menu/icon_trip.png"
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

    Row {
        id: navigation
        width: 68
        height: 12
        anchors.top: menu.bottom
        spacing: 16
        anchors.topMargin: 21
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: point_1
            x: 0
            y: 0
            source: "../images/menu/porint_sel.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: point_2
            x: 0
            y: 0
            source: "../images/menu/point_normal.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: point_3
            x: 0
            y: 0
            source: "../images/menu/point_normal.png"
            fillMode: Image.PreserveAspectFit
        }
    }
    states: [
        State {
            name: "Trip"

            PropertyChanges {
                target: root
                visible: true
            }

            PropertyChanges {
                target: icon
                source: "../images/menu/icon_shisu.png"
            }

            PropertyChanges {
                target: lab
                text: "平均车速"
            }

            PropertyChanges {
                target: point_1
                source: "../images/menu/porint_sel.png"
            }

            PropertyChanges {
                target: point_2
                source: "../images/menu/point_normal.png"
            }

            PropertyChanges {
                target: value
                text: tripcomputerdatamodel.tripcomputer_trip_Average_Speed
            }
        },
        State {
            name: "Speed"

            PropertyChanges {
                target: root
                visible: true
            }

            PropertyChanges {
                target: icon
                source: "../images/menu/icon_time.png"
            }

            PropertyChanges {
                target: lab
                text: "行驶时间"
            }

            PropertyChanges {
                target: point_1
                source: "../images/menu/point_normal.png"
            }

            PropertyChanges {
                target: point_3
                source: "../images/menu/point_normal.png"
            }

            PropertyChanges {
                target: value
                text: tripcomputerdatamodel.tripcomputer_Vehicle_Running_time
            }

            PropertyChanges {
                target: point_2
                source: "../images/menu/porint_sel.png"
            }
        },
        State {
            name: "Time"

            PropertyChanges {
                target: root
                visible: true
            }

            PropertyChanges {
                target: value
                text: tripcomputerdatamodel.tripcomputer_trip
            }

            PropertyChanges {
                target: point_3
                source: "../images/menu/porint_sel.png"
            }

            PropertyChanges {
                target: point_1
                source: "../images/menu/point_normal.png"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:331;width:490}
}
##^##*/

