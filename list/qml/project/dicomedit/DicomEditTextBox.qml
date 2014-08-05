import QtQuick 2.0

FocusScope {
    id: focusScope
    property alias text: textInput.text

    BorderImage {
        source: "../res/searchbox.png"
        width: parent.width; height: parent.height
        border { left: 4 * dp; top: 4 * dp; right: 4 * dp; bottom: 4 * dp }
    }

    BorderImage {
        source: "../res/searchbox_focus.png"
        width: parent.width; height: parent.height
        border { left: 4 * dp; top: 4 * dp; right: 4 * dp; bottom: 4 * dp }
        visible: parent.activeFocus ? true : false
    }

    Text {
        id: typeSomething
        anchors.fill: parent; anchors.leftMargin: 4 * dp
        verticalAlignment: Text.AlignVCenter
        color: "gray"
        font.italic: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { focusScope.focus = true; textInput.openSoftwareInputPanel(); }
    }

    TextInput {
        id: textInput
        anchors { topMargin:0;bottomMargin:0; left: parent.left; leftMargin: 4 * dp; right: clear.left; rightMargin: 4 * dp; verticalCenter: parent.verticalCenter }
        focus: true
        selectByMouse: true
        maximumLength: 50
        z:1
    }

    Image {
        id: clear
        anchors { right: parent.right; rightMargin: 8 * dp; verticalCenter: parent.verticalCenter }
        source: "../res/cross6.png"
        opacity: 0
        height: 10 * dp
        width: 10 * dp
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
