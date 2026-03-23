import QtQuick
import QtQuick3D
import Quick3DAssets.Effect 1.0
import QtQuick.Timeline 1.0

Node {
    id: node
    // Materials
    // end of Materials

    Node {
        id: rootNode

        Model {
            id: effect
            y: 8.03475
            source: "meshes/effect.mesh"
            materials: newMaterial
        }
    }

    Node {
        id: __materialLibrary__

        CustomMaterial {
            id: newMaterial
            property real speed: 3
            property real uTime: 0
            NumberAnimation on uTime { from: 0; to: 10; duration: 20000; loops: -1 }
            property real blendIntensity: 1
            destinationBlend: CustomMaterial.One
            sourceBlend: CustomMaterial.One
            vertexShader: "../../../shader/particle2.0.vert.glsl"
            shadingMode: CustomMaterial.Unshaded
            fragmentShader: "../../../shader/particle2.0.frag.glsl"
            objectName: "New Material"
        }
    }
}
