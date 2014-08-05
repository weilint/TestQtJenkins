import QtQuick 2.0

FocusScope {
    id: focusScope
    width: 300; height: 55
    property alias text: textInput.text

    BorderImage {
        source: "../res/searchbox.png"
        width: parent.width; height: parent.height
        border { left: 4; top: 4; right: 4; bottom: 4 }
    }

    BorderImage {
        source: "../res/searchbox_focus.png"
        width: parent.width; height: parent.height
        border { left: 4; top: 4; right: 4; bottom: 4 }
        visible: parent.activeFocus ? true : false
    }

    Text {
        id: typeSomething
        anchors.fill: parent; anchors.leftMargin: 8; anchors.topMargin: 20
        //verticalAlignment: Text.AlignTop
        color: "gray"
        font.italic: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { focusScope.focus = true; textInput.openSoftwareInputPanel(); }
    }

    TextInput {
        id: textInput
        anchors { left: parent.left; leftMargin: 8; right: clear.left; rightMargin: 8; top: parent.top; topMargin: 5}
        focus: true
        selectByMouse: true
        height: parent.height
        width: parent.width
        wrapMode: TextInput.Wrap
        maximumLength: 62
    }

    Image {
        id: clear
        anchors { right: parent.right; rightMargin: 8; top: parent.top; topMargin: 8 }
        source: "../res/cross6.png"
        opacity: 0
        height: 10
        width: 10
        MouseArea {
            anchors.fill: parent
            onClicked: { textInput.text = ''; focusScope.focus = true; textInput.openSoftwareInputPanel(); }
        }
    }

    states: State {
        name: "hasText"; when: textInput.text != ''
        PropertyChanges { target: typeSomething; opacity: 0 }
        PropertyChanges { target: clear; opacity: 1 }
    }

    transitions: [
        Transition {
            from: ""; to: "hasText"
            NumberAnimation { exclude: typeSomething; properties: "opacity" }
        },
        Transition {
            from: "hasText"; to: ""
            NumberAnimation { properties: "opacity" }
        }
    ]
}
