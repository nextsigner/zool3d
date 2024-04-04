import QtQuick 2.14
import QtQuick3D 1.14
import ZM3D.ZM3DHousesCircle.ZM3DHouse 1.0

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
    Node{
        id: xHouses
    }

    Component{
        id: compHouse
        ZM3DHouse{}
    }
    Component.onCompleted: {
        load()
    }
    function load(){
        for(var i=0;i<xHouses.children.length;i++){
            xHouses.children[i].destroy(0)
        }
        let aDegs=[0, 35, 65, 90, 120, 155, 180, 210, 240, 270, 300, 330]
        for(i=0;i<12;i++){
            let obj=compHouse.createObject(xHouses, {deg: i})
            obj.rotation=Qt.vector3d(0, 0, parseFloat(aDegs[i]))
            obj.ih=parseInt(i + 1)
        }
    }
    }
