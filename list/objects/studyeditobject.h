#ifndef STUDYEDITOBJECT_H
#define STUDYEDITOBJECT_H

#include <QObject>
class StudyEditObject : public QObject
{
    Q_OBJECT
//    //patient
//    Q_PROPERTY( QString patientID READ patientID WRITE setPatientID NOTIFY patientIDChanged )
//    Q_PROPERTY( QString patientName READ patientName WRITE setPatientName NOTIFY patientNameChanged )
//    Q_PROPERTY( QString sex READ sex WRITE setSex NOTIFY sexChanged )
//    Q_PROPERTY( QString age READ age WRITE setAge NOTIFY ageChanged )

//    //study
//    Q_PROPERTY( QString accessionNumber READ accessionNumber WRITE setAccessionNumber NOTIFY accessionNumberChanged )
//    Q_PROPERTY( QString studyDate READ studyDate WRITE setStudyDate NOTIFY studyDateChanged )
//    Q_PROPERTY( QString studyTime READ studyTime WRITE setStudyTime NOTIFY studyTimeChanged )

//    //series
//    Q_PROPERTY( QString modality READ modality WRITE setModality NOTIFY modalityChanged )
//    Q_PROPERTY( QString bodyPart READ bodyPart WRITE setBodyPart NOTIFY bodyPartChanged )

public:
    explicit StudyEditObject(QObject *parent = 0);
//    explicit StudyEditObject(const QString &_patientID,
//                         const QString &_patientName,
//                         const QString &_sex,
//                         const QString &_age,
//                         const QString &_accessionNumber,
//                         const QString &_studyDate,
//                         const QString &_studyTime,
//                         const QString &_modality,
//                         const QString &_bodyPart,
//                         QObject * parent=0 );


//public:
//    //Properties --------------------------
//    QString patientID() const;
//    void setPatientID(const QString &);

//    QString patientName() const;
//    void setPatientName(const QString &);

//    QString sex() const;
//    void setSex(const QString &);

//    QString age() const;
//    void setAge(const QString &);

//    QString accessionNumber() const;
//    void setAccessionNumber(const QString &);

//    QString studyDate() const;
//    void setStudyDate(const QString &);

//    QString studyTime() const;
//    void setStudyTime(const QString &);

//    QString modality() const;
//    void setModality(const QString &);

//    QString bodyPart() const;
//    void setBodyPart(const QString &);
//    //-------------------------------------

//private:
//    QString m_patientID;
//    QString m_patientName;
//    QString m_sex;
//    QString m_age;
//    QString m_accessionNumber;
//    QString m_studyDate;
//    QString m_studyTime;
//    QString m_modality;
//    QString m_bodyPart;

//signals:
//    void patientIDChanged();
//    void patientNameChanged();
//    void sexChanged();
//    void ageChanged();
//    void accessionNumberChanged();
//    void studyDateChanged();
//    void studyTimeChanged();
//    void modalityChanged();
//    void bodyPartChanged();

//public slots:


};

#endif // STUDYEDITOBJECT_H
