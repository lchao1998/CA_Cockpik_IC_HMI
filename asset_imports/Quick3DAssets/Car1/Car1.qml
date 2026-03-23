import QtQuick
import QtQuick3D
Node {
    id: rootNode
    Model {
        id: shadowplane
        scale.x: 0.393701
        scale.y: 0.393701
        scale.z: 0.393701
        source: "meshes/shadowplane.mesh"
        materials: [
            iteration1_Shadow_material
        ]
    }
    Node {
        id: car
        scale.x: 0.393701
        scale.y: 0.393701
        scale.z: 0.393701
        Model {
            id: car_Bottom
            x: -0.978067
            y: 0.880909
            z: 1.03344
            source: "meshes/car_Bottom.mesh"
            materials: [
                iteration1_CarBlack_material
            ]
        }
        Model {
            id: car_Wheels
            x: -0.893625
            y: 0.379777
            z: -1.60926
            source: "meshes/car_Wheels.mesh"
            materials: [
                iteration1_CarRim_material,
                iteration1_CarTire_material
            ]
        }
        Model {
            id: car_Grill
            source: "meshes/car_Grill.mesh"
            materials: [
                iteration1_CarBlack_material
            ]
        }
        Model {
            id: carBadge
            source: "meshes/carBadge.mesh"
            materials: [
                carMainBody_material
            ]
        }
        Model {
            id: car_Taillights
            source: "meshes/car_Taillights.mesh"
            materials: [
                iteration1_CarTaillight_material
            ]
        }
        Model {
            id: car_Interior
            x: -0.31943
            y: 0.276799
            z: 1.02561
            source: "meshes/car_Interior.mesh"
            materials: [
                iteration1_CarInterior_material,
                iteration1_CarLicense_material
            ]
        }
        Model {
            id: car_Windows
            source: "meshes/car_Windows.mesh"
            materials: [
                iteration1_CarWindow_material
            ]
        }
        Model {
            id: car_HeadlightsGlass
            source: "meshes/car_HeadlightsGlass.mesh"
            materials: [
                iteration1_CarHeadlight_material
            ]
        }
        Model {
            id: iteration1_Car_Bumper
            x: 1.90735e-06
            source: "meshes/iteration1_Car_Bumper.mesh"
            materials: [
                carChrome_material
            ]
        }
        Model {
            id: carBody
            x: -0
            y: -0
            z: 0
            source: "meshes/carBody.mesh"
            materials: spe
        }
    }
    Model {
        id: carFrontLampBase
        x: -1.45519e-10
        y: -1.19209e-06
        z: -1.62436e-07
        rotation: Qt.quaternion(1, 5.96046e-08, 0, 0)
        scale.x: 0.393701
        scale.y: 0.393701
        scale.z: 0.393701
        source: "meshes/carFrontLampBase.mesh"
        materials: [
            carMainBody_material
        ]
    }

    Node {
        id: __materialLibrary__
        DefaultMaterial {
            id: iteration1_Shadow_material
            objectName: "iteration1_Shadow_material"
            diffuseMap: Texture {
                source: "maps/CarShadowGroundA.png.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
                pivotV: 0.5
                pivotU: 0.5
            }
        }

        DefaultMaterial {
            id: iteration1_CarBlack_material
            opacity: 1
            specularTint: "#ffffff"
            emissiveFactor.z: 0
            emissiveFactor.y: 0
            emissiveFactor.x: 0
            blendMode: DefaultMaterial.SourceOver
            objectName: "iteration1_CarBlack_material"
            diffuseColor: "#000000"
        }

        DefaultMaterial {
            id: iteration1_CarRim_material
            objectName: "iteration1_CarRim_material"
            diffuseMap: Texture {
                source: "maps/360Car_Wheel.png.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
                pivotV: 0.5
                pivotU: 0.5
            }
        }

        DefaultMaterial {
            id: iteration1_CarTire_material
            objectName: "iteration1_CarTire_material"
            diffuseMap: Texture {
                source: "maps/360Car_Tire.png.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
                pivotV: 0.5
                pivotU: 0.5
            }
        }

        DefaultMaterial {
            id: carMainBody_material
            diffuseColor: "#ffffff"
            objectName: "carMainBody_material"
            diffuseMap: Texture {
                source: "maps/CarBodyShape.png.png"
                generateMipmaps: true
                mipFilter: Texture.Linear
                pivotV: 0.5
                pivotU: 0.5
            }
        }

        DefaultMaterial {
            id: iteration1_CarTaillight_material
            emissiveFactor.z: 1
            emissiveFactor.y: 1
            emissiveFactor.x: 1
            blendMode: DefaultMaterial.Screen
            objectName: "iteration1_CarTaillight_material"
            diffuseColor: "#d4ffffff"
        }

        DefaultMaterial {
            id: iteration1_CarInterior_material
            objectName: "iteration1_CarInterior_material"
            diffuseColor: "#332f3d"
        }

        DefaultMaterial {
            id: iteration1_CarLicense_material
            specularTint: "#ffffff"
            objectName: "iteration1_CarLicense_material"
            diffuseColor: "#191919"
        }

        DefaultMaterial {
            id: iteration1_CarWindow_material
            opacity: 1
            emissiveFactor.z: 0
            emissiveFactor.y: 0
            emissiveFactor.x: 0
            specularTint: "#ffffff"
            blendMode: DefaultMaterial.Screen
            objectName: "iteration1_CarWindow_material"
            diffuseColor: "#8b717171"
        }

        DefaultMaterial {
            id: iteration1_CarHeadlight_material
            emissiveFactor.z: 0
            emissiveFactor.y: 0
            emissiveFactor.x: 0
            specularTint: "#ffffff"
            blendMode: DefaultMaterial.Screen
            objectName: "iteration1_CarHeadlight_material"
            diffuseColor: "#86f7f7f7"
        }

        DefaultMaterial {
            id: carChrome_material
            objectName: "carChrome_material"
            diffuseColor: "#1d0e27"
        }



        PrincipledMaterial {
            id: spe
            opacity: 1
            alphaMode: PrincipledMaterial.Default
            lighting: PrincipledMaterial.FragmentLighting
            specularTint: 0
            occlusionAmount: 1
            occlusionMap: texture3
            specularAmount: 0.1
            normalStrength: 0.05
            normalMap: texture1
            roughness: 0.4
            metalness: 0.7
            baseColor: "#2c54b8"
            objectName: "spe"

            Texture {
                id: texture1
                source: "../../../images/flakeNormal.png"
                mappingMode: Texture.UV
            }

            Texture {
                id: texture3
                source: "maps/CarBodyShape.png.png"
            }
        }
    }

    DirectionalLight {
        id: lightDirectional
        x: 22.435
        y: 7.293
        color: "#ffffff"
        ambientColor: "#000000"
        eulerRotation.z: -179.99989
        eulerRotation.y: 179.99988
        eulerRotation.x: -90
        brightness: 2.05
        z: 13.28752
    }

}











/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
