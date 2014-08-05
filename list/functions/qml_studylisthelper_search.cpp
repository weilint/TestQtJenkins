#include "qml_studylisthelper.h"

#define JTR( localString ) QTextCodec::codecForLocale()->toUnicode( localString )

int QML_StudyListHelper::searchStudies(QString searchFilter, int folderIndex, int sortkeyIndex)
{
    int nRet = 0;

    qDebug() << "searchFilter=" << searchFilter;
    qDebug() << "folderIndex=" << folderIndex ;
    qDebug() << "sortkeyIndex=" << sortkeyIndex ;

    SearchStudyKey *cond = new SearchStudyKey();
    int nkeys = makeSearchKeys(searchFilter,  cond);
    qDebug() << "nkeys=" << nkeys;

    switch(folderIndex)
    {
        case N_FOLDER::N_MainFolder:
            nRet = searchStudiesFromSrcList(g_mainList, cond, sortkeyIndex, g_studyList);
            break;
        case N_FOLDER::N_SmartFolder:
            nRet = searchStudiesFromSrcList(g_mainList, cond, sortkeyIndex, g_studyList);
            break;
        case N_FOLDER::N_RemoteFolder:
            nRet = searchStudiesFromSrcList(g_remoteList, cond, sortkeyIndex, g_studyList);
            break;
    }

    return nRet;
}


//入力された検索条件から内部の検索キーを作成
int QML_StudyListHelper::makeSearchKeys(QString searchFilter, SearchStudyKey* cond)
{
    QString myfilter = searchFilter;

    myfilter = myfilter.replace(JTR("　"), " ");
    myfilter = myfilter.replace(JTR("＊"), "*");

    QStringList keys = myfilter.split(" ");

    int numkey = 0;

    for(int i = 0; i < keys.length(); i++)
    {
        QString s = keys.at(i);
        QString s_uppper = s.toUpper();

        bool bIs = false;
        if(g_pIniParam->m_modalityList.contains(s_uppper)){
            //search by modality
            bIs = true;
            cond->m_modality = s_uppper;
            qDebug() << "m_modality=" << cond->m_modality ;
        }else if(s_uppper == "M" || s_uppper == "F" || s_uppper == "O")
        {
            //search by sex
            bIs = true;
            cond->m_sex = s_uppper;
            qDebug() << "m_sex=" << cond->m_sex ;

        }else if(s.contains("/")){
            QStringList ranges=s.split("-");
            if(ranges.length() == 1) { //no -
                QStringList parts=s.split("/");
                switch(parts.length()){
                case 2:
                    //search by YYYYMM of study date
                    if(parts.at(0).length() == 4){
                        bIs = true;
                        cond->m_studyDate = parts.at(0) + parts.at(1) + "*";
                        qDebug() << "m_studyDate=" << cond->m_studyDate ;
                     }
                    break;
                case 3:
                    //search by YYYYMMDD of study date
                    if(parts.at(0).length() == 4 && parts.at(1).length()==2){
                        bIs = true;
                        cond->m_studyDate = parts.at(0) + parts.at(1) + parts.at(2);
                        qDebug() << "m_studyDate=" << cond->m_studyDate ;
                     }
                    break;
                }
            }else{
                if(ranges.at(0).length() == 0 && ranges.at(1).length() == 10){ //-YYYY/MM/DD
                    QString stemp = ranges.at(1);
                    cond->m_studyDate = "-" + stemp.replace("/", "");
                    bIs = true;
                }if(ranges.at(0).length() == 10 && ranges.at(1).length() == 0){ //YYYY/MM/DD-
                    QString stemp = ranges.at(0);
                    cond->m_studyDate = stemp.replace("/", "") + "-";
                    bIs = true;
                }else if(ranges.at(0).length() == 10 && ranges.at(1).length() == 10){ //YYYY/MM/DD-YYYY/MM/DD
                    QString stemp = ranges.at(0);
                    QString stemp2 = ranges.at(1);
                    cond->m_studyDate = stemp.replace("/", "") + "-" + stemp2.replace("/", "");
                    bIs = true;
                }
            }
        }else{
            QString ss = qstringTrim(s, "*");
            ss = qstringTrimEnd(ss, "\\");
            QString ss2 = ss;
            ss2.replace("-", "");

            if(!ss2.isEmpty()){
                QRegExp re("\\d*");  // a digit (\d), zero or more times (*)
                if (re.exactMatch(ss2)){
                   qDebug() << "all digits";
                   //search by patient id

                   cond->m_patientID = ss;
                   if(s.startsWith("*")){
                       cond->m_patientID = "*" + cond->m_patientID;
                   }                   
                   if(!s.endsWith("\\"))
                   {
                       //デフォルトは先頭一致で検索⇒完全一致
                       cond->m_patientID = cond->m_patientID;
                   }
                   qDebug() << "m_patientID=" << cond->m_patientID ;
                   bIs = true;
                 }
            }
        }

        if(bIs) numkey++;
    }


    if(numkey == 0){
        //search by patient name
        if(myfilter.startsWith("*") || myfilter.endsWith("*")){
            //指定された通り部分一致検索
            cond->m_patientName = myfilter;
        }else{
            //指定されていない場合は常に部分一致検索
            cond->m_patientName = "*" + myfilter + "*";
        }
        qDebug() << "m_patientName=" << cond->m_patientName ;
    }

    qDebug() << "numkey=" << numkey;

    return numkey;
}


bool QML_StudyListHelper::checkValueAsFilter(QString value, QString filter)
{
    bool bFound = true;
    QString key = qstringTrim(filter, "*");
    if(!key.isEmpty()){
        bFound = false;
        if(filter.startsWith("*")){
            if(filter.endsWith("*")){
                bFound = value.contains(key);
            }else{
                bFound = value.endsWith(key);
            }
        }else{
            if(filter.endsWith("*")){
                bFound = value.startsWith(key);
            }else{
                bFound = value == filter? true: false;
            }
        }
    }

    return bFound;
}

bool QML_StudyListHelper::checkValueAsDateRangeFilter(QString value, QString filter)
{
    bool bFound = true;
    if(!filter.isEmpty()){
        bFound = false;
        QStringList  parts = filter.split("-");
        if(parts.at(0).length() == 0 && parts.at(1).length() != 0){
            if(value.length() == parts.at(1).length() && value <= parts.at(1)){
                bFound = true;
            }
        }else if(parts.at(0).length() != 0 && parts.at(1).length() == 0){
            if(value.length() == parts.at(0).length() && value >= parts.at(0)){
                bFound = true;
            }
        }else if(parts.at(0).length() != 0 && parts.at(1).length() != 0){
            if(value.length() == parts.at(0).length() && value >= parts.at(0) && value <= parts.at(1)){
                bFound = true;
            }
        }
    }

    return bFound;
}



//指定されたソースリストからフィルターを適用
bool QML_StudyListHelper::searchStudiesFromSrcList(QList<QObject *>& srcStudyList, SearchStudyKey *cond, int sortkeyIndex, QList<QObject *>& resultStudyList)
{
    int num = 0;

    resultStudyList.clear();
    for(int i = 0; i < srcStudyList.length(); i++){
        //QML_StudyListObject *src = (QML_StudyListObject *)g_mainList.at(i);
        QML_StudyListObject *src = (QML_StudyListObject *)srcStudyList.at(i);

        bool bFound = true;
        QString key = "";
        if(!cond->m_patientID.isEmpty()){
            bFound = checkValueAsFilter(src->patientID(), cond->m_patientID );
        }

        if(!bFound) continue;
        if(!cond->m_patientName.isEmpty()){
            bFound = checkValueAsFilter(src->patientName(), cond->m_patientName );
        }
        if(!bFound) continue;
        if(!cond->m_sex.isEmpty()){
            bFound = checkValueAsFilter(src->sex(), cond->m_sex );
        }

        if(!bFound) continue;
        if(!cond->m_studyDate.isEmpty()){
            if(cond->m_studyDate.contains("-")) {
                bFound = checkValueAsDateRangeFilter(src->studyDate(), cond->m_studyDate);
            }else{
                bFound = checkValueAsFilter(src->studyDate(), cond->m_studyDate );
            }
        }

        if(!bFound) continue;
        if(!cond->m_modality.isEmpty()){
            bFound = checkValueAsFilter(src->modality(), cond->m_modality );
        }

        if(bFound) {
            QML_StudyListObject *dest = new QML_StudyListObject();
            *dest = *src;
            resultStudyList.append(dest);
        }
    }

    sortStudies(resultStudyList, sortkeyIndex);

    num = resultStudyList.length();

    qDebug() << "searchStudiesFromSrcList:: return num=" << resultStudyList.length();
    return num;
}


void QML_StudyListHelper::sortStudies(QList<QObject *>& studyList, int sortkeyIndex)
{
    switch(sortkeyIndex){
    case 0:
        qSort(studyList.begin(),studyList.end(),QML_StudyListObject::compare_pat);
        break;
    case 1:
        qSort(studyList.begin(),studyList.end(),QML_StudyListObject::compare_study);
        break;
     default:
        //未実装
        break;
    }
}
