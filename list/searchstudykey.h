#ifndef SEARCHSTUDYKEY_H
#define SEARCHSTUDYKEY_H
#include <QTextCodec>
#include <QStringList>

class SearchStudyKey
{    
public:
    SearchStudyKey();

public:
    QString m_patientID;
    QString m_sex;
    QString m_modality;
    QString m_studyDate;
    QString m_patientName;

};

#endif // SEARCHSTUDYKEY_H
