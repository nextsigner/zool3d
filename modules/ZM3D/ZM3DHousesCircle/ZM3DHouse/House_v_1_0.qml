import QtQuick 2.14
import QtQuick3D 1.14

Model {
    id: r
    source: "#Sphere"
    pickable: true
    property bool isPicked: false

    scale.x: 1.0
    scale.y: 1.0
    scale.z: 1.0

    materials: DefaultMaterial {
        diffuseColor: "yellow"
        //specularAmount: 0.4
        //specularRoughness: 0.4
        //roughnessMap: Texture { source: "maps/roughness.jpg" }
    }

    Model {
        id: eje
        //source: "#Cylinder"
        source: "#Cube"
        pickable: true
        property bool isPicked: false

        scale.x: 0.1
        scale.y: 25
        scale.z: 5
        //position.x: 500
        rotation.z: 90
        materials: DefaultMaterial {
            diffuseColor: "red"
            //specularAmount: 0.4
            //specularRoughness: 0.4
            //roughnessMap: Texture { source: "maps/roughness.jpg" }
        }
    }

//    SequentialAnimation on rotation {
//        running: !cubeModel.isPicked
//        loops: Animation.Infinite
//        PropertyAnimation {
//            duration: 2500
//            from: Qt.vector3d(0, 0, 0)
//            to: Qt.vector3d(360, 360, 360)
//        }
//    }
}
