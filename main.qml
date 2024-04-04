import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick3D 1.14
import ZM3D 1.0
import Luces 1.0

ApplicationWindow {
    id: app
    visible: true
    width: 800
    height: 500
    title: 'Zool 3D'
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


        Luces{id: luces}

        //        PointLight {
        //            x: 0
        //            y: 0
        //            z: 0
        //            quadraticFade: 0
        //            brightness: 10.5
        //            //visible: false
        //        }

        ZM3D{id: zm}
        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 0, (0-zm.d)*2)
            //rotation.y: 30 //Con eje y rota/gira hacia los costados.
        }
        //CustomCamera{
        OrthographicCamera{
            id: camera2
            position: Qt.vector3d(0, 0, -1000)
            //position: Qt.vector3d(0, 0, (0-zm.d)*4)
            clipNear: 0.1 //Distancia mínima
            clipFar: 1000.0 //Distancia máxima

            //rotation.y: 30 //Con eje y rota/gira hacia los costados.
        }
        //        CustomCamera {
        //            id: camera3
        //            projectionType: CameraLens.PerspectiveProjection
        //            fieldOfView: 45
        //            aspectRatio: 16/9
        //            nearPlane : 0.1
        //            farPlane : 1000.0
        //            position: Qt.vector3d(0, 0, -10)
        //            viewCenter: Qt.vector3d(0, 0, 0)
        //        }

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
                //roughnessMap: Texture { source: "maps/roughness.jpg" }
            }

        }
        Model {
            id: centro
            source: "#Sphere"
            pickable: true
            property bool isPicked: false

            scale.x: 1.0
            scale.y: 1.0
            scale.z: 1.0
            materials: DefaultMaterial {
                diffuseColor: centro.isPicked ? "red" : "#00FF00"
                specularAmount: 0.4
                specularRoughness: 0.4
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

        //Rueda{}

    }

    MouseArea {
        anchors.fill: view

        //onClicked: (mouse) => {
        onClicked: {
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
        onDoubleClicked: {
            camera.position=Qt.vector3d(0, 0, (0-zm.d)*2)
            camera.rotation=Qt.vector3d(0, 0, 0)
        }
        onWheel: {
            let cz=camera.position.z
            if (wheel.modifiers & Qt.ControlModifier) {
                if(wheel.angleDelta.y>=0){
                    cz+=40
                }else{
                    cz-=40
                }
            }else if (wheel.modifiers & Qt.ShiftModifier){

            }else{
                if(wheel.angleDelta.y>=0){
                    //                    if(reSizeAppsFs.fs<app.fs*2){
                    //                        reSizeAppsFs.fs+=reSizeAppsFs.fs*0.1
                    //                    }else{
                    //                        reSizeAppsFs.fs=app.fs
                    //                    }
                    pointerPlanet.pointerRot+=45
                }else{
                    //                    if(reSizeAppsFs.fs>app.fs){
                    //                        reSizeAppsFs.fs-=reSizeAppsFs.fs*0.1
                    //                    }else{
                    //                        reSizeAppsFs.fs=app.fs*2
                    //                    }
                    //pointerPlanet.pointerRot-=45
                }
            }
            //reSizeAppsFs.restart()
            camera.position.z=cz
        }
    }
    //MaterialControl{id:materialCtrl}

    //    Rectangle{
    //        anchors.fill: parent
    //        color: 'red'
    //        Repeater{
    //            model: 12
    //            Rectangle{
    //                id: rect
    //                width: 1000
    //                height: 1000
    //                color: 'transparent'
    //                Text{
    //                    text: '<b>'+parseInt(index + 1)+'</b>'
    //                    font.pixelSize: parent.width*0.6
    //                    color: 'white'
    //                    anchors.centerIn: parent
    //                }
    //                Timer{
    //                    running: true
    //                    repeat: false
    //                    interval: 3000
    //                    onTriggered: {
    //                        rect.grabToImage(function(result) {
    //                            result.saveToFile("/home/ns/nsp/zool3d/modules/ZM3D/ZM3DHousesCircle/ZM3DHouse/imgs/h_"+parseInt(index + 1)+".png")
    //                        });
    //                    }
    //                }
    //            }
    //        }
    //    }

    Shortcut{
        sequence: 'Esc'
        onActivated: Qt.quit()
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            if(camera.position.x>-2000){
                let cr=camera.rotation.y
                cr+=5
                camera.rotation.y=cr

                let cp=camera.position.x
                cp-=200
                camera.position.x=cp
            }
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            if(camera.position.x<2000){
                let cr=camera.rotation.y
                cr-=5
                camera.rotation.y=cr

                let cp=camera.position.x
                cp+=200
                camera.position.x=cp
            }
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(camera.position.y<2000){
                let cr=camera.rotation.x
                cr+=5
                camera.rotation.x=cr

                let cp=camera.position.y
                cp+=200
                camera.position.y=cp
            }
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(camera.position.y>-2000){
                let cr=camera.rotation.x
                cr-=5
                camera.rotation.x=cr

                let cp=camera.position.y
                cp-=200
                camera.position.y=cp
            }
        }
    }
    Shortcut{
        sequence: 'Shift+Up'
        onActivated: {
            camera.position.z+=50.0
        }
    }
    Shortcut{
        sequence: 'Shift+Down'
        onActivated: {
            camera.position.z-=50.0
        }
    }
    Shortcut{
        sequence: 'c'
        onActivated: {
            if(view.camera===camera2){
                view.camera=camera
            }else{
                view.camera=camera2
            }
        }
    }
}
