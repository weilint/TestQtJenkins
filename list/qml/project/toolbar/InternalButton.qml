import QtQuick 2.1
import QtQuick.Controls 1.0

Rectangle {

    property string imageSource
    property string title

    id: root
    color: "transparent"
    border.width: 1 * dp
    border.color: "transparent"

    signal clicked()

    Image {
        id: image
        // y: 8
        width:  32 * dp  //44   // 50
        height: 32 * dp  //44  // 50
        smooth: true
        anchors.horizontalCenter: root.horizontalCenter
        source: imageSource
    }

    Text {
        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: parent.bottom
        text: title
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            root.border.color = "gray"
        }
        onExited: {
            root.border.color = "transparent"
        }

        onClicked: {
            root.clicked()
        }

    }
}
