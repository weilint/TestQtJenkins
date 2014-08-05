import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

//ScrollView {
//    width:parent.width
//    height: parent.height
//    implicitHeight: 100
//    implicitWidth: 100

//Flickable {
//   width: parent.width; height: parent.height
//    contentHeight: root.height
//    contentWidth: root.width
    //anchors.fill: parent

Grid {
    id: maingrid
    columns: 1
    rows: 1
    //height: 100
    //width: 100
    //anchors.fill: parent

Rectangle{
    id: root
    //anchors.fill: parent
    //width: 400; height: 300
    //width:whole.width
    //height: whole.height
    //Layout.maximumHeight: 200
    //Layout.maximumWidth: 200
    color: "#303030"

    Item
    {
        id: whole
        //anchors.top: parent.top
        //anchors.left: blankrect.right
        //anchors.right: parent.right
//        anchors.top: blankrect.bottom
//        anchors.left: parent.left
//        anchors.margins: 10
        //anchors.fill: parent

        Rectangle
        {
            id:blankrect
            color:  "#303030"
            width: 120 * dp
            height: 30 * dp
            anchors.top: parent.top
            anchors.left: parent.left
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
                rows: timelineStudyDateList.length
                //spacing: 10

                Repeater {
                    model: timelineStudyDateList.length

                    Rectangle {
                        color: "LightCyan"
                        //color: "LemonChiffon"
                        width: 120 * dp
                        height: 100 * dp
                        border.color: "gray"
                        border.width: 1 * dp

                        function formatDate(input)
                        {
                            if (input !== "" && input.length === 8)
                                return input.substring(0,4) + "/" + input.substring(4,6) + "/" + input.substring(6,8)
                         }

                        Text {
                            color: "#00000C"
                            text: if (timelineStudyDateList[index] === "")
                                      formatDate(timelineStudyDateList[index-1])
                                  else
                                      formatDate(timelineStudyDateList[index])
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
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
                columns: timelineModalityList.length
                //spacing: 10

                Repeater {
                    model: timelineModalityList.length

                    Rectangle {
                        //color: "LemonChiffon"
                        color: "LightCyan"
                        width: 100 * dp
                        height: 30 * dp
                        border.color: "gray"
                        border.width: 1 * dp

                        Text {
                            color: "#00000C"
                            text: timelineModalityList[index]
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }

//        Rectangle {
//            anchors.left: studydatelist.right
//            anchors.top: modalitylist.bottom

//            width: 100
//            height: 100

//            color: "blue"

//        }

        Item {
            anchors.left: studydatelist.right
            anchors.top: modalitylist.bottom

            width: modalitylist.width
            height: studydatelist.height


            Grid {
                id: datagrid
                columns: timelineModalityList.length
                rows: timelineStudyDateList.length
                //spacing: 10

                property var imagelist: new Array;
                function getImageSource(index)
                {
                    var _modalityindex = index%timelineModalityList.length
                    var _studydateindex = ~~(index/timelineModalityList.length)
                    console.debug("modality index = " + _modalityindex + " study date index = " + _studydateindex)
                    if (timelineStudyDateList[_studydateindex] === "")
                    {
                        _studydateindex = _studydateindex - 1;
                    }
                    var result = richListHelper.qmlGetTimeLineImage(timelineModalityList[_modalityindex], timelineStudyDateList[_studydateindex])
//                    if (result !== "")
//                    {
//                        imagelist[imagelist.length + 1] = result;
//                    }
                    return result;
                }

                Repeater
                {
                    model: timelineModalityList.length * timelineStudyDateList.length

                    Rectangle {
                        color: {
                            if (richListCurrentStudy.sampleImage.toString().toLowerCase() === thumbnail.source.toString().toLowerCase())
                            {
                                return "royalblue"
                            }
                            else {
                                console.debug(richListCurrentStudy.sampleImage + " not equal to " + thumbnail.source)
                                return "#303030"
                            }

                        }
                        width: 100 * dp
                        height:100 * dp
                        border.color: "gray"
                        border.width: 0.5 * dp

                        Image {
                            id: thumbnail
                            anchors.centerIn: parent
                            width: 92 * dp
                            height: 92 * dp
                            source: datagrid.getImageSource(index)                            
                        }

                        MouseArea {
                            anchors.fill: thumbnail
                            onDoubleClicked: {
                                richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
                            }
                            onClicked: {
                                var i = richListHelper.qmlGetStudyIndexByImage(thumbnail.source);
                                richListHelper.qmlSetCurrentIndex(i);
                                mainWindow.currentStudyIndex = i;
                                mainWindow.setSelectedStudy();
                                richListHelper.qmlUpdatePreviewAt(i, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex );
                            }
                        }
                    }
                }
            }
        }
    }
    }
//}
}
//}

