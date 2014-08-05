import QtQuick 2.1
import "../share"

ListView {
    id: root
    width: parent.width
    height: parent.height
    focus: true
    clip: true
    highlightFollowsCurrentItem: true
    highlightMoveDuration: 0


    highlight: Rectangle {
        color: "royalblue"          // "#366BDA"
        y: root.currentItem.y
        visible: true
        //Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
        //Behavior on y { NumberAnimation { easing.type: Easing.OutElastic; duration: 2000 } }
    }

        ScrollBar {
            scrollArea: parent
            height: root.height
            width: 8 * dp
            anchors.right: root.right
        }
}
