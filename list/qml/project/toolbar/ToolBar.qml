import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Window 2.0
import "../export" as Export

Rectangle {
    id: root

    property alias searchbox_text: searchbox.text
    property var exportWindow: Export.Export { }

//    ListModel {
//        id: flagmodel
//        ListElement {flagid: "flag001"; flagicon: "../flag/f001.png" }
//        ListElement {flagid: "flag002"; flagicon: "../flag/f002.png" }
//        ListElement {flagid: "flag003"; flagicon: "../flag/f003.png" }
//    }


    // ----------------------------------------
    // 左領域
    // ----------------------------------------
    Rectangle {
        // id: rectLeftArea
        width: rowLeftGroup.width
        height: rowLeftGroup.height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 20 * dp
        color: "transparent"

        Row {
            id: rowLeftGroup
            spacing: 8 * dp

            // 表示ボタン
            Column {
                ToolButton {
                    id: viewButtonIcon
                    iconSource: "../res/button_layout1.png"
                }
                Text {
                    text: "表示"
                }
            }

            // 拡大/縮小コンボボックス
            Column {
                ComboBox {
                    width: 90 * dp                       // コンボボックス幅
                    editable: true
                    currentIndex: 1
                    model: [ qsTr("75%"), qsTr("100%"), qsTr("125%") ]
                    style:isTouch ? comboboxStyleTouchMag : comboboxStyle
                }

                Text {
                    y: viewButtonIcon.height
                    text: "拡大/縮小"
                }
            }
        }
    }

    // ----------------------------------------
    // 中央領域
    // ----------------------------------------
    // センターグループのボタンサイズ
    property int centerButtonWidth: 80 * dp
    property int centerButtonHeight: 50 * dp

    Rectangle {
        id: rectCenterArea
        width: rawCenterGroup.width
        height: rawCenterGroup.height
        anchors.centerIn: parent
        color: "transparent"



        Row {
            id: rawCenterGroup
            spacing: 4 * dp

            InternalButton {
                width: centerButtonWidth
                height: centerButtonHeight
                imageSource: "../res/button_import.png"
                title: qsTr("インポート")
                onClicked: {
                    richListHelper.qmlStartPreludio()
                }
            }

            InternalButton {
                width: centerButtonWidth
                height: centerButtonHeight

                imageSource: "../res/button_export.png"
                title: qsTr("エクスポート")
                //property var exportWindow: Export { }
                onClicked: {
                    //exportWindow.loaderSource = exportWindow.exportfirst;
                    //var win = new Export;


                    //win.show();
                    exportWindow.show();

                    //exportWindow.visible = true;
                    //exportWindow.visible = true
                }
            }

            InternalButton {
                width: centerButtonWidth
                height: centerButtonHeight

                imageSource: "../res/button_viewer.png"
                title: qsTr("ビュー")

                onClicked: {
                    richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
                }
            }

            InternalButton {
                id: flagbtn
                width: centerButtonWidth
                height: centerButtonHeight

                imageSource: "../res/button_flag.png"
                title: qsTr("フラグ")
                onClicked: {
                    //flagmenu.setMenuItems()
                    flagmenu.setFlagItem()
                    flagmenu.popup()
                }

                Menu{
                    id: flagmenu
                    property bool stopevent: false
                    function setFlagItem(){
                        stopevent = true
                        for (var counter1 = 0; counter1 < items.length; counter1++) {
                            if (richListCurrentStudy.flagid === items[counter1].text)
                            {
                                items[counter1].checked = true
                            }
                            else
                            {
                                items[counter1].checked = false
                            }
                        }
                        stopevent = false
                    }
                    function handleFlag(ischecked, flagtext)
                    {
                        console.debug("in handleFlag: " + ischecked + " " + flagtext);
                        if (stopevent == false)
                        {
                            if (flagtext !== "フラグなし")
                            {
                                if (ischecked===false)
                                {
                                    console.debug("remove flag " + flagtext)
                                    richListCurrentStudy.flagid = ""
                                    //                          var newflaglist = richListHelper.qmlRemoveFlag(richListCurrentStudy.flagList, richListCurrentStudy.flagList.indexOf(flagtext))
                                    //                          richListCurrentStudy.flagList = newflaglist
                                }
                                else
                                {
                                    console.debug("add flag " + flagtext)
                                    richListCurrentStudy.flagid = flagtext
                                    //                            var newflaglist1 = richListHelper.qmlAddFlag(richListCurrentStudy.flagList, flagtext)
                                    //                            richListCurrentStudy.flagList = newflaglist1
                                }
                            }
                            else
                            {
                                richListCurrentStudy.flagid = "";
                            }
                        }
                    }
                    MenuItem {
                        id: menuitem1
                        text: "flag001"
                        checkable: true
                        iconSource: "../flag/f001.png"

//                        text: flagid
//                        checkable: true
//                        iconSource: flagicon
                        onCheckedChanged: {
                            flagmenu.handleFlag(checked, text)
                        }
//                        shortcut: "Ctrl+X"
//                        onTriggered: ...
                    }
                    MenuItem {
                        text: "flag002"
                        checkable: true
                        iconSource: "../flag/f002.png"
                        onCheckedChanged: {
                            flagmenu.handleFlag(checked, text)
                        }
                    }
                    MenuItem {
                        text: "flag003"
                        checkable: true
                        iconSource: "../flag/f003.png"
                        onCheckedChanged: {
                            flagmenu.handleFlag(checked, text)
                        }
                    }
                    MenuItem {
                        text: "flag004"
                        checkable: true
                        iconSource: "../flag/f004.png"
                        onCheckedChanged: {
                            flagmenu.handleFlag(checked, text)
                        }
                    }
                    MenuItem {
                        text: "flag005"
                        checkable: true
                        iconSource: "../flag/f005.png"

                        onCheckedChanged: {
                            flagmenu.handleFlag(checked, text)
                        }
                    }
//                    MenuItem {
//                        text: "flag006"
//                        checkable: true
//                        iconSource: "../flag/f006.png"
//                        onCheckedChanged: {
//                            flagmenu.handleFlag(checked, text)
//                        }
//                    }
//                    MenuItem {
//                        text: "flag007"
//                        checkable: true
//                        iconSource: "../flag/f007.png"
//                        onCheckedChanged: {
//                            flagmenu.handleFlag(checked, text)
//                        }
//                    }
//                    MenuItem {
//                        text: "flag008"
//                        checkable: true
//                        iconSource: "../flag/f008.png"
//                        onCheckedChanged: {
//                            flagmenu.handleFlag(checked, text)
//                        }
//                    }

                    MenuItem {
                        id: noflag
                        text: "フラグなし"
                        checkable: false
                        onTriggered: {
                            flagmenu.handleFlag(checked, text)
                        }

//                        checkable: true
//                        iconSource: ""
//                        onCheckableChanged: {
//                            flagmenu.handleFlag(checked, text)
//                        }
//                        MouseArea {
//                            anchors.fill: noflag
//                            onClicked: {
//                                richListCurrentStudy.flagid = "";
//                            }
//                        }

                    }

                    //MenuSeparator { }

                    //Menu {
//                        title: "More Stuff"

//                        MenuItem {
//                            text: "Do Nothing"
//                        }
//                    }
                }

            }

            InternalButton {
                width: centerButtonWidth
                height: centerButtonHeight

                imageSource: "../res/button_command.png"
                title: qsTr("その他")
            }
        }
    }


    // ----------------------------------------
    // 右領域
    // ----------------------------------------
    Rectangle {
        id: rectRightArea
        anchors.right: parent.right
        anchors.rightMargin: 20 * dp
        anchors.bottom: parent.bottom
        height: childrenRect.height
        width : 280 * dp     // 220
        color: "transparent"

        // SearchBox
        InternalSearchBox {
            id: searchbox
            anchors.top: rectRightArea.top
            anchors.right: rectRightArea.right
            width : rectRightArea.width
            Keys.onReturnPressed: {
                console.debug("searchbox: onReturnPressed: text=" + searchbox.text)
                var n = richListHelper.qmlSearchStudies(searchbox.text, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex);
                console.debug("qmlSearchStudies: n=" + n)
                //------------
                //ソート後のcurrentIndexを適切に反映すべき  未実装
                richListHelper.qmlSetCurrentIndex(0);
                mainWindow.currentStudyIndex = 0
                richListHelper.qmlUpdatePreviewAt(0, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
                //-----------
                if(richlist.visible) {
                    richlist.setCurrent(mainWindow.currentStudyIndex)
                }
                if(row2list.visible) {
                    row2list.setCurrent(mainWindow.currentStudyIndex)
                 }
                //-----------
            }
        }

        // SearchBoxの虫眼鏡
        Image {
            anchors.right: searchbox.left
            anchors.verticalCenter: searchbox.verticalCenter
            width: 20 * dp   //24
            height: 20 * dp  //24
            source: "../res/searchbox_glass.png"
        }

        ToolButton {
            id: toolbuttonSetting
            anchors.right: rectRightArea.right
            anchors.top: searchbox.bottom
            anchors.topMargin: 8 * dp
            iconSource: "../res/button_setting.png"
        }

        ToolButton {
            anchors.top: searchbox.bottom
            anchors.topMargin: 8 * dp
            anchors.right: toolbuttonSetting.left
            anchors.rightMargin: 8 * dp
            iconSource: "../res/button_printer.png"
        }
    }

//    Rectangle {
//        id: flaglist
//        anchors.top: flagbtn.bottom
//        height: 500
//        width: 100
//        visible: false
//        color: "yellow"
//        //z:5
//    }

}
