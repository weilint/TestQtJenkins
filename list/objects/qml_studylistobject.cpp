#include "qml_studylistobject.h"
#include "qml_serieslistobject.h"
#include "qml_imagelistobject.h"

#include <QTextCodec>
#define JTR( localString ) QTextCodec::codecForLocale()->toUnicode( localString )


QML_StudyListObject::QML_StudyListObject(QObject *parent) :
    QObject(parent)
{

}

QML_StudyListObject::QML_StudyListObject( const QString &_patientID,
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
                                  QObject * parent)
    : QObject( parent )
    , m_patientID( _patientID )
    , m_patientName( _patientName )
    , m_patientKanaName( _patientKanaName )
    , m_patientRomaName( _patientRomaName )
    , m_sex(_sex )
    , m_age(_age )
    , m_birthdate(_birthdate)

    , m_accessionNumber( _accessionNumber )
    , m_studyDate(_studyDate )
    , m_studyTime(_studyTime )
    , m_institutionName(_institutionName)
    , m_readingPhysName(_readingPhysName)
    , m_studyID(_studyID)
    , m_studyDesc(_studyDesc)
    , m_refPhysName(_refPhysName)
    , m_studyInstanceUID(_studyInstanceUID)
    , m_arrivedDateTime(_arrivedDateTime)
    , m_flagid(_flagid)

    , m_modality(_modality )
    , m_bodyPart( _bodyPart)    
    , m_seriesDesc(_seriesDesc )
    , m_patientPos(_patientPos )
    , m_laterality(_laterality )
    , m_sampleImage(_sampleImage )
    , m_numOfSerieses( 0 )
    , m_numOfImages( 0 )
{
}

QString QML_StudyListObject::patientID() const {
     return m_patientID;
}

void QML_StudyListObject::setPatientID(const QString &patientID) {
    if ( patientID != m_patientID ) {
        m_patientID = patientID ;
        emit patientIDChanged();

        m_patientSection = makePatientSection();
        emit patientSectionChanged();
    }
}


QString QML_StudyListObject::patientName() const {
     return m_patientName;
}
void QML_StudyListObject::setPatientName(const QString &patientName) {
    if ( patientName != m_patientName ) {
        m_patientName = patientName ;
        emit patientNameChanged();

        m_patientSection = makePatientSection();
        emit patientSectionChanged();
    }
}

QString QML_StudyListObject::patientKanaName() const {
     return m_patientKanaName;
}
void QML_StudyListObject::setPatientKanaName(const QString &_patientKanaName) {
    if ( _patientKanaName != m_patientKanaName ) {
        m_patientKanaName = _patientKanaName ;
        emit patientKanaNameChanged();
    }
}

QString QML_StudyListObject::patientRomaName() const {
     return m_patientRomaName;
}
void QML_StudyListObject::setPatientRomaName(const QString &_patientRomaName) {
    if ( _patientRomaName != m_patientRomaName ) {
        m_patientRomaName = _patientRomaName ;
        emit patientRomaNameChanged();
    }
}


QString QML_StudyListObject::sex() const {
     return m_sex;
}

void QML_StudyListObject::setSex(const QString &sex) {
    if ( sex != m_sex ) {
        m_sex = sex ;
        emit sexChanged();

        m_patientSection = makePatientSection();
        emit patientSectionChanged();
    }
}

QString QML_StudyListObject::age() const {
     return m_age;
}

void QML_StudyListObject::setAge(const QString &age) {
    if ( age != m_age ) {
        m_age = age ;
        emit ageChanged();

        m_patientSection = makePatientSection();
        emit patientSectionChanged();
    }
}

QString QML_StudyListObject::birthdate() const {
     return m_birthdate;
}
void QML_StudyListObject::setBirthdate(const QString &birthdate) {
    if ( birthdate != m_birthdate ) {
        m_birthdate = birthdate ;
        emit birthdateChanged();
    }
}

QString QML_StudyListObject::accessionNumber() const {
     return m_accessionNumber;
}

void QML_StudyListObject::setAccessionNumber(const QString &accessionNumber) {
    if ( accessionNumber != m_accessionNumber ) {
        m_accessionNumber = accessionNumber ;
        emit accessionNumberChanged();
    }
}


QString QML_StudyListObject::studyDate() const {
     return m_studyDate;
}

void QML_StudyListObject::setStudyDate(const QString &studyDate) {
    if ( studyDate != m_studyDate ) {
        m_studyDate = studyDate ;
        emit studyDateChanged();

        m_studySection = makeStudySection();
        emit studySectionChanged();
    }
}


QString QML_StudyListObject::studyTime() const {
     return m_studyTime;
}

void QML_StudyListObject::setStudyTime(const QString &studyTime) {
    if ( studyTime != m_studyTime ) {
        m_studyTime = studyTime ;
        emit studyTimeChanged();
    }
}


QString QML_StudyListObject::institutionName() const {
     return m_institutionName;
}
void QML_StudyListObject::setInstitutionName(const QString &institutionName) {
    if ( institutionName != m_institutionName ) {
        m_institutionName = institutionName ;
        emit institutionNameChanged();
    }
}

QString QML_StudyListObject::readingPhysName() const {
     return m_readingPhysName;
}
void QML_StudyListObject::setReadingPhysName(const QString &readingPhysName) {
    if ( readingPhysName != m_readingPhysName ) {
        m_readingPhysName = readingPhysName ;
        emit readingPhysNameChanged();
    }
}


QString QML_StudyListObject::studyID() const {
     return m_studyID;
}
void QML_StudyListObject::setStudyID(const QString &studyID) {
    if ( studyID != m_studyID ) {
        m_studyID = studyID ;
        emit studyIDChanged();
    }
}

QString QML_StudyListObject::studyDesc() const {
     return m_studyDesc;
}
void QML_StudyListObject::setStudyDesc(const QString &studyDesc) {
    if ( studyDesc != m_studyDesc ) {
        m_studyDesc = studyDesc ;
        emit studyDescChanged();
    }
}

QString QML_StudyListObject::refPhysName() const {
     return m_refPhysName;
}
void QML_StudyListObject::setRefPhysName(const QString &refPhysName) {
    if ( refPhysName != m_refPhysName ) {
        m_refPhysName = refPhysName ;
        emit refPhysNameChanged();
    }
}


QString QML_StudyListObject::studyInstanceUID() const {
     return m_studyInstanceUID;
}
void QML_StudyListObject::setStudyInstanceUID(const QString &studyInstanceUID) {
    if ( studyInstanceUID != m_studyInstanceUID ) {
        m_studyInstanceUID = studyInstanceUID ;
        emit studyInstanceUIDChanged();
    }
}



QString QML_StudyListObject::arrivedDateTime() const {
     return m_arrivedDateTime;
}
void QML_StudyListObject::setArrivedDateTime(const QString &arrivedDateTime) {
    if ( arrivedDateTime != m_arrivedDateTime ) {
        m_arrivedDateTime = arrivedDateTime ;
        emit arrivedDateTimeChanged();
    }
}

//int QML_StudyListObject::flagid() const {
//     return m_flagid;
//}

QString QML_StudyListObject::flagid() const {
     return m_flagid;
}

void QML_StudyListObject::setFlagid(const QString &flagid) {
    if ( flagid != m_flagid ) {
        m_flagid = flagid ;
        emit flagidChanged();
    }
}


//void QML_StudyListObject::setFlagid(const int &flagid) {
//    if ( flagid != m_flagid ) {
//        m_flagid = flagid ;
//        emit flagidChanged();
//    }
//}


QString QML_StudyListObject::modality() const {
     return m_modality;
}

void QML_StudyListObject::setModality(const QString &modality) {
    if ( modality != m_modality ) {
        m_modality = modality ;
        emit modalityChanged();
    }
}

QString QML_StudyListObject::bodyPart() const {
     return m_bodyPart;
}

void QML_StudyListObject::setBodyPart(const QString &bodyPart) {
    if ( bodyPart != m_bodyPart ) {
        m_bodyPart = bodyPart ;
        emit bodyPartChanged();
    }
}


QString QML_StudyListObject::seriesDesc() const {
     return m_seriesDesc;
}
void QML_StudyListObject::setSeriesDesc(const QString &seriesDesc) {
    if ( seriesDesc != m_seriesDesc ) {
        m_seriesDesc = seriesDesc ;
        emit seriesDescChanged();
    }
}


QString QML_StudyListObject::patientPos() const {
     return m_patientPos;
}
void QML_StudyListObject::setPatientPos(const QString &patientPos) {
    if ( patientPos != m_patientPos ) {
        m_patientPos = patientPos ;
        emit patientPosChanged();
    }
}

QString QML_StudyListObject::laterality() const {
     return m_laterality;
}
void QML_StudyListObject::setLaterality(const QString &laterality) {
    if ( laterality != m_laterality ) {
        m_laterality = laterality ;
        emit lateralityChanged();
    }
}


int QML_StudyListObject::numOfSerieses() const
{
    return m_seriesList.length();
}

//void QML_StudyListObject::setNumOfSerieses(const int &numOfSerieses)
//{
//    if ( numOfSerieses != m_numOfSerieses ) {
//        m_numOfSerieses = numOfSerieses ;
//        emit numOfSeriesesChanged();

//        m_seriesImageNumber = makeSeriesImageNumber();
//        emit seriesImageNumberChanged();
//    }
//}

int QML_StudyListObject::numOfImages() const
{
    return m_numOfImages;
}

int QML_StudyListObject::makeNumOfImages()
{
    int num = 0;
    for(int i = 0 ; i <  m_seriesList.length(); i++) {
          QML_SeriesListObject *series = (QML_SeriesListObject*)m_seriesList[i];
          num += series->imageList().length();
    }
    m_numOfImages = num;
    return num;
}

//void QML_StudyListObject::setNumOfImages(const int &numOfImages)
//{
//    if ( numOfImages != m_numOfImages ) {
//        m_numOfImages = numOfImages ;
//        emit numOfImagesChanged();

//        m_seriesImageNumber = makeSeriesImageNumber();
//        emit seriesImageNumberChanged();
//    }
//}


QString QML_StudyListObject::sampleImage() const {
     return m_sampleImage;
}

void QML_StudyListObject::setSampleImage(const QString &sampleImage) {
    if ( sampleImage != m_sampleImage ) {
        m_sampleImage = sampleImage ;
        emit sampleImageChanged();
    }
}

QString QML_StudyListObject::patientSection() const {
     return m_patientSection;
}

QString QML_StudyListObject::studySection() const {
     return m_studySection;
}

//------------

//------------



QString QML_StudyListObject::seriesImageNumber() const {    
    return m_seriesImageNumber;
}

QStringList QML_StudyListObject::flagList() const {
    return m_flagList;
}
void QML_StudyListObject::setFlagList(const QStringList &_flagList) {
    if (_flagList != m_flagList){
        m_flagList = _flagList;

        emit flagListChanged();
    }
}

QList<QObject *> QML_StudyListObject::seriesList() const {
     //qDebug() << QString("m_seriesList.length=%1").arg(m_seriesList.length());
     return m_seriesList;
}
void QML_StudyListObject::setSeriesList(const QList<QObject *> &seriesList) {
    //qDebug() << QString("seriesList.length=%1").arg(seriesList.length());

    if ( seriesList != m_seriesList ) {
        m_seriesList = seriesList ;

        m_numOfSerieses = seriesList.length();
        m_numOfImages = makeNumOfImages();
        m_seriesImageNumber = makeSeriesImageNumber();

        //qDebug() << QString("m_numOfSerieses=%1").arg(m_numOfSerieses);
        //qDebug() << QString("m_numOfImages=%1").arg(m_numOfImages);

        emit seriesListChanged();
        emit numOfSeriesesChanged();
        emit numOfImagesChanged();
        emit seriesImageNumberChanged();
    }
}


QString QML_StudyListObject::makePatientSection()
{
    QString s;
    QString sex_str = "";

    if(m_sex == "M")  sex_str = JTR("男");
    if(m_sex == "F")  sex_str = JTR("女");

    QString name = m_patientName;
    if(name.isEmpty()){
        name = m_patientKanaName;
    }
    if(name.isEmpty()){
        name = m_patientRomaName;
    }

    s = QString("%1^%2^%3%4 %5^").arg(m_patientID).arg(name).arg(m_age).arg(JTR("歳")).arg(sex_str);
    return s;
}

QString QML_StudyListObject::makeStudySection()
{
    QString s = m_studyDate;
    return s;
}


QString QML_StudyListObject::makeSeriesImageNumber()
{
    QString s;
    s = QString("%1-%2").arg(m_numOfSerieses).arg(m_numOfImages);
    return s;
}


//for test
//QList<QObject *> QML_StudyListObject::getSeriesList()
//{
//    return m_seriesList;
//}
