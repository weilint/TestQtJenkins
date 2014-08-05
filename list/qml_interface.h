#ifndef QML_INTERFACE_H
#define QML_INTERFACE_H

//---------------------------------
//QMLとのインターフェース
//---------------------------------

//検査リストモデル
#define QMLRichListViewModel  "studyListModel"

//検査リストのヘルパークラス
#define QMLStudyListHelper     "richListHelper"

//DICOM属性編集の表示情報
#define QMLEditStudyObject     "editStudyObject"

//サムネールプレビューのデータモデル
#define QMLPreviewSeriesModel  "previewSeriesModel"

//選択中の検査情報
#define QMLRichListCurrentStudy "richListCurrentStudy"

//timelineの検査情報
#define QMLTimelineStudyModel "timelineStudyModel"
#define QMLTimelineModalityList "timelineModalityList"
#define QMLTimelineStudyDateList "timelineStudyDateList"

//export
#define QMLExportListViewModel "exportListModel"
#define QMLExportHelper "exportHelper"
#define QMLExportModalityList "exportModalityList"
#define QMLExportStudyDateList "exportStudyDateList"
#define QMLExportDisplayList "exportDisplayList"

#endif // QML_INTERFACE_H
