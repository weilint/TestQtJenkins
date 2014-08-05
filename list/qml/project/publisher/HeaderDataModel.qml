import QtQuick 2.0

ListModel {
    id: items
    ListElement {statusIcon:"";
                jobStatus: "ジョブステータス";
                createDateTime:"作成日時";
                patientID:"患者ID";
                patientName:"患者名";
                numOfStudies:"検査数";
                newestStudyDate:"最新検査の検査日";
                modality:"モダリティ";
                bodyPartExamined:"部位";
                discType:"ディスク種別";
                copyNum:"出力枚数";
                recreateButton:""
    }
}
