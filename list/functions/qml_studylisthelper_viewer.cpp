#include "qml_studylisthelper.h"
#include <QDir>
#include <QFile>
#include <QTextCodec>
#include <QSqlQuery>
#include <QSqlError>
#include <QMessageBox>
#include "..\iniparam.h"
#include "..\common_functions.h"

#define JTR( localString ) QTextCodec::codecForLocale()->toUnicode( localString )

int QML_StudyListHelper::startViewerAt(int indexOfFolder, int indexOfStudyInShowingList)
{
    int iret = 0;

    qDebug() << "indexOfFolder=" << indexOfFolder << "indexOfStudyInShowingList=" << indexOfStudyInShowingList ;
    QString pid = "";
    QString studyuid = "";

    int indexOfStudy = indexOfStudyInShowingList;

    if(indexOfStudy < g_studyList.length() && indexOfStudy >=0 ) {
        QML_StudyListObject *pStudy = (QML_StudyListObject *)g_studyList.at(indexOfStudy);
        pid = pStudy->patientID();
        studyuid = pStudy->studyInstanceUID();

    }
    qDebug() <<  "indexOfStudy" << indexOfStudy <<  "pid" << pid <<  "studyuid" << studyuid;

    if(pid.isEmpty()){
        iret = -1;  //error
        QMessageBox::information(0, tr("Index is out of bounds"), "indexOfStudy=" +  QString::number(indexOfStudy) + "  g_studyList.length=" +  g_studyList.length() );
    }else{
        iret = copyPatientDicomFilesIfNeed(indexOfFolder, pid);
    }

    if(iret == 0){
        //起動情報ファイルを作成
        iret = createViewStartFile(pid, studyuid);
    }

    return iret;

}


int QML_StudyListHelper::createViewStartFile(QString  pid, QString studyuid)
{
    int iret = 0;
    QString startFileName = pid + "_" + studyuid + ".view.start";
    QString startFilePath = g_pIniParam->m_viewerDataFolder + "\\" + startFileName;

    QString startFileName_temp = startFileName + ".temp";
    QString startFilePath_temp = g_pIniParam->m_viewerDataFolder + "\\" + startFileName_temp;

    qDebug() <<  "startFilePath= " << startFilePath ;
    qDebug() <<  "startFilePath_temp= " << startFilePath_temp ;

    QFile file(startFilePath_temp);
    if ( QFile::exists( startFilePath_temp ) ){
        //QMessageBox::information(0, tr("File already exists"), startFilePath_temp);
        file.remove();
    }
    if (!file.open(QIODevice::WriteOnly)) {
       QMessageBox::information(0, tr("Unable to open file"), file.errorString());
       iret = -1;  //error
    }

    try{
        file.close();
    }catch(...){}

    if(iret == 0){
        if ( QFile::exists( startFilePath ) ){
            //QMessageBox::information(0, tr("File already exists"), startFilePath);
            QFile::remove(startFilePath);
        }
        qDebug() <<  "rename" << startFilePath_temp <<  " to " << startFilePath;
        file.rename(startFilePath);
    }

   return iret;
}

int QML_StudyListHelper::copyPatientDicomFilesIfNeed(int folderIndex, QString  pid)
{

    int iret = 0;

    QString pidFolder = g_pIniParam->m_viewerDataFolder + "\\" + pid;
    QDir dir(pidFolder);
    bool bDoCopy = false;
    if ( !dir.exists() )
    {
        dir.mkdir(".");
        bDoCopy = true;
    }

    qDebug() <<  "bDoCopy= " << bDoCopy ;
    if ( bDoCopy)
    {
        //DICOMファイルを書き出す
        QList<QObject *> studyList;  //QML_StudyListObject
        SearchStudyKey *cond = new SearchStudyKey();
        makeSearchKeys(pid + "\\", cond);
        switch(folderIndex)
        {
            case N_FOLDER::N_MainFolder:
            case N_FOLDER::N_SmartFolder:
                searchStudiesFromSrcList(g_mainList, cond, 0, studyList);
                break;
            case N_FOLDER::N_RemoteFolder:
                searchStudiesFromSrcList(g_remoteList, cond, 0, studyList);
                break;
        }

        qDebug() <<  "studyList.length=" << studyList.length();
        for(int isdy =0; isdy <studyList.length(); isdy++ ){
            //QString s_sdy = QString::number(isdy).leftJustified(4, '0');            
            QML_StudyListObject *pStudy = (QML_StudyListObject *)studyList.at(isdy);

            qDebug() <<  " seriesList().length=" << pStudy->seriesList().length();
            for(int iser = 0; iser < pStudy->seriesList().length(); iser++ )
            {                    
                //QString s_ser = QString::number(iser).leftJustified(4, '0');
                QML_SeriesListObject *pSeries = (QML_SeriesListObject *)pStudy->seriesList().at(iser);
                qDebug() <<  "  imageList().length=" << pSeries->imageList().length();
                for(int iimg = 0; iimg < pSeries->imageList().length(); iimg++ )
                {
                    //QString s_img = QString::number(iimg).leftJustified(4, '0');
                    QML_ImageListObject *pImage = (QML_ImageListObject *)pSeries->imageList().at(iimg);

                    //convert to dcm file path from thumbnail file path
                    QString thumb = pImage->imageSource();
                    QString dcmpath = thumb;
                    dcmpath = qstringTrimStart(dcmpath, "file:///");
                    dcmpath.replace("Thumbnails", "DICOM");
                    dcmpath.replace("jpg", "dcm");
                    dcmpath.replace("/", "\\");


                    QFileInfo fInfo(dcmpath);
                    QString destpath = g_pIniParam->m_viewerDataFolder + "\\" + pid + "\\" + fInfo.fileName();
                    if(QFile::exists(destpath)) {
                        qDebug() <<  "  remove file: " << destpath;
                        QFile::remove(destpath);
                    }
                    qDebug() <<  "  copy " << dcmpath << " to " << destpath;
                    QFile::copy(dcmpath, destpath);
                }
            }
        }
    }

    return iret;
}
