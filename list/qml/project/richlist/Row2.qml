import QtQuick 2.1
//import "InternalFunc.js" as Func

// 2行＋サムネール

Rectangle {

    // --- Interface ----------------------------------------------
    // model role: PatientName, StudyDate etc
    property variant dataModel: studyListModel
    property int currentIndex: 0
    signal clicked(int index)
    // ------------------------------------------------------------

    InternalListView {
        id: internallist2
        model: studyListModel
        delegate: richlistDelegate
    }

    id: root
    width: parent.width; height: parent.height

    function setCurrent(iCurrent)
    {
        ////とりあえず
        internallist2.currentIndex = iCurrent
    }

    //マウスクリックの処理
    function onClickedStudy(iCurrent)
    {
        currentIndex = iCurrent                // 外部に渡すプロパティを更新
        internallist2.currentIndex = iCurrent
        mainWindow.currentStudyIndex = iCurrent

        richListHelper.qmlSetCurrentIndex(iCurrent)
        richListHelper.qmlUpdatePreviewAt(iCurrent, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
        root.clicked(iCurrent)

    }

    //コンテキストメニュー　-----------------------
    ListMenu{
        id: listmenu
    }

    ListMenuMainFolder{
        id: listmenu_mainfolder
    }
    //-------------------------------------



    Component.onCompleted: {
        //カレントをセットする
        onClickedStudy(0)
    }


    Component {
        id: richlistDelegate

        Item {
            id: richlistItem
            width: parent.width
            height: childrenRect.height

            Column {
                id: itemColumn
                spacing: 1 * dp                                             // 縦方向間隔

                Row {
                    Column {
                        spacing: itemColumn.spacing

                        Row {
                            Text {
                                width: richlistItem.width * 0.4                 // 全幅の40％
                                font.bold: true
                                elide: Text.ElideRight
                                //color: Func.textColor(index, richlistItem.ListView.view.currentIndex)
                                text: patientName;
                            }

                            Text {
                                width: richlistItem.width * 0.4                 // 全幅の40％
                                elide: Text.ElideRight
                                color: {
                                    if(index === richlistItem.ListView.view.currentIndex) return "white"
                                    return "#4979FF"
                                }
                                text: {
                                    var yyyymmdd = studyDate.substr(0,4)
                                            + "/" + studyDate.substr(4,2)
                                            + "/" + studyDate.substr(6,2)
                                    return yyyymmdd
                                }
                            }
                        }

                        Row{
                            Text {
                                width: richlistItem.width * 0.6                     // 全幅の60％
                                //color: Func.textColor(index, richlistItem.ListView.view.currentIndex)
                                elide: Text.ElideRight
                                text: modality + ": " + bodyPart
                            }
                            Text {
                                width: richlistItem.width * 0.2                     // 全幅の20％
                                //color: Func.textColor(index, richlistItem.ListView.view.currentIndex)
                                elide: Text.ElideRight
                                text: seriesImageNumber
                            }
                        }
                    }
                    
                    Image {
                        width: Math.min(richlistItem.width * 0.2, richlistItem.height)  // 全幅の20％
                        height: width
                        y:4 * dp
                        source:sampleImage;
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

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: {
                    //マウスクリックの処理
                    onClickedStudy(index)

                    if(mouse.button === Qt.RightButton){
                        console.debug("mouse.button === Qt.RightButton")
                        //listmenu.visible=true
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
    }
}

