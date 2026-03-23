import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: digitDisplay
    width: 320
    height: 148
    color: "#00000000"
    border.color: "#00000000"
    property real number: 0
    state: "base state"

    Row {
        id: digits
        spacing: 7
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: _2
            width: 98
            visible: false
            source: "../images/number/0.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: _1
            width: 98
            visible: false
            source: "../images/number/0.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: _0
            width: 98
            source: "../images/number/0.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: _p
            visible: false
            anchors.bottom: parent.bottom
            source: "../images/number/point.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: _p1
            width: 98
            visible: false
            source: "../images/number/0.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Connections {
        target: digitDisplay
        onNumberChanged: {
            var str = number.toString()
            if (str.indexOf(".") == -1) {
                if (str.length == 3) {
                    _2.source = "../images/number/" + str[0] + ".png"
                    _1.source = "../images/number/" + str[1] + ".png"
                    _0.source = "../images/number/" + str[2] + ".png"
                    digitDisplay.state = "three_digits"
                } else if (str.length == 2) {
                    _1.source = "../images/number/" + str[0] + ".png"
                    _0.source = "../images/number/" + str[1] + ".png"
                    digitDisplay.state = "double_digits"
                } else if (str.length == 1) {
                    _0.source = "../images/number/" + str[0] + ".png"
                    digitDisplay.state = "base state"
                }
            } else {
                _0.source = "../images/number/" + str[0] + ".png"
                _p1.source = "../images/number/" + str[2] + ".png"
                digitDisplay.state = "point_digits"
            }
        }
    }

    states: [
        State {
            name: "double_digits"

            PropertyChanges {
                target: _1
                visible: true
            }

            PropertyChanges {
                target: _p1
                x: 115
                y: 0
            }
        },
        State {
            name: "three_digits"

            PropertyChanges {
                target: _1
                visible: true
            }

            PropertyChanges {
                target: _2
                visible: true
            }

            PropertyChanges {
                target: digitDisplay
                width: 320
            }
        },
        State {
            name: "point_digits"

            PropertyChanges {
                target: _1
                x: 44
                y: 0
                width: 44
                height: 75
                visible: false
            }

            PropertyChanges {
                target: _2
                x: 65
                y: 0
                visible: false
            }

            PropertyChanges {
                target: _p
                visible: true
            }

            PropertyChanges {
                target: _p1
                visible: true
                source: "../images/number/0.png"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;height:148;width:320}
}
##^##*/

