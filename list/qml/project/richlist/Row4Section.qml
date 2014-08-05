import QtQuick 2.1
import QtQuick.Controls 1.0

import StudyListLibrary 1.0
import StudyObjectLibrary 1.0
import EditInfoLibrary 1.0
import SeriesLisLibrary 1.0
import ImageListLibrary 1.0
import QtQuick 2.2
import QtQuick.Dialogs 1.1

Rectangle {

    // --- Interface ----------------------------------------------
    // model role: PatientName, StudyDate etc
    //property variant dataModel: DataMode{}
    property variant dataModel: studyListModel
    property int currentIndex: 0
    signal clicked(int index)
    property string sentPatientId

    // --- InternalListView.qml が参照しているプロパティ ---
    property string selectedPatientName                     // 同一 PatientID識別用
    // ------------------------------------------------------------


    function setCurrent(iCurrent)
    {
        //とりあえず
        internallist.currentIndex = mainWindow.currentStudyIndex
        currentIndex=mainWindow.currentStudyIndex
        selectedPatientName = richListHelper.qmlGetPatientIDAt(currentIndex)
    }


    //マウスクリックの処理
    function onClickedStudy(iCurrent)
    {
        internallist.currentIndex = iCurrent
        currentIndex = iCurrent               // 外部に渡すプロパティを更新
        mainWindow.currentStudyIndex = iCurrent

        richListHelper.qmlSetCurrentIndex(iCurrent);
        selectedPatientName = richListHelper.qmlGetPatientIDAt(iCurrent)  //　同一PatientID識別用

        richListHelper.qmlUpdatePreviewAt(iCurrent, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )

        mainWindow.setSelectedStudy(iCurrent)

        root.clicked(iCurrent)
    }

    //コンテキストメニュー　-----------------------
    ListMenu{
        id: listmenu
    }

    ListMenuMainFolder{
        id: listmenu_mainfolder
    }
    // -----------------------------------


    InternalListView {
        id: internallist
        //model: dataModel
        model:studyListModel
        delegate: richlistDelegate

        // セクション
        //section.property: "PatientName"
        section.property: "patientSection"
	    section.criteria: ViewSection.FullString
	    section.labelPositioning: ViewSection.CurrentLabelAtStart + ViewSection.InlineLabels

	    section.delegate:
            Rectangle {
                width: parent.width
                height: childrenRect.height
                color: "navy"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 4 * dp
                    color: "white"
                    text: section.split("^")[0]        // 患者ID
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    font.bold: true
                    text: section.split("^")[1]         // 患者名
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 6 * dp     // 4
                    color: "white"
                    text: section.split("^")[2]         // 性別、年齢
                }
            }
    }

    Component.onCompleted: {
            console.debug("onCompleted ")
            //mainWindow.studyListView.currentItem.y = 243
            onClickedStudy(0)
    }

    id: root
    width: parent.width; height: parent.height


    Component {
        id: richlistDelegate

        Item {
            id: richlistItem
            width: parent.width
            height: itemColumn.height
            //height: childrenRect.height

            Column {
                id: itemColumn
                // spacing: 4                                              // 縦方向間隔

                Rectangle {
                    id: listviewitemrect
                    width: richlistItem.width;
                    height: columnText.height;

                    // 背景色
                    color: {//
                        if(currentIndex == index)
                        {
                            console.debug("## index=" + index + " currentIndex=" + currentIndex)
                            return "transparent"             // クリック項目ならハイライターを有効化
                        }
                        if(selectedPatientName === patientID) {
                            console.debug("## selectedPatientName=" + selectedPatientName)
                            return "lightcyan" // 同一PatientNameが選択されてたら背景色を変える
                        }
                        return "transparent"
                    }

                    Column {
                        id: columnFlag
                        anchors.top: parent.top
                        anchors.topMargin: 3 * dp
                        //x:8
                        Image {
                            width: 15 * dp   // Math.min(richlistItem.width * 0.4, richlistItem.height)  // 全幅の40％
                            height: 15 * dp  // width
                            source: richListHelper.qmlGetFlagIcon(flagid)
                            //source:"../flag/f001.png"
                        }
                    }

                    Column {
                        id: columnText
                        anchors.left: columnFlag.right
                        //x: 8
                        Text {
                            id: studyDateText
                            width: richlistItem.width * 0.7                    // 全幅に対する比率
                            elide: Text.ElideRight
                            color: {
//                                if( (selectedPatientName !== "")
//                                    &&(index === richlistItem.ListView.view.currentIndex)) return "white"
                                if (index === richlistItem.ListView.view.currentIndex)
                                    return "white"
                                else
                                    return  "royalblue"
                            }
                            text: {
                                var yyyymmdd = studyDate.substr(0,4)
                                        + "/" + studyDate.substr(4,2)
                                        + "/" + studyDate.substr(6,2)
                                var hhmm = studyTime.substr(0,2)
                                        + ":" + studyTime.substr(2,2)
                                return yyyymmdd + " " + hhmm
                            }
                        }

                        Text {
                            id: modalitypartText
                            width: richlistItem.width * 0.7                     // 全幅に対する比率
                            elide: Text.ElideRight
                            color: {
                                if( (selectedPatientName !== "")
                                    &&(index === richlistItem.ListView.view.currentIndex)) return "white"
                                return "black"
                            }

                            text: modality + ": " + bodyPart
                        }

                        Text {
                            id: seriesImageNumberText
                            width: richlistItem.width * 0.7                     // 全幅に対する比率
                            elide: Text.ElideRight
                            color: {
                                if( (selectedPatientName !== "")
                                    &&(index === richlistItem.ListView.view.currentIndex)) return "white"
                                return "black"
                            }
                            //text:AccessionNumber
                            text:seriesImageNumber
                        }
                    }

                    Image {
                        id: thumbnail
                        width: 55 * dp   // Math.min(richlistItem.width * 0.4, richlistItem.height)  // 全幅の40％
                        height: 55 * dp  // width
                        y:2
                        //anchors.left: columnText.right
                        anchors.right: parent.right
                        anchors.rightMargin: 3 * dp
                        anchors.leftMargin: 4 * dp
                        source:sampleImage;
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: thumbnail

                        onPressed: {
                            console.debug("onPressAndHold")
                            var component = Qt.createComponent("ListViewItemClone.qml")
                            drag.target = component.createObject(richlistItem)
                        }

                        onReleased:
                        {
                            drag.target.destroy()
                            console.debug("released")
                            if (folder.inImageServer == true)
                            {
                                console.debug("drop action")
                                sendMsg.open()
                            }
                        }
                    }

                    MouseArea {
                        id: studymouseArea
                        anchors.fill: columnText
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        onClicked: {
                            console.debug("onClicked index=" + index)
                            onClickedStudy(index)

                            console.debug("timeline modality = " + timelineModalityList.length)
                            if(mouse.button === Qt.RightButton){
                                console.debug("mouse.button === Qt.RightButton")
                                if(currentFolderIndex == 0) listmenu_mainfolder.popup()
                                else listmenu.popup()
                            }
                        }

                        onDoubleClicked: {
                            console.debug("onDoubleClicked index=" + index)
                            richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex);
                        }
                    }

                }

                Rectangle {
                    id: borderline
                    height: 1 * dp
                    x: 8 * dp
                    width:parent.width - 16 * dp
                    color: "#cccccc"
                }
            }


            MessageDialog {
                id: sendMsg
                title: "送信確認"
                text: {
                    "検査を" + folder.selectedImageServer + "に送信しますか？"
                }
                icon: StandardIcon.Warning
                standardButtons: StandardButton.No | StandardButton.Yes
                onYes: {
                    sentPatientId = richListHelper.qmlGetPatientIDAt(index)
                    sendingstatus.visible = false
                    sendingstatus.opacity = 1
                    sendingstatus.visible = true
                    sendMsg.close()
                }

                onNo: {
                    sendMsg.close()
                }
            }


        }
    }

}

