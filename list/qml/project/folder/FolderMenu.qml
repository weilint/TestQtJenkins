import QtQuick 2.0
import QtQuick.Controls 1.0
import StudyListLibrary 1.0
import StudyObjectLibrary 1.0

//リストのフォルダー領域のコンテクストメニュー
//・新しいフォルダー
//・フォルダー名の変更
//・フォルダーを削除

Menu{
    MenuItem{
        id: viewItem
        text: qsTr("新規フォルダーの作成")
        checkable: true
//        iconSource: "../res/button_viewer.png"
//        onCheckedChanged: {
//            richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
//        }

//      shortcut: "Ctrl+X"
//      onTriggered: ...
   }

    MenuSeparator { }


    MenuItem{
        id: duplicateItem
        text: qsTr("フォルダー名の変更")
        checkable: true
//        iconSource: "../res/button_viewer.png"
//        onCheckedChanged: {
//            richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
//        }

//      shortcut: "Ctrl+X"
//      onTriggered: ...
   }

    MenuSeparator { }


    MenuItem{
        id: deleteItem
        text: qsTr("フォルダーの削除")
        checkable: true
//        iconSource: "../res/button_viewer.png"
//        onCheckedChanged: {
//            richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
//        }

//      shortcut: "Ctrl+X"
//      onTriggered: ...
   }

}
