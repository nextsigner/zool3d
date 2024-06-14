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
    property real anchoProfundoBandaSign: 0.15
    property real anchoProfundoLineaHouse: 2.5

    property var aSigns: ['Aries', 'Tauro', 'Géminis', 'Cáncer', 'Leo', 'Virgo', 'Libra', 'Escorpio', 'Sagitario', 'Capricornio', 'Acuario', 'Piscis']
    property var aSignsLowerStyle: ['aries', 'tauro', 'geminis', 'cancer', 'leo', 'virgo', 'libra', 'escorpio', 'sagitario', 'capricornio', 'acuario', 'piscis']
    property var aBodies: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    property var aBodiesFiles: ['sol', 'luna', 'mercurio', 'venus', 'marte', 'jupiter', 'saturno', 'urano', 'neptuno', 'pluton', 'nodo_norte', 'nodo_sur', 'quiron', 'selena', 'lilith', 'pholus', 'ceres', 'pallas', 'juno', 'vesta']
    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']

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
        //visible: false
    }
    ZM3DHousesCircle{
        id: hc
        rotation.z:0-currentSignRot
        //visible: false
    }
    ZM3DBodiesCircle{
        id: bc
        rotation.z:0-currentSignRot
        //visible: false
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

    function getObjZGdec(gdec){
        let nz=-90-zm.currentSignRot-gdec+90
        if(nz>360.00)nz=360.00-nz
        return nz
    }
    function getIndexSign(gdec){
        let index=0
        let g=0.0
        for(var i=0;i<12+5;i++){
            g = g + 30.00
            if (g > parseFloat(gdec)){
                break
            }
            index = index + 1
        }
        if(index===12)index--
        return index
    }
}
