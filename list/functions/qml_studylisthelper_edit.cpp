#include "qml_studylisthelper.h"
#include "qtquick2controlsapplicationviewer.h"

//set edit object as current index
void QML_StudyListHelper::setCurrentEditStudy(const int index)
{
    //実装未完了：内部データと表示データを分けるべき
    g_pEditInfo->clear();
    if(index < g_studyList.length() && index >=0 ) {
        QML_StudyListObject *pObj = (QML_StudyListObject *)g_studyList.at(index);
        g_pEditInfo->setPatientID(pObj->patientID());
        g_pEditInfo->setPatientName(pObj->patientName());
        g_pEditInfo->setPatientKanaName(pObj->patientKanaName());
        g_pEditInfo->setPatientRomaName(pObj->patientRomaName());
        g_pEditInfo->setSex(pObj->sex());
        g_pEditInfo->setBirthdate(pObj->birthdate());

        g_pEditInfo->setAccessionNumber(pObj->accessionNumber());
        g_pEditInfo->setStudyDate(pObj->studyDate());
        g_pEditInfo->setStudyTime(pObj->studyTime());
        g_pEditInfo->setStudyID(pObj->studyID());
        g_pEditInfo->setStudyDesc(pObj->studyDesc());
        g_pEditInfo->setInstitutionName(pObj->institutionName());
        g_pEditInfo->setReadingPhysName(pObj->readingPhysName());
        g_pEditInfo->setModality(pObj->modality());
        g_pEditInfo->setBodyPart(pObj->bodyPart());
    }

    //QMLへ登録
    //QQmlContext *ctxt = g_pViewer.rootContext();
    g_pContext->setContextProperty(QMLEditStudyObject, g_pEditInfo);
}

//QMLから呼び出す
bool QML_StudyListHelper::qmlEditCurrentStudy(const QString  patientID,
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
                   )
{
    bool b;
    b = updateStudyListAt(g_currentStudyIndex,
                      patientID,
                      patientName,
                      patientKanaName,
                      patientRomaName,
                      sex,
                      birthdate,

                      accessionNumber,
                      studyDate,
                      studyTime,
                      institutionName,
                      readingPhysName,
                      studyID,
                      studyDesc,
                      refPhysName,

                      modality,
                      bodyPart,
                      seriesDesc,
                      patientPos,
                      larerality);
    return b;
}




//set edit object to study list as index
//なぜかQMLから呼び出すと　QML_EditInfoObject
bool QML_StudyListHelper::qmlUpdateStudyAt(const int index, const QML_EditInfoObject &editObj)
{
    int b = false;

    //実装未完了：内部データと表示データを分けるべき
    const QML_EditInfoObject *pObj = (QML_EditInfoObject *)&editObj;
    if(index < g_studyList.length() && index >=0 ) {
        QML_StudyListObject *p = (QML_StudyListObject *)g_studyList.at(index);
        p->setPatientID(pObj->patientID());
        p->setPatientName(pObj->patientName());
        p->setSex(pObj->sex());

        p->setAccessionNumber(pObj->accessionNumber());
        p->setStudyDate(pObj->studyDate());
        p->setStudyTime(pObj->studyTime());

        p->setModality(pObj->modality());
        p->setBodyPart(pObj->bodyPart());

        b = true;
     }

    return b;
}


bool QML_StudyListHelper::updateStudyListAt(const int index,
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
                                        const QString  larerality)
{
    int b = false;
    if(index < g_studyList.length() && index >=0 ) {
        QML_StudyListObject *p = (QML_StudyListObject *)g_studyList.at(index);
        p->setPatientID(patientID);
        p->setPatientName(patientName);
        p->setPatientKanaName(patientKanaName);
        p->setPatientRomaName(patientRomaName);
        p->setSex(sex);
        p->setBirthdate(birthdate);

        p->setAccessionNumber(accessionNumber);
        p->setStudyDate(studyDate);
        p->setStudyTime(studyTime);
        p->setStudyDesc(studyDesc);
        p->setInstitutionName(institutionName);
        p->setReadingPhysName(readingPhysName);

        p->setModality(modality);
        p->setBodyPart(bodyPart);

        b = true;
    }

    if(b){
       updateStudyListView();
    }
    return b;
}

