#ifndef QML_EDITINFOOBJECT_H
#define QML_EDITINFOOBJECT_H

#include <QObject>

class QML_EditInfoObject : public QObject
{
    Q_OBJECT
    //patient
    Q_PROPERTY( QString patientID READ patientID WRITE setPatientID NOTIFY patientIDChanged )
    Q_PROPERTY( QString patientName READ patientName WRITE setPatientName NOTIFY patientNameChanged )
    Q_PROPERTY( QString sex READ sex WRITE setSex NOTIFY sexChanged )
    Q_PROPERTY( QString birthdate READ birthdate WRITE setBirthdate NOTIFY birthdateChanged )
    //
    Q_PROPERTY( QString patientKanaName READ patientKanaName WRITE setPatientKanaName NOTIFY patientKanaNameChanged )
    Q_PROPERTY( QString patientRomaName READ patientRomaName WRITE setPatientRomaName NOTIFY patientRomaNameChanged )


    //study
    Q_PROPERTY( QString accessionNumber READ accessionNumber WRITE setAccessionNumber NOTIFY accessionNumberChanged )
    Q_PROPERTY( QString studyDate READ studyDate WRITE setStudyDate NOTIFY studyDateChanged )
    Q_PROPERTY( QString studyTime READ studyTime WRITE setStudyTime NOTIFY studyTimeChanged )
    Q_PROPERTY( QString institutionName READ institutionName WRITE setInstitutionName NOTIFY institutionNameChanged )
    Q_PROPERTY( QString readingPhysName READ readingPhysName WRITE setReadingPhysName NOTIFY readingPhysNameChanged )
    Q_PROPERTY( QString studyID READ studyTime WRITE setStudyID NOTIFY studyIDChanged )
    Q_PROPERTY( QString studyDesc READ studyDesc WRITE setStudyDesc NOTIFY studyDescChanged )
    Q_PROPERTY( QString refPhysName READ refPhysName WRITE setRefPhysName NOTIFY refPhysNameChanged )

    //series
    Q_PROPERTY( QString modality READ modality WRITE setModality NOTIFY modalityChanged )
    Q_PROPERTY( QString bodyPart READ bodyPart WRITE setBodyPart NOTIFY bodyPartChanged )
    Q_PROPERTY( QString seriesDesc READ seriesDesc WRITE setSeriesDesc NOTIFY seriesDescChanged )
    Q_PROPERTY( QString patientPos READ patientPos WRITE setPatientPos NOTIFY patientPosChanged )
    Q_PROPERTY( QString laterality READ laterality WRITE setLaterality NOTIFY lateralityChanged )

public:
        explicit QML_EditInfoObject(QObject *parent = 0);
        explicit QML_EditInfoObject(const QString &_patientID,
                             const QString &_patientName,
                             const QString &_patientKanaName,
                             const QString &_patientRomaName,
                             const QString &_sex,
                             const QString &_birthdate,
                             const QString &_accessionNumber,
                             const QString &_studyDate,
                             const QString &_studyTime,
                             const QString &_institutionName,
                             const QString &_readingPhysName,
                             const QString &_studyID,
                             const QString &_studyDesc,
                             const QString &_refPhysName,
                             const QString &_modality,
                             const QString &_bodyPart,
                             const QString &_seriesDesc,
                             const QString &_patientPos,
                             const QString &_laterality,
                             QObject * parent=0 );


    QML_EditInfoObject::QML_EditInfoObject(const QML_EditInfoObject &other)
    {
         *this=other;
    }

    QML_EditInfoObject & QML_EditInfoObject::operator =(const QML_EditInfoObject &other)
    {
        this->setPatientID(other.patientID());
        this->setPatientName(other.patientName());
        this->setPatientKanaName(other.patientKanaName());
        this->setPatientRomaName(other.patientRomaName());
        this->setSex(other.sex());
        this->setBirthdate(other.birthdate());

        this->setAccessionNumber(other.accessionNumber());
        this->setStudyDate(other.studyDate());
        this->setStudyTime(other.studyTime());
        this->setInstitutionName(other.institutionName());
        this->setReadingPhysName(other.readingPhysName());
        this->setStudyID(other.studyID());
        this->setStudyDesc(other.studyDesc());
        this->setRefPhysName(other.refPhysName());

        this->setModality(other.modality());
        this->setBodyPart(other.bodyPart());
        this->setSeriesDesc(other.seriesDesc());
        this->setPatientPos(other.patientPos());
        this->setLaterality(other.laterality());

        return *this;
    }

public:
        //Properties --------------------------
        QString patientID() const;
        void setPatientID(const QString &);

        QString patientName() const;
        void setPatientName(const QString &);

        QString patientKanaName() const;
        void setPatientKanaName(const QString &);
        QString patientRomaName() const;
        void setPatientRomaName(const QString &);


        QString sex() const;
        void setSex(const QString &);

        QString birthdate() const;
        void setBirthdate(const QString &);


        QString accessionNumber() const;
        void setAccessionNumber(const QString &);

        QString studyDate() const;
        void setStudyDate(const QString &);

        QString studyTime() const;
        void setStudyTime(const QString &);

        QString institutionName() const;
        void setInstitutionName(const QString &);

        QString readingPhysName() const;
        void setReadingPhysName(const QString &);

        QString studyID() const;
        void setStudyID(const QString &);

        QString studyDesc() const;
        void setStudyDesc(const QString &);

        QString refPhysName() const;
        void setRefPhysName(const QString &);


        QString modality() const;
        void setModality(const QString &);

        QString bodyPart() const;
        void setBodyPart(const QString &);

        QString seriesDesc() const;
        void setSeriesDesc(const QString &);

        QString patientPos() const;
        void setPatientPos(const QString &);

        QString laterality() const;
        void setLaterality(const QString &);
        //-------------------------------------

public:
        void clear();

signals:
        void patientIDChanged();
        void patientNameChanged();
        void sexChanged();
        void birthdateChanged();
        void patientKanaNameChanged();
        void patientRomaNameChanged();

        void accessionNumberChanged();
        void studyDateChanged();
        void studyTimeChanged();
        void institutionNameChanged();
        void readingPhysNameChanged();
        void studyIDChanged();
        void studyDescChanged();
        void refPhysNameChanged();

        void modalityChanged();
        void bodyPartChanged();
        void seriesDescChanged();
        void patientPosChanged();
        void lateralityChanged();

public slots:

private:
        QString m_patientID;
        QString m_patientName;
        QString m_patientKanaName;
        QString m_patientRomaName;
        QString m_sex;
        QString m_birthdate;

        QString m_accessionNumber;
        QString m_studyDate;
        QString m_studyTime;
        QString m_institutionName;
        QString m_readingPhysName;
        QString m_studyID;
        QString m_studyDesc;
        QString m_refPhysName;

        QString m_modality;
        QString m_bodyPart;
        QString m_seriesDesc;
        QString m_patientPos;
        QString m_laterality;

};

#endif // QML_QML_EditInfoObject_H
