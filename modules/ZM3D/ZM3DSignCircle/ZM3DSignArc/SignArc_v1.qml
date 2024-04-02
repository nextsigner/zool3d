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
    Component.onCompleted: {
        for(let i=r.ci*30;i<(r.ci*30)+30;i++){
            let obj=compDeg.createObject(ns, {deg: i})
            obj.rotation=Qt.vector3d(0, parseFloat(i), 0)
        }
    }
}
