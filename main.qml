import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick3D 1.14

ApplicationWindow {
    id: app
    visible: true
    width: 800
    height: 500
    title: qsTr("Picking Example")
    color: "#848895"
    visibility: 'Maximized'
    property color c: 'black'


    Row {
        anchors.left: parent.left
        anchors.leftMargin: 8
        spacing: 10
        Column {
            Label {
                color: app.c
                font.pointSize: 14
                text: "Last Pick:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "Screen Position:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "UV Position:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "Distance:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "World Position:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "Local Position:"
            }

            Label {
                color: app.c
                font.pointSize: 14
                text: "World Normal:"
            }
            Label {
                color: app.c
                font.pointSize: 14
                text: "Local Normal:"
            }
        }
        Column {
            Label {
                id: pickName
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: pickPosition
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: uvPosition
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: distance
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: scenePosition
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: localPosition
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: worldNormal
                color: app.c
                font.pointSize: 14
            }
            Label {
                id: localNormal
                color: app.c
                font.pointSize: 14
            }

        }
    }
    MaterialControl{id:materialCtrl}
    View3D {
        id: view
        anchors.fill: parent
        renderMode: View3D.Underlay
        environment: SceneEnvironment {
            probeBrightness: 0//250
            clearColor: "#848895"

            backgroundMode: SceneEnvironment.Color
//            lightProbe: Texture {
//                source: "maps/OpenfootageNET_garage-1024.hdr"
//            }
        }


        DirectionalLight {
            position.x: 0
            position.y: 300
            position.z: 300
            rotation: Qt.vector3d(0, 30, 0)
            brightness: 100
        }
        DirectionalLight {
            position.x: 0
            position.y: -300
            position.z: 300
            rotation: Qt.vector3d(0, -30, 0)
            brightness: 100
        }


//        PointLight {
//            x: 0
//            y: 0
//            z: 0
//            quadraticFade: 0
//            brightness: 10.5
//            //visible: false
//        }

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 0, -600*3)
            //rotation.y: 30 //Con eje y rota/gira hacia los costados.
        }

        Model {
            id: bg
            source: "#Cube"
            pickable: true
            property bool isPicked: false

            scale.x: 100
            scale.y: 100
            scale.z: 10
            position.x: 0
            position.y: 0
            position.z: 600

            materials: DefaultMaterial {
                diffuseColor: "#000"
                specularAmount: 0.1
                specularRoughness: 0.1
                roughnessMap: Texture { source: "maps/roughness.jpg" }
            }

        }
        Model {
            id: cubeModel
            objectName: "Cube"
            source: "#Cube"
            pickable: true
            property bool isPicked: false

            scale.x: 1.5
            scale.y: 2
            scale.z: 1.5

            materials: DefaultMaterial {
                diffuseColor: cubeModel.isPicked ? "red" : "blue"
                specularAmount: 0.4
                specularRoughness: 0.4
                roughnessMap: Texture { source: "maps/roughness.jpg" }
            }

            SequentialAnimation on rotation {
                running: !cubeModel.isPicked
                loops: Animation.Infinite
                PropertyAnimation {
                    duration: 2500
                    from: Qt.vector3d(0, 0, 0)
                    to: Qt.vector3d(360, 360, 360)
                }
            }
        }

        Rueda{}
    }

    MouseArea {
        anchors.fill: view

        onClicked: (mouse) => {
                       // Get screen coordinates of the click
                       pickPosition.text = "(" + mouse.x + ", " + mouse.y + ")"
                       var result = view.pick(mouse.x, mouse.y);
                       if (result.objectHit) {
                           var pickedObject = result.objectHit;
                           // Toggle the isPicked property for the model
                           pickedObject.isPicked = !pickedObject.isPicked;
                           // Get picked model name
                           pickName.text = pickedObject.objectName;
                           // Get other pick specifics
                           uvPosition.text = "("
                           + result.uvPosition.x.toFixed(2) + ", "
                           + result.uvPosition.y.toFixed(2) + ")";
                           distance.text = result.distance.toFixed(2);
                           scenePosition.text = "("
                           + result.scenePosition.x.toFixed(2) + ", "
                           + result.scenePosition.y.toFixed(2) + ", "
                           + result.scenePosition.z.toFixed(2) + ")";
                           localPosition.text = "("
                           + result.position.x.toFixed(2) + ", "
                           + result.position.y.toFixed(2) + ", "
                           + result.position.z.toFixed(2) + ")";
                           worldNormal.text = "("
                           + result.sceneNormal.x.toFixed(2) + ", "
                           + result.sceneNormal.y.toFixed(2) + ", "
                           + result.sceneNormal.z.toFixed(2) + ")";
                           localNormal.text = "("
                           + result.normal.x.toFixed(2) + ", "
                           + result.normal.y.toFixed(2) + ", "
                           + result.normal.z.toFixed(2) + ")";
                       } else {
                           pickName.text = "None";
                           uvPosition.text = "";
                           distance.text = "";
                           scenePosition.text = "";
                           localPosition.text = "";
                           worldNormal.text = "";
                           localNormal.text = "";
                       }
                   }
    }
    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
}
