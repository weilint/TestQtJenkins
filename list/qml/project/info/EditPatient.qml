import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

//A 患者
//患者ID
//患者氏名　日本語等
//患者氏名　かな
//患者氏名　ローマ字
//生年月日
//性別
//コメント
//サムネール画像
//*登録日時
//*変更日時

Rectangle {
    id:root
    property int label_width: 150*dp
    property int label_height: 30*dp

    property int button_width: 120*dp
    property int button_height: 30*dp

    anchors.fill:parent
    color: "CornSilk"

    Rectangle{
        id: rootrec
        anchors.fill:parent
        anchors.topMargin: 10*dp
        color: "transparent"



        Column{
            spacing: 10*dp
            ScrollView {
                id: scrollview1

                //まだできていないが。。。
                width: rootrec.width
                height: rootrec.height * 0.65

                GridLayout {
                    id: grid

                    anchors.left: parent.left
                    anchors.leftMargin: 30*dp
                    anchors.topMargin: 50*dp

                    columns: 3
                    rows: 8

                    columnSpacing: 8*dp
                    rowSpacing: 4*dp

                    // patient id
                    CheckBox{
                        id: editPatientIdChkbox; text: "患者ID"; width: label_width; height:label_height
                    }
                    InfoEditTextBox{
                        id: patientIdTextbox; text: richListCurrentStudy.patientID // "353657"
                        anchors.top: editPatientIdChkbox.top
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}


                    // patientromaname
                    CheckBox{
                        id: editPatientRomaNameChkbox; text: "ローマ字氏名"; width: label_width; height:label_height
                    }
                    InfoEditTextBox{
                        id: patientRomaNameTextbox
                        text: richListCurrentStudy.patientRomaName //"Taro Arei"
                        anchors.top: editPatientRomaNameChkbox.top
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}


                    // patientkanjiname
                    CheckBox{
                        id: editPatientKanjiNameChkbox; text: "漢字氏名"; width: label_width; height:label_height
                    }
                    InfoEditTextBox{
                        id: patientKanjiNameTextbox
                        text: richListCurrentStudy.patientName //"亜鈴 太郎"
                        anchors.top: editPatientKanjiNameChkbox.top
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}

                    // patientkananame
                    CheckBox{
                        id: editPatientKanaNameChkbox; text: "かな氏名"; width: label_width; height:label_height
                    }
                    InfoEditTextBox{
                        id: patientKanaNameTextbox; text: richListCurrentStudy.patientKanaName //"あれい たろう"
                        anchors.top: editPatientKanaNameChkbox.top
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}

                    // birthdate
                    CheckBox{
                        id: editBirthChkbox; text: "生年月日"; width: label_width; height:label_height
                    }
                    InfoEditTextBox{
                        id: birthTextbox; text: richListCurrentStudy.birthdate  //"19350510"
                        anchors.top: editBirthChkbox.top
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}


                    // gender
                    CheckBox{
                        id: editGenderChkbox; text: qsTr("性別"); width: label_width; height:label_height
                    }

                    Rectangle{
                        width: patientIdTextbox.width
                        height:editGenderChkbox.height
                        anchors.top: editGenderChkbox.top
                        color: "transparent"
                        Row{

                            RadioButton {
                                id:maleRadioBtn; text: qsTr("男");

                                checked: richListCurrentStudy.sex === "M"? true:false
                                onClicked: {
                                    maleRadioBtn.checked = true
                                    if(checked) {
                                        femaleRadioBtn.checked = false
                                        otherRadioBtn.checked = false
                                        originalRadioBtn.checked = false
                                    }
                                }
                            }
                            RadioButton {
                                id:femaleRadioBtn; text:qsTr("女")
                                anchors.top: editGenderChkbox.top
                                checked: richListCurrentStudy.sex === "F"? true:false
                                onClicked: {
                                    femaleRadioBtn.checked = true
                                    if(checked) {
                                        maleRadioBtn.checked = false
                                        otherRadioBtn.checked = false
                                        originalRadioBtn.checked = false
                                    }
                                }
                            }
                            RadioButton {
                                id:otherRadioBtn; text:qsTr("他")
                                anchors.top: editGenderChkbox.top
                                checked: richListCurrentStudy.sex === "O"? true:false
                                onClicked: {
                                    otherRadioBtn.checked = true
                                    if(checked) {
                                        maleRadioBtn.checked = false
                                        femaleRadioBtn.checked = false
                                        originalRadioBtn.checked = false
                                    }
                                }
                            }
                            RadioButton {
                                id:originalRadioBtn; text:qsTr("空")
                                anchors.top: editGenderChkbox.top
                                checked: richListCurrentStudy.sex === ""? true:false
                                onClicked: {
                                    originalRadioBtn.checked = true
                                    if(checked) {
                                        maleRadioBtn.checked = false
                                        femaleRadioBtn.checked = false
                                        otherRadioBtn.checked = false
                                    }
                                }
                            }
                        }
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}

                    // study desc
                    CheckBox{
                        id: patientCommentChkbox; text: "コメント"; width: label_width; height:label_height
                    }
                    InfoEditRichTextBox{
                        id:　patientCommentTextbox; text: ""  //"Scoutview Cor"
                        anchors.top: patientCommentChkbox.top;
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}

                    //サムネール画像
                    CheckBox{
                        id: patientThumbChkbox; text: "サムネール画像"; width: label_width; height:label_height
                    }
                    Image{
                        id: thumbImg
                        width: 80*dp
                        height:width
                        anchors.top: patientThumbChkbox.top
                        source: richListCurrentStudy.sampleImage
                        fillMode: Image.PreserveAspectFit

                    }

                    Button {
                         id: okbtn
                         text: "適用"
                         width: button_width
                         height: button_height
                         anchors.leftMargin: 20*dp
                         anchors.bottom: thumbImg.bottom
                    }

                }

            }

            // separator--------
            Rectangle {
                id: separator;  height: 1*dp; width: root.width; color: "#cccccc"
            }
            //------------------


            ScrollView {
                id: scrollview2

                width: rootrec.width
                height: rootrec.height*0.35

                GridLayout {
                    id: grid2

                    anchors.left: parent.left
                    anchors.leftMargin: 30*dp

                    columns: 2
                    rows: 2

                    columnSpacing: 8*dp
                    rowSpacing: 4*dp

                    // 登録日時
                    Text{
                        id: createDateTimeLabel; text: "登録日時: "; width: label_width; height:label_height
                    }
                    Text{
                        id: 　createDateTimeText; text: "2010/12/11 08:10:00"
                    }

                    // 変更日時
                    Text{
                        id: updateDateTimeLabel; text: "変更日時: "; width: label_width; height:label_height
                    }
                    Text{
                        id: updateDateTimeText; text: "2014/04/07 15:30:00"
                    }

               }
            }
        }
    }
}
