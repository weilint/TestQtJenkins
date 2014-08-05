import QtQuick 2.1
import "InternalFunc.js" as Func

// 3行＋サムネール

Rectangle {

    // --- Interface ----------------------------------------------
    // model role: PatientName, StudyDate etc
    property variant dataModel: DataModel { }
    property int currentIndex: 0
    signal clicked(int index)
    // ------------------------------------------------------------

    InternalListView {
        model: dataModel
        delegate: richlistDelegate
    }

    id: root
    width: parent.width; height: parent.height

    Component {
        id: richlistDelegate

        Item {
            id: richlistItem
            width: parent.width
            height: childrenRect.height

            Column {
                id: itemColumn
                spacing: 4 * dp                                          // 縦方向間隔

                Row {
                    // Base
                    Column {
                        spacing: itemColumn.spacing

                        Text {
                            id: itemText
                            width: richlistItem.width * 0.7                 // 全幅の70％
                            font.bold: true
                            elide: Text.ElideRight
                            color: Func.textColor(index, richlistItem.ListView.view.currentIndex)
                            text: PatientName;
                        }

                        Text {
                            width: itemText.width
                            elide: Text.ElideRight
                            color: {
                                if(index === richlistItem.ListView.view.currentIndex) return "white"
                                return "#4979FF"
                            }
                            text: {
                                var yyyymmdd = StudyDate.substr(0,4)
                                        + "/" + StudyDate.substr(4,2)
                                        + "/" + StudyDate.substr(6,2)
                                var hhmm = StudyTime.substr(0,2)
                                        + ":" + StudyTime.substr(2,2)
                                return yyyymmdd + " " + hhmm
                            }
                        }

                        Text {
                            width: itemText.width
                            elide: Text.ElideRight
                            color: Func.textColor(index, richlistItem.ListView.view.currentIndex)
                            text: Modality + ": " + BodyPartExamined
                        }
                    }

                    Image {
                        width: Math.min(richlistItem.width * 0.3, richlistItem.height)  // 全幅の30％
                        height: width
                        source:SampleImage;
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
                onClicked: {
                    currentIndex = index                // 外部に渡すプロパティを更新
                    richlistItem.ListView.view.currentIndex = index

                    root.clicked(index)
                }
            }
        }
    }
}

