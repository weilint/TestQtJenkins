#include "qml_studylisthelper.h"
#include <QTextCodec>
#include <QSqlQuery>
#include <QSqlError>
#include <QMessageBox>
#include "..\iniparam.h"
#include "..\common_functions.h"

#define JTR( localString ) QTextCodec::codecForLocale()->toUnicode( localString )

QString makeThumbnailPath(QString imgroot, QString img_objid)
{
    QString path = QString("file:///C:/Array/GrandBleu_AppData/Data/Thumbnails/");  //本来はimgrootから変換すべき
    path += img_objid.left(8);
    path += "/";
    path += "00_";
    path += img_objid;
    path += ".jpg";
    //qDebug() << path ;

    return path;
}




bool QML_StudyListHelper::initTestStudiesFromDB(QString filter, QList<QObject *>& studyList)
{
    bool b = true;

    studyList.clear();

    QSqlDatabase db = QSqlDatabase::addDatabase("QODBC");
    //"Driver={SQL Server};Server=127.0.0.1\\SQLEXPRESS;Database=GrandBleuDB;User ID=GB_USER;Password=Array2012;";
    db.setDatabaseName(g_pIniParam->m_connectString);
    //QMessageBox::information(0, tr("Debug"), g_pIniParam->m_connectString);

    //QMessageBox msgbox(0);
    //msgbox.setText(g_pIniParam->m_connectString);
    //msgbox.exec();
    if(!db.open()){
        qDebug()<<"ERROR: "<<QSqlError(db.lastError()).text();
        QMessageBox::information(0, tr("Error"), g_pIniParam->m_connectString + "\n\n"+ QSqlError(db.lastError()).text());
        //QMessageBox msgbox(0);
        //msgbox.setText(g_pIniParam->m_connectString + "\n\n"+ QSqlError(db.lastError()).text());
        //msgbox.exec();
    } else {
        //qDebug()<<"Ok";
        //msgbox.setText("OK");
        //msgbox.exec();
        QSqlQuery pat_query;
        QSqlQuery sdy_query;
        QSqlQuery ser_query;
        QSqlQuery img_query;

        QString pat_selectString = "SELECT ";
        pat_selectString += "pat.PatientObjectID, ";   //0
        pat_selectString += "pat.PatientID, ";
        pat_selectString += "pat.PN_Kanji, ";
        pat_selectString += "pat.PN_HanKana, ";
        pat_selectString += "pat.PN_Roma, ";
        pat_selectString += "pat.PatientSex, ";
        pat_selectString += "pat.PatientAge, " ;
        pat_selectString += "pat.PatientBirthdate ";
        pat_selectString += "FROM Patient pat ";
        //pat_selectString += g_pIniParam->m_dbFilterForMainFolder;  //for test
        pat_selectString += " ";
        //pat_selectString += "where pat.PatientID='12345678' ";    //for test
        pat_selectString += filter;
        pat_selectString += " ";
        pat_selectString += "order by pat.PatientID asc";
        pat_selectString += ";";

        qDebug() << pat_selectString;

        pat_query.exec(pat_selectString);
        while (pat_query.next()) {
            QString pat_objid = pat_query.value(0).toString();
            QString pid = pat_query.value(1).toString();
            QString kanji = pat_query.value(2).toString();
            QString kana = pat_query.value(3).toString();
            QString roma = pat_query.value(4).toString();
            QString sex = pat_query.value(5).toString();
            QString age = pat_query.value(6).toString();
            age = qstringTrimStart(age, "0");
            age = qstringTrimEnd(age, "Y");
            QString birthdate = pat_query.value(7).toString();

            qDebug() << pat_objid << pid << kanji << kana << roma << sex << age << birthdate ;


            //search study
            QString sdy_selectString = "SELECT ";
            sdy_selectString += "sdy.PatientObjectID, ";     //0
            sdy_selectString += "sdy.StudyObjectID, ";
            sdy_selectString += "sdy.StudyInstanceUID, ";
            sdy_selectString += "sdy.AccessionNumber, ";
            sdy_selectString += "sdy.StudyDate, ";
            sdy_selectString += "sdy.StudyTime, ";
            sdy_selectString += "sdy.StudyId, ";
            sdy_selectString += "sdy.StudyDescription, ";
            sdy_selectString += "sdy.ReadingStudyPhysicianName, ";
            sdy_selectString += "sdy.ReferringPhysicianName ";
            sdy_selectString += "FROM Study sdy ";
            sdy_selectString += "where sdy.PatientObjectID='" + pat_objid + "' ";
            sdy_selectString += "order by sdy.StudyDate desc, sdy.StudyTime desc ";
            sdy_selectString += ";";

            qDebug() << sdy_selectString;

            sdy_query.exec(sdy_selectString);

            QML_StudyListObject *pStudy;
            while (sdy_query.next()) {
                pStudy = new QML_StudyListObject();
                QString sdy_objid = sdy_query.value(1).toString();
                QString studyuid = sdy_query.value(2).toString();
                QString accnum =sdy_query.value(3).toString();
                QString studydate =sdy_query.value(4).toString();
                QString studytime = sdy_query.value(5).toString();
                QString studyid = sdy_query.value(6).toString();
                QString studydesc = sdy_query.value(7).toString();
                QString readphyname = sdy_query.value(8).toString();

                qDebug() << sdy_objid <<studydate << studytime << studyid << studydesc << readphyname;

                pStudy->setPatientID(pid);
                pStudy->setPatientName(kanji);
                pStudy->setPatientKanaName(kana);
                pStudy->setPatientRomaName(roma);

                pStudy->setSex(sex);
                pStudy->setAge(age);
                pStudy->setBirthdate(birthdate);

                pStudy->setAccessionNumber(accnum);
                pStudy->setStudyDate(studydate);
                pStudy->setStudyTime(studytime);
                pStudy->setStudyDesc(studydesc);
                pStudy->setStudyID(studyid);
                pStudy->setReadingPhysName(readphyname);
                pStudy->setStudyInstanceUID(studyuid);

                //pStudy->setFlagid("flag002");

//                QStringList flags;
//                flags.append("flag002");

                //search series
                QString ser_selectString = "SELECT ";
                ser_selectString += "ser.StudyObjectID, ";
                ser_selectString += "ser.SeriesObjectID, ";
                ser_selectString += "ser.SeriesInstanceUID, ";
                ser_selectString += "ser.SeriesNumber, ";
                ser_selectString += "ser.Modality, ";
                ser_selectString += "ser.BodyPart, ";
                ser_selectString += "ser.ImageRootIDOfSampleThumb, ";
                ser_selectString += "ser.ImageObjectIDOfSampleThumb, ";
                ser_selectString += "ser.InstitutionName ";
                ser_selectString += "FROM Series ser ";
                ser_selectString += "where ser.StudyObjectID='" + sdy_objid + "' ";
                ser_selectString += "order by SeriesNumber asc ";
                ser_selectString += ";";

                qDebug() << ser_selectString;

                ser_query.exec(ser_selectString);

                QML_SeriesListObject *pSeries;
                QList<QObject *> serList;
                bool isFirstSeries = true;
                while (ser_query.next()) {
                    pSeries = new QML_SeriesListObject();

                    QString ser_objid = ser_query.value(1).toString();
                    QString seriesuid = ser_query.value(2).toString();
                    QString sriesnum = ser_query.value(3).toString();
                    QString modality = ser_query.value(4).toString();
                    QString bodypart = ser_query.value(5).toString();
                    QString thumb_root = ser_query.value(6).toString();
                    QString thumb_objid = ser_query.value(7).toString();
                    QString instname = ser_query.value(8).toString();

                    qDebug() << ser_objid <<sriesnum << modality << bodypart << thumb_root << thumb_objid << instname;

                    //set to study                    
                    if(isFirstSeries){
                        isFirstSeries = false;
                        pStudy->setModality(modality);
                        pStudy->setBodyPart(bodypart);
                        pStudy->setSampleImage(makeThumbnailPath(thumb_root, thumb_objid));
                        pStudy->setInstitutionName(instname);
                    }

                    //set to series
                    pSeries->setSeriesInstanceUID(seriesuid);
                    pSeries->setModality(modality);
                    pSeries->setBodyPart(bodypart);
                    pSeries->setSeriesNumber(sriesnum);

                    //search image
                    QString img_selectString = "SELECT ";
                    img_selectString += "img.SeriesObjectID, ";          //0
                    img_selectString += "img.ImageObjectID, ";
                    img_selectString += "img.SopInstanceUID, ";
                    img_selectString += "img.ImageRootID, ";
                    img_selectString += "img.InstanceNumber ";
                    img_selectString += "FROM Image img ";
                    img_selectString += "where img.SeriesObjectID='" + ser_objid + "' ";
                    img_selectString += "order by InstanceNumber asc ";
                    img_selectString += ";";

                    img_query.exec(img_selectString);
                    qDebug() << img_selectString;

                    QList<QObject *> imgList;                    
                    while (img_query.next()) {

                        QString img_objid = img_query.value(1).toString();
                        QString sopInstUID = img_query.value(2).toString();
                        QString imgroot = img_query.value(3).toString();
                        QString instancenum = img_query.value(4).toString();
                        qDebug() << img_objid <<imgroot << instancenum ;

                        QString path = makeThumbnailPath(imgroot, img_objid);

                        QML_ImageListObject *pImage = new QML_ImageListObject(sopInstUID, instancenum, path);
                        imgList.append(pImage);
                    }

                    //sort by sop instance number
                    qSort(imgList.begin(),imgList.end(),QML_ImageListObject::compare_instnum);
                    pSeries->setImageList(imgList);
                    serList.append(pSeries);
                }

                //sort by series number
                qSort(serList.begin(),serList.end(),QML_SeriesListObject::compare_seriesnum);

                pStudy->setSeriesList(serList);

                //pStudy->setFlagList(flags);

                studyList.append(pStudy);
            }
        }
    }
    db.close();

    return b;
 }




bool QML_StudyListHelper::qmlEditTestSlot(const int index, const QString value)
{
    int b = false;
    if(index < g_studyList.length() && index >=0 ) {
        QML_StudyListObject *p = (QML_StudyListObject *)g_studyList[index];
//        p->setPatientID(patientID);
//        p->setPatientName(patientName);
//        p->setSex(sex);
//        p->setAge(age);
//        p->setAccessionNumber(accessionNumber);
//        p->setStudyDate(studyDate);
//        p->setStudyTime(studyTime);
        p->setModality(value);
//        p->setBodyPart(bodyPart);

        b = true;
    }
    return b;
}



