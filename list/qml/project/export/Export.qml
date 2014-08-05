import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.0

Window {
    id: exportwin
    width:900 * dp
    height:500 * dp
    //visible: false
    title: "エクスポート"
    property var exportfirst: Export_firstpage{}
    property var exportsecond: Export_secondpage{}
    property variant patientDataModel: PatientDataModel{}
    property variant sendDataModel: InstitutionDataModel{}
    property alias loaderSource: main.sourceComponent
    property string exportpatient: patientDataModel.get(0).PatientName + patientDataModel.get(0).Birth
    property string exportsend: sendDataModel.get(0).Name
    property bool canGoNext: true

    ListModel {
        id: pat1123456
        ListElement {StudyDate: "2014/01/30"; Modality: "CT"; Part: "HEAD"; NumSeries: "6シリーズ"; NumImg:"133画像"; ImageSource: "../data/01/00019767.jpg"; IsChecked: false}
        ListElement {StudyDate: "2013/11/19"; Modality: "MR"; Part: "CHEST"; NumSeries: "6シリーズ"; NumImg:"130画像"; ImageSource: "../data/02/00019779.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/10/05"; Modality: "CR"; Part: "HEAD"; NumSeries:"6シリーズ"; NumImg:"139画像"; ImageSource: "../data/05/00019999.jpg"; IsChecked: false}
        ListElement {StudyDate: "2013/11/19"; Modality: "PDF"; Part: "レポート"; NumSeries:"1ページ"; NumImg:""; ImageSource: "../data/th.jpg"; IsChecked: false}
    }

    ListModel {
        id: pat1134567
        ListElement {StudyDate: "2014/05/03"; Modality: "CT"; Part: "HEAD"; NumSeries: "1シリーズ"; NumImg:"13画像"; ImageSource: "../data/12/00020233.jpg"; IsChecked: false}
        ListElement {StudyDate: "2013/04/06"; Modality: "MR"; Part: "CHEST"; NumSeries: "3シリーズ"; NumImg:"1画像"; ImageSource: "../data/10/00020191.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/12/05"; Modality: "MR"; Part: "HEAD"; NumSeries:"4シリーズ"; NumImg:"39画像"; ImageSource: "../data/11/00020195.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/12/05"; Modality: "PDF"; Part: "レポート"; NumSeries:"1ページ"; NumImg:""; ImageSource: "../data/th.jpg"; IsChecked: false}
    }

    ListModel {
        id: pat1234567
        ListElement {StudyDate: "2014/05/03"; Modality: "CT"; Part: "HEAD"; NumSeries: "7シリーズ"; NumImg:"8画像"; ImageSource: "../data/06/00020019.jpg"; IsChecked: false}
        ListElement {StudyDate: "2013/04/06"; Modality: "MR"; Part: "CHEST"; NumSeries: "1シリーズ"; NumImg:"244画像"; ImageSource: "../data/08/00020093.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/12/05"; Modality: "OT"; Part: "HEAD"; NumSeries:"5シリーズ"; NumImg:"93画像"; ImageSource: "../data/07/00020040.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/12/05"; Modality: "PDF"; Part: "レポート"; NumSeries:"1ページ"; NumImg:""; ImageSource: "../data/th.jpg"; IsChecked: false}
    }

    ListModel {
        id: pat1357246
        ListElement {StudyDate: "2014/03/17"; Modality: "OT"; Part: "HEAD"; NumSeries: "1シリーズ"; NumImg:"13画像"; ImageSource: "../data/12/00020233.jpg"; IsChecked: false}
        ListElement {StudyDate: "2013/04/06"; Modality: "MR"; Part: "CHEST"; NumSeries: "3シリーズ"; NumImg:"1画像"; ImageSource: "../data/08/00020052.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/12/05"; Modality: "MR"; Part: "HEAD"; NumSeries:"4シリーズ"; NumImg:"39画像"; ImageSource: "../data/09/00020117.jpg"; IsChecked: false}
        ListElement {StudyDate: "2014/03/17"; Modality: "PDF"; Part: "レポート"; NumSeries:"1ページ"; NumImg:""; ImageSource: "../data/th.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/12/05"; Modality: "PDF"; Part: "レポート"; NumSeries:"2ページ"; NumImg:""; ImageSource: "../data/th.jpg"; IsChecked: false}
    }

    ListModel {
        id: pat7654321
        ListElement {StudyDate: "2014/05/03"; Modality: "CT"; Part: "HEAD"; NumSeries: "1シリーズ"; NumImg:"13画像"; ImageSource: "../data/12/00020233.jpg"; IsChecked: false}
        ListElement {StudyDate: "2013/04/06"; Modality: "MR"; Part: "CHEST"; NumSeries: "3シリーズ"; NumImg:"1画像"; ImageSource: "../data/10/00020191.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/12/05"; Modality: "MR"; Part: "HEAD"; NumSeries:"4シリーズ"; NumImg:"39画像"; ImageSource: "../data/11/00020195.jpg"; IsChecked: false}
        ListElement {StudyDate: "2012/12/05"; Modality: "PDF"; Part: "レポート"; NumSeries:"1ページ"; NumImg:""; ImageSource: "../data/th.jpg"; IsChecked: false}
    }

//    onVisibleChanged:
//    {
//        if (visible === true)
//        {
//            console.debug("visible changed export")
//            main.sourceComponent = exportfirst
//            //main.source = "Export_firstpage.qml"
//        }
//    }

    onVisibleChanged:
    {
        console.debug("visible changed")
        main.sourceComponent = exportfirst;
    }


    Rectangle {
        id:loaderrect
        anchors.top: parent.top
        anchors.left: parent.left
        //anchors.bottom: buttonrect.top
        width: exportwin.width
        height: (parent.height - buttonrect.height)
        Loader {
            id:main
            anchors.fill: parent
            //height: parent.height * dp
            //source: "Export_firstpage.qml"
            sourceComponent: exportfirst
            onLoaded: {
                console.debug("loaded")

                //exportwin.show()
//                buttonrect.bottom = parent.bottom
//                this.bottom = buttonrect.top
//                this.top = e
            }

        }
    }

    Rectangle {
        id: buttonrect
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: loaderrect.bottom
        height: 50 *dp
        width: loaderrect.implicitWidth
        //width: parent.width
        color: "lightgray"


        Button {
            id: previousbutton
            anchors.left: parent.left
            anchors.leftMargin: 10 * dp
            anchors.verticalCenter: parent.verticalCenter
            height: 30 * dp
            text: "前へ"
            visible: {
                if (main.sourceComponent === exportfirst){
                    return false
                }
                else {
                    return true
                }
            }
            onClicked: {
                main.sourceComponent = exportfirst
            }
        }

        Button {
            id: nextbutton
            anchors.right: parent.right
            anchors.rightMargin: 10 * dp
            anchors.verticalCenter: parent.verticalCenter
            enabled: canGoNext
            height: 30 * dp
            text: {
                if (main.sourceComponent === exportfirst){
                    return "次へ"
                }
                else {
                    return "閉じる"
                }
            }

            onClicked: {
                if (text === "次へ") {

                    switch (exportpatient.substring(0,7))
                    {
                        case "1123456":
                        setupExportList(pat1123456);
                        break;
                        case "1134567":
                        setupExportList(pat1134567);
                        break;
                        case "1234567":
                        setupExportList(pat1234567);
                        break;
                        case "1357246":
                        setupExportList(pat1357246);
                        break;
                        case "7654321":
                        setupExportList(pat7654321);
                        break;
                    }
                    main.sourceComponent =  exportsecond
                }
                else
                {
                    //main.sourceComponent = exportfirst
                    //exportwin.visible= false

                    exportwin.close()
                }
            }

            function setupExportList(m){
                console.debug("in setupExportList")
                exportHelper.qmlClearExportList();
                for (var i = 0; i < m.count; i++){
                    var _studydate = m.get(i).StudyDate;
                    var _modality = m.get(i).Modality;
                    var _part = m.get(i).Part;
                    var _numseries = m.get(i).NumSeries;
                    var _numimg = m.get(i).NumImg;
                    var _imgsource = m.get(i).ImageSource;
                    var _ischecked = m.get(i).IsChecked
                    exportHelper.qmlAddToExportList(_studydate, _modality, _part, _numseries, _numimg, _imgsource, _ischecked);
                }
                exportHelper.qmlSetExportDisplayList();
                console.debug("count in export display = " + exportDisplayList.length);
            }
        }
    }
}


