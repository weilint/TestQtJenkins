import QtQuick 2.0
import QtQuick.Controls 1.0
import StudyListLibrary 1.0
import StudyObjectLibrary 1.0

//リストのリスト領域のコンテクストメニュー
//「すべて」（実体が入っている）
//*・ビュー
//・複製
//・削除

Menu{
    MenuItem{
        id: viewItem
        text: qsTr("ビュー")
        checkable: true
        iconSource: "../res/button_viewer.png"
        onCheckedChanged: {
            richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
        }

//      shortcut: "Ctrl+X"
//      onTriggered: ...
   }

    MenuSeparator { }


    MenuItem{
        id: duplicateItem
        text: qsTr("複製")
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
        text: qsTr("削除")
        checkable: true
//        iconSource: "../res/button_viewer.png"
//        onCheckedChanged: {
//            richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
//        }

//      shortcut: "Ctrl+X"
//      onTriggered: ...
   }

}
