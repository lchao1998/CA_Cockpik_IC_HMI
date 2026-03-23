import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick3D 6.2
import Quick3DAssets.TachMeter 1.0

Rectangle {
    width: 546
    height: 546
    color: "#00000000"
    border.color: "#00000000"

    View3D {
        id: view3D
        anchors.fill: parent
        environment: sceneEnvironment
        SceneEnvironment {
            id: sceneEnvironment
            antialiasingQuality: SceneEnvironment.High
            antialiasingMode: SceneEnvironment.MSAA
        }

        Node {
            id: scene
            DirectionalLight {
                id: directionalLight
                ambientColor: "#f0f0f0"
            }

            PerspectiveCamera {
                id: camera
                z: 15
            }

            TachMeter {
                id: tachMeter
                tachoValue: gaugedatamodel.gauge_EMS_EngineSpeed
            }
        }
    }

    Image {
        id: right_line
        x: 0
        y: 0
        source: "../images/right_line.png"
        asynchronous: true
        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: __materialLibrary__
    }
}
