import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    width: 208
    height: 18
    color: "#00000000"
    border.color: "#00000000"
    property int volume: 0

    Image {
        id: water_oil_bg
        anchors.top: parent.top
        source: "../images/water_oil_bg.png"
        asynchronous: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 0
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: water_oil_progress
        x: 4
        y: 0
        width: root.volume * 2
        source: "../images/water_oil_progress.png"
        asynchronous: true
        z: 5
        fillMode: Image.PreserveAspectCrop
    }

    Image {
        id: oil_scale
        x: 0
        y: 0
        anchors.bottom: parent.bottom
        source: "../images/scale.png"
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }
}

/*##^##
Designer {
    D{i:0;height:18;width:208}
}
##^##*/

