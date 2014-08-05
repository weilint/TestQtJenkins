import QtQuick 2.1
import "InternalFunc.js" as Func

// 4行＋サムネール大

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
                spacing: 8 * dp                                              // 縦方向間隔

                Row {
                    Column {
                        spacing: itemColumn.spacing

                        Text {
                            width: richlistItem.width * 0.6                     // 全幅の60％
                            font.bold: true
                            elide: Text.ElideRight
                            color: Func.textColor(index, richlistItem.ListView.view.currentIndex)
                            text: PatientName;
                        }

                        Text {
                            width: richlistItem.width * 0.6                     // 全幅の60％
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
                            width: richlistItem.width * 0.6                     // 全幅の60％
                            elide: Text.ElideRight
                            color: Func.textColor(index, richlistItem.ListView.view.currentIndex)
                            text: Modality + ": " + BodyPartExamined
                        }

                        Text {
                            width: richlistItem.width * 0.6                     // 全幅の60％
                            elide: Text.ElideRight
                            color: Func.textColor(index, richlistItem.ListView.view.currentIndex)
                            text:AccessionNumber
                        }
                    }

                    Image {
                        width: Math.min(richlistItem.width * 0.4, richlistItem.height)  // 全幅の40％
                        height: width
                        y:4 * dp
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

