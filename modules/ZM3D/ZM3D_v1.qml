import QtQuick 2.0
import QtQuick 2.14
import QtQuick3D 1.14
import ZM3D.ZM3DSignCircle 1.0
import ZM3D.ZM3DHousesCircle 1.0
import ZM3D.ZM3DBodiesCircle 1.0

Node{
    id: r
    //Tamaños
    property int d: 1000
    property real anchoProfundoBandaSign: 2.4
    property real anchoProfundoLineaHouse: 2.5

    //Current Bodies and Houses Indexs
    property int cbi: -1
    property int chi: -1


    property real currentSignRot: 0

    onChiChanged: {
        //log.lv('zm.chi: '+chi)
    }

    ZM3DSignCircle{
        id: sc
        rotation.z:0-currentSignRot
    }
    ZM3DHousesCircle{
        id: hc
        rotation.z:0-currentSignRot
    }
    ZM3DBodiesCircle{
        id: bc
        rotation.z:0-currentSignRot
    }

    function loadData(j){
        //log.lv('j:'+JSON.stringify(j, null, 2))
        //log.lv('Deg Casa 1:'+j.ph.h1.gdec)
        let rot=360-j.ph.h1.gdec
        //log.lv('Rot:'+rot)
        r.currentSignRot=0-rot
        hc.load(j.ph)
        bc.load(j.pc)
    }
}
