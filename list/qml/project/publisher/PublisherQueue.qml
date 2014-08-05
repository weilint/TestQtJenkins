import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1

import "../richlist" as RichList




Rectangle {
    property variant headerData: HeaderDataModel{}
    property variant jobData: JobDataModel{}
    property variant jobData2: JobDataModel_withFinished{}

    //作成済みのチェックボックス
    property alias finishedJobChecked: finishedJobschkbox.checked

    //width of job list
    property int statusIconWidth:     20*dp
    property int jobStatusTextWidth:  130*dp
    property int buttonWidth:         80*dp

    property int varWidth: jobList.width - statusIconWidth - jobStatusTextWidth - buttonWidth
    property int createDateTimeTextWidth:  varWidth * 0.13
    property int patientIDTextWidth:       varWidth * 0.1
    property int patientNameTextWidth:     varWidth * 0.1
    property int numOfStudiesTextWidth:    varWidth * 0.07
    property int newestStudyDateTextWidth: varWidth * 0.16
    property int modalityTextWidth:        varWidth * 0.1
    property int bodyPartExaminedTextWidth:varWidth * 0.12
    property int discTypeTextWidth:        varWidth * 0.12
    property int copyNumTextWidth:         varWidth * 0.1

    // ------------------

    //sort---------------
    property int indexOfSortItem: 1
    property int last_indexOfSortItem: 1
    property string sortmark: "▼"
    //-------------------

    id: root
    width: parent.width;
    height: parent.height
    //color: "gray"

    Rectangle{
        id: rootrec
        anchors.fill: parent
        width: root.width-20
        height: root.height-20
        anchors.margins: 5

        Column {
            //spacing: 5                         //縦方向間隔
            Rectangle{
                id: toprec
                width: rootrec.width
                height:finishedJobschkbox.height
                color: "transparent"
                //Row{

                    CheckBox {
                        id: finishedJobschkbox
                        text: qsTr("作成済みも含める")
                        width: 200*dp;
                        height: 20*dp
                        checked: true
                        anchors.bottom: toprec.bottom
                        //anchors.horizontalCenter: toprec
                        onCheckedChanged: {
                            var bAsc = sortmark === "▲"? true:false
                            if(finishedJobChecked) jobData2.sortModel(last_indexOfSortItem, bAsc)
                            else jobData.sortModel(last_indexOfSortItem, bAsc)
                         }
                    }

                    //パブリッシャーの情報
                    PublisherInfo{
                        id: paulisherStatusRect
                        anchors.top: toprec.top
                        anchors.right: toprec.right
                    }
                //}

            }



            //間隔
            Rectangle{  id: separater1; width:  rootrec.width ;  height: 5*dp }

            //ヘッダー
            ListView {
                id: headerList
                width: rootrec.width
                height: childrenRect.height

                model: headerData
                delegate: headerDelegate
            }

            Component.onCompleted: {                
                if(finishedJobChecked) jobData2.sortModel(1, false)
                else jobData.sortModel(1, false)
                jobList.currentIndex=-1
            }

            Component {
                id: headerDelegate
                Item {
                    id: headerItem
                    width: headerList.width
                    height: childrenRect.height*1.1

                    Rectangle {
                        id: headerItemRect
                        width: headerList.width
                        height: 20*dp
                        //color:"LemonChiffon"
                        //color: "royalblue"
                        color: "darksalmon"
                        border.color: "darkgray"
                        //border.width: 1*dp

                        Row {
                            id: itemRow
                            // spacing: 4                         //横方向間隔

                            Text {
                                id: statusIconText
                                width: statusIconWidth
                                text: statusIcon
                            }

                            Repeater {
                                id: itemRepeater
                                model: 10
                                Rectangle{
                                    id: headerItemRec
                                    width: getListItemWidth(index)
                                    height:headerItemRect.height
                                    //color: "transparent"
                                    color: headerItemMouseArea.containsMouse ? "salmon" : "transparent"
                                    border.color: headerItemMouseArea.containsMouse ? "gray" : "transparent"
                                    border.width: headerItemMouseArea.containsMouse ? 2*dp : 0
                                    //opacity: 1.0

                                    Text {
                                        id: headerItemText
                                        anchors.fill: parent
                                        elide: Text.ElideRight
                                        color:  "black"
                                        text: getHeaderItemName(index) + (indexOfSortItem===index?sortmark:"")

                                        MouseArea {
                                            id: headerItemMouseArea
                                            anchors.fill: headerItemText
                                            hoverEnabled: true
                                            onHoveredChanged: {
                                                //console.debug("onHoveredChanged index=" + index)
                                            }

                                            onClicked: {
                                                //console.debug(index)
                                                indexOfSortItem = index
                                                var bAsc=true
                                                if(last_indexOfSortItem===indexOfSortItem){
                                                    if(sortmark === "▼"){
                                                        sortmark = "▲"
                                                    }else if(sortmark === "▲") {
                                                        sortmark = "▼"
                                                        bAsc = false
                                                    }
                                                }else{
                                                    sortmark = "▲"
                                                }
                                                last_indexOfSortItem = indexOfSortItem
                                                if(finishedJobChecked) jobData2.sortModel(index, bAsc)
                                                else jobData.sortModel(index, bAsc)
                                            }
                                        }


                                        function getHeaderItemName(index)
                                        {
                                            switch(index) {
                                                case 0: return jobStatus
                                                case 1: return createDateTime
                                                case 2: return patientID
                                                case 3: return patientName
                                                case 4: return numOfStudies
                                                case 5: return newestStudyDate
                                                case 6: return modality
                                                case 7: return bodyPartExamined
                                                case 8: return discType
                                                case 9: return copyNum
                                            }
                                        }
                                    }
                                }
                            }

                            Text {
                                id: recreateButtonText
                                width: buttonWidth
                                text: recreateButton
                            }

                        }
                    }
                 }
             }


            ScrollView {
                id: scrollview_vertival
                width: rootrec.width
                height: rootrec.height-finishedJobschkbox.height-separater1.height-headerList.height

                //ジョブキューリスト
                ListView {
                    id: jobList
                    width: headerList.width
                    height: rootrec.height

                    focus: true
                    clip: true
                    highlightMoveDuration: 0

                    highlight: Rectangle {
                        color: "royalblue"          // "#366BDA"
                        //y: jobList.currentItem.y
                        visible: true
                        //Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
                        //Behavior on y { NumberAnimation { easing.type: Easing.OutElastic; duration: 2000 } }
                    }

                    model: {
                        if(finishedJobChecked) return jobData2
                        else jobData
                    }
                    delegate: jobDelegate
                }
            }//SCrollViewEnd



            Component {
                id: jobDelegate
                Item {
                    id: jobItem
                    width: headerList.width
                    height: childrenRect.height

                    Column{

                        Rectangle {
                            id: jobItemRect
                            width: headerList.width
                            height: (!finishedJobChecked　&& jobStatusText.text==="作成済み")? 0: 20*dp*2
                            visible: !finishedJobChecked　&& jobStatusText.text==="作成済み"? false:true
                            border.width: jobItemMouseArea.containsMouse? 1*dp : 0
                            border.color: jobItemMouseArea.containsMouse? "gray" : "transparent"


                            color:{
                                if(index%2 === 0) return  "white"
                                return "LemonChiffon"
                            }
                            //color: "royalblue"
                            //color: "darksalmon"
                            //border.color: "darkgray"
                            //border.width: 1

                            //x: 8
                            Row {
                                id: itemRow
                                // spacing: 4                         //横方向間隔

                                Image{
                                    id: statusIconImage
                                    height: 20 * dp
                                    width: statusIconWidth
                                    source: statusIcon
                                }

                                NumberAnimation{
                                    target: statusIconImage
                                    property: "rotation"
                                    from: 0
                                    to: 360
                                    duration:3000
                                    running: jobStatusText.text==="作成準備中" || jobStatusText.text==="作成中"?  true:false
                                    loops: Animation.Infinite
                                }


                                Column{
                                    Text {
                                        id: jobStatusText
                                        width: jobStatusTextWidth
                                        elide: Text.ElideRight
                                        color:  "black"
                                        text: jobStatus
                                    }

                                    Button {
                                        //anchors.centerIn: buttonrec
                                        id: cancelButton
                                        text: "キャンセル"
                                        width: buttonWidth
                                        height: visible? 20*dp:0
                                        visible: jobStatusText.text==="作成準備中" || jobStatusText.text==="作成中"?  true:false
                                    }

                                }

                                Column{
                                    Text {
                                        id: createDateText
                                        //width: 100*dp
                                        width: createDateTimeTextWidth
                                        elide: Text.ElideRight
                                        color:  "black"
                                        text: {
                                            var yyyymmdd = createDateTime.substr(0,4)
                                                    + "/" + createDateTime.substr(4,2)
                                                    + "/" + createDateTime.substr(6,2)

                                            return yyyymmdd
                                        }
                                    }

                                    Text {
                                        id: createTimeText
                                        width: createDateText.width
                                        elide: Text.ElideRight
                                        color:  "black"
                                        text: {
                                            var hhmm = createDateTime.substr(9,2)
                                                    + ":" + createDateTime.substr(11,2)
                                                    + ":" + createDateTime.substr(13,2)
                                            return hhmm
                                        }
                                    }
                                }

                                Text {
                                    id: patientIDText
                                    //width: 100*dp
                                    width:  patientIDTextWidth
                                    elide: Text.ElideRight
                                    color:  "black"
                                    text: patientID
                                }

                                Text {
                                    id: patientNameText
                                    //width: 80*dp
                                    width:  patientNameTextWidth
                                    elide: Text.ElideRight
                                    color:  "black"
                                    text: patientName
                                }

                                Text {
                                    id: numOfStudiesText
                                    //width: 60*dp
                                    width:  numOfStudiesTextWidth
                                    elide: Text.ElideRight
                                    color:  "black"
                                    text: numOfStudies
                                }


                                Text {
                                    id: newestStudyDateText
                                    //width: 130*dp
                                    width: newestStudyDateTextWidth
                                    elide: Text.ElideRight
                                    color:  "black"
                                    text: newestStudyDate
                                }


                                Text {
                                    id: modalityText
                                    //width: 80*dp
                                    width: modalityTextWidth
                                    elide: Text.ElideRight
                                    color:  "black"
                                    text: modality
                                }

                                Text {
                                    id: bodyPartExaminedText
                                    //width: 100*dp
                                    width:  bodyPartExaminedTextWidth
                                    elide: Text.ElideRight
                                    color:  "black"
                                    text: bodyPartExamined
                                }

                                Text {
                                    id: discTypeText
                                    //width: 100*dp
                                    width:  discTypeTextWidth
                                    elide: Text.ElideRight
                                    color:  "black"
                                    text: discType
                                }

                                Text {
                                    id: copyNumText
                                    //width: 80*dp
                                    width:copyNumTextWidth
                                    elide: Text.ElideRight
                                    color:  "black"
                                    text: copyNum
                                }

                                Rectangle{
                                    id:buttonrec
                                    width: buttonWidth
                                    height: jobItem.height
                                    //height: 20*dp*2
                                    color: "transparent"
                                    //color: "red"
                                    Column{
                                        //anchors.verticalCenter: buttonrec.verticalCenter
                                        Button {
                                            //anchors.centerIn: buttonrec
                                            id: recreateButton
                                            text: "再作成"
                                            width: buttonWidth
                                            height: 20*dp
                                            enabled: jobStatusText.text==="作成済み" || jobStatusText.text==="作成失敗" || jobStatusText.text==="作成キャンセル" ? true:false
                                            //visible: jobStatusText.text==="作成済み" || jobStatusText.text==="作成失敗" || jobStatusText.text==="作成キャンセル" ? true:false
                                        }

//                                        Button {
//                                            //anchors.centerIn: buttonrec
//                                            id: cancelButton
//                                            text: "キャンセル"
//                                            width: buttonWidth
//                                            height: visible? 20*dp:0
//                                            visible: jobStatusText.text==="作成準備中" || jobStatusText.text==="作成中"?  true:false
//                                        }
                                    }
                                }
                            }
                        }

                        //行の境界線
//                        Rectangle {
//                            id: jobItemUnderLine
//                            width: headerList.width
//                            height: 1*dp
//                            //height: jobItemRect.visible? 1*dp: 0
//                            color: "gray"
//                        }
                    }

                    MouseArea {
                        id: jobItemMouseArea
                        anchors.fill: jobItem
                        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                        hoverEnabled: true
                        onHoveredChanged: {
                            //console.debug("onHoveredChanged index="+index)
                        }

                        onClicked: {
                            console.debug("onClicked index="+index)
                            jobList.currentIndex=index
                        }
                    }

                }
             }

        }
    }
//  } //scrollview_horivertival

    function getListItemWidth(index)
    {
        switch(index) {
            case 0: return jobStatusTextWidth
            case 1: return createDateTimeTextWidth
            case 2: return patientIDTextWidth
            case 3: return patientNameTextWidth
            case 4: return numOfStudiesTextWidth
            case 5: return newestStudyDateTextWidth
            case 6: return modalityTextWidth
            case 7: return bodyPartExaminedTextWidth
            case 8: return discTypeTextWidth
            case 9: return copyNumTextWidth
        }
    }

}
