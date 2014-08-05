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
        anchors.fill: parent; anchors.leftMargin: 4 * dp; anchors.topMargin: 20 * dp
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
        anchors { left: parent.left; leftMargin: 4 * dp; right: clear.left; rightMargin: 4* dp; top: parent.top; topMargin:0;bottomMargin:0}
        focus: true
        selectByMouse: true
        height: parent.height
        width: parent.width
        wrapMode: TextInput.Wrap
        maximumLength: 100
    }

    Image {
        id: clear
        anchors { right: parent.right; rightMargin: 4 * dp; top: parent.top; topMargin: 8 * dp }
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
