import QtQuick 2.1

ListModel {
    id: items

    ListElement {PatientName: "353657^亜鈴 太郎^78歳 男^"; StudyDate:"20140228"; StudyTime:"103200.000"; PatientID:"12353657"; PatientSex:"M"; PatientAge:"78"; Modality:"CR"; BodyPartExamined:"CHEST"; AccessionNumber:"2-2"; SampleImage:"../data/richlist/111.jpg" }
    // ListElement {PatientName: "353657^亜鈴 太郎^78歳 男^"; StudyDate:"20140228"; StudyTime:"103200.000"; PatientID:"12353657"; PatientSex:"M"; PatientAge:"78"; Modality:"一般撮影"; BodyPartExamined:"CHEST"; AccessionNumber:"2-2"; SampleImage:"../data/richlist/111.jpg" }

    ListElement {PatientName: "353657^亜鈴 太郎^78歳 男^"; StudyDate:"20140227"; StudyTime:"101000.000"; PatientID:"12353657"; PatientSex:"M"; PatientAge:"78"; Modality:"CT"; BodyPartExamined:"CHEST"; AccessionNumber:"12-478"; SampleImage:"../data/richlist/112.jpg" }

    ListElement {PatientName: "353657^亜鈴 太郎^78歳 男^"; StudyDate:"20130723"; StudyTime:"103200.000"; PatientID:"12353657"; PatientSex:"M"; PatientAge:"78"; Modality:"ECG"; BodyPartExamined:"HEART"; AccessionNumber:"2-2"; SampleImage:"../data/richlist/113.jpg" }
    // ListElement {PatientName: "353657^亜鈴 太郎^78歳 男^"; StudyDate:"20130723"; StudyTime:"103200.000"; PatientID:"12353657"; PatientSex:"M"; PatientAge:"78"; Modality:"心電図"; BodyPartExamined:"HEART"; AccessionNumber:"2-2"; SampleImage:"../data/richlist/113.jpg" }

    // -----

    ListElement {PatientName: "583381^渋谷 花子^53歳 女^"; StudyDate:"20140227"; StudyTime:"124800.000"; PatientID:"12583381"; PatientSex:"F"; PatientAge:"53"; Modality:"MRI"; BodyPartExamined:"BRAIN"; AccessionNumber:"7-80"; SampleImage:"../data/richlist/201.jpg" }

    ListElement {PatientName: "583381^渋谷 花子^53歳 女^"; StudyDate:"20140226"; StudyTime:"131000.000"; PatientID:"12583381"; PatientSex:"F"; PatientAge:"53"; Modality:"CR"; BodyPartExamined:"HEAD"; AccessionNumber:"2-2"; SampleImage:"../data/richlist/202.jpg" }
    // ListElement {PatientName: "583381^渋谷 花子^53歳 女^"; StudyDate:"20140226"; StudyTime:"131000.000"; PatientID:"12583381"; PatientSex:"F"; PatientAge:"53"; Modality:"一般撮影"; BodyPartExamined:"HEAD"; AccessionNumber:"2-2"; SampleImage:"../data/richlist/202.jpg" }

    ListElement {PatientName: "583381^渋谷 花子^53歳 女^"; StudyDate:"20140227"; StudyTime:"133500.000"; PatientID:"12583381"; PatientSex:"F"; PatientAge:"53"; Modality:"レポート/JPEG"; BodyPartExamined:"HEAD"; AccessionNumber:"3-3"; SampleImage:"../data/richlist/203.jpg" }

    // -----

    ListElement {PatientName: "883259^東京 次郎^35歳 男^"; StudyDate:"20140114"; StudyTime:"143300.000"; PatientID:"12883259"; PatientSex:"M"; PatientAge:"35"; Modality:"PET/CT"; BodyPartExamined:"LSPINE"; AccessionNumber:"7-738"; SampleImage:"../data/richlist/301.jpg" }

    ListElement {PatientName: "883259^東京 次郎^35歳 男^"; StudyDate:"20130112"; StudyTime:"133500.000"; PatientID:"12883259"; PatientSex:"M"; PatientAge:"35"; Modality:"MRI"; BodyPartExamined:"LSPINE"; AccessionNumber:"15-486"; SampleImage:"../data/richlist/302.jpg" }

    ListElement {PatientName: "883259^東京 次郎^35歳 男^"; StudyDate:"20130110"; StudyTime:"113100.000"; PatientID:"12883259"; PatientSex:"M"; PatientAge:"35"; Modality:"CR"; BodyPartExamined:"ANKLE"; AccessionNumber:"1-1"; SampleImage:"../data/richlist/303.jpg" }
    // ListElement {PatientName: "883259^東京 次郎^35歳 男^"; StudyDate:"20130110"; StudyTime:"113100.000"; PatientID:"12883259"; PatientSex:"M"; PatientAge:"35"; Modality:"一般撮影"; BodyPartExamined:"ANKLE"; AccessionNumber:"1-1"; SampleImage:"../data/richlist/303.jpg" }


    //ソート
    function sortModel(icolumnIndex)
    {
        var n;
        var i;

        if(icolumnIndex <0) icolumnIndex = 0;
        for (n=0; n < items.count; n++)
        {
            for (i=n+1; i < items.count; i++)
            {
                if(icolumnIndex === 0){　//患者ID昇順
                   if (items.get(n).PatientID > items.get(i).PatientID){
                       items.move(i, n, 1);
                       n=0;
                   }else if (items.get(n).PatientID === items.get(i).PatientID){
                        //同一患者IDの場合は検査日時の降順
                       n = sortByStudyDate(i, n)
                   }
                }else{
                    //検査日時の降順
                    n = sortByStudyDate(i, n)
                }
            }
        }
    }

    //検査日の降順でソート
    function sortByStudyDate(i, n)
    {
        if (items.get(n).StudyDate < items.get(i).StudyDate)
        {
            //検査日の降順
            items.move(i, n, 1);
            n=0;
        }else if (items.get(n).StudyDate === items.get(i).StudyDate)
        {
            if (items.get(n).StudyTime < items.get(i).StudyTime)
            {
                //同一検査日の場合は検査時刻の降順
                items.move(i, n, 1);
                n=0;
            }
        }

        return n
    }


}

