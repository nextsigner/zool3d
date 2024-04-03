import QtQuick 2.14
import QtQuick3D 1.14

Model {
    id: r
    source: "#Sphere"
    pickable: true
    property bool isPicked: false
    property real rot: 0
    property int ih: 12
    scale.x: 1.0
    scale.y: 1.0
    scale.z: 1.0
    rotation.z:r.rot
    materials: DefaultMaterial {
        diffuseColor: "yellow"
    }
    Timer{
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            if(r.ih<12){
                r.ih++
            }else{
                r.ih=1
            }
        }
    }
    Model {
        id: eje
        source: "#Cube"
        pickable: true
        property bool isPicked: false

        scale.x: 0.1
        scale.y: 11.0
        scale.z: 5
        position.x: -580
        rotation.z: 90
        materials: DefaultMaterial {
            diffuseColor: "red"
            //specularAmount: 0.4
            //specularRoughness: 0.4
            //roughnessMap: Texture { source: "maps/roughness.jpg" }
        }
    }
    Model {
        id: num
        source: "#Cylinder"
        scale: Qt.vector3d(1.0, 1.0, 1.0)
        position.x: eje.position.x*2-150
        rotation.x: 90
        materials: DefaultMaterial {
            diffuseColor: "#333"
            specularAmount: 100
            specularRoughness: 100
            roughnessMap: Texture {
                source: "imgs/h_"+r.ih+".png"
                scaleU: 1.8
                scaleV: 1.8
                positionU: 0.15
                positionV: -0.8


            }
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
