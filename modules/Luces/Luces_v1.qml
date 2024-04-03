import QtQuick 2.12
import QtQuick3D 1.14

Node{
    id: r
    property alias l: l4

    //Luz desde el centro hacia arriba
    DirectionalLight {
        id:l1
        position.x: 0
        position.y: 0
        position.z: -1000
        rotation: Qt.vector3d(-50, 0, 0)
        brightness: 100
        visible: false
    }

    //Luz desde el centro hacia abajo
    DirectionalLight {
        id:l2
        position.x: 0
        position.y: 0
        position.z: -1000
        rotation: Qt.vector3d(50, 0, 0)
        brightness: 100
    }
    //Luz desde el centro hacia la derecha
    DirectionalLight {
        id:l3
        position.x: 0
        position.y: 0
        position.z: -1000
        rotation: Qt.vector3d(0, 50, 0)
        brightness: 100
    }
    //Luz desde el centro hacia la izquierda
    DirectionalLight {
        id:l4
        position.x: 0
        position.y: 0
        position.z: -1000
        rotation: Qt.vector3d(0, -50, 0)
        brightness: 100
    }
    Node{
        position: l.position
        rotation: l.rotation
        Model {
            id: esferaFoco
            source: "#Sphere"
            pickable: true
            scale.x: 0.5
            scale.y: 0.5
            scale.z: 0.5
            materials: DefaultMaterial {
                diffuseColor: 'red'
            }
        }
        Model {
            source: "#Cube"
            pickable: true
            scale.x: 0.1
            scale.y: 1.0
            scale.z: 0.1
            materials: DefaultMaterial {
                diffuseColor: 'blue'
            }
        }
        Model {
            source: "#Cube"
            pickable: true
            scale.x: 0.1
            scale.y: 0.1
            scale.z: 1.0
            materials: DefaultMaterial {
                diffuseColor: 'yellow'
            }
        }
        Model {
            source: "#Cube"
            pickable: true
            scale.x: 1.0
            scale.y: 0.1
            scale.z: 0.1
            materials: DefaultMaterial {
                diffuseColor: 'white'
            }
        }
    }
}
