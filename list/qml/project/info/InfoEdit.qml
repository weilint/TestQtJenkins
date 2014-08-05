import QtQuick 2.0
import QtQuick.Controls 1.0


Rectangle {
    id: root
    anchors.fill: parent

    TabView {
        id: tabview
        focus:true
        anchors.fill: parent
        anchors.margins: 1 * dp
        tabPosition: Qt.BottomEdge
        frameVisible :false

        Tab {
            title: qsTr("患者")
            EditPatient{}
        }

        Tab {
            title: qsTr("検査")
            EditStudy{}
        }

        style:isTouch ? tabViewStyleTouch : tabViewStyle

    }

}
