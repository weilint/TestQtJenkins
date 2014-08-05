import QtQuick 2.0

ListModel {
    id: items
    ListElement {statusIcon:"../res/icon_status_error.png"; jobStatus: "作成失敗";     createDateTime:"20140404 114500"; patientID:"140004"; patientName:"中村 明菜"; numOfStudies:"4"; newestStudyDate:"2014/04/04"; modality:"CR"; bodyPartExamined:"ARM"; discType:"CD"; copyNum:"1" }
    ListElement {statusIcon:"../res/icon_status_error.png"; jobStatus: "作成キャンセル";  createDateTime:"20140404 131000"; patientID:"150005"; patientName:"保泉 奈奈"; numOfStudies:"5"; newestStudyDate:"2014/04/04"; modality:"CR"; bodyPartExamined:"CHEST"; discType:"CD"; copyNum:"1" }
    ListElement {statusIcon:"../res/spinner3-greenie.gif"; jobStatus: "作成準備中";   createDateTime:"20140404 141000"; patientID:"110001"; patientName:"亜鈴 花子"; numOfStudies:"1"; newestStudyDate:"2013/10/11"; modality:"CT"; bodyPartExamined:"HEAD"; discType:"CD"; copyNum:"2" }
    ListElement {statusIcon:"../res/spinner3-greenie.gif"; jobStatus: "作成準備中";   createDateTime:"20140404 142000"; patientID:"111001"; patientName:"亜鈴 明子"; numOfStudies:"1"; newestStudyDate:"2012/11/19"; modality:"CT"; bodyPartExamined:"HEAD"; discType:"CD"; copyNum:"2" }
    ListElement {statusIcon:"../res/spinner3-greenie.gif"; jobStatus: "作成準備中";   createDateTime:"20140404 143000"; patientID:"112001"; patientName:"亜鈴 天美"; numOfStudies:"1"; newestStudyDate:"2012/09/25"; modality:"CT"; bodyPartExamined:"HEAD"; discType:"CD"; copyNum:"2" }
    ListElement {statusIcon:"../res/spinner3-greenie.gif"; jobStatus: "作成中";     　createDateTime:"20140404 135500"; patientID:"120002"; patientName:"亜鈴 一郎"; numOfStudies:"2"; newestStudyDate:"2013/12/14"; modality:"MR/CR"; bodyPartExamined:"NECK/CHEST"; discType:"DVD"; copyNum:"1" }
    ListElement {statusIcon:"../res/spinner3-greenie.gif"; jobStatus: "作成中";     　createDateTime:"20140404 140000"; patientID:"120002"; patientName:"亜鈴 太郎"; numOfStudies:"2"; newestStudyDate:"2013/12/14"; modality:"MR/CR"; bodyPartExamined:"NECK/CHEST"; discType:"DVD"; copyNum:"1" }


    //ソート
    function sortModel(icolumnIndex, bAsc)
    {
        var n;
        var i;

        if(icolumnIndex <0) icolumnIndex = 0;
        for (n=0; n < items.count; n++)
        {
            for (i=n+1; i < items.count; i++)
            {
                var sn,si
                switch(icolumnIndex) {
                    case 0:
                        sn = items.get(n).jobStatus
                        si = items.get(i).jobStatus
                        break
                    case 1:
                        sn = items.get(n).createDateTime
                        si = items.get(i).createDateTime
                        break
                    case 2:
                        sn = items.get(n).patientID
                        si = items.get(i).patientID
                        break
                    case 3:
                        sn = items.get(n).patientName
                        si = items.get(i).patientName
                        break
                    case 4:
                        sn = items.get(n).numOfStudies
                        si = items.get(i).numOfStudies
                        break
                    case 5:
                        sn = items.get(n).newestStudyDate
                        si = items.get(i).newestStudyDate
                        break
                    case 6:
                        sn = items.get(n).modality
                        si = items.get(i).modality
                        break
                    case 7:
                        sn = items.get(n).bodyPartExamined
                        si = items.get(i).bodyPartExamined
                        break
                    case 8:
                        sn = items.get(n).discType
                        si = items.get(i).discType
                        break
                    case 9:
                        sn = items.get(n).copyNum
                        si = items.get(i).copyNum
                        break
                }

                if(bAsc) {
                    if (sn > si){
                        items.move(i, n, 1);
                        n=0;
                    }
                }else{
                    if (sn < si){
                        items.move(i, n, 1);
                        n=0;
                    }
                }

            }
        }
    }

}
