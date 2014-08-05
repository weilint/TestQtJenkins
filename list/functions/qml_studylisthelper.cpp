#include "qml_studylisthelper.h"

QML_StudyListHelper::QML_StudyListHelper(QObject *parent) :
    QObject(parent)
{
}

// --------------------------------------------------------------------------------
bool QML_StudyListHelper::initStudies()
{
    bool b = true;

    //QList<QObject *> g_dataList;

    //----デモデータ------
    initTestStudiesFromDB(g_pIniParam->m_dbFilterForMainFolder, g_mainList);       //メインフォルダー
    //initTestStudiesFromDB(g_pIniParam->m_dbFilterForRemoteFolder, g_remoteList);   //リモートフォルダー
    //----------------

    //デフォルトはメインフォルダーの内容を表示
    SearchStudyKey *cond = new SearchStudyKey();
    searchStudiesFromSrcList(g_mainList, cond, N_FOLDER::N_MainFolder, g_studyList);

    // get remote studies
    initTestStudiesFromDB(g_pIniParam->m_dbFilterForRemoteFolder, g_remoteList);       //メインフォルダー

    return b;
}

void QML_StudyListHelper::initFlagList()
{
    QML_FlagObject *pFlag;
    for (int i = 1; i <=8; i++ )
    {
        pFlag = new QML_FlagObject();
        int flagid = i;
        QString flagname = "flag00";
        flagname.append(QString::number(i));
        QString flagicon = "../flag/f00";
        flagicon.append(QString::number(i));
        flagicon.append(".png");

        pFlag->setFlagID(flagid);
        pFlag->setFlagName(flagname);
        pFlag->setFlagIcon(flagicon);

        g_flagList.append(pFlag);
    }
}



//検査リストをソート
void QML_StudyListHelper::qmlSortStudyList(int indexOfSortKey )
{
    sortStudies(g_studyList, indexOfSortKey);
    updateStudyListView();
}

//検査リストビューをアップデート
void QML_StudyListHelper::updateStudyListView()
{
     //QQmlContext *ctxt = g_pViewer->rootContext();
    //qDebug() << "g_studyList.length=" << g_studyList.length();
     g_pContext->setContextProperty( QMLRichListViewModel, QVariant::fromValue(g_studyList));
}

//検査リストのカレントindex
void QML_StudyListHelper::qmlSetCurrentIndex(const int index )
{
    //qDebug() << QString("qmlSetCurrentIndex = %1").arg(index);
    g_currentStudyIndex = index;
}


//指定された検査のサムネールプレビューを更新
void QML_StudyListHelper::qmlUpdatePreviewAt(int indexOfStudy, int folderIndex, int sortKeyIndex)
{
    //qDebug() << QString("g_currentStudyIndex = %1").arg(g_currentStudyIndex);
    setCurrentEditStudy(indexOfStudy);
    setCurrentPreview(indexOfStudy, folderIndex, sortKeyIndex);
}


int QML_StudyListHelper::qmlSearchStudies(QString searchFilter, int folderIndex, int sortkeyIndex)
{
    int num = searchStudies(searchFilter, folderIndex, sortkeyIndex);
    updateStudyListView();

    return num;
}

void QML_StudyListHelper::qmlGetRemoteStudies()
{
    //initTestStudiesFromDB(g_pIniParam->m_dbFilterForRemoteFolder, g_remoteList);       //メインフォルダー
    SearchStudyKey *cond = new SearchStudyKey();
    searchStudiesFromSrcList(g_remoteList, cond, N_FOLDER::N_RemoteFolder, g_studyList);
    updateStudyListView();
}

QString QML_StudyListHelper::qmlGetRemoteFolderSearchKey()
{
    return g_pIniParam->m_dbFilterForRemoteFolder;
}

QString QML_StudyListHelper::qmlGetSmartFolderSearchKey()
{
    return g_pIniParam->m_filterForSmartFolder;
}

QStringList QML_StudyListHelper::qmlRemoveFlag(QStringList flaglist, int index)
{
    flaglist.removeAt(index);
    return flaglist;
}

QStringList QML_StudyListHelper::qmlAddFlag(QStringList flaglist, QString flag)
{
    flaglist.append(flag);
    return flaglist;
}

QString QML_StudyListHelper::qmlGetFlagIcon(QString flagname)
{
    for (int i = 0; i < g_flagList.length(); i++){
        QML_FlagObject *myflag = (QML_FlagObject *) g_flagList.at(i);
        if (myflag->flagName() == flagname)
        {
            return myflag->flagIcon();
        }
    }
    return "";
}

QString QML_StudyListHelper::qmlGetTimeLineImage(QString modality, QString studydate)
{
    qDebug() << "in qmlGetTimeLineImage: " << modality << " " << studydate;
    for (int i = 0; i < g_timelineStudyList.length(); i++)
    {
        QML_StudyListObject *pStudy = (QML_StudyListObject *) g_timelineStudyList.at(i);
        if (pStudy->studyDate()==studydate)
        {           
            if (pStudy->modality().toUpper() == modality.toUpper())
            {
                QString imgsrc = pStudy->sampleImage();
                if (bg_retrievedStudyImage.contains(imgsrc) == false)
                {
                    qDebug() << "return image source: " << imgsrc;
                    bg_retrievedStudyImage.append(imgsrc);
                    return imgsrc;
                }
            }

//            for (int j = 0; j < pStudy->seriesList().length(); j++)
//            {
//                QML_SeriesListObject *pSeries = (QML_SeriesListObject *) pStudy->seriesList().at(j);
//                if (pSeries->modality().toUpper()==modality.toUpper())
//                {
//                    QML_ImageListObject *pImage = (QML_ImageListObject *)pSeries->imageList().at(0);
//                    QString imgsrc = pImage->imageSource();
//                    //if (imageSourceList.contains(imgsrc) == false)
//                    if (bg_retrievedStudyImage.contains(imgsrc) == false)
//                    {
//                        qDebug() << "return image source: " << pImage->imageSource();
//                        bg_retrievedStudyImage.append(imgsrc);
//                        return pImage->imageSource();
//                    }
//                }
//            }
        }
    }
    return "";
}


//ビューアーにカレント患者のDICOMファイルとカレント検査情報を渡す
int QML_StudyListHelper::qmlStartViewerAt(int indexOfFolder, int indexOfStudyInShowingList)
{
    int iret;

    iret = startViewerAt(indexOfFolder, indexOfStudyInShowingList);

    return iret;
}


//Preludioを起動
int QML_StudyListHelper::qmlStartPreludio()
{
    int iret = 0;

    //QString program = "notepad.exe";
    QString program = g_pIniParam->m_importerExePath;
    QStringList arguments;

    QProcess proc;
    proc.startDetached(program, arguments);

    return iret;
}

int QML_StudyListHelper::qmlGetStudyIndexByImage(QString thumbnail){
    for (int i=0; i<g_studyList.length(); i++){
        QML_StudyListObject *pObj = (QML_StudyListObject *)g_studyList.at(i);
        qDebug() << "in qmlGetStudyIndexByImage : " << pObj->sampleImage().toLower() << " " << thumbnail.toLower();
        if (pObj->sampleImage().toLower()==thumbnail.toLower())
            return i;
    }
    return 0;
}
