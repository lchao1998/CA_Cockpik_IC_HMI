import QtQuick
import QtQuick3D
Node {
    id: rootNode
    Model {
        id: car
        source: "meshes/car.mesh"
        eulerRotation.x: -90
        materials: node14___Default_material
    }

    Node {
        id: __materialLibrary__
        DefaultMaterial {
            id: node14___Default_material
            diffuseColor: "#ffffff"
            lighting: DefaultMaterial.NoLighting
            objectName: "node14___Default_material"
            Texture {
                id: maps
                source: "../../../images/maps.png"
            }
            diffuseMap: maps
        }
    }
}
