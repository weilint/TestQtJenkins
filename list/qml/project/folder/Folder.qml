import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1
import "../share"

Rectangle {

    // --- Interface ----------------------------------------------
    property variant dataModel
    property bool inImageServer: false
    property string selectedImageServer: ""
    property int clickedcategory: 0
    // ------------------------------------------------------------

    id: root

    //-------------------------------------
    FolderMenu{
        id: foldermenu;
    }
    //-------------------------------------

    ListView {
        anchors.fill: parent
        anchors.margins: 1 * dp
        width: parent.width
        height: parent.height
        spacing: 16 * dp
        clip: true
        focus: true

        model: DataModel {id:dataModel}                        // DataModel.qml 読み込み
        delegate: categoryDelegate

        ScrollBar {
            scrollArea: parent
            height: root.height
            anchors.right: parent.right
            width: 8 * dp
        }
    }

    // 第１階層
    Component {
        id: categoryDelegate


        Column {
            id: categorycol
            property bool isSelected1st: true
            property int selectedIndex1st: 0

            width: root.width

            Rectangle {
                id: categoryItem
                color: categoryMouseArea.containsMouse? "lightgray": "transparent"
                border.width: categoryMouseArea.containsMouse? 1 * dp : 0
                border.color: categoryMouseArea.containsMouse? "gray" :"transparent"
                // height: categoryText.contentHeight
                height:isTouch ? 40 * dp : 25 * dp     // 30                          // となりのコンボボックスと同じ高さ
                width: parent.width

                Text {
                    id: categoryText
                    anchors.verticalCenter: parent.verticalCenter
                    x:isTouch ? 25 * dp : 15 * dp
                    // color: ( collapsed ) ? "gray": "white"
                    text: categoryName

                    MouseArea {
                        id: categoryMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: dataModel.setProperty(index, "collapsed", !collapsed)
                    }
                }

                ToolButton {
                    anchors.right: buttonMinus.left
                    anchors.rightMargin: 2 * dp
                    anchors.verticalCenter: categoryText.verticalCenter
                    width: 16 * dp
                    height: 16 * dp
                    enabled: true
                    iconSource: "../res/button_plus.png"
                }

                ToolButton {
                    id: buttonMinus
                    anchors.right: parent.right
                    anchors.rightMargin: 4 * dp
                    anchors.verticalCenter: categoryText.verticalCenter
                    width: 16 * dp
                    height: 16 * dp
                    // enabled: ((isSelected1st==true) && (selectedIndex1st==index)) ?  true: false
                    enabled: false      // ★デモ仕様★  本来は「全検査」選択時だけfalseにする
                    iconSource: "../res/button_minus.png"
                }
            }

            Loader {
                id: subItemLoader
                property string category
                // This is a workaround for a bug/feature in the Loader element. If sourceComponent is set to null
                // the Loader element retains the same height it had when sourceComponent was set. Setting visible
                // to false makes the parent Column treat it as if it's height was 0.
                visible: !collapsed
                property variant subItemModel : subItems
                sourceComponent:{
                    var ret = null;
                    if(!collapsed){
                        if(isTouch){
                            ret = subItemColumnDelegateTouch;
                        }else{
                            ret = subItemColumnDelegate;
                        }
                    }
                    return ret;
                }
                onStatusChanged: {
                    if (status == Loader.Ready)
                    {
                        item.model = subItemModel
                        item.category = index
                        //item.category = qsTr(categoryName)
                    }
                }
                // ★デモ用仕様１★
                MouseArea {
                    id: mymousearea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        isSelected1st = !isSelected1st
                        selectedIndex1st = index
                        console.debug("selectedIndex1st=" + selectedIndex1st)
                        console.debug("categoryName=" + qsTr(categoryName))
                        if(categoryName === qsTr("フォルダー")) {
                            console.debug("categoryName=" + qsTr("フォルダー"))
                        }
                    }
                }
            }


        }
    }

    // 第２階層
    Component {
        id: subItemColumnDelegate

        Column {
            //property bool isSelected2nd: false
            property int selectedIndex2nd: 0
            property alias model : subItemRepeater.model
            property int category

            width: root.width
            // spacing: 4

            Repeater {
                id: subItemRepeater

                delegate: Rectangle {
                    height: subItemText.contentHeight
                    width: parent.width-2*dp
                    //color: itemMouseArea.containsMouse? "lightgray":"transparent"
                    border.width: itemMouseArea.containsMouse? 1 * dp : 0
                    border.color: itemMouseArea.containsMouse? "gray" :"transparent"

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: ((selectedIndex2nd==index) && (clickedcategory==category)) ? "lightgray": "transparent" }
                        GradientStop { position: 0.9; color: ((selectedIndex2nd==index) && (clickedcategory==category)) ? "silver": "transparent" }
                        GradientStop { position: 1.0; color: ((selectedIndex2nd==index) && (clickedcategory==category)) ? "gray": "transparent" }
                    }

                    ToolButton {
                        id: toolbtn
                        x: 30 * dp
                        width: parent.height                   // 正方形にする
                        height: parent.height
                        iconSource: imageSource
                    }

                    Text {
                        id: subItemText
                        anchors.verticalCenter: parent.verticalCenter
                        x: { return 30 * dp + parent.height + 10 * dp }
                        text: itemName
                    }

                    MouseArea {
                        id: itemMouseArea
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        hoverEnabled: true
                        onClicked: {
                            // アイコンクリックで、選択状態を切り替える
                            //isSelected2nd = !isSelected2nd
                            //isSelected2nd = true
                            selectedIndex2nd = index
                            root.clickedcategory = category

                            if(itemName === qsTr("全検査")){
                                //------------
                                mainWindow.currentFolderIndex = 0　//全検査フォルダー
                                setSearchKey("")
                                var n = richListHelper.qmlSearchStudies("", mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex);
                                console.debug("qmlSearchStudies: n=" + n)

                                //------------
                                //ソート後のcurrentIndexを適切に反映すべき  未実装
                                richListHelper.qmlSetCurrentIndex(0);
                                mainWindow.currentStudyIndex = 0
                                richListHelper.qmlUpdatePreviewAt(0, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
                                setSelectedStudy()
                                //-------------
                            }else if(itemName === qsTr("SmartFolder1")){
                                //------------
                                mainWindow.currentFolderIndex = 1  //スマートフォルダ
                                var searchkey = richListHelper.qmlGetSmartFolderSearchKey();
                                setSearchKey("")
                                var n = richListHelper.qmlSearchStudies(searchkey, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex);
                                console.debug("qmlSearchStudies: n=" + n)
                                //------------
                                //ソート後のcurrentIndexを適切に反映すべき  未実装
                                richListHelper.qmlSetCurrentIndex(0);
                                mainWindow.currentStudyIndex = 0
                                richListHelper.qmlUpdatePreviewAt(0, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
                                setSelectedStudy()
                                //-------------
                            } else if(itemName === qsTr("Folder1")){
                                mainWindow.currentFolderIndex = 2
                                richListHelper.qmlGetRemoteStudies();
                                richListHelper.qmlSetCurrentIndex(0);
                                mainWindow.currentStudyIndex = 0
                                richListHelper.qmlUpdatePreviewAt(0, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
                                setSelectedStudy()
                            }
                            if(itemName === qsTr("PP-100N 1")){
                                bPublisherSelected = true;
                            }else{
                                bPublisherSelected = false;
                            }

                            if(mouse.button === Qt.RightButton){
                                console.debug("mouse.button === Qt.RightButton")
                                foldermenu.popup()
                            }
                        }
                    }
                    DropArea{
                        anchors.fill: parent
                        property int fontsize: 14

                        onEntered: {
                            if(itemName === qsTr("イメージサーバー1")) {
                                //subItemText.color = "red"
                                fontsize = subItemText.font.pointSize
                                subItemText.font.pointSize = 12
                                subItemText.font.bold = true
                                toolbtn.height = toolbtn.height + 10 * dp
                                toolbtn.width = toolbtn.width + 10 * dp
                                inImageServer = true
                                selectedImageServer = itemName
                            }
                        }

                        onExited: {
                            if(itemName === qsTr("イメージサーバー1")) {
                                //subItemText.color = "black"
                                subItemText.font.pointSize = fontsize
                                subItemText.font.bold = false
                                toolbtn.height = parent.height
                                toolbtn.width = parent.height
                                inImageServer = false
                            }
                        }
                    }
                }
            }
        }
    }
    // 第２階層
    Component {
        id: subItemColumnDelegateTouch

        Column {
            //property bool isSelected2nd: false
            property int selectedIndex2nd: 0
            property alias model : subItemRepeater.model
            property int category

            width: root.width
            // spacing: 4

            Repeater {
                id: subItemRepeater

                delegate: Rectangle {
                    height: subItemText.contentHeight * 1.6
                    width: parent.width

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: ((selectedIndex2nd==index) && (clickedcategory==category)) ? "lightgray": "transparent" }
                        GradientStop { position: 0.9; color: ((selectedIndex2nd==index) && (clickedcategory==category)) ? "silver": "transparent" }
                        GradientStop { position: 1.0; color: ((selectedIndex2nd==index) && (clickedcategory==category)) ? "gray": "transparent" }
                    }

                    ToolButton {
                        id: toolbtn
                        x: 30 * dp
                        width: parent.height                   // 正方形にする
                        height: parent.height
                        iconSource: imageSource
                    }

                    Text {
                        id: subItemText
                        anchors.verticalCenter: parent.verticalCenter
                        x: { return 30 * dp + parent.height + 10 * dp }
                        text: itemName
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            // アイコンクリックで、選択状態を切り替える
                            //isSelected2nd = !isSelected2nd
                            //isSelected2nd = true
                            selectedIndex2nd = index
                            root.clickedcategory = category

                            if(itemName === qsTr("全検査")){
                                //------------
                                mainWindow.currentFolderIndex = 0　//全検査フォルダー
                                setSearchKey("")
                                var n = richListHelper.qmlSearchStudies("", mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex);
                                console.debug("qmlSearchStudies: n=" + n)

                                //------------
                                //ソート後のcurrentIndexを適切に反映すべき  未実装
                                richListHelper.qmlSetCurrentIndex(0);
                                mainWindow.currentStudyIndex = 0
                                richListHelper.qmlUpdatePreviewAt(0, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
                                //setSelectedStudy()
                                //-------------
                            }else if(itemName === qsTr("SmartFolder1")){
                                //------------
                                mainWindow.currentFolderIndex = 1  //スマートフォルダ
                                var searchkey = richListHelper.qmlGetSmartFolderSearchKey();
                                setSearchKey("")
                                var n = richListHelper.qmlSearchStudies(searchkey, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex);
                                console.debug("qmlSearchStudies: n=" + n)
                                //------------
                                //ソート後のcurrentIndexを適切に反映すべき  未実装
                                richListHelper.qmlSetCurrentIndex(0);
                                mainWindow.currentStudyIndex = 0
                                richListHelper.qmlUpdatePreviewAt(0, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
                                //setSelectedStudy()
                                //-------------
                            } else if(itemName === qsTr("Folder1")){
                                mainWindow.currentFolderIndex = 2
                                richListHelper.qmlGetRemoteStudies();
                                richListHelper.qmlSetCurrentIndex(0);
                                mainWindow.currentStudyIndex = 0
                                richListHelper.qmlUpdatePreviewAt(0, mainWindow.currentFolderIndex, mainWindow.currentSortKeyIndex )
                                //setSelectedStudy()
                            }

                        }
                    }

                    DropArea{
                        anchors.fill: parent
                        property int fontsize: 14

                        onEntered: {
                            if(itemName === qsTr("イメージサーバー1")) {
                                //subItemText.color = "red"
                                fontsize = subItemText.font.pointSize
                                subItemText.font.pointSize = 12
                                subItemText.font.bold = true
                                toolbtn.height = toolbtn.height + 10 * dp
                                toolbtn.width = toolbtn.width + 10 * dp
                                inImageServer = true
                                selectedImageServer = itemName
                            }
                        }

                        onExited: {
                            if(itemName === qsTr("イメージサーバー1")) {
                                //subItemText.color = "black"
                                subItemText.font.pointSize = fontsize
                                subItemText.font.bold = false
                                toolbtn.height = parent.height
                                toolbtn.width = parent.height
                                inImageServer = false
                            }
                        }
                    }
                }
            }
        }
    }
}
