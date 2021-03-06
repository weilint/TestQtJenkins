import QtQuick 2.0

FocusScope {
    id:combobox

    clip:true
    signal clicked


    property int elementsToShow: 5;
    property string currentText;
    property alias model: elements.model;
    property alias currentIndex: elements.currentIndex;

    property alias hover: markerArea.containsMouse
    property bool pressed: false

    property Component background : defaultbackground
    property Component content : defaultlabel
    property Component delegate : defaultDelegate
    property Component highlight : defaultHighlight

    property string text
    property string icon

    property color backgroundColor: "#fff";

    ListView {
        id: elements;
        anchors.fill: parent;

        clip:true;
        boundsBehavior: "StopAtBounds";
        keyNavigationWraps: true;

        delegate: delegate;
        highlight: highlight;
    }


    // background
    Loader {
        id:backgroundComponent
        anchors.fill:parent
        sourceComponent:background
        opacity: enabled ? 1 : 0.8
    }

    // content
    Loader {
        id:labelComponent        
        anchors.left: parent.left
        anchors.leftMargin: 4 * dp
        anchors.verticalCenter: parent.verticalCenter
        //anchors.centerIn: parent
        sourceComponent:content
    }

    onClicked:{
        list.state == "" ? list.state = "shown" : list.state = "";
        elements.currentIndex = list.lastIndex;
    }

    MouseArea {
        id:markerArea
        enabled: combobox.enabled
        hoverEnabled: true
        anchors.fill: parent
        onPressed: {
            combobox.pressed = true
        }
        onEntered: if(pressed && enabled) combobox.pressed = true  // handles clicks as well
        onExited: {
            combobox.pressed = false
        }

        onReleased: {
            if (combobox.pressed && enabled) { // No click if release outside area
                combobox.pressed  = false
                combobox.clicked()
            }
        }
    }

    Component {
        id:defaultbackground
        Item {

            Rectangle{
                color:backgroundColor
                radius: 0
                x:1
                y:1
                width: parent.width
                height: parent.height
            }

            BorderImage {
                anchors.fill:parent
                id: backgroundimage
                smooth:true
                source: pressed ? "../res/searchbox_focus.png" : "../res/searchbox.png"
                border.left: 4 * dp; border.top: 4 * dp
                border.right: 4 * dp; border.bottom: 4 * dp

                Image{
                    anchors { right: parent.right; rightMargin: 8 * dp; verticalCenter: parent.verticalCenter }
                    width:15 * dp
                    height:15 * dp
                    opacity: enabled ? 1 : 0.3
                    source:"../res/arrow1.png"
                }
            }
        }
    }

    Component {
        id:defaultlabel
        Item {
            width:layout.width
            height:layout.height
            anchors.margins:4 * dp
            Row {
                spacing:6 * dp
                anchors.centerIn:parent
                id:layout
                Image { source:combobox.icon; anchors.verticalCenter:parent.verticalCenter}
                Text {
                    id:label
//                    font:combobox.font
//                    color:combobox.foregroundColor;
                    anchors.verticalCenter: parent.verticalCenter ;
                    text:combobox.text
                    opacity:parent.enabled ? 1 : 0.5
                }
            }
        }
    }

    Component {
        id: defaultDelegate
        Item {
            id: wrapper
            width: background.width;
            height: background.height;

            Row {
                x: 5;
                y: 5;
                spacing: 0 * dp;
                Text {
                    text: content;
                }
                Image {
                    source: icon;
                    anchors.verticalCenter: parent.verticalCenter;
                    height: wrapper.height - 10 * dp;
                }
            }

            function selectItem(index) {
                combobox.current = elements.model.get(index).content;
                list.lastIndex = index;
                list.state = "";
            }

            MouseArea {
                anchors.fill: parent;
                hoverEnabled: true;

                onEntered: {
                    elements.currentIndex = index;
                }
                onClicked: selectItem(index);
            }

            Keys.onPressed: {
                if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                    selectItem(index);
                } else if (event.key === Qt.Key_Escape) {
                    list.state = "";
                }
            }
        }
    }

    Component {
        id: defaultHighlight
        Rectangle {
            color: "#cccccc";
            x:1
            width:parent.width-2 * dp
        }
    }

    Item {
        id: list;
        property int lastIndex;

        opacity: 0;
        height: Math.min(background.height * elements.count,
                         background.height * combobox.elementsToShow);

        anchors.top: background.bottom;
        anchors.left: background.left;
        anchors.right: background.right;

        Component {
            id: delegate
            Item {
                id: wrapper
                width: background.width;
                height: background.height;

                Row {
                    x: 5;
                    y: 5;
                    spacing: 5 * dp;
                    Text {
                        font.pixelSize: mx.fontSize
                        color: mx.fontColor
                        text: content;
                    }
                    Image {
                        source: icon;
                        anchors.verticalCenter: parent.verticalCenter;
                        height: wrapper.height - 10 * dp;
                    }
                }

                function selectItem(index) {
                    combobox.current = elements.model.get(index).content;
                    list.lastIndex = index;
                    list.state = "";
                }

                MouseArea {
                    anchors.fill: parent;
                    hoverEnabled: true;

                    onEntered: {
                        elements.currentIndex = index;
                    }
                    onClicked: selectItem(index);
                }

                Keys.onPressed: {
                    if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                        selectItem(index);
                    } else if (event.key === Qt.Key_Escape) {
                        list.state = "";
                    }
                }
            }
        }
    }
}

