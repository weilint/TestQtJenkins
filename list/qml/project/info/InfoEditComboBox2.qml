import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1

ComboBox {
    id: root
    width: 300 * dp
    implicitHeight: 28 * dp

    //editable: true
    property alias mymodel: root.model

    function getIndex(input){
        if (model.indexOf(input) >= 0)
            return model.indexOf(input);
        else {
            console.debug("getIndex: no value found " + input);
            console.debug("length = " + mymodel.length);
            mymodel.push(input);
            console.debug("done " + mymodel.length);
            return mymodel.length;
        }
    }

//    MouseArea {
//        anchors.fill: parent
//        onDoubleClicked: {
//            root.editable = true;
//            //root.focus = true;
//        }
//    }

//    onEditableChanged:
//    {

//    }

    TextInput {
        id: textInput
        anchors { left: parent.left; leftMargin: 8; rightMargin: 8; verticalCenter: parent.verticalCenter }
        focus: true
        selectByMouse: true
        maximumLength: 40
        z:1
    }

    style: ComboBoxStyle {
        background: Rectangle{

            anchors.fill: parent

            BorderImage {
                anchors.fill: parent
                border { left: 4 * dp; top: 4 * dp; right: 4 * dp; bottom: 4 * dp }
                source: "../res/searchbox.png"

                Image{
                    id: buttonimg
                    anchors.bottom:parent.bottom;
                    anchors.right: parent.right
                    anchors.bottomMargin: 5 * dp
                    anchors.rightMargin: 7 * dp
                    anchors.topMargin: 2 * dp
                    width:15 * dp
                    height:15 * dp
                    opacity: enabled ? 1 : 0.3
                    source:"../res/arrow1.png"
                }
            }
        }

    }
}
