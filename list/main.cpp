#include <QFont>
#include <QTextCodec>
#include <QtQml>
#include <QQmlContext>
#include <QFileInfo>
#include <QTextStream>
#include <QScreen>
#include <windows.h>

#include <QDebug>
#include "qtquick2controlsapplicationviewer.h"
#include "functions/qml_studylisthelper.h"
#include "functions/qml_exporthelper.h"
#include "iniparam.h"

#define JTR( localString ) QTextCodec::codecForLocale()->toUnicode( localString )


//　Global values ------------------
QtQuick2ControlsApplicationViewer *g_pViewer;
QQmlContext *g_pContext;

//デモデータ-----------------------
QList<QObject *> g_mainList;
QList<QObject *> g_remoteList;
//QList<QObject *> g_smartList;
//-----------------------------

//検査リストに表示するデータ QML_StudyListObject
QList<QObject *> g_studyList;
QList<QObject *> g_exportList;
QList<QObject *> g_exportDisplayList;

// timeline
QList<QObject *> g_timelineStudyList;
QString g_currentPatientId = "";
QStringList g_timelineModalityList;
QStringList g_timelineStudyDateList;
QStringList bg_timelineStructure;
QStringList bg_retrievedStudyImage;

int g_currentStudyIndex = 0; //検査リストのカレントインデックス


//サムネールプレビュー中の検査とシリーズ情報
QML_StudyListObject *g_pCurrentStudy = new QML_StudyListObject();
//シリーズの画像リスト QML_SeriesListObject
QList<QObject *> g_seriesList;

QList<QObject *> g_flagList;

//編集用の検査情報
QML_EditInfoObject *g_pEditInfo = new QML_EditInfoObject();

//export用
QStringList g_exportModalityList;
QStringList g_exportStudydateList;


//初期設定　list.ini
IniParam *g_pIniParam = new IniParam();
//---------------------------------

int main(int argc, char *argv[])
{
    //Database *m_db;

    //QStringList list;
    //list << "one" << "two" << "three" << "four";

    Application app(argc, argv);

    HDC screen = GetDC(0);
    double scaleX = GetDeviceCaps(screen, LOGPIXELSX);
    bool isTouch = false;
    if (scaleX >= 120)
    {
        isTouch = true;
    }

    //implement density-independent pixel
    double dp = scaleX/96;

    //初期設定
    QFileInfo fInfo(QString::fromLocal8Bit(argv[0]));
    g_pIniParam = new IniParam(fInfo.absolutePath() + "/" + fInfo.baseName() + ".ini");

    qmlRegisterType<QML_StudyListHelper>("StudyListLibrary", 1, 0, "QML_StudyListHelper");
    qmlRegisterType<QML_StudyListObject>("StudyObjectLibrary", 1, 0, "QML_StudyListObject");
    qmlRegisterType<QML_EditInfoObject>("EditInfoLibrary", 1, 0, "QML_EditInfoObject");
    qmlRegisterType<QML_SeriesListObject>("SeriesLisLibrary", 1, 0, "QML_SeriesListObject");
    qmlRegisterType<QML_ImageListObject>("ImageListLibrary", 1, 0, "QML_ImageListObject");

    // +++<S>+++
    // フォント設定
    QFont font;
    font.setPointSize(10);
    font.setFamily(JTR("メイリオ"));
    app.setFont(font);
    // +++<E>+++

    QtQuick2ControlsApplicationViewer viewer;
    g_pViewer = &viewer;
    g_pContext = g_pViewer->rootContext();

    //-----------
    //検査リストの表示情報
    QML_StudyListHelper *pRitchListHelper = new QML_StudyListHelper;
    pRitchListHelper->initStudies();
    //-----------
    pRitchListHelper->initFlagList();

    QML_ExportHelper *pExportHelper = new QML_ExportHelper;

    //QMLへ登録----------------
    //RichListViewのデータモデルのヘルパークラス
    g_pContext->setContextProperty(QMLRichListViewModel, QVariant::fromValue(g_studyList));
    g_pContext->setContextProperty(QMLStudyListHelper, pRitchListHelper);    

    //Export用
    g_pContext->setContextProperty(QMLExportListViewModel, QVariant::fromValue(g_exportList));
    g_pContext->setContextProperty(QMLExportHelper, pExportHelper);

    //DICOM属性編集タブとの受け渡しObject
    g_pContext->setContextProperty(QMLEditStudyObject, g_pEditInfo);


    //Previewタブとの受け渡しObject
    g_pContext->setContextProperty(QMLPreviewSeriesModel, QVariant::fromValue(g_seriesList));  //???

    //カレント検査Object
    g_pContext->setContextProperty(QMLRichListCurrentStudy, QVariant::fromValue(g_pCurrentStudy));

    //timeline用のStudyList
    g_pContext->setContextProperty(QMLTimelineStudyModel, QVariant::fromValue(g_timelineStudyList));
    g_pContext->setContextProperty(QMLTimelineModalityList, QVariant::fromValue(g_timelineModalityList));
    g_pContext->setContextProperty(QMLTimelineStudyDateList, QVariant::fromValue(g_timelineStudyDateList));

    //export用
    g_pContext->setContextProperty(QMLExportModalityList, QVariant::fromValue(g_exportModalityList));
    g_pContext->setContextProperty(QMLExportStudyDateList, QVariant::fromValue(g_exportStudydateList));
    g_pContext->setContextProperty(QMLExportDisplayList, QVariant::fromValue(g_exportDisplayList));

    // dp設定
    g_pContext->setContextProperty(QLatin1String("dp"), QVariant::fromValue(dp));
    g_pContext->setContextProperty(QLatin1String("isTouch"), QVariant::fromValue(isTouch));


    //for test
    qDebug() << "patientName" << g_pCurrentStudy->patientName();
    //g_pContext->setContextProperty(QMLRichListCurrentPatient, QVariant::fromValue(g_pCurrentStudy->patientSection()));
    //-----------------------

    viewer.setMainQmlFile(QStringLiteral("qml/project/main.qml"));

    // QMLのSIGNAL連結
//    QObject *qmlObject = (QObject *)viewer.rootObject();
    //-----------------------
    //SLOT　テスト、実際は未使用
//    QObject::connect(qmlObject,
//                     SIGNAL(qmlEditTestSignal(int, QString)),
//                     (QObject *)pRitchListHelper,
//                     SLOT(qmlEditTestSlot(int, QString)));
    //-----------------------

    viewer.show();
    return app.exec();
}
