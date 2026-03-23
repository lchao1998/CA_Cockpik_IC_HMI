import QtQuick
import QtQuick.Controls
import QtQuick3D
import CA_Cockpik_IC_HMI
import QtQuick.Layouts 6.0

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#00000000"
    border.color: "#ffffff"

    transformOrigin: Item.Center

    Image {
        id: backgrand
        x: 0
        y: 0
        visible: true
        source: statusdatamodel.status_navi_status ? "../images/navi_backgrand.png" : "../images/backgrand.png"
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: leftDail
        y: 174
        width: 546
        height: 546
        color: "#002d9b71"
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        z: 0

        DigitDisplay {
            id: speedDisplay
            anchors.right: parent.right
            anchors.top: parent.top
            z: 1
            number: gaugedatamodel.gauge_ESP_VehicleSpeed
            anchors.rightMargin: 30
            anchors.topMargin: 70
        }

        Image {
            id: km_h
            anchors.top: speedDisplay.bottom
            source: "../images/km_h.png"
            asynchronous: true
            anchors.horizontalCenterOffset: 70
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        SpeedDial {
            id: speedDial
            x: 0
            y: 0
            width: 546
            color: "#00000000"
            border.color: "#00742525"
            layer.enabled: false
        }

        InvertEffect {
            id: speedInvert
            anchors.top: speedDisplay.bottom
            anchors.horizontalCenter: speedDisplay.horizontalCenter
            m_target: speedDisplay
        }
    }

    Rectangle {
        id: rightDail
        x: 1374
        y: 174
        width: 546
        height: 546
        color: "#00ffffff"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.rightMargin: 0

        DigitDisplay {
            id: tachoDisplay
            anchors.left: parent.left
            anchors.top: parent.top
            z: 1
            number: gaugedatamodel.gauge_EMS_EngineSpeed
            anchors.leftMargin: 30
            anchors.topMargin: 70
        }

        Image {
            id: rpm
            anchors.top: tachoDisplay.bottom
            source: "../images/rpm.png"
            asynchronous: true
            anchors.horizontalCenterOffset: -70
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        TachoDial {
            id: tachoDial
            anchors.fill: parent
        }

        InvertEffect {
            id: tachoInvert
            anchors.top: tachoDisplay.bottom
            anchors.horizontalCenter: tachoDisplay.horizontalCenter
            m_target: tachoDisplay
        }
    }

    Image {
        id: skyline
        x: 0
        y: 0
        visible: !statusdatamodel.status_navi_status
        source: "../images/skyline.png"
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }

    Row {
        id: center_row
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenterOffset: 0
        spacing: 60
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: left_turn_singal
            x: 0
            width: 80
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            source: telltaledatamodel.telltale_BCM_TurnIndicatorLeft ? "../images/left_turn_singal.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: time
            color: "#f9f9f9"
            text: tripcomputerdatamodel.tripcomputer_systime
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Source Han Sans CN Normal"
        }

        Rectangle {
            id: gear
            width: 84
            height: 84
            color: "#00ffffff"

            Image {
                id: gear_bg
                x: 0
                y: 0
                source: "../images/gear_bg.png"
                asynchronous: true
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: gear_char
                color: "#ffffff"
                text: gaugedatamodel.gauge_TCU_GearForDisplay
                anchors.fill: parent
                font.pixelSize: 55
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                z: 1
                font.family: "Source Han Sans CN Normal"
            }
        }

        Text {
            id: temperature
            color: "#ffffff"
            text: tripcomputerdatamodel.tripcomputer_AC_EnvironmentalTemp.toString(
                      ) + "℃"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            font.family: "Source Han Sans CN Normal"
        }

        Image {
            id: right_turn_singal
            x: 0
            y: 0
            width: 80
            height: 80
            source: telltaledatamodel.telltale_BCM_TurnIndicatorRight ? "../images/right_turn_singal.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Row {
        id: oil_row
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 15
        anchors.leftMargin: 50

        Image {
            id: icon_oil
            x: 0
            y: 0
            source: "../images/icon_oil.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: oil_e
            color: "#ffffff"
            text: qsTr("E")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 32
            font.family: "Source Han Sans CN Normal"
        }

        ProgressDisplay {
            id: oilDisplay
            anchors.verticalCenter: parent.verticalCenter
            volume: tripcomputerdatamodel.tripcomputer_IP_FuelLevelPercent
        }

        Text {
            id: oil_f
            color: "#ffffff"
            text: qsTr("F")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 32
            font.family: "Source Han Sans CN Normal"
        }
    }

    Row {
        id: odo
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.leftMargin: 610
        spacing: 20

        Text {
            id: odo_lab
            width: 58
            height: 24
            color: "#6080ad"
            text: qsTr("ODO")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 28
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.bold: false
            font.family: "Source Han Sans CN Normal"
        }

        Text {
            id: odo_value
            width: 120
            height: 24
            color: "#ffffff"
            text: tripcomputerdatamodel.tripcomputer_Odo
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Source Han Sans CN Normal"
        }

        Text {
            id: odo_unit
            color: "#6080ad"
            text: qsTr("km")
            font.pixelSize: 24
            font.family: "Source Han Sans CN Normal"
        }
    }

    Row {
        id: dte
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 20
        anchors.bottomMargin: 15
        anchors.leftMargin: 1028
        Text {
            id: dte_lab
            width: 58
            height: 24
            color: "#6080ad"
            text: qsTr("DTE")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 28
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Source Han Sans CN Normal"
            font.bold: false
        }

        Text {
            id: dte_value
            width: 120
            height: 24
            color: "#ffffff"
            text: tripcomputerdatamodel.tripcomputer_Dte
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Source Han Sans CN Normal"
        }

        Text {
            id: dte_unit
            color: "#6080ad"
            text: qsTr("km")
            font.pixelSize: 24
            font.family: "Source Han Sans CN Normal"
        }
    }

    Row {
        id: water_row
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        spacing: 15
        anchors.leftMargin: 1546

        Text {
            id: water_c
            color: "#ffffff"
            text: qsTr("C")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 32
            font.family: "Source Han Sans CN Normal"
        }

        ProgressDisplay {
            id: waterDisplay
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id: water_h
            color: "#ffffff"
            text: qsTr("H")
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 32
            font.family: "Source Han Sans CN Normal"
        }

        Image {
            id: icon_water
            x: 0
            y: 0
            source: "../images/icon_water.png"
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Loader {
        id: menuView
        width: 490
        height: 331
        anchors.top: parent.top
        source: gaugedatamodel.gauge_SpecialEffects_Switch
                < 1 ? "MenuView.ui.qml" : "MenuView_Special.ui.qml"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 287
    }

    Row {
        id: left_row
        anchors.verticalCenter: center_row.verticalCenter
        anchors.right: center_row.left
        anchors.rightMargin: 32
        spacing: 23

        Image {
            id: svs
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_EMS_SVS ? "../images/svs.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: seat_belt
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_SRS_BuckleSwitchStatus ? "../images/seat_belt.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: frontFoglamp
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_BCM_FrontFoglampStatus ? "../images/FrontFoglamp.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: rearFoglamp
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_BCM_RearFoglampStatus ? "../images/RearFoglamp.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: highBeam
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_BCM_HighBeamStatus ? "../images/HighBeam.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: lowBeam
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_BCM_LowBeamStatus ? "../images/LowBeam.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: positionLamp
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_BCM_PositionLampStatus ? "../images/PositionLamp.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Row {
        id: right_row
        anchors.verticalCenter: center_row.verticalCenter
        anchors.left: center_row.right
        anchors.leftMargin: 32
        spacing: 23

        Image {
            id: engine_failure
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_EMS_MIL ? "../images/engine_failure.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: temperatureError
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_EMS_CoolanTemperatureError ? "../images/TemperatureError.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: oil_pressure
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_EMS_OilPressureSts ? "../images/oil_pressure.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: aBS
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_ESP_ABSFailStatus ? "../images/ABS.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: airbag
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_SRS_WarningLampStatus ? "../images/airbag.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: gearbox_failure
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_TCU_TransFailureStatus ? "../images/gearbox_failure.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: functionLamp
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_EPB_FunctionLamp ? "../images/FunctionLamp.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Row {
        id: left_row_2
        anchors.left: left_row.left
        anchors.top: left_row.bottom
        anchors.topMargin: 16
        spacing: 23

        Image {
            id: battery_failure
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_BCM_BatteryStatus ? "../images/battery_failure.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Row {
        id: right_row_2
        anchors.right: right_row.right
        anchors.top: right_row.bottom
        anchors.topMargin: 16

        Image {
            id: not_closed
            x: 0
            y: 0
            width: 56
            height: 56
            source: telltaledatamodel.telltale_BCM_DoorStatus ? "../images/not_closed.png" : ""
            asynchronous: true
            fillMode: Image.PreserveAspectFit
        }
    }

    Loader {
        id: adas
        width: 1920
        height: 720
        source: gaugedatamodel.gauge_SpecialEffects_Switch
                < 1 ? "AdasView.ui.qml" : "AdasView_Special.ui.qml"
    }

    WarningPopup {
        id: warningPopup
        visible: warningdatamodel.warning_visibility
        anchors.top: center_row.bottom
        anchors.horizontalCenterOffset: 0
        z: 0
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: __materialLibrary__
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/

