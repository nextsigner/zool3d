import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick3D 1.14
import ZoolLogView 1.0
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
    property int fs: 50
    property color c: 'white'


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

    Row{
        anchors.right: parent.right
        Column{
            Label {
                text: "cbi:"+zm.cbi
                font.pointSize: 14
                color: app.c
            }
        }
    }

    View3D {
        id: view
        anchors.fill: parent
        renderMode: View3D.Underlay
        property var cCam: camera//Giro
        camera: cCam
        environment: SceneEnvironment {
            probeBrightness: 0//250
            //clearColor: "#848895"
            clearColor: "#000"

            backgroundMode: SceneEnvironment.Color
            lightProbe: Texture {
                source: "maps-/OpenfootageNET_garage-1024.hdr"
            }
        }


        //        DirectionalLight {
        //            rotation: Qt.vector3d(0, 100, 0)
        //            brightness: 100
        //            SequentialAnimation on rotation {
        //                loops: Animation.Infinite
        //                PropertyAnimation {
        //                    duration: 5000
        //                    to: Qt.vector3d(0, 360, 0)
        //                    from: Qt.vector3d(0, 0, 0)
        //                }
        //            }
        //        }

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


        Node{
            id: ncg
            rotation.z: 30
            Node{
                //position: Qt.vector3d(0, 0, ((0-zm.d)*2)+2000)
                position: Qt.vector3d(0, -1500, -600)
                rotation.x: -90
                //rotation.z: -30
                PerspectiveCamera {
                    id: cameraGiro
                    rotation.x: 40
                }
                Node{
                    position: cameraGiro.position
                    rotation: cameraGiro.rotation
                    //visible: r.verPosicionDeCamara
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
            SequentialAnimation on rotation {
                //enabled: false
                loops: Animation.Infinite
                running: false
                PropertyAnimation {
                    duration: 12000
                    to: Qt.vector3d(0, 0, 0)
                    from: Qt.vector3d(0, 0, 360)
                }
            }
        }

        PerspectiveCamera {
            id: camera
            position: Qt.vector3d(0, 0, ((0-zm.d)*2)-400)
        }
        Model {
            visible: false
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

            //            SequentialAnimation on rotation {
            //                running: !cubeModel.isPicked
            //                loops: Animation.Infinite
            //                PropertyAnimation {
            //                    duration: 2500
            //                    from: Qt.vector3d(0, 0, 0)
            //                    to: Qt.vector3d(360, 360, 360)
            //                }
            //            }

        }

        Model {
            source: "#Sphere"
            scale: Qt.vector3d(2.0, 2.0, 2.0)
            position: Qt.vector3d(0, 0, -100)
            rotation: Qt.vector3d(0, 0, 0)
            materials: [ PrincipledMaterial {
                    metalness: 0.0
                    roughness: 0.0
                    specularAmount: 0.0
                    indexOfRefraction: 1.0
                    opacity: 1.0
                    baseColorMap: Texture { source: "modules/ZM3D/ZM3DBodiesCircle/imgs/mundo.jpg" }
                }
            ]
            SequentialAnimation on rotation {
                loops: Animation.Infinite
                running: true
                PropertyAnimation {
                    duration: 5000
                    to: Qt.vector3d(0, 360, 0)
                    from: Qt.vector3d(0, 0, 0)
                }
            }
        }
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
                //                var object = result.node;
                //                if (object) {
                //                    log.lv("Posición absoluta del objeto seleccionado:", object.position);
                //                }
                //                log.lv('result.position: '+pickedObject.parent.position)
                //                log.lv('result.position: '+pickedObject.node)
                //view.cCam.position=result.position
                // Get other pick specifics
                uvPosition.text = "("
                        + result.uvPosition.x.toFixed(2) + ", "
                        + result.uvPosition.y.toFixed(2) + ")";
                //view.cCam.position.x=result.uvPosition.x
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
            view.cCam.position=Qt.vector3d(0, 0, (0-zm.d)*2)
            view.cCam.rotation=Qt.vector3d(0, 0, 0)
        }
        onWheel: {
            let cz=view.cCam.position.z
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
            view.cCam.position.z=cz
        }
    }
    ZoolLogView{
        id: log
        width: app.fs*20
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
        onActivated: {
            if(log.visible){
                log.visible=false
                return
            }
            Qt.quit()
        }
    }
    Shortcut{
        sequence: 'Ctrl+Esc'
        onActivated: {
            view.cCam.position=Qt.vector3d(0, 0, (0-zm.d)*2)
            view.cCam.rotation=Qt.vector3d(0, 0, 0)
        }
    }
    Shortcut{
        sequence: 'Left'
        onActivated: {
            //log.lv('view.cCam.objectName: '+view.cCam.objectName)
            if(view.camera===cameraGiro){
                let cr=ncg.rotation.z
                cr+=5
                ncg.rotation.z=cr
            }else{
                if(view.cCam.position.x>-2000){
                    let cr=view.cCam.rotation.y
                    cr+=5
                    view.cCam.rotation.y=cr

                    let cp=view.cCam.position.x
                    cp-=200
                    view.cCam.position.x=cp
                }
            }
        }
    }
    Shortcut{
        sequence: 'Right'
        onActivated: {
            if(view.camera===cameraGiro){
                let cr=ncg.rotation.z
                cr-=5
                ncg.rotation.z=cr
            }else{
            if(view.cCam.position.x<2000){
                let cr=view.cCam.rotation.y
                cr-=5
                view.cCam.rotation.y=cr

                let cp=view.cCam.position.x
                cp+=200
                view.cCam.position.x=cp
            }
            }
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(view.camera===cameraGiro){
                zm.cbi++
            }else{
            if(view.cCam.position.y<2000){
                let cr=view.cCam.rotation.x
                cr+=5
                view.cCam.rotation.x=cr

                let cp=view.cCam.position.y
                cp+=200
                view.cCam.position.y=cp
            }
            }
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(view.camera===cameraGiro){
                zm.cbi--
            }else{
            if(view.cCam.position.y>-2000){
                let cr=view.cCam.rotation.x
                cr-=5
                view.cCam.rotation.x=cr

                let cp=view.cCam.position.y
                cp-=200
                view.cCam.position.y=cp
            }
            }
        }
    }
    Shortcut{
        sequence: 'Shift+Up'
        onActivated: {
            view.cCam.position.z+=50.0
        }
    }
    Shortcut{
        sequence: 'Shift+Down'
        onActivated: {
            view.cCam.position.z-=50.0
        }
    }
    Shortcut{
        sequence: 'c'
        onActivated: {
            if(view.camera===cameraGiro){
                view.camera=camera
                view.cCam=camera
            }else{
                view.camera=cameraGiro
                view.cCam=cameraGiro
            }
        }
    }

    Component.onCompleted: {
        //log.lv('Inicio...')
        let js=unik.getFile('/home/ns/j.json')
        //console.log('JSON:\n'+js)
        js=js.replace(/\n/g, '')
        let json=JSON.parse(js)
        zm.loadData(json)
        //log.lv('JSON:\n'+JSON.stringify(json, null, 2))
    }
}
