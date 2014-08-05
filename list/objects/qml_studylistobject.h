#ifndef QML_StudyListObject_H
#define QML_StudyListObject_H

#include <QObject>
#include <QDebug>

#include "../objects/qml_serieslistobject.h"
#include "../objects/qml_imagelistobject.h"

class QML_StudyListObject : public QObject
{

    Q_OBJECT
    //患者
    Q_PROPERTY( QString patientID READ patientID WRITE setPatientID NOTIFY patientIDChanged )
    Q_PROPERTY( QString patientName READ patientName WRITE setPatientName NOTIFY patientNameChanged )
    Q_PROPERTY( QString sex READ sex WRITE setSex NOTIFY sexChanged )
    Q_PROPERTY( QString age READ age WRITE setAge NOTIFY ageChanged )
    Q_PROPERTY( QString birthdate READ birthdate WRITE setBirthdate NOTIFY birthdateChanged )

    Q_PROPERTY( QString patientKanaName READ patientKanaName WRITE setPatientKanaName NOTIFY patientKanaNameChanged )
    Q_PROPERTY( QString patientRomaName READ patientRomaName WRITE setPatientRomaName NOTIFY patientRomaNameChanged )



    //検査
    Q_PROPERTY( QString accessionNumber READ accessionNumber WRITE setAccessionNumber NOTIFY accessionNumberChanged )
    Q_PROPERTY( QString studyDate READ studyDate WRITE setStudyDate NOTIFY studyDateChanged )
    Q_PROPERTY( QString studyTime READ studyTime WRITE setStudyTime NOTIFY studyTimeChanged )
    Q_PROPERTY( QString institutionName READ institutionName WRITE setInstitutionName NOTIFY institutionNameChanged )
    Q_PROPERTY( QString readingPhysName READ readingPhysName WRITE setReadingPhysName NOTIFY readingPhysNameChanged )
    Q_PROPERTY( QString studyID READ studyTime WRITE setStudyID NOTIFY studyIDChanged )
    Q_PROPERTY( QString studyDesc READ studyDesc WRITE setStudyDesc NOTIFY studyDescChanged )
    Q_PROPERTY( QString refPhysName READ refPhysName WRITE setRefPhysName NOTIFY refPhysNameChanged )
    Q_PROPERTY( QString studyInstanceUID READ studyInstanceUID WRITE setStudyInstanceUID NOTIFY studyInstanceUIDChanged )


    Q_PROPERTY( QString arrivedDateTime READ arrivedDateTime WRITE setArrivedDateTime NOTIFY arrivedDateTimeChanged )
    //Q_PROPERTY( int flagid READ flagid WRITE setFlagid NOTIFY flagidChanged )
    Q_PROPERTY( QString flagid READ flagid WRITE setFlagid NOTIFY flagidChanged )

    //シリーズ
    Q_PROPERTY( QString modality READ modality WRITE setModality NOTIFY modalityChanged )
    Q_PROPERTY( QString bodyPart READ bodyPart WRITE setBodyPart NOTIFY bodyPartChanged )
    Q_PROPERTY( QString sampleImage READ sampleImage WRITE setSampleImage NOTIFY sampleImageChanged )
    Q_PROPERTY( QString seriesDesc READ seriesDesc WRITE setSeriesDesc NOTIFY seriesDescChanged )
    Q_PROPERTY( QString patientPos READ patientPos WRITE setPatientPos NOTIFY patientPosChanged )
    Q_PROPERTY( QString laterality READ laterality WRITE setLaterality NOTIFY lateralityChanged )


    Q_PROPERTY( int numOfSerieses READ numOfSerieses NOTIFY numOfSeriesesChanged )
    Q_PROPERTY( int numOfImages READ numOfImages NOTIFY numOfImagesChanged )

    //series list
    Q_PROPERTY( QList<QObject *> seriesList READ seriesList WRITE setSeriesList NOTIFY seriesListChanged )

    Q_PROPERTY(QStringList flagList READ flagList WRITE setFlagList NOTIFY flagListChanged)
    //read only properties ---------
    //---------
    //患者セクション
    Q_PROPERTY( QString patientSection READ patientSection NOTIFY patientSectionChanged )

    //検査セクション
    Q_PROPERTY( QString studySection READ studySection NOTIFY studySectionChanged )

    //例1-22
    Q_PROPERTY( QString seriesImageNumber READ seriesImageNumber NOTIFY seriesImageNumberChanged )
    //-------------------------------


    //Q_INVOKABLE QList<QObject *> getSeriesList();


public:
    explicit QML_StudyListObject(QObject *parent = 0);

    explicit QML_StudyListObject(const QString &_patientID,
                         const QString &_patientName,
                         const QString &_patientKanaName,
                         const QString &_patientRomaName,
                         const QString &_sex,
                         const QString &_age,
                         const QString &_birthdate,

                         const QString &_accessionNumber,
                         const QString &_studyDate,
                         const QString &_studyTime,
                         const QString &_institutionName,
                         const QString &_readingPhysName,
                         const QString &_studyID,
                         const QString &_studyDesc,
                         const QString &_refPhysName,
                         const QString &_studyInstanceUID,

                         const QString &_arrivedDateTime,
                         //const int &_flagid,
                         const QString &_flagid,

                         const QString &_modality,
                         const QString &_bodyPart,
                         const QString &_seriesDesc,
                         const QString &_patientPos,
                         const QString &_laterality,
                         const QString &_sampleImage,
                         QObject * parent=0 );


    QML_StudyListObject::QML_StudyListObject(const QML_StudyListObject &other)
    {
         *this=other;
    }

    QML_StudyListObject & QML_StudyListObject::operator =(const QML_StudyListObject &other)
    {
        this->setPatientID(other.patientID());
        this->setPatientName(other.patientName());
        this->setPatientKanaName(other.patientKanaName());
        this->setPatientRomaName(other.patientRomaName());
        this->setSex(other.sex());
        this->setAge(other.age());
        this->setBirthdate(other.birthdate());

        this->setAccessionNumber(other.accessionNumber());
        this->setStudyDate(other.studyDate());
        this->setStudyTime(other.studyTime());
        this->setInstitutionName(other.institutionName());
        this->setReadingPhysName(other.readingPhysName());
        this->setStudyID(other.studyID());
        this->setStudyDesc(other.studyDesc());
        this->setRefPhysName(other.refPhysName());
        this->setStudyInstanceUID(other.studyInstanceUID());

        this->setFlagid(other.flagid());
        this->setArrivedDateTime(other.arrivedDateTime());

        this->setModality(other.modality());
        this->setBodyPart(other.bodyPart());
        this->setSeriesDesc(other.seriesDesc());
        this->setPatientPos(other.patientPos());
        this->setLaterality(other.laterality());

        this->setSampleImage(other.sampleImage());

        this->setSeriesList(other.seriesList());
        this->setFlagList(other.flagList());

        return *this;
    }

    //患者ID昇順、同一患者IDの場合は検査日降順
    static bool compare_pat(const QObject *d1,const QObject *d2)
    {
        QML_StudyListObject *t1 = (QML_StudyListObject *)d1;
        QML_StudyListObject *t2 = (QML_StudyListObject *)d2;
        if(t1->patientID() == t2->patientID()){
            QString s1 = t1->studyDate()+ t1->studyTime();
            QString s2 = t2->studyDate()+ t2->studyTime();
            return s1> s2;
        }else{
            return (t1->patientID() < t2->patientID());
        }
    }

    //検査日降順、同一検査日の場合は患者ID昇順
    static bool compare_study(const QObject *d1,const QObject *d2)
    {
        QML_StudyListObject *t1 = (QML_StudyListObject *)d1;
        QML_StudyListObject *t2 = (QML_StudyListObject *)d2;
        if(t1->studyDate() == t2->studyDate()){
            if(t1->studyTime() == t2->studyTime()){
                return (t1->patientID() < t2->patientID());
            }else{
                return (t1->studyTime() > t2->studyTime());
            }
        }else{
            return (t1->studyDate() > t2->studyDate());
        }
    }


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

    QString age() const;
    void setAge(const QString &);

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

    QString studyInstanceUID() const;
    void setStudyInstanceUID(const QString &);

    QString arrivedDateTime() const;
    void setArrivedDateTime(const QString &);

//    int flagid() const;
//    void setFlagid(const int &);
    QString flagid() const;
    void setFlagid(const QString &);

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


    int numOfSerieses() const;
//    void setNumOfSerieses(const int &);

    int numOfImages() const;
//    void setNumOfImages(const int &);

    QString sampleImage() const;
    void setSampleImage(const QString &);

    QList<QObject *> seriesList() const;
    void setSeriesList(const QList<QObject *> &);

    QStringList flagList() const;
    void setFlagList(const QStringList &);
    //-------------------------------------

    QString patientSection() const;
    QString studySection() const;
    QString seriesImageNumber() const;

signals:
    void patientIDChanged();
    void patientNameChanged();
    void patientKanaNameChanged();
    void patientRomaNameChanged();
    void sexChanged();
    void ageChanged();
    void birthdateChanged();

    void accessionNumberChanged();
    void studyDateChanged();
    void studyTimeChanged();
    void institutionNameChanged();
    void readingPhysNameChanged();
    void studyIDChanged();
    void studyDescChanged();
    void refPhysNameChanged();
    void studyInstanceUIDChanged();
    void arrivedDateTimeChanged();
    void flagidChanged();


    void modalityChanged();
    void bodyPartChanged();
    void seriesDescChanged();
    void patientPosChanged();
    void lateralityChanged();

    void numOfSeriesesChanged();
    void numOfImagesChanged();

    void sampleImageChanged();

    void seriesListChanged();
    void flagListChanged();

    void patientSectionChanged();
    void studySectionChanged();
    void seriesImageNumberChanged();

public slots:


private:
    QString m_patientID;
    QString m_patientName;
    QString m_patientKanaName;
    QString m_patientRomaName;
    QString m_sex;
    QString m_age;
    QString m_birthdate;

    QString m_accessionNumber;
    QString m_studyDate;
    QString m_studyTime;
    QString m_institutionName;
    QString m_readingPhysName;
    QString m_studyID;
    QString m_studyDesc;
    QString m_refPhysName;
    QString m_studyInstanceUID;

    //到着日時プロパティ
    QString m_arrivedDateTime;

    //フラグリストプロパティ
    //int m_flagid;
    QString m_flagid;

    //患者基本情報プロパティ
    //検査基本情報プロパティ

    QString m_modality;
    QString m_bodyPart;
    QString m_seriesDesc;
    QString m_patientPos;
    QString m_laterality;

    int m_numOfSerieses;
    int m_numOfImages;
    QString m_sampleImage;

    QString m_patientSection;
    QString m_studySection;
    QString m_seriesImageNumber;
    QList<QObject *> m_seriesList;
    QStringList m_flagList;

private:
    QString makePatientSection();
    QString makeStudySection();
    QString makeSeriesImageNumber();

    int makeNumOfImages();

};

#endif // QML_StudyListObject_H


