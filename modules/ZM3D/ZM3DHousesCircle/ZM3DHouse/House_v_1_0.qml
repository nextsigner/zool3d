import QtQuick 2.14
import QtQuick3D 1.14

Model {
    id: r
    source: "#Sphere"
    pickable: true
    property bool isPicked: false
    property real rot: 0
    property int ih: 12
    property real anchoProfundoLineaHouse: 2.5
    scale.x: 1.0
    scale.y: 1.0
    scale.z: 1.0
    rotation.z:r.rot
    materials: DefaultMaterial {
        diffuseColor: "yellow"
    }
    Model {
        id: eje
        source: "#Cube"
        pickable: true
        property bool isPicked: false

        scale.x: 0.1
        scale.y: 11.0
        scale.z: r.anchoProfundoLineaHouse
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
        position.x: eje.position.x*2-50
        rotation.x: 90
        visible: false
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
                //rotationUV: 10


            }
        }
    }


    Node{
        //position: num.position
        position.x: eje.position.x*2-50
        rotation.x:0
        rotation.y:0
        rotation.z:360-r.rotation.z //Rotación para la imagen del número
        Model {
            id: num2
            source: "#Cylinder"
            scale: Qt.vector3d(1.0, r.anchoProfundoLineaHouse, 1.0)
            //rotation: Qt.vector3d(90, 0, 0)
            rotation.x:90
            rotation.y:90
            rotation.z:90
            materials: DefaultMaterial {
                diffuseColor: "#00FF33"
                specularAmount: 100
                specularRoughness: 100
                roughnessMap: Texture {
                    source: "imgs/h_"+r.ih+".png"
                    scaleU: 1.8
                    scaleV: 1.8
                    positionU: 0.15
                    positionV: -0.8
                    //rotationUV: 10


                }
            }
        }
        Model {
            source: "#Cube"
            scale: Qt.vector3d(0.2, 0.2, 2.0)
            rotation: num2.rotation
            visible: false
            materials: DefaultMaterial {
                diffuseColor: "yellow"
                specularAmount: 0
                specularRoughness: 00
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
