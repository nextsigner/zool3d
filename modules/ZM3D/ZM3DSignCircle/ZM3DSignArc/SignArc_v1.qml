import QtQuick 2.14
import QtQuick3D 1.14


Model {
    id: r
    source: "#Cylinder"
    scale: Qt.vector3d(1.0, 1.0, 1.0)
    position: Qt.vector3d(0, 0, 0)
    rotation: Qt.vector3d(90, 0, 0)
    property int ci: 0
    property color c: parent.colors[ci]
    Node{
        id: ns
    }
    //    SequentialAnimation on rotation {
    //        //enabled: false
    //        loops: Animation.Infinite
    //        running: false
    //        PropertyAnimation {
    //            duration: 5000
    //            to: Qt.vector3d(360, 0, 0)
    //            from: Qt.vector3d(0, 0, 0)
    //        }
    //    }
    Component{
        id: compDeg
        Model {
            id: xModel
            source: "#Sphere"
            scale: Qt.vector3d(1.0, 1.0, 1.0)
            position: Qt.vector3d(0, 0, 0)
            rotation: Qt.vector3d(0, 0, 0)
            property int deg: -1
            Model {
                id: m1
                source: "#Cube"
                scale: Qt.vector3d(r.parent.wAlt, r.parent.wProf, r.parent.wAnc)
                position: Qt.vector3d(0-r.parent.radio, 0, 0)
                rotation: Qt.vector3d(0, 90, 0)
                materials: DefaultMaterial {
                    diffuseColor: r.c
                    specularAmount: 0.0
                    opacity: 1.0
                }
                pickable: true
                property bool isPicked: false
                SequentialAnimation on scale {
                    running: m1.isPicked
                    //loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 2500
                        from: Qt.vector3d(0.1, 0.1, 0.1)
                        to: Qt.vector3d(0.1, 2.5, 0.1)
                    }
                }
                SequentialAnimation on rotation {
                    running: m1.isPicked
                    //loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 2500
                        from: Qt.vector3d(0, 0, 0)
                        to: Qt.vector3d(0, 180, 0)
                    }
                }
            }

        }
    }
    Model {
        id: xModelIcon
        source: "#Sphere"
        scale: Qt.vector3d(1.0, 1.0, 1.0)
        position: Qt.vector3d(0, 0, 0)
        //rotation: Qt.vector3d(0, 0, 0)
        rotation: Qt.vector3d(0, (r.ci*30)+15, 0)
        property int deg: -1
        Model {
            id: m2
            source: "#Cylinder"
            scale: Qt.vector3d(0.8, r.parent.wProf+0.1, 0.8)
            position: Qt.vector3d(0-r.parent.radio, 0, 0)
            rotation: Qt.vector3d(0, (sc.rotation.z-r.ci*30)-90, 0)
            materials: DefaultMaterial {
                diffuseColor: 'red'//r.selected?aColors[0]:aColors[1]
                specularAmount: 100
                specularRoughness: 100
                roughnessMap: Texture {
                    source: "imgs/"+r.ci+".png"
                    //source: "/home/ns/nsp/zool-release/resources/imgs/signos/1.svg"
                    scaleU: 2.3
                    scaleV: 2.3
                    positionU: -0.05
                    positionV: -1.2
                    //rotationUV: 10


                }
            }
            pickable: true
            property bool isPicked: false
        }

    }
    Component.onCompleted: {
        for(let i=r.ci*30;i<(r.ci*30)+30;i++){
            let obj=compDeg.createObject(ns, {})
            obj.rotation=Qt.vector3d(0, parseFloat(i), 0)
        }
    }
}
