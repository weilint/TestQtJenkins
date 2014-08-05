import QtQuick 2.0
import QtQuick.Controls 1.0
import "../share"

Component {

Rectangle {    
    id:container2
    anchors.fill: parent
    Rectangle {
        id: sendinforect
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 20 * dp

        Text {
            id: patientinfotext
            text: exportwin.exportpatient + " → " + exportwin.exportsend
            anchors.top: parent.top
        }

        Rectangle {
            id: studyrect
            anchors.top:  patientinfotext.bottom
            anchors.left: parent.left
            width: parent.width - exportdetailsrect.width
            height: parent.height - patientinfotext.height

            CheckBox {
                id: allstudychkbox
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 10 * dp
                text: "すべての検査を表示"
            }

//            ScrollView {
//                id: scrollview1
//                width: parent.width
//                height: studyrect.height - allstudychkbox.height - exportbuttonrect.height
//                anchors.top: allstudychkbox.bottom
//                anchors.left: parent.left

                Rectangle {
                    id: exportgrid
                    //color: "#303030"
                    width: parent.width
                    height: studyrect.height - allstudychkbox.height - exportbuttonrect.height
                    anchors.top: allstudychkbox.bottom
                    anchors.topMargin: 10 * dp


                    function checkbyModality(modality, checked){
                        console.debug("checked by modality = " + checked.toString())
                    }

                    Item
                    {
                        id: griditem

                        Rectangle
                        {
                            id:blankrect
                            //color:  "#303030"
                            color: "LightCyan"
                            width: 120 * dp
                            height: 30 * dp
                            anchors.top: parent.top
                            anchors.left: parent.left
                            border.color: "gray"
                            border.width: 0.5
                            CheckBox {
                                id: gridallchkbox
                                anchors.centerIn: parent
                            }
                        }

                        Item {
                            id: studydatelist
                            width: studydategrid.width
                            //height: childrenRect.height
                            height: studydategrid.height
                            anchors.top: blankrect.bottom
                            anchors.left: parent.right


                            Grid {
                                id: studydategrid
                                rows: exportStudyDateList.length
                                //spacing: 10

                                Repeater {
                                    model: exportStudyDateList.length

                                    Rectangle {
                                        color: "LightCyan"
                                        //color: "LemonChiffon"
                                        width: 120 * dp
                                        height: 90 * dp
                                        border.color: "gray"
                                        border.width: 0.5

                                        CheckBox {
                                            id: studydatechkbox
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: exportStudyDateList[index]
                                        }
                                    }
                                }
                            }
                        }

                        Item {
                            id: modalitylist
                            anchors.left: blankrect.right
                            anchors.top : parent.top
                            //width: parent.width
                            //height: childrenRect.height
                            width: modalitygrid.width
                            height: modalitygrid.height
                            Grid {
                                id: modalitygrid
                                columns: exportModalityList.length
                                //spacing: 10

                                Repeater {
                                    model: exportModalityList.length

                                    Rectangle {
                                        //color: "LemonChiffon"
                                        color: "LightCyan"
                                        width: 140 * dp
                                        height: 30 * dp
                                        border.color: "gray"
                                        border.width: 0.5

                                        CheckBox {
                                            id: modalitychkbox
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: exportModalityList[index]                                            
                                            onCheckedChanged: {
                                                exportHelper.qmlCheckModality(exportModalityList[index], checked);
                                                //exportgrid.checkbyModality(exportModalityList[index], checked)
//                                                for (var i = 0; i<exportDisplayList.length; i++){
//                                                    console.debug("index " + i.toString() + ":" + exportDisplayList[i].isSelected);
//                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Item {
                            anchors.left: studydatelist.right
                            anchors.top: modalitylist.bottom

                            width: modalitylist.width
                            height: studydatelist.height

                            Grid {
                                id: datagrid
                                columns: exportModalityList.length
                                rows: exportStudyDateList.length

                                Repeater
                                {
                                    id: myrepeater
                                    model: exportModalityList.length * exportStudyDateList.length

                                    Rectangle {
                                        width: 140 * dp
                                        height: 90 * dp
                                        border.color: "gray"
                                        border.width: 0.5

                                        Rectangle {
                                            id: textrect
                                            anchors.left: parent.left
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.top: parent.top
                                            anchors.topMargin: 8 * dp
                                            anchors.leftMargin: 5 * dp
                                            //anchors.Margin: 10
                                            width: parent.width - thumbnail.width
                                            height: parent.height

                                            Column {
                                                CheckBox {
                                                    id: partchkbox
                                                    text: exportDisplayList[index].bodyPart
                                                    checked: exportDisplayList[index].isSelected
                                                    visible: {
                                                        if (text !== "") {
                                                            return true
                                                        }
                                                        else
                                                            return false
                                                    }
                                                    anchors.top: parent.top
                                                }
                                                Label {
                                                    id: numserieslabel
                                                    text: exportDisplayList[index].numSeries
                                                    anchors.top: partchkbox.bottom
                                                }
                                                Label {
                                                    id: numimglabel
                                                    text: exportDisplayList[index].numImg
                                                    anchors.top: numserieslabel.bottom
                                                }
                                            }
                                        }

                                        Image {
                                            id: thumbnail
                                            anchors.right: parent.right
                                            anchors.top: parent.top
                                            anchors.margins: 5 * dp
                                            width: 60 * dp
                                            height: 60 * dp
                                            source:exportDisplayList[index].imgSource
                                        }
                                    }
                                }
                            }
                        }
                    }
            }

            Rectangle {
                id: exportbuttonrect
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10 * dp
                width: parent.width
                height: 80 * dp

                Label {
                    id: exportlabel
                    anchors.left: parent.left
                    anchors.leftMargin: 10 * dp
                    text: "エクスポート先："
                    anchors.verticalCenter: parent.verticalCenter
                }

                ComboBox {
                    id: exportcombobox
                    anchors.left: exportlabel.right
                    anchors.leftMargin: 10 * dp
                    anchors.verticalCenter: parent.verticalCenter
                    model: [ "CD/DVD" ]
                }

                Button {
                    id: exportbtn
                    text: "エクスポート"
                    width: 120 * dp
                    height: 40 * dp
                    anchors.right: parent.right
                    anchors.rightMargin: 10 * dp
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
                        exportwin.visible= false
                    }
                }
            }
        }

        Rectangle {
            id: exportdetailsrect
            anchors.top: studyrect.top
            anchors.right: parent.right
            //color: "green"
            width: 150 * dp
            height: parent.height - patientinfotext.height


            Text {
                id: detailstxt
                text: qsTr("▶ エクスポート詳細")
                anchors.top: parent.top
                anchors.topMargin: 50 * dp
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

}
}
