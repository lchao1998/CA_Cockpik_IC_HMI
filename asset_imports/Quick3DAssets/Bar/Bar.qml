import QtQuick
import QtQuick3D
import Quick3DAssets.Bar 1.0

Node {
    // Materials
    // end of Materials

    Node {
        id: rootNode
        Node {
            id: tachMeter
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            Model {
                id: tachMeter_Bar
                x: -4.76837e-07
                y: 0.0378419
                z: -1.08033e-07
                source: "meshes/tachMeter_Bar.mesh"
                materials: [
                    defaultMaterial_material
                ]
            }
            Model {
                id: tachMeter_Bar_Bg
                x: -4.76837e-07
                y: 0.0378419
                z: -1.08033e-07
                source: "meshes/tachMeter_Bar_Bg.mesh"
                materials: [
                    material__25_material
                ]
            }
        }
        Node {
            id: speedMeter
            rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
            Model {
                id: speedMeter_Bar
                y: -0.0378544
                z: 1.19209e-07
                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)
                source: "meshes/speedMeter_Bar.mesh"
                materials: [
                    defaultMaterial_material
                ]
            }
            Model {
                id: speedMeter_Bar_Bg
                y: 0.0378422
                z: 8.9407e-08
                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)
                source: "meshes/speedMeter_Bar_Bg.mesh"
                materials: [
                    material__25_material
                ]
            }
        }
    }

    Node {
        id: __materialLibrary__
        DefaultMaterial {
            id: defaultMaterial_material
            diffuseColor: "#cccccc"
            objectName: "defaultMaterial_material"
        }

        DefaultMaterial {
            id: material__25_material
            diffuseColor: "#969696"
            objectName: "material__25_material"
        }
    }
}
