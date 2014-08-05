import QtQuick 2.0
import QtQuick.Controls 1.0
import "../dicomedit"
import "../share"

Component {

Rectangle {
    id: container
    anchors.fill: parent
    color: "blue"
    property ListModel patDisplayModel: setAllPat()
    property ListModel sendDisplayModel: setAllSend()

    ListModel{
        id: tempPatDisplayModel
    }

    ListModel {
        id: tempSendDisplayModel
    }

    function setAllPat() {
        //var _result = new ListModel({});
        tempPatDisplayModel.clear()
        for (var i=0; i<exportwin.patientDataModel.count; i++)
        {
            //fruitModel.append({"cost": 5.95, "name":"Jackfruit"});
            tempPatDisplayModel.append({"PatientName": exportwin.patientDataModel.get(i).PatientName, "Birth": exportwin.patientDataModel.get(i).Birth});
        }
        return tempPatDisplayModel;
    }

    function searchPat(input) {
        tempPatDisplayModel.clear()
        for (var i=0; i<exportwin.patientDataModel.count; i++)
        {
            var patname = exportwin.patientDataModel.get(i).PatientName;
            var birth = exportwin.patientDataModel.get(i).Birth;
            if (patname.indexOf(input) >= 0 || birth.indexOf(input) >= 0)
            {
                tempPatDisplayModel.append({"PatientName": patname, "Birth": birth});
            }
        }
        return tempPatDisplayModel;
    }

    function setAllSend() {
        tempSendDisplayModel.clear()
        for (var i=0; i<exportwin.sendDataModel.count; i++)
        {
            //fruitModel.append({"cost": 5.95, "name":"Jackfruit"});
            tempSendDisplayModel.append({"Name": exportwin.sendDataModel.get(i).Name});
        }
        return tempSendDisplayModel;
    }

    function searchSend(input) {
        tempSendDisplayModel.clear()
        for (var i=0; i<exportwin.sendDataModel.count; i++)
        {
            var name = exportwin.sendDataModel.get(i).Name;
            if (name.indexOf(input) >= 0)
            {
                tempSendDisplayModel.append({"Name": name});
            }
        }
        return tempSendDisplayModel;
    }

    Rectangle {
        id: patientsearchrect
        width: (parent.width / 2) - 1
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top

        Rectangle {
            id: patientsearchsection
            anchors.top: parent.top
            width: parent.width
            height: 50 * dp
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 20 * dp
            anchors.rightMargin: 20 * dp

            Label {
                id: patientsearchlabel
                text: "患者検索："
                width: 60 * dp
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            DicomEditTextBox {
                id: patientsearchtextbox
                //width: parent.width - patientsearchlabel.width - patientsearchbtn.width - 50
                width: parent.width - patientsearchlabel.width - (50 * dp)
                height: 28 * dp
                anchors.left: patientsearchlabel.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10 * dp

                onTextChanged: {
                    if (text === "")
                    {
                        container.patDisplayModel = setAllPat()
                    }
                    else
                    {
                        container.patDisplayModel = searchPat(text)
                    }
                }
            }

//            Button {
//                id: patientsearchbtn
//                text: "検索"
//                width: 80
//                anchors.right: parent.right
//                anchors.verticalCenter: parent.verticalCenter
//            }

        }


        Rectangle {
            id: patientresultsection
            width: parent.width
            height: parent.height - patientsearchsection.height - patientnewsection.height
            anchors.top: patientsearchsection.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            property int currentIndex: 0

            ListView {
                onCountChanged:
                {
                    if (count == 0)
                    {
                        exportwin.canGoNext = false
                    }
                    else
                    {
                        exportwin.exportpatient = model.get(0).PatientName + " " + model.get(0).Birth
                        exportwin.canGoNext= true
                    }
                }

                id: patientlistview
                width: parent.width
                height: parent.height
                anchors.fill: parent
                anchors.margins: 20 * dp
                //model: PatientDataModel {}
                //model: exportwin.patientDataModel
                model: container.patDisplayModel

                delegate:Component {
                    Item {
                        property variant myData: model
                        width: parent.width
                        height: 50 * dp
                        Column {
                            anchors.fill: parent
                            spacing: 30 * dp
                            Text {
                                id: patienttext
                                text: PatientName
                                //wrapMode: Text.WordWrap
                                width: parent.width - (60 * dp)
                                x: 20 * dp
                                //verticalAlignment: Text.AlignTop
                                y: 5 * dp
                                color: {
                                    if(index === patientlistview.currentIndex) {
                                        return "white"
                                    }
                                    else {
                                        return "black"
                                    }
                                }
                            }
                            Text {
                                text: Birth
                                anchors.top: patienttext.bottom
                                //wrapMode: Text.WordWrap
                                width: parent.width - (60 * dp)
                                x: 20 * dp
                                //verticalAlignment: Text.AlignBottom
                                //y: 8
                                color: {
                                    if(index === patientlistview.currentIndex) {
                                        return "white"
                                    }
                                    else {
                                        return "black"
                                    }
                                }
                            }

                            MouseArea {
                                id: mouse_area1
                                z: 1 * dp
                                hoverEnabled: false
                                anchors.fill: parent
                                onClicked: {
                                    patientlistview.currentIndex = index
                                    //selectedPatient = PatientName
                                    console.debug("current patientname = " + PatientName)
                                    exportwin.exportpatient = PatientName + " " + Birth
                                  }
                            }
                        }
                    }
                }

                highlight: Rectangle {
                    color:"royalblue"
                    radius: 5 * dp
                    y: sendlistview.currentItem.y
                    //focus: true
                }

            }
        }
        Rectangle {
            id: patientnewsection
            width: parent.width
            height: 50 * dp
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50 * dp
            anchors.left: parent.left
            anchors.leftMargin: 20 * dp
            anchors.rightMargin: 20 * dp

            CheckBox {
                id: patientnewchkbox
                text: "新しい患者"
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: patientnewlabel
                text: "患者ID:"
                anchors.left: patientnewchkbox.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10 * dp
            }

            DicomEditTextBox {
                id: patientnewtxtbox
                anchors.left: patientnewlabel.right
                anchors.leftMargin: 10 * dp
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - patientnewchkbox.width - patientnewlabel.width - (50 * dp)
                height: 28 * dp

            }
        }
    }

    Rectangle {
        id: separator
        width: 2
        height: parent.height
        color: "gray"
        anchors.left: patientsearchrect.right
        anchors.top: parent.top
    }

    Rectangle {
        id: sendsearchrect
        width: (parent.width / 2) - 1
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top

        Rectangle {
            id: sendsearchsection
            anchors.top: parent.top
            width: parent.width
            height: 50 * dp
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 20 * dp
            anchors.leftMargin: 20 * dp

            Label {
                id: sendsearchlabel
                text: "送り先検索："
                width: 80 * dp
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
            DicomEditTextBox {
                id: sendsearchtextbox
                //width: parent.width - sendsearchlabel.width - sendsearchbtn.width - 50
                width: parent.width - sendsearchlabel.width - (50 * dp)
                height: 28 * dp
                //width: 180 * dp
                anchors.left: sendsearchlabel.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10 * dp

                onTextChanged: {
                    if (text === "")
                    {
                        container.sendDisplayModel = setAllSend()
                    }
                    else
                    {
                        container.sendDisplayModel = searchSend(text)
                    }
                }
            }



            //            Button {
            //                id: sendsearchbtn
            //                text: "検索"
            //                width: 80
            //                anchors.right: parent.right
            //                anchors.verticalCenter: parent.verticalCenter
            //            }

        }


        Rectangle {
            id: sendresultsection
            width: parent.width
            height: parent.height - sendsearchsection.height - sendnewsection.height
            anchors.top: sendsearchsection.bottom
            anchors.bottom: sendnewsection.top
            anchors.horizontalCenter: parent.horizontalCenter

            ListView {
                onCountChanged:
                {
                    if (count == 0)
                    {
                        exportwin.canGoNext = false
                    }
                    else
                    {
                        exportwin.exportsend = model.get(0).Name
                        exportwin.canGoNext= true
                    }
                }

                id: sendlistview
                width: parent.width
                height: parent.height
                anchors.fill: parent
                anchors.margins: 20 * dp
                clip: true

////                keyNavigationWraps: false
//                 boundsBehavior: Flickable.DragAndOvershootBounds
////                 opacity: 1
////                 maximumFlickVelocity: 2500
////                 contentWidth: 0
////                 preferredHighlightEnd: 2
////                 spacing: 5
////                 highlightRangeMode: ListView.NoHighlightRange
//                 snapMode: ListView.SnapToItem


                //model: InstitutionDataModel {}
                //model: exportwin.sendDataModel
                model: container.sendDisplayModel
                delegate:Component {
                    Item {
                        id: senditem
                        property variant myData: model
                        width: parent.width
                        height: 50 * dp

                        Column {
                            spacing: 10 * dp
                            anchors.fill: senditem
                            Text {
                                text: Name
                                x: 20 * dp
                                y: 18 * dp
                                color: {
                                    if(index === sendlistview.currentIndex) {
                                        return "white"
                                    }
                                    else {
                                        return "black"
                                    }
                                }
                            }

                            MouseArea {
                                id: mouse_area1
                                //z: 1
                                hoverEnabled: false
                                anchors.fill: parent
                                onClicked: {
                                    sendlistview.currentIndex = index
                                    console.debug("height of parent: " + sendlistview.height.toString())
                                    console.debug("height of root: " + container.height.toString())
                                    exportwin.exportsend = Name
                                }
                            }
                        }
                    }
                }

                highlight: Rectangle {
                    color:"royalblue"
                    radius: 5 * dp
                    y: sendlistview.currentItem.y
                    //focus: true
                }

                ScrollBar {
                    scrollArea: sendlistview
                    height: sendlistview.height
                    width: 8 * dp
                    anchors.right: sendlistview.right
                }

            }
        }

        Rectangle {
            id: sendnewsection
            width: parent.width
            height: 50 * dp
           //anchors.top: sendresultsection.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50 * dp
            anchors.left: parent.left
            anchors.leftMargin: 20 * dp
            anchors.rightMargin: 20 * dp

            //color:"yellow"

            CheckBox {
                id: sendnewchkbox
                text: "新しい送り先"
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                id: sendnewlabel
                text: "施設名："
                anchors.left: sendnewchkbox.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10 * dp
            }

            DicomEditTextBox {
                id: sendnewtxtbox
                anchors.left: sendnewlabel.right
                anchors.leftMargin: 10 * dp
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - sendnewchkbox.width - sendnewlabel.width - (50 * dp)
                height: 28 * dp

            }

            Label {
                id: sendnewfuriganalabel
                text: "フリガナ："
                anchors.top: sendnewlabel.bottom
                anchors.topMargin: 8 * dp
                anchors.right: sendnewlabel.right
            }

            DicomEditTextBox {
                id: sendnewfuriganatxtbox
                anchors.top: sendnewtxtbox.bottom
                anchors.left: sendnewtxtbox.left
                width: sendnewtxtbox.width
                height: 28 * dp
            }

            CheckBox {
                id: sendnocheckbox
                anchors.top: sendnewfuriganalabel.bottom
                anchors.left: sendnewchkbox.left
                text: "送り先指定しない"
            }
        }
    }
}

}
