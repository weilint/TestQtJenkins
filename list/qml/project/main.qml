import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Controls.Private 1.0
import StudyListLibrary 1.0
import StudyObjectLibrary 1.0

import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

import "folder"
import "richlist" as RichList
import "multislice"
import "toolbar"
import "dicomedit"
import "timeline"
import "info"
import "publisher"


ApplicationWindow {

    id: mainWindow
    title: qsTr("AOC7")

    width: 1280 * dp
    height: 720 * dp
    minimumWidth: 800 * dp
    minimumHeight: 400 * dp

    // ----------------------------------------
    // 表示
    // ----------------------------------------
    Column {
        id: root
        width: parent.width
        height: parent.height

        // ツールバー
        ToolBar {
            id: toolArea
            width: root.width
            height: 80 * dp                                  // ツールバー高さ
            // border.color: "gray"
            // border.width: 1

            gradient: Gradient {
                GradientStop { position: 0.0; color: "white" }
                GradientStop { position: 0.7; color: "lightgray" }
                GradientStop { position: 1.0; color: "darkgray" }
            }
        }

        Row {
            id: screenArea
            width: root.width
            height: parent.height - toolArea.height

            // フォルダーエリア
            Rectangle {
                id: folderArea
                width: 200 * dp                              // フォルダ幅
                height: screenArea.height
                color: "#F6F6F6"

                // フォルダ画面
                Folder {
                    id: folder
                    width: folderArea.width
                    height: folderArea.height * 0.7
                    color: "#F6F6F6"
                    // dataModel: folderModel
                }

                // 境界線
                Rectangle {
                    anchors.top: folder.bottom
                    height: 1 * dp
                    x: 8 * dp
                    width:parent.width - 16 * dp
                    color: "#cccccc"
                }

                Column {
                    id: mycolumn
                    anchors.top: folder.bottom
                    Text {
                        //height: 20
                        //anchors.top: folder.bottom
                        x: 8 * dp
                        text: qsTr("AOC7の動作状況")
                    }

//                    Text {
//                        //anchors.top: folder.bottom
//                        color: "royalblue"
//                        x: 8 * dp
//                        text: qsTr("表示中の患者(debug)")
//                    }

//                    Text {
//                        //anchors.top: folder.bottom
//                        color: "royalblue"
//                        x: 8 * dp
//                        text: richListCurrentStudy.patientID + " " + richListCurrentStudy.patientName
//                    }

                }
                Rectangle
                {
                    id: sendingstatus
                    width: folderArea.width
                    visible: false
                    x:8 * dp
                    anchors.top: mycolumn.bottom
                    anchors.topMargin: 10 * dp
                    Text {
                        width: folderArea.width
                        wrapMode: Text.WordWrap
                        color: "blue"
                        text: "患者[" + richlist.sentPatientId + "]の検査を送信しました。"
                    }

                    onVisibleChanged:
                    {
                        if (visible === true)
                        {
                            animation.start()
                        }
                    }
                    PropertyAnimation { id: animation; target: sendingstatus; property: "opacity"; to: 0; duration:3000; }

                }
            }

            // パブリッシャーキュー            
            PublisherQueue {
                id: publishshertArea
                visible: bPublisherSelected
                width: screenArea.width - folderArea.width    // パブリッシャーキュー幅
                height: screenArea.height
                border.width: 1 * dp
                border.color: "gray"
            }

            // リッチリストエリア
            Column {
                id: richlistArea
                width: 250 * dp                              // リッチリスト幅
                height: screenArea.height
                visible: !bPublisherSelected


                /*
                Rectangle {
                    width: richlistArea.width
                    height: 16
                    ToolButton {
                        anchors.right: parent.right
                        smooth: true
                        width: 16; height: 16
                        iconSource: "res/button_plus.png"
                    }
                }
                */

                // 並べ替えコンボボックス
                ComboBox {
                    id: richlistCombobox
                    width: richlistArea.width
                    model: [ qsTr("患者IDで並べ替え"), qsTr("検査日で並べ替え"), qsTr("到着日時で並べ替え"), qsTr("フラグで並べ替え")]

                    onCurrentIndexChanged: {
                        //mainWindow.qmlEditTestSignal(0,qsTr("test"))
                        //mainWindow(study)
                        richListHelper.qmlSortStudyList(currentIndex)  //ソートキー

                        //------------
                        //ソート後のcurrentIndexを適切に反映すべき  未実装
                        richListHelper.qmlSetCurrentIndex(0);
                        mainWindow.currentStudyIndex = 0
                        richListHelper.qmlUpdatePreviewAt(0, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
                        //-----------
                        currentSortKeyIndex = richlistCombobox.currentIndex
                        setSelectedStudy()

                        //-----------------------
                        //一時的にこうする
                        if(richlist.visible) {
                            row2list.onClickedStudy(0)
                        }
                        if(row2list.visible) {
                            richlist.onClickedStudy(0)
                        }
                        //------------------------

                        //-----------
                    }
                    style:isTouch ? comboboxStyleTouchStudySort : comboboxStyle

                 }
                // リッチリスト
                RichList.Row4Section {
                    id: richlist
                    width: richlistArea.width
                    height: richlistArea.height - richlistCombobox.height
                    border.color: "lightgray"
                    border.width: 1 * dp
                    visible: richlistCombobox.currentIndex == 0? true:false

                    // dataModel: richlistModel
                }

                //2行
                RichList.StudySection {
                    id: row2list
                    width: richlistArea.width
                    height: richlistArea.height - richlistCombobox.height
                    border.color: "lightgray"
                    border.width: 1 * dp
                    visible: richlistCombobox.currentIndex == 1? true:false

                    // dataModel: richlistModel
                }
            }

            // タブエリア
            TabView {
                id: tabview
                focus:true
                anchors.margins: 50 * dp
                height: screenArea.height
                width: screenArea.width - richlistArea.width - folderArea.width
                visible: !bPublisherSelected

                Tab {
                    title: qsTr("プレビュー")
                    MultiSlice { }
                }
                Tab {
                    title: qsTr("マトリックスビュー")
                    Timeline { }                    
                }
                Tab {
                    title: qsTr("情報")
                    //Info { }
                    InfoEdit{}
                }
                Tab {
                    title: qsTr("DICOM")
                    DicomEdit { }
                }
                style:isTouch ? tabViewStyleTouch : tabViewStyle
            }
        }
    }
    property Component comboboxStyle:ComboBoxStyle{
    }
    property Component comboboxStyleTouchStudySort: ComboBoxStyle {
        background: Rectangle {
            implicitWidth: 200 * dp
            implicitHeight: 40 * dp
            color: "#FFFFFF"
            border.width: 1 * dp
            border.color: !control.enabled ? "#DADAD9" : control.activeFocus ? "#3C3C3B" : "#9D9C9C"
            antialiasing: true
            Rectangle {
                id: glyph
                width: 20 * dp
                height: 20 * dp
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10 * dp
                //color: !control.enabled ? "#DADAD9" : control.hovered ? "#1D5086" : "#5791CD"
                states: State {
                    name: "inverted"
                    when: __popup.__popupVisible
                    PropertyChanges { target: glyph; rotation: 180 }
                }
                transitions: Transition {
                    RotationAnimation { duration: 50; direction: RotationAnimation.Clockwise }
                }
                Image {
                    id: imageItem
                    width: 20 * dp
                    height: 20 * dp
                    source: "res/arrow1.png"
                }
            }
        }
        label: {
            implicitHeight: 40*dp
        }
    }
    property Component comboboxStyleTouchMag: ComboBoxStyle {
        background: Rectangle {
            implicitWidth: 200 * dp
            implicitHeight: 25 * dp
            color: "#FFFFFF"
            border.width: 1 * dp
            border.color: !control.enabled ? "#DADAD9" : control.activeFocus ? "#3C3C3B" : "#9D9C9C"
            antialiasing: true
            Rectangle {
                id: glyph1
                width: 15 * dp
                height: 15 * dp
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5 * dp
                //color: !control.enabled ? "#DADAD9" : control.hovered ? "#1D5086" : "#5791CD"
                states: State {
                    name: "inverted"
                    when: __popup.__popupVisible
                    PropertyChanges { target: glyph1; rotation: 180 }
                }
                transitions: Transition {
                    RotationAnimation { duration: 50; direction: RotationAnimation.Clockwise }
                }
                Image {
                    id: imageItem1
                    width: 15 * dp
                    height: 15 * dp
                    source: "res/arrow1.png"
                }
            }
        }
        label: {
            implicitHeight: 25*dp
        }
    }
    property Component tabViewStyle: TabViewStyle {
    }
    property Component tabViewStyleTouch: TabViewStyle {
        frameOverlap: 1
        tab: Rectangle {
            color: styleData.selected ? "steelblue" :"lightsteelblue"
            border.color:  "steelblue"
            implicitWidth: Math.max(text.width + 12 * dp, 120 * dp)
            implicitHeight: 40 * dp
            radius: 2 * dp
            Text {
                id: text
                anchors.centerIn: parent
                text: styleData.title
                color: styleData.selected ? "white" : "black"
            }
        }
        frame: Rectangle { color: "steelblue" }
    }

    // ----------------------------------------
    // C++へ送るSIGNAL
    // ----------------------------------------
    signal qmlEditTestSignal(int index, string value)

    // ----------------------------------------
    // ++グローバルプロパティ
    // ----------------------------------------
    property int  currentFolderIndex: 0
    property int  currentSortKeyIndex: 0
    property int  currentStudyIndex: 0

    property bool bPublisherSelected: false

    function setSelectedStudy()
    {
        //-----------
        if(richlist.visible) {
            richlist.setCurrent(mainWindow.currentStudyIndex)
            //richlist.update()
        }
        if(row2list.visible) {
            row2list.setCurrent(mainWindow.currentStudyIndex)
            //row2list.update()
        }
        //-------------
    }

    function setSearchKey(searckkey)
    {
        toolArea.searchbox_text=searckkey
    }

}
