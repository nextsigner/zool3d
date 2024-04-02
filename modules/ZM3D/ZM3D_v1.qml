import QtQuick 2.0
import QtQuick 2.14
import QtQuick3D 1.14
import ZM3D.ZM3DSignCircle 1.0
import ZM3D.ZM3DHousesCircle.ZM3DHouse 1.0

Node{
    id: r
    property int d: 1000
    property real currentSignRot: 0
    ZM3DSignCircle{
        rotation.z:0-currentSignRot
    }
    ZM3DHouse{}
}
