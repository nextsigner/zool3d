import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick3D 1.14
import Cartel 1.0

Node{
    id: r
    property alias rot: ejeCarteles.rotation.z


    property int ciSignSen: -1
    property int ciDegSen: -1

    property int currentDegSen: 0
    onCurrentDegSenChanged: {
        r.ciSignSen=zm.getIndexSign(currentDegSen)
        let gs=(r.currentDegSen-(r.ciSignSen*30))
        r.ciDegSen=gs
    }
    Node{
        id: ejeCarteles
        //rotation.z:view.cCam.rotation.y
        Node{
            position.y: -1200
            position.z: 50
            Model {
                id: baseDePerno
                source: "#Cube"
                position.y:90
                scale: Qt.vector3d(0.25, 1.85, 0.25)

                materials: [
                    DefaultMaterial {
                        diffuseColor: 'yellow'
                        SequentialAnimation on diffuseColor{
                            loops: Animation.Infinite
                            //running: false
                            PropertyAnimation{
                                duration: 200
                                from: 'white'
                                to: 'red'
                            }
                            PropertyAnimation{
                                duration: 200
                                from: 'red'
                                to: 'yellow'
                            }
                            PropertyAnimation{
                                duration: 200
                                from: 'yellow'
                                to: 'white'
                            }
                        }
                    }
                ]

            }
            Model {
                id: perno
                source: "#Cylinder"
                scale: Qt.vector3d(0.25, 0.8, 0.25)
                rotation.x: 90
                position.z:-60
                position.y: 100 //Distancia hacia la rueda
                materials: baseDePerno.materials
                Model {
                    id: senGira
                    source: "#Cube"
                    scale: Qt.vector3d(1.5, 0.25, 1.5)
                    position.y:-36
                    rotation.y:45
                    materials: baseDePerno.materials
                    SequentialAnimation on rotation.y{
                        loops: Animation.Infinite
                        //running: false
                        PropertyAnimation{
                            duration: 250
                            from: 45
                            to: 45+15
                        }
                        PropertyAnimation{
                            duration: 250
                            from: 45+15
                            to: 45
                        }
                        PropertyAnimation{
                            duration: 250
                            from: 45
                            to: 45-15
                        }
                        PropertyAnimation{
                            duration: 250
                            from: 45-15
                            to: 45
                        }
                    }
                }
            }
            Model {
                source: "#Cube"
                scale: Qt.vector3d(0.25, 0.25, 1.5)
                //rotation.z: 90
                position.y:100
                visible: false
                materials: [
                    DefaultMaterial {
                        diffuseColor: 'white'
                    }
                ]
            }
        }

        Node{
            position.y: -1100
            position.z: 300
            rotation.z:-90
            Cartel{
                id: cartelSen
                position.x: 160
                position.y: 0
                position.z: -250
                itemTexture: zm.cbi<0?itemSen1:itemBodieSen
            }
//            Cartel{
//                id: cartel1
//                position.y:700
//                itemTexture: itemBodieSen
//            }
//            Cartel{
//                id: cartel2
//                position.y:-700
//            }
        }
    }
}
