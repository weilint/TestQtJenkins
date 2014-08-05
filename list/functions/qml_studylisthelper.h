#ifndef QML_STUDYLISTHELPER_H
#define QML_STUDYLISTHELPER_H

#include <QtQml>
#include <QQmlContext>
#include <QDebug>
#include <QProcess>

#include "qtquick2controlsapplicationviewer.h"
#include "../objects/qml_studylistobject.h"
#include "../objects/qml_editinfoobject.h"
#include "../objects/qml_serieslistobject.h"
#include "../objects/qml_imagelistobject.h"
#include "../qml_interface.h"
#include "../iniparam.h"
#include "../searchstudykey.h"
#include "../common_functions.h"
#include "../objects/qml_flagobject.h"



//デモデータ-----------------------
extern QList<QObject *> g_mainList;
extern QList<QObject *> g_remoteList;
//extern QList<QObject *> g_smartList;
//-----------------------------

//　Global values ------------------
extern QList<QObject *> g_studyList;  //QML_StudyListObject
extern QList<QObject *>g_flagList;

// tiimeline用
extern QList<QObject *> g_timelineStudyList;
extern QString g_currentPatientId;
extern QStringList g_timelineModalityList;
extern QStringList g_timelineStudyDateList;
extern QStringList bg_timelineStructure;
extern QStringList bg_retrievedStudyImage;

//サムネールプレビュー中の検査とシリーズ情報
extern int g_currentStudyIndex;
extern QML_StudyListObject *g_pCurrentStudy;
extern QList<QObject *> g_seriesList;

//extern QStringList g_flagList;

extern QtQuick2ControlsApplicationViewer *g_pViewer;
extern QQmlContext *g_pContext;

//DICOM属性編集
extern QML_EditInfoObject *g_pEditInfo;

//初期設定
extern IniParam *g_pIniParam;


//---------------------------------

class QML_StudyListHelper: public QObject
{
    Q_OBJECT
public:
    explicit QML_StudyListHelper(QObject *parent = 0);

    bool initStudies();
    static void updateStudyListView();

    //for study list-------------------
    Q_INVOKABLE void qmlSortStudyList(int indexOfSortKey );

    Q_INVOKABLE  void qmlSetCurrentIndex(const int index );
    Q_INVOKABLE bool qmlEditCurrentStudy(const QString  patientID,
                                  const QString  patientName,
                                  const QString  patientKanaName,
                                  const QString  patientRomaName,
                                  const QString  sex,
                                  const QString  birthdate,
                                  const QString  accessionNumber,
                                  const QString  studyDate,
                                  const QString  studyTime,

                                  const QString  institutionName,
                                  const QString  readingPhysName,
                                  const QString  studyID,
                                  const QString  studyDesc,
                                  const QString  refPhysName,

                                  const QString  modality,
                                  const QString  bodyPart,
                                  const QString  seriesDesc,
                                  const QString  patientPos,
                                  const QString  larerality
                                );


    Q_INVOKABLE int qmlGetNumOfImagesAt(int indexOfSeries);

    Q_INVOKABLE void qmlUpdatePreviewAt(int indexOfStudy, int folderIndex, int sortKeyIndex);

    Q_INVOKABLE QString qmlGetPatientNameAt(int indexOfStudy);
    Q_INVOKABLE QString qmlGetPatientIDAt(int indexOfStudy);

    //for DICOM edit--------------
    //まだ、QMLからの呼び出しができない
    Q_INVOKABLE  bool qmlUpdateStudyAt(const int index, const QML_EditInfoObject &pEditObj);
    //-----------------------------

    //検索
    Q_INVOKABLE int qmlSearchStudies(QString searchFilter, int folderIndex, int sortkeyIndex);

    Q_INVOKABLE void qmlGetRemoteStudies();

    Q_INVOKABLE QString qmlGetRemoteFolderSearchKey();

    //スマートフォルダーの検索キー
    Q_INVOKABLE QString qmlGetSmartFolderSearchKey();

    Q_INVOKABLE QStringList qmlRemoveFlag(QStringList flaglist, int index);

    Q_INVOKABLE QStringList qmlAddFlag(QStringList flaglist, QString flag);

    Q_INVOKABLE QString qmlGetFlagIcon(QString flagname);

    Q_INVOKABLE QString qmlGetTimeLineImage(QString modality, QString studydate);

    //ビューアーとの連携
    Q_INVOKABLE int qmlStartViewerAt(int indexOfFolder, int indexOfStudyInShowingList);

    //Preludioを起動
    Q_INVOKABLE int qmlStartPreludio();

    Q_INVOKABLE int qmlGetStudyIndexByImage(QString thumbnail);

public slots:

    //--------------------------test--------------------
public:
    bool initTestStudies();
    void initFlagList();

public slots:
    bool qmlEditTestSlot(const int index,  const QString  patientName);
    //--------------------------------------------

private:
    void setCurrentEditStudy(const int index );
    bool updateStudyListAt(const int index,
                                  const QString  patientID,
                                  const QString  patientName,
                                  const QString  patientKanaName,
                                  const QString  patientRomaName,
                                  const QString  sex,
                                  const QString  birthdate,

                                  const QString  accessionNumber,
                                  const QString  studyDate,
                                  const QString  studyTime,
                                  const QString  institutionName,
                                  const QString  readingPhysName,
                                  const QString  studyID,
                                  const QString  studyDesc,
                                  const QString  refPhysName,

                                  const QString  modality,
                                  const QString  bodyPart,
                                  const QString  seriesDesc,
                                  const QString  patientPos,
                                  const QString  larerality
                                );

    void setCurrentPreview(int index, int folderIndex, int sortKeyIndex);
    void setImageListModelAt(int indexOfSeries);

    int searchStudiesAs(SearchStudyKey *cond, int sortkeyIndex);
    void sortStudies(QList<QObject *>& studyList, int sortkeyIndex);


    bool initTestStudiesFromDB(QString filter, QList<QObject *>& studyList);
    bool searchStudiesFromSrcList(QList<QObject *>& srcStudyList, SearchStudyKey *cond, int sortkeyIndex, QList<QObject *>& resultStudyList);
    bool checkValueAsFilter(QString value, QString filter);
    bool checkValueAsDateRangeFilter(QString value, QString filter);

    int searchStudies(QString searchFilter, int folderIndex, int sortkeyIndex);

    int makeSearchKeys(QString searchFilter, SearchStudyKey* cond);

    void setTimelineModalityList();
    void setTimelineStudyDateList();

    int startViewerAt(int indexOfFolder, int indexOfStudyInShowingList);
    int createViewStartFile(QString  pid, QString studyuid);
    int copyPatientDicomFilesIfNeed(int folderIndex, QString  pid);

};

#endif // QML_STUDYLISTHELPER_H
