#include "qml_studylisthelper.h"


void QML_StudyListHelper::setCurrentPreview(int index, int folderIndex, int sortkeyIndex)
 {
    g_seriesList.clear();
    g_pCurrentStudy=new QML_StudyListObject();

    if(index < g_studyList.length() && index >=0 ) {
        QML_StudyListObject *pObj = (QML_StudyListObject *)g_studyList.at(index);
          g_seriesList = pObj->seriesList();
    }

    //qDebug() << QString("g_seriesList.length=%1").arg(g_seriesList.length());
    //QMLへ登録 
    for(int i = 0; i < g_seriesList.length(); i++){
        setImageListModelAt(i);  //カレント検査の各シリーズ
    }

    if(index >= 0 && index < g_studyList.length()){
        g_pCurrentStudy = (QML_StudyListObject *)g_studyList.at(index);
        //カレント検査
        qDebug() << "patientName" << g_pCurrentStudy->patientName();
    }

    g_pContext->setContextProperty(QMLRichListCurrentStudy, QVariant::fromValue(g_pCurrentStudy));
    //g_pContext->setContextProperty(QMLRichListCurrentPatient, QVariant::fromValue(g_pCurrentStudy->patientSection()));

    // for timeline
    QString patientid = g_pCurrentStudy->patientID();
    if (g_currentPatientId != patientid)
    {
        bg_retrievedStudyImage.clear();
        g_timelineStudyList.clear();
        g_pContext->setContextProperty(QMLTimelineStudyModel, QVariant::fromValue(g_timelineStudyList));
        g_timelineModalityList.clear();
        g_pContext->setContextProperty(QMLTimelineModalityList, QVariant::fromValue(g_timelineModalityList));
        g_timelineStudyDateList.clear();
        g_pContext->setContextProperty(QMLTimelineStudyDateList, QVariant::fromValue(g_timelineStudyDateList));
        // get all studies of the patientid
        //searchStudies(patientid, )

        SearchStudyKey *cond = new SearchStudyKey();
        int nkeys = makeSearchKeys(patientid.append("\\"),  cond);

        switch(folderIndex)
        {
            case N_FOLDER::N_MainFolder:
                searchStudiesFromSrcList(g_mainList, cond, sortkeyIndex, g_timelineStudyList);
                break;
            case N_FOLDER::N_SmartFolder:
                searchStudiesFromSrcList(g_mainList, cond, sortkeyIndex, g_timelineStudyList);
                break;
            case N_FOLDER::N_RemoteFolder:
                searchStudiesFromSrcList(g_remoteList, cond, sortkeyIndex, g_timelineStudyList);
                break;
        }

        //initTestStudiesFromDB("where pat.PatientID='" + patientid + "'", g_timelineStudyList);
        qDebug() << "=== get timeline studylist, num of studies in patient " << g_timelineStudyList.length();
        g_pContext->setContextProperty(QMLTimelineStudyModel, QVariant::fromValue(g_timelineStudyList));
        setTimelineModalityList();
        qDebug() << "num of modalities = " << g_timelineModalityList.length();
        setTimelineStudyDateList();
        qDebug() << "num of study dates = " << g_timelineStudyDateList.length();
        g_currentPatientId = patientid;
    }
 }


void QML_StudyListHelper::setImageListModelAt(int indexOfSeries)
{
    //qDebug() <<  QString("indexOfSeries=%1").arg(indexOfSeries);
    QList<QObject *> imagesInSeries;
    if(indexOfSeries < g_seriesList.length() && indexOfSeries >=0 ) {
        QML_SeriesListObject *pSeries = (QML_SeriesListObject *)g_seriesList.at(indexOfSeries);
        imagesInSeries = pSeries->imageList();
    }

    QString name =  QString("%1").arg(indexOfSeries);
    //qDebug() << QMLPreviewSeriesModel + name;
    //qDebug() << QString("imagesInSeries.length=%1").arg(imagesInSeries.length());
    g_pContext->setContextProperty(QMLPreviewSeriesModel + name, QVariant::fromValue(imagesInSeries));
}



int QML_StudyListHelper::qmlGetNumOfImagesAt(int indexOfSeries)
{
    int num = 0;
    //qDebug() <<  "indexOfSeries" << indexOfSeries;

    if(indexOfSeries < g_seriesList.length() && indexOfSeries >=0 ) {
        QML_SeriesListObject *pSeries = (QML_SeriesListObject *)g_seriesList.at(indexOfSeries);
        num = pSeries->imageList().length();
    }
    return num;
}


QString QML_StudyListHelper::qmlGetPatientNameAt(int indexOfStudy )
{
    QString name= "";

    if(indexOfStudy < g_studyList.length() && indexOfStudy >=0 ) {
        QML_StudyListObject *pStudy = (QML_StudyListObject *)g_studyList.at(indexOfStudy);
        name = pStudy->patientName();
    }
    qDebug() <<  "indexOfStudy" << indexOfStudy <<  "name" << name;

    return name;
}

QString QML_StudyListHelper::qmlGetPatientIDAt(int indexOfStudy )
{
    QString pid= "";

    if(indexOfStudy < g_studyList.length() && indexOfStudy >=0 ) {
        QML_StudyListObject *pStudy = (QML_StudyListObject *)g_studyList.at(indexOfStudy);
        pid = pStudy->patientID();
    }
    qDebug() <<  "indexOfStudy" << indexOfStudy <<  "pid" << pid;

    return pid;
}

void QML_StudyListHelper::setTimelineModalityList()
{
    g_timelineModalityList.clear();
    for (int i = 0; i < g_timelineStudyList.length(); i++)
    {
        QML_StudyListObject *pStudy = (QML_StudyListObject *)g_timelineStudyList.at(i);
        for (int j = 0; j < pStudy->seriesList().length(); j++)
        {
            QML_SeriesListObject *pSeries = (QML_SeriesListObject *)pStudy->seriesList().at(j);
            if (g_timelineModalityList.contains(pSeries->modality()) == false)
            {
                g_timelineModalityList.append(pSeries->modality());
            }
        }
    }
    g_pContext->setContextProperty(QMLTimelineModalityList, QVariant::fromValue(g_timelineModalityList));
}

void QML_StudyListHelper::setTimelineStudyDateList()
{
    g_timelineStudyDateList.clear();
    for (int i = 0; i < g_timelineStudyList.length(); i++)
    {
        QML_StudyListObject *pStudy = (QML_StudyListObject *)g_timelineStudyList.at(i);
        QString hidden = pStudy->studyDate();
        hidden.append(",");
        hidden.append(pStudy->modality());
        if (g_timelineStudyDateList.contains(pStudy->studyDate()) == false)
        {
            g_timelineStudyDateList.append(pStudy->studyDate());
            bg_timelineStructure.append(hidden);
        }
        else
        {
            if (bg_timelineStructure.contains(hidden) == true)
            {
                g_timelineStudyDateList.append("");
            }
        }
    }
    g_pContext->setContextProperty(QMLTimelineStudyDateList, QVariant::fromValue(g_timelineStudyDateList));
}
