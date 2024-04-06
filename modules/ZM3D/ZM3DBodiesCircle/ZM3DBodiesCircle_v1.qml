import QtQuick 2.14
import QtQuick3D 1.14


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
            //position: Qt.vector3d(0, 0, 0)
            //rotation: Qt.vector3d(0, 0, 0)
            property int bi
            Model {
                id: m1
                source: "#Sphere"
                scale: Qt.vector3d(1.0, 1.0, 1.0)
                position: Qt.vector3d(0-zm.d+150, 0, 0)
                rotation: Qt.vector3d(0, 90, 0)
                materials: [
                    DefaultMaterial {
                        id: mat1
                        diffuseColor: 'red'//r.selected?aColors[0]:aColors[1]
                        specularAmount: 100
                        specularRoughness: 100
                        roughnessMap: Texture {
                            id: texture1
                            scaleU: 1.8
                            scaleV: 1.8
                            //positionU: 0.05
                            //positionV: -0.8
                            //rotationUV: 10


                            SequentialAnimation on scaleU {
                                running: !m1.isPicked
                                loops: Animation.Infinite
                                PropertyAnimation {
                                    duration: 5000
                                    from: 0.5
                                    to: 0.8
                                }
                                PropertyAnimation {
                                    duration: 5000
                                    from: 0.8
                                    to: 0.5
                                }
                            }
                            SequentialAnimation on scaleV {
                                running: !m1.isPicked
                                loops: Animation.Infinite
                                PropertyAnimation {
                                    duration: 2500
                                    from: 0.0
                                    to: 1.8
                                }
                                PropertyAnimation {
                                    duration: 2500
                                    from: 1.8
                                    to: 0.0
                                }
                            }
                        }
                    },
                    DefaultMaterial {
                        id: mat2
                        diffuseColor: r.aBdiesColors[xModel.bi]
                        //specularAmount: 50.0
                        opacity: 1.0
                    }
                ]
                //                materials: DefaultMaterial {
                //                    diffuseColor: r.aBdiesColors[xModel.bi]
                //                    //specularAmount: 50.0
                //                    opacity: 1.0
                //                }

                pickable: true
                property bool isPicked: false
                SequentialAnimation on rotation.z {
                    running: !m1.isPicked
                    loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 2500
                        //from: Qt.vector3d(0, 0, 0)
                        //to: Qt.vector3d(360, 360, 360)
                        from: 0
                        to: 360
                    }
                }
            }

            Component.onCompleted: {
                if(xModel.bi===0){
                    m1.scale=Qt.vector3d(2.0, 2.0, 2.0)
                    m1.position.z=m1.position.z+100
                    texture1.source="imgs/sol.png"
                }else{
                    //texture1.source=""
                    mat1.specularAmount=0.0
                    mat1.specularRoughness=0.0
                    mat1.specularMap=0.0
                    mat1.opacity=0.0
                    mat1.visible=false
                    mat1.diffuseColor=r.aBdiesColors[xModel.bi]
                }
            }
        }

    }

    function load(j){
        for(var i=0;i<nb.children.length;i++){
            nb.children[i].destroy(0)
        }
        let aDegs=[]
        for(var i=0;i<20;i++){
            let jb=j['c'+parseInt(i)]
            aDegs.push(jb.gdec)
        }
        for(i=0;i<20;i++){
            let obj=compBodie.createObject(nb, {bi: i})
            obj.rotation=Qt.vector3d(0, 0, parseFloat(aDegs[i]))
        }
    }
}
