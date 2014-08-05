import QtQuick 2.0

Rectangle {
    id: clone
    height: listviewitemrect.height
    width: listviewitemrect.width
    color: "cyan"
    //visible: false
    opacity: 0.8
    Drag.active: mouseArea.drag.active
    Drag.hotSpot.x: width/2
    Drag.hotSpot.y: height/2
    states: State {
        when: mouseArea.drag.active
        ParentChange { target: clone; parent: root.parent }
        AnchorChanges { target: clone; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
    }

    Column {
        id: cloneColumnText
        x: 8 * dp
        Text {
            width: studyDateText.width
            color: "black"
            text: studyDateText.text
        }

        Text {
            width: modalitypartText.width
            color: "black"
            text: modalitypartText.text
        }

        Text {
            id: cloneseriesImageNumberText
            width: seriesImageNumberText.width
            color: "black"
            text:seriesImageNumberText.text
        }
    }

    Image {
        width: 55 * dp   // Math.min(richlistItem.width * 0.4, richlistItem.height)  // 全幅の40％
        height: 55 * dp  // width
        y:2 * dp
        anchors.left: cloneColumnText.right
        anchors.leftMargin: 4 * dp
        source:sampleImage;
    }
}
