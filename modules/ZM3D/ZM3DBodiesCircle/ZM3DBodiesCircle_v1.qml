import QtQuick 2.14
import QtQuick3D 1.14
import QtQuick3D.Materials 1.14


Model {
    id: r
    source: "#Cylinder"
    scale: Qt.vector3d(1.0, 1.0, 1.0)
    position: Qt.vector3d(0, 0, 0)
    rotation: Qt.vector3d(90, 0, 0)
    property int ci: 0
    //property color c: parent.colors[ci]
    property var aBdiesColors: ["#00ff00", "#33ff51", "#00ff88", "#ff8833", "#0f00ff", "#88ddff", "#0ff08d", "#ff5133", "#ff51dd", "#3f313f", "#ddff00", "#ff3838", "#ffff38", "#38ffcc", "#cc3838", "#ac38ff", "#afafaf", "#f8f838", "#ff38ff", "#ffccaa"]
    property var aBodies: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Júpiter', 'Saturno', 'Urano', 'Neptuno', 'Plutón', 'N.Norte', 'N.Sur', 'Quirón', 'Selena', 'Lilith', 'Pholus', 'Ceres', 'Pallas', 'Juno', 'Vesta']
    Node{
        id: nb
    }
    Component{
        id: compBodie
        Model {
            id: xModel
            source: "#Sphere"
            scale: Qt.vector3d(1.0, 1.0, 1.0)
            property int bi
            property int hi
            Component.onCompleted: {
                if(xModel.bi===0){
                    let obj=c1.createObject(xModel, {hi: xModel.hi})
                }else{
                    let obj=c2.createObject(xModel, {hi: xModel.hi})
                }
            }
        }
    }
    Component{
        id: c1
        Node{
            id: n
            rotation: Qt.vector3d(0, 0, 0)
            position: Qt.vector3d(0-zm.d+150, 0, 0)
            property int hi
            property real s: 1.5
            Model {
                source: "#Sphere"
                scale: Qt.vector3d(n.s-0.06, n.s-0.06, n.s-0.06)
                materials:DefaultMaterial{
                    diffuseColor: 'yellow'
                }
            }
            Model {
                source: "#Sphere"
                scale: Qt.vector3d(n.s-0.05, n.s-0.05, n.s-0.05)

                pickable: true
                property bool isPicked: false
                onIsPickedChanged: {
                    if(isPicked){
                        zm.chi=n.hi
                    }else{
                        zm.chi=-1
                    }
                }
                materials: [
                    PrincipledMaterial {
                        specularAmount: 0.0 //De 0.0 a 1.0
                        indexOfRefraction: 0.0//De 1.0 3.0
                        opacity: 0.5
                        baseColorMap: Texture {source: "imgs/sol/basecolor1.jpg"}
                        //Metalizar
                        metalness: 0.1 //De 0.0 a 1.0
                        metalnessMap: Texture { source: "imgs/sol/metallic.jpg" }//Metalicidad
                        //Arrugar
                        roughnessMap: Texture { source: "maps/metallic/roughness.jpg" }//Rugosidad
                        roughness: 0.0 //De 0.0 a 1.0

                        //normalMap: Texture { source: "imgs/sol/normal.jpg" }//Piel de fondo
                    }
                ]
                SequentialAnimation on rotation {
                    loops: Animation.Infinite
                    running: true
                    PropertyAnimation {
                        duration: 30000
                        to: Qt.vector3d(0, 360, 0)
                        from: Qt.vector3d(360, 0, 0)
                    }
                }
            }
            Model {
                source: "#Sphere"
                scale: Qt.vector3d(n.s, n.s, n.s)
                materials: [
                    PrincipledMaterial {
                        specularAmount: 0.0 //De 0.0 a 1.0
                        indexOfRefraction: 0.0//De 1.0 3.0
                        opacity: 0.5
                        baseColorMap: Texture {source: "imgs/sol/basecolor2.jpg"}
                        //Metalizar
                        metalness: 0.1 //De 0.0 a 1.0
                        metalnessMap: Texture { source: "imgs/sol/metallic.jpg" }//Metalicidad
                        //Arrugar
                        roughnessMap: Texture { source: "maps/metallic/roughness.jpg" }//Rugosidad
                        roughness: 0.0 //De 0.0 a 1.0

                        //normalMap: Texture { source: "imgs/sol/normal.jpg" }

                    }
                ]
                SequentialAnimation on rotation {
                    loops: Animation.Infinite
                    running: true
                    PropertyAnimation {
                        duration: 30000
                        to: Qt.vector3d(360, 0, 0)
                        from: Qt.vector3d(0, 360, 0)
                    }
                }
            }
        }
    }
    Component{
        id: c2
        Model {
            source: "#Sphere"
            scale: Qt.vector3d(1.0, 1.0, 1.0)
            position: Qt.vector3d(0-zm.d+150, 0, 0)
            rotation: Qt.vector3d(0, 90, 0)
            materials:DefaultMaterial {
                diffuseColor: "blue"
                specularAmount: 0.0
                indexOfRefraction:0.1
            }
        }
    }

    function load(j){
        for(var i=0;i<nb.children.length;i++){
            nb.children[i].destroy(0)
        }
        let aDegs=[]
        let aIHs=[]
        for(var i=0;i<20;i++){
            let jb=j['c'+parseInt(i)]
            aDegs.push(jb.gdec)
            aIHs.push(jb.ih)
        }
        for(i=0;i<20;i++){
            let obj=compBodie.createObject(nb, {bi: i, hi: aIHs[i]})
            obj.rotation=Qt.vector3d(0, 0, parseFloat(aDegs[i]))
        }
    }
}
