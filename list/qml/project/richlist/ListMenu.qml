import QtQuick 2.0
import QtQuick.Controls 1.0
import StudyListLibrary 1.0
import StudyObjectLibrary 1.0


//「すべて」以外のフォルダー（リンクしか入っていない）
//*・ビュー
//・切り取り
//・コピー
//・貼り付け
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
        id: cutItem
        text: qsTr("切り取り")
        checkable: true
//        iconSource: "../res/button_viewer.png"
//        onCheckedChanged: {
//            richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
//        }

//      shortcut: "Ctrl+X"
//      onTriggered: ...

   }

    MenuItem{
        id: copyItem
        text: qsTr("コピー")
        checkable: true
//        iconSource: "../res/button_viewer.png"
//        onCheckedChanged: {
//            richListHelper.qmlStartViewerAt(currentFolderIndex, currentStudyIndex)
//        }

//      shortcut: "Ctrl+X"
//      onTriggered: ...
   }


    MenuItem{
        id: pestItem
        text: qsTr("貼り付け")
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
