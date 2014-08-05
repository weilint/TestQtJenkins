import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1

//B 検査
//検査日時：デフォルトは検査情報から取得
//実施施設（検査を実施した施設を表す内部ID、自施設、不明なども表現）
//*データ種別（DICOM画像か、その他の画像か、文書か、など）
//モダリティ（複数可）：デフォルトはシリーズから自動作成
//部位（複数可）：デフォルトはシリーズから自動作成
//コメント：デフォルトは空欄
//サムネール画像：デフォルトは最大シリーズの中央画像
//*シリーズ数
//*総インスタンス数
//*データサイズ
//*登録日時
//*変更日時
//*最終参照日時
//*参照回数
//*最終エクスポート日時
//*エクスポート回数
//*最終プリント日時
//*プリント回数


Rectangle {
    property variant instData: InstitutionDataModel{}
    property int label_width: 150*dp
    property int label_height: 30*dp
    property int value_width:500*dp

    property int button_width: 120*dp
    property int button_height: 30*dp

    property int colseprec_width: 50*dp

    id: root
    anchors.fill:parent
    //color: "LightYellow"
    color: "FloralWhite"

    Rectangle{
        id: rootrec
        anchors.fill:parent
        anchors.topMargin: 10*dp
        color: "transparent"

        Column{
            spacing: 10*dp

            ScrollView {
                id: scrollview1
                width: rootrec.width
                height: rootrec.height * 0.55
                GridLayout {
                    id: grid

                    anchors.left: parent.left
                    anchors.leftMargin: 30*dp
                    anchors.topMargin: 50*dp

                    columns: 3
                    rows: 8

                    columnSpacing: 8*dp
                    rowSpacing: 4*dp

                    // studydate
                    CheckBox{
                        id: editStudyDateChkbox; text: "検査日"; width: label_width; height:label_height
                    }
                    InfoEditTextBox{
                        id: studyDateTextbox; text: richListCurrentStudy.studyDate // "20140228"
                        anchors.top: editStudyDateChkbox.top
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}

                    // studytime
                    CheckBox{
                        id: editStudyTimeChkbox; text: "検査時刻"; width: label_width; height:label_height
                    }
                    InfoEditTextBox{
                        id: studyTimeTextbox; text: richListCurrentStudy.studyTime //"103200"
                        anchors.top: editStudyTimeChkbox.top
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}

                    // institution
                    CheckBox{
                        id: editInstitutionChkbox; text: "実施施設"; width: label_width; height:label_height
                    }
                    InfoEditComboBox2{
                        id: institutionCombobox;    //text: richListCurrentStudy.institutionName //"Array Hospital"
                        anchors.top: editInstitutionChkbox.top
                        model: ["自施設", "アレイ病院", "不明"]
                        currentIndex: getIndex("自施設")
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}


                    // modality
                    CheckBox{
                        id: editModalityChkbox; text: "モダリティ"; width: label_width; height:label_height
                    }
                    InfoEditComboBox2{
                        id: modalityCombobox;   //text: richListCurrentStudy.modality //"CR"
                        anchors.top: editModalityChkbox.top
                        model: [ "AS","AU","BI","CD","CF","CP","CR","CS","CT","CD","DF","DG","DM","DS","DX","EC","ECG","EPS","ES","FA","FS","GM","HC","HD","IVUS","IO","LP","LS","MA","MG","MR","MS","NM","OT","PR","PT","PX","RF","RG","RTDOSE","RTIMAGE","RTRECORD","RTSTRUCT","SM","SR","ST","TG","US","VF","XA","XC"]
                        currentIndex: getIndex(richListCurrentStudy.modality)
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}


                    // body part
                    CheckBox{
                        id: editBodyPartChkbox; text: "検査部位"; width: label_width; height:label_height
                    }
                    InfoEditComboBox2{
                        id: bodyPartCombobox; //text: richListCurrentStudy.bodyPart //"CHEST"
                        anchors.top: editBodyPartChkbox.top
                        model: ["ARM","ABDOMEN","ANKLE","BREAST","CHEST","CLAVICLE","COCCYX","ELBOW","EXTREMITY","FOOT","HAND","HEAD","HEART","HIP","JAW","KNEE","LEG","NECK","PELVIS","SHOULDER","SKULL","CSPINE","LSPINE","SSPINE","TSPINE"]
                        currentIndex: getIndex(richListCurrentStudy.bodyPart)
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}


                    // study desc
                    CheckBox{
                        id: studyCommentChkbox; text: "コメント"; width: label_width; height:label_height
                    }
                    InfoEditRichTextBox{
                        id:studyCommentTextbox; text: ""  //"Scoutview Cor"
                        anchors.top: studyCommentChkbox.top
                    }
                    Rectangle { width: button_width;  height: button_height; color:"transparent"}


                    //サムネール画像：デフォルトは最大シリーズの中央画像
                    //サムネール画像
                    CheckBox{
                        id: studyThumbChkbox; text: "サムネール画像"; width: label_width; height:label_height
                    }
                    Image{
                        id: thumbImg
                        width: 80*dp
                        height:width
                        anchors.top: studyThumbChkbox.top
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
                height: rootrec.height*0.4

                GridLayout {
                    id: grid2

                    anchors.left: parent.left
                    anchors.leftMargin: 30*dp

                    columns: 5
                    rows: 6

                    columnSpacing: 8*dp
                    rowSpacing: 2*dp

                    // データ種別
                    Text{
                        id: dataTypeText;  text: "データ種別:" ;  width: label_width;
                    }
                    Text{
                        id: dataTypeTextbox;
                        text: richListCurrentStudy.modality==="PDF"? "PDFファイル":"DICOM画像"
                    }
                    Rectangle{width: colseprec_width; height: label_height; color:"transparent"}
                    //データサイズ
                    Text{
                        id: dataSizeText; text: "データサイズ: "; width: label_width;
                    }
                    Text{
                        id: dataSizeTextbox; text: "50MB";
                    }

                    //-----
                    //シリーズ数
                    Text{
                        id: seriesNumText; text: "シリーズ数: "; width: label_width;
                    }
                    Text{
                        id: seriesNumTextbox; text: richListCurrentStudy.numOfSerieses;
                    }
                    Rectangle{width: colseprec_width; height: label_height; color:"transparent"}
                    //総インスタンス数
                    Text{
                        id: instanceNumText; text: "総インスタンス数: "; width: label_width;
                    }
                    Text{
                        id: instanceNumTextbox; text: richListCurrentStudy.numOfImages;
                    }



                    //-----
                    // 登録日時
                    Text{
                        id: createDateTimeText; text: "登録日時: "; width: label_width;
                    }
                    Text{
                        id: createDateTimeTextbox; text:"2011/10/10 11:30:20"
                    }
                    Rectangle{width: colseprec_width; height: label_height; color:"transparent"}

                    // 変更日時
                    Text{
                        id: updateDateTimeText; text: "変更日時: "; width: label_width;
                    }
                    Text{
                        id: updateDateTimeTextbox; text:"2014/04/07 13:10:30"
                    }

                    //-----
                    // 最終参照日時
                    Text{
                        id: lastRefDateTimeText; text: "最終参照日時: "; width: label_width;
                    }
                    Text{
                        id: lastRefDateTimeTextbox; text:"2014/04/07 17:20:12"
                    }
                    Rectangle{width: colseprec_width; height: label_height; color:"transparent"}
                    // 参照回数
                    Text{
                        id: refNumeText; text: "参照回数: "; width: label_width;
                    }
                    Text{
                        id: refNumTextbox; text:"1"
                    }

                    //-----
                    // 最終エクスポート日時
                    Text{
                        id: lastExportDateTimeText; text: "最終エクスポート日時: "; width: label_width;
                    }
                    Text{
                        id: lastExportDateTimeTextbox; text:"2014/04/07 14:30:10"
                    }

                    Rectangle{width: colseprec_width; height: label_height; color:"transparent"}
                    // エクスポート回数
                    Text{
                        id: exportNumText; text: "エクスポート回数: "; width: label_width;
                    }
                    Text{
                        id: exportNumbox; text:"1"
                    }


                    //-----
                    // 最終プリント日時
                    Text{
                        id: lastPrintDateTimeText; text: "最終プリント日時: "; width: label_width;
                    }
                    Text{
                        id: lastPrintDateTimeTextbox; text:"2014/04/07 15:30:10"
                    }

                    Rectangle{width: colseprec_width; height: label_height; color:"transparent"}
                    // プリント回数
                    Text{
                        id: printNumText; text: "プリント回数: "; width: label_width;
                    }
                    Text{
                        id: printNumbox; text:"1"
                    }
               }
            }
        }

    }

}
