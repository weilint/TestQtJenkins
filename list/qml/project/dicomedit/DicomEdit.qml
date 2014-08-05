import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "../richlist" as RichList
import QtQuick.Window 2.0

Rectangle {
    id: root
    anchors.fill: parent

    signal okbtn_clicked()

    function enableEdit(){
        finishedEditStatus.visible= false;
        okbtn.enabled= true;
    }

        // 属性の欄
    Rectangle {
        id: topleft
        width: root.width
        height: root.height

        Rectangle {
            id: dicombtnrect
            anchors.top: topleft.top
            height: 50 * dp
            width: dicomeditrect.width

            Row {
                spacing: 10 * dp
                id: toolbarrow
                anchors.right: dicombtnrect.right
                anchors.rightMargin: 10 * dp
                anchors.verticalCenter: dicombtnrect.verticalCenter

                Button {
                    id: pastePatientInfobtn
                    text: "患者情報を適用"
                    width: 110 * dp
                    height: 28 * dp

                }

                Button {
                    id: pasteStudyInfobtn
                    text: "検査情報を適用"
                    width: 110 * dp
                    height: 28 * dp

                }

                Button {
                    id: copybtn
                    text: "コピー"
                    width: 80 * dp
                    height: 28 * dp

                }

                Button {
                    id: pastebtn
                    text: "貼り付け"
                    width: 80 * dp
                    height: 28 * dp
                }

                Row
                {
                    DicomEditComboBox2{
                        id: worklistcombobox
                        width: 180 * dp
                        height: 28 * dp
                        model: [ "ワークリストサーバー","ワークリストサーバー1"]
                        currentIndex: 0
                    }

                    Button {
                        id: worklistbtn
                        text: "検索"
                        width: 50 * dp
                        height: 28 * dp
                        onClicked: {
                            patientIdTextbox.text="987654321"
                            patientKanaNameTextbox.text="アレイタロウ"
                            patientKanjiNameTextbox.text="亜鈴太郎"
                            patientRomaNameTextbox.text="arai tarou"
                        }
                    }
                }
            }
        }

        Rectangle {
            id: dicomeditrect
            anchors.top: dicombtnrect.bottom
            width: root.width
            height: root.height - dicombtnrect.height - bottomrow.height

            Rectangle {
                id: editbtnrow
                height: 35 * dp
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 10 * dp
                width: dicomeditrect.width

                ToolButton {
                    id: buttonPlus
                    width: 18 * dp
                    height: 18 * dp
                    anchors.left: parent.left
                    enabled: true
                    iconSource: "../res/button_plus.png"
                    anchors.verticalCenter: editbtnrow.verticalCenter
                }

                ToolButton {
                    id: buttonMinus
                    width: 18 * dp
                    height: 18 * dp
                    anchors.left: buttonPlus.right
                    // enabled: ((isSelected1st==true) && (selectedIndex1st==index)) ?  true: false
                    enabled: true      // ★デモ仕様★  本来は「全検査」選択時だけfalseにする
                    iconSource: "../res/button_minus.png"
                    //anchors.horizontalCenter: editbtnrow.horizontalCenter
                    anchors.verticalCenter: editbtnrow.verticalCenter
                    anchors.rightMargin: 20 * dp
                }

                CheckBox {
                    id: editallchkbox; text: "変更"; width: 100 * dp
                    anchors.left: buttonMinus.right
                    anchors.leftMargin: 20 * dp
                    anchors.verticalCenter: editbtnrow.verticalCenter
                }
                Rectangle {
                    id: rect1
                    color: "transparent"; width: 325 * dp; height: 30 * dp
                    anchors.left: editallchkbox.right
                    anchors.verticalCenter: editbtnrow.verticalCenter
                }
                CheckBox {
                    id: searchallchkbox; text: "検索キー"; width: 100 * dp
                    anchors.left: rect1.right
                    anchors.verticalCenter: editbtnrow.verticalCenter
                }
            }

            // separator
            Rectangle {
                id: separator
                height: 1; width: editbtnrow.width; color: "#cccccc"
                anchors.top: editbtnrow.bottom
            }

            ScrollView {
                id: scrollview1
                width: grid.implicitWidth + 20 * dp
                height: dicomeditrect.height - editbtnrow.height - 20 * dp
                anchors.top: separator.bottom
                anchors.left: parent.left
                anchors.topMargin: 10 * dp
                anchors.horizontalCenter: dicomeditrect.horizontalCenter
                //y: 10



                GridLayout {
                    id: grid

                    anchors.left: parent.left
                    anchors.leftMargin: 66 * dp

                    columns: 3
                    rows: 18

                    columnSpacing: 8 * dp
                    rowSpacing: 10 * dp

                    // patient id
                    CheckBox{
                        id: editPatientIdChkbox; text: "患者ID"; width: 100 * dp; height:30 * dp
                    }
                    DicomEditTextBox{
                        id: patientIdTextbox;
                        width: 300 * dp; height: 24 * dp
                        text: editStudyObject.patientID // "353657"
                        onTextChanged: enableEdit();
                    }
                    CheckBox{
                        id: patientIdKeybox; width: 80 * dp; height:30 * dp
                    }

                    // patientromaname
                    CheckBox{
                        id: editPatientRomaNameChkbox; text: "ローマ字氏名"; width: 100 * dp; height:30 * dp
                    }
                    DicomEditTextBox{
                        id: patientRomaNameTextbox
                        width: 300 * dp; height: 24 * dp
                        text: editStudyObject.patientRomaName //"Taro Arei"
                        onTextChanged: enableEdit();
                        //text: richlist.selectedPatientKanjiName.toString()
                    }
                    CheckBox{
                        id: patientRomaNameKeybox; width: 80 * dp
                    }

                    // patientkanjiname
                    CheckBox{
                        id: editPatientKanjiNameChkbox; text: "漢字氏名"; width: 100 * dp; height:30 * dp
                    }
                    DicomEditTextBox{
                        id: patientKanjiNameTextbox
                        width: 300 * dp; height: 24 * dp
                        text: editStudyObject.patientName //"亜鈴 太郎"
                        onTextChanged: enableEdit();
                        //text: richlist.selectedPatientKanjiName.toString()
                    }
                    CheckBox{
                        id: patientKanjiNameKeybox; width: 80 * dp
                    }

                    // patientkananame
                    CheckBox{
                        id: editPatientKanaNameChkbox; text: "かな氏名"; width: 100; height:30
                    }
                    DicomEditTextBox{
                        id: patientKanaNameTextbox;
                        width: 300 * dp; height: 24 * dp
                        text: editStudyObject.patientKanaName //"あれい たろう"
                        onTextChanged: enableEdit();
                    }
                    CheckBox{
                        id: patientKanaNameKeybox; width: 80 * dp
                    }


                    // birthdate
                    CheckBox{
                        id: editBirthChkbox; text: "生年月日"; width: 100; height:30
                    }
                    DicomEditTextBox{
                        id: birthTextbox;
                        width: 300 * dp; height: 24 * dp
                        text: editStudyObject.birthdate  //"19350510"
                        onTextChanged: enableEdit();
                    }
                    CheckBox{
                        id: birthKeybox; width: 80 * dp
                    }

                    // gender
                    CheckBox{
                        id: editGenderChkbox; text: "性別"; width: 100 * dp; height:30 * dp
                    }

                    Row{                        
                        RadioButton {
                            id:maleRadioBtn; text: "男";
                            checked: editStudyObject.sex === "M"? true:false
                            onClicked: {
                                maleRadioBtn.checked = true
                                if(checked) {
                                    femaleRadioBtn.checked = false
                                    otherRadioBtn.checked = false
                                    originalRadioBtn.checked = false
                                }
                                onTextChanged: enableEdit();
                            }
                        }
                        RadioButton {
                            id:femaleRadioBtn; text:"女"
                            checked: editStudyObject.sex === "F"? true:false
                            onClicked: {
                                femaleRadioBtn.checked = true
                                if(checked) {
                                    maleRadioBtn.checked = false
                                    otherRadioBtn.checked = false
                                    originalRadioBtn.checked = false
                                }
                                onTextChanged: enableEdit();
                            }
                        }
                        RadioButton {
                            id:otherRadioBtn; text:"他"
                            checked: editStudyObject.sex === "O"? true:false
                            onClicked: {
                                otherRadioBtn.checked = true
                                if(checked) {
                                    maleRadioBtn.checked = false
                                    femaleRadioBtn.checked = false
                                    originalRadioBtn.checked = false
                                }
                                onTextChanged: enableEdit();
                            }
                        }
                        RadioButton {
                            id:originalRadioBtn; text:"空"
                            checked: editStudyObject.sex === ""? true:false
                            onClicked: {
                                originalRadioBtn.checked = true
                                if(checked) {
                                    maleRadioBtn.checked = false
                                    femaleRadioBtn.checked = false
                                    otherRadioBtn.checked = false
                                }
                                onTextChanged: enableEdit();
                            }
                        }
                    }
                    CheckBox{
                        id: genderKeybox; width: 80 * dp
                    }

                    // studydate
                    CheckBox{
                        id: editStudyDateChkbox; text: "検査日"; width: 100 * dp; height:30 * dp
                    }
                    DicomEditTextBox{
                        id: studyDateTextbox;
                        width: 300 * dp; height: 24 * dp
                        text: editStudyObject.studyDate // "20140228"
                        onTextChanged: enableEdit();
                    }
                    CheckBox{
                        id: studyDateKeybox; width: 80
                    }

                    // studytime
                    CheckBox{
                        id: editStudyTimeChkbox; text: "検査時刻"; width: 100; height:30
                    }
                    DicomEditTextBox{
                        id: studyTimeTextbox;
                        width: 300 * dp; height: 24 * dp
                        text: editStudyObject.studyTime //"103200"
                        onTextChanged: enableEdit();
                    }
                    Rectangle {
                        color: "transparent"; width: 80 * dp; height: 30 * dp
                    }

                    // institution
                    CheckBox{
                        id: editInstitutionChkbox; text: "施設名"; width: 100; height:30
                    }
                    DicomEditComboBox2{
                        id: institutionCombobox;
                        width: 300 * dp; height: 24 * dp
                        //text: editStudyObject.institutionName //"Array Hospital"
                        onCurrentTextChanged: enableEdit();
                        //onTextChanged: enableEdit();
                        model: []
                        currentIndex: getIndex(editStudyObject.institutionName)
                    }
                    Rectangle {
                        color: "transparent"; width: 80 * dp; height: 30 * dp
                    }

                    // acc num
                    CheckBox{
                        id: editAccNumChkbox; text: "受付番号"; width: 100 * dp; height:30 * dp
                    }
                    DicomEditTextBox{
                        id: accNumTextbox;
                        width: 300 * dp; height: 24 * dp
                        text: editStudyObject.accessionNumber //"4328244"
                        onTextChanged: enableEdit();
                    }
                    CheckBox{
                        id: accNumKeybox; width: 80 * dp
                    }

                    // study desc
                    CheckBox{
                        id: editStudyDescChkbox; text: "検査記述"
                        width: 100 * dp; height:30 * dp
                        anchors.top: 　studyDescTextbox.top
                    }
                    DicomEditRichTextBox{
                        id:　studyDescTextbox;
                        width: 300 * dp; height: 24 * 2 * dp
                        text: editStudyObject.studyDesc //"Scoutview Cor"
                        onTextChanged: enableEdit();
                    }
                    Rectangle {
                        color: "transparent"; width: 80 * dp; height: 30 * dp
                    }

                    // modality
                    CheckBox{
                        id: editModalityChkbox; text: "モダリティ"; width: 100; height:30
                    }
                    DicomEditComboBox2{
                        id: modalityCombobox;
                        width: 300 * dp; height: 24 * dp
                        model: [ "AS","AU","BI","CD","CF","CP","CR","CS","CT","CD","DF","DG","DM","DS","DX","EC","ECG","EPS","ES","FA","FS","GM","HC","HD","IVUS","IO","LP","LS","MA","MG","MR","MS","NM","OT","PR","PT","PX","RF","RG","RTDOSE","RTIMAGE","RTRECORD","RTSTRUCT","SM","SR","ST","TG","US","VF","XA","XC"]
                        currentIndex: getIndex(editStudyObject.modality)
                        onCurrentTextChanged: enableEdit();
                    }
                    CheckBox{
                        id: modalityKeybox; width: 80 * dp
                    }

                    // body part
                    CheckBox{
                        id: editBodyPartChkbox; text: "検査部位"; width: 100 * dp; height:30 * dp
                    }
                    DicomEditComboBox2{
                        id: bodyPartCombobox;
                        width: 300 * dp; height: 24 * dp
                        //text: editStudyObject.bodyPart //"CHEST"
                        //onTextChanged: enableEdit();
                        onCurrentTextChanged: enableEdit();
                        //onTextChanged: enableEdit();
                        model: ["ARM","ABDOMEN","ANKLE","BREAST","CHEST","CLAVICLE","COCCYX","ELBOW","EXTREMITY","FOOT","HAND","HEAD","HEART","HIP","JAW","KNEE","LEG","NECK","PELVIS","SHOULDER","SKULL","CSPINE","LSPINE","SSPINE","TSPINE"]
                        currentIndex: getIndex(editStudyObject.bodyPart)
                    }
                    Rectangle {
                        color: "transparent"; width: 80 * dp; height: 30 * dp
                    }

                    // reading physician
                    CheckBox{
                        id: editReadingPhysicianChkbox; text: "読影医師名"; width: 100 * dp; height:30 * dp
                    }
                    DicomEditComboBox2{
                        id: readingPhysicianCombobox;
                        width: 300 * dp; height: 24 * dp
                        //text: editStudyObject.readingPhysName
                        //onTextChanged: enableEdit();
                        //text: editStudyObject.bodyPart //"CHEST"
                        //onTextChanged: enableEdit();
                        onCurrentTextChanged: enableEdit();
                        //onTextChanged: enableEdit();
                        model: []
                        currentIndex: getIndex(editStudyObject.readingPhysName)
                    }
                    Rectangle {
                        color: "transparent"; width: 80 * dp; height: 30 * dp
                    }

                    // series desc
                    CheckBox{
                        id: editSeriesDescChkbox; text: "シリーズ記述"; width: 100 * dp; height:30 * dp
                        anchors.top:seriesDescTextbox.top
                    }
                    DicomEditRichTextBox{
                        id:　seriesDescTextbox
                        width: 300 * dp; height: 24 * 2 * dp
                        onTextChanged: enableEdit();
                    }
                    Rectangle {
                        color: "transparent"; width: 80 * dp; height: 30 * dp
                    }
                }
            }
        }
    }
    Rectangle {
        id: bottomrow
        anchors.bottom: root.bottom
        anchors.right: root.right
        height: 50 * dp
        width: root.width
        color: "aliceblue"

        Text {
            id: finishedEditStatus
            anchors.left: bottomrow.left
            anchors.leftMargin: 20 * dp
            anchors.top: bottomrow.top
            anchors.topMargin: 10 * dp
            text: qsTr("属性変更を適用しました。")
            color: "blue"
            font.pointSize: 12
            visible: false

//            onVisibleChanged:
//            {
//                if (visible === true)
//                {
//                    animation.start()
//                }
//            }
//            PropertyAnimation { id: animation; target: sendingstatus; property: "opacity"; to: 0; duration:3000; }
        }

        Row {
            anchors.verticalCenter: bottomrow.verticalCenter
            anchors.right: bottomrow.right
            anchors.rightMargin: 30 * dp
            spacing:10 * dp

            Button {
                id: detailsbtn
                text: "詳細設定"
                width: 100 * dp
                height: 30 * dp
                onClicked:
                {
                    dicomEditDetails.open();
                }
            }

            Button {
                id: okbtn
                text: "適用"
                width: 100 * dp
                height: 30 * dp
                MouseArea {
                    anchors.fill: parent
                    onClicked:
                    {
                        console.debug("okbtn:: onClicked")
                        if(maleRadioBtn.checked) editStudyObject.sex = "M"
                        else if(femaleRadioBtn.checked) editStudyObject.sex = "F"
                        else if(otherRadioBtn.checked) editStudyObject.sex = "O"
                        else editStudyObject.sex = ""

                        richListHelper.qmlEditCurrentStudy(
                                       patientIdTextbox.text,
                                       patientKanjiNameTextbox.text,
                                       editStudyObject.patientKanaName,
                                       editStudyObject.patientRomaName,
                                       editStudyObject.sex,
                                       editStudyObject.birthdate,
                                       editStudyObject.accessionNumber,
                                       studyDateTextbox.text,
                                       studyTimeTextbox.text,

                                       editStudyObject.institutionName,
                                       editStudyObject.readingPhysName,
                                       editStudyObject.studyID,
                                       editStudyObject.studyDesc,
                                       editStudyObject.refPhysName,
                                       modalityCombobox.text,
                                       editStudyObject.bodyPart,
                                       editStudyObject.seriesDesc,
                                       editStudyObject.patientPos,
                                       editStudyObject.larerality)
                        //デモ版
                        mainWindow.setSelectedStudy();
                        root.okbtn_clicked()
//                        finishedEditStatus.visible = false
//                        finishedEditStatus.opacity = 1
                        finishedEditStatus.visible = true
                        okbtn.enabled = false
                    }
                }
            }
        }
    }

    Window{
        id: dicomEditDetails
        title: "DICOM属性編集詳細"
        width: 500 * dp
        height: 330 * dp
        visible: false
        flags: Qt.Window | Qt.WindowTitleHint | Qt.CustomizeWindowHint

        function open(){
            visible = true
        }
        function close(){
            visible = false
        }

        Rectangle
        {
            id: main
            anchors.fill: dicomEditDetails
            width: dicomEditDetails.width
            height: uidrect.height + studyuidrect.height + detailsbtnrect.height

            Rectangle
            {
                id: uidrect
                width: main.width
                height: 120 * dp
                anchors.top: main.top
                anchors.topMargin: 20 * dp
                anchors.left: main.left
                anchors.leftMargin: 20 * dp

                Column{
                    RadioButton{
                        id: maintainStudySeriesRadioBtn
                        text: "検査・シリーズの構成を現在のままにする"
                    }
                    CheckBox{
                        id: maintainSOPInstanceUidCheckBox
                        text: "SOP Instance UIDを維持する"
                        x: 30
                    }
                    RadioButton{
                        id:mergeStudyRadioBtn
                        text:"検査を1個にまとめ、シリーズは現在の構成のままにする"
                    }
                    RadioButton {
                        id: mergeStudySeriesRadioBtn
                        text:"検査・シリーズを1個にまとめる"
                    }
                    CheckBox {
                        id:newSeriesCheckBox
                        text:"新しいシリーズを生成する"
                    }
                }

            }
            Rectangle
            {
                id: studyuidrect
                anchors.top: uidrect.bottom
                anchors.topMargin: 20 * dp
                anchors.left: main.left
                anchors.leftMargin: 20 * dp
                width: main.width
                height: 120 * dp

                Text {
                    id: studyinstanceuid
                    anchors.top: studyuidrect.top
                    text: "Study Instance UIDの扱い方法："
                }
                Column
                {
                    anchors.top: studyinstanceuid.bottom
                    RadioButton {
                        id: studyUidNoChangeRadioBtn
                        text: "変更しない"
                    }
                    RadioButton{
                        id: newStudyUidRadioBtn
                        text: "新しく生成する"
                    }
                    RadioButton {
                        id: studyUidUseMwmRadioBtn
                        text: "MWMで取得した情報で上書きする"
                    }
                }
            }

            Rectangle
            {
                id:detailsbtnrect
                anchors.top: studyuidrect.bottom
                anchors.bottomMargin: 20 * dp
                anchors.right: main.right
                anchors.rightMargin: 20 * dp
                height: 50
                width: cancelbtn.width + detailsokbtn.width

                Row
                {
                    spacing: 10 * dp

                    Button {
                        id: cancelbtn
                        //anchors.right: detailsbtnrect.right
                        //anchors.right: detailsokbtn.left
                        text: "キャンセル"
                        width: 100 * dp
                        height: 30 * dp
                        onClicked:
                        {
                            dicomEditDetails.close();
                        }
                    }

                    Button {
                        id: detailsokbtn
                        //anchors.right: detailsbtnrect.left
                        text: "OK"
                        width: 100 * dp
                        height: 30 * dp
                        onClicked:
                        {
                            dicomEditDetails.close();
                        }
                    }
                }
            }
        }
    }
}

