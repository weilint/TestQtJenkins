#include "qml_editinfoobject.h"

QML_EditInfoObject::QML_EditInfoObject(QObject *parent) :
    QObject(parent)
{
}

QML_EditInfoObject::QML_EditInfoObject( const QString &_patientID,
                                  const QString &_patientName,
                                  const QString &_patientKanatName,
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

                                  QObject * parent)
    : QObject( parent )
    , m_patientID( _patientID )
    , m_patientName( _patientName )
    , m_patientKanaName( _patientKanatName )
    , m_patientRomaName( _patientRomaName )
    , m_sex( _sex )
    , m_birthdate( _birthdate )

    , m_accessionNumber( _accessionNumber )
    , m_studyDate( _studyDate )
    , m_studyTime( _studyTime )
    , m_institutionName( _institutionName )
    , m_readingPhysName( _readingPhysName )
    , m_studyID( _studyID )
    , m_studyDesc ( _studyDesc )
    , m_refPhysName( _refPhysName )

    , m_modality( _modality )
    , m_bodyPart( _bodyPart)
    , m_seriesDesc( _seriesDesc )
    , m_patientPos( _patientPos )
    , m_laterality( _laterality)
{
}

QString QML_EditInfoObject::patientID() const {
     return m_patientID;
}
void QML_EditInfoObject::setPatientID(const QString &patientID) {
    if ( patientID != m_patientID ) {
        m_patientID = patientID ;
        emit patientIDChanged();
    }
}


QString QML_EditInfoObject::patientName() const {
     return m_patientName;
}
void QML_EditInfoObject::setPatientName(const QString &patientName) {
    if ( patientName != m_patientName ) {
        m_patientName = patientName ;
        emit patientNameChanged();
    }
}


QString QML_EditInfoObject::patientKanaName() const {
     return m_patientKanaName;
}
void QML_EditInfoObject::setPatientKanaName(const QString &_patientKanaName) {
    if ( _patientKanaName != m_patientKanaName ) {
        m_patientKanaName = _patientKanaName ;
        emit patientKanaNameChanged();
    }
}

QString QML_EditInfoObject::patientRomaName() const {
     return m_patientRomaName;
}
void QML_EditInfoObject::setPatientRomaName(const QString &_patientRomaName) {
    if ( _patientRomaName != m_patientRomaName ) {
        m_patientRomaName = _patientRomaName ;
        emit patientRomaNameChanged();
    }
}



QString QML_EditInfoObject::sex() const {
     return m_sex;
}
void QML_EditInfoObject::setSex(const QString &sex) {
    if ( sex != m_sex ) {
        m_sex = sex ;
        emit sexChanged();
    }
}

QString QML_EditInfoObject::birthdate() const {
     return m_birthdate;
}
void QML_EditInfoObject::setBirthdate(const QString &birthdate) {
    if ( birthdate != m_birthdate ) {
        m_birthdate = birthdate ;
        emit birthdateChanged();
    }
}


QString QML_EditInfoObject::accessionNumber() const {
     return m_accessionNumber;
}
void QML_EditInfoObject::setAccessionNumber(const QString &accessionNumber) {
    if ( accessionNumber != m_accessionNumber ) {
        m_accessionNumber = accessionNumber ;
        emit accessionNumberChanged();
    }
}


QString QML_EditInfoObject::studyDate() const {
     return m_studyDate;
}
void QML_EditInfoObject::setStudyDate(const QString &studyDate) {
    if ( studyDate != m_studyDate ) {
        m_studyDate = studyDate ;
        emit studyDateChanged();
    }
}


QString QML_EditInfoObject::studyTime() const {
     return m_studyTime;
}
void QML_EditInfoObject::setStudyTime(const QString &studyTime) {
    if ( studyTime != m_studyTime ) {
        m_studyTime = studyTime ;
        emit studyTimeChanged();
    }
}


QString QML_EditInfoObject::institutionName() const {
     return m_institutionName;
}
void QML_EditInfoObject::setInstitutionName(const QString &institutionName) {
    if ( institutionName != m_institutionName ) {
        m_institutionName = institutionName ;
        emit institutionNameChanged();
    }
}

QString QML_EditInfoObject::readingPhysName() const {
     return m_readingPhysName;
}
void QML_EditInfoObject::setReadingPhysName(const QString &readingPhysName) {
    if ( readingPhysName != m_readingPhysName ) {
        m_readingPhysName = readingPhysName ;
        emit readingPhysNameChanged();
    }
}


QString QML_EditInfoObject::studyID() const {
     return m_studyID;
}
void QML_EditInfoObject::setStudyID(const QString &studyID) {
    if ( studyID != m_studyID ) {
        m_studyID = studyID ;
        emit studyIDChanged();
    }
}

QString QML_EditInfoObject::studyDesc() const {
     return m_studyDesc;
}
void QML_EditInfoObject::setStudyDesc(const QString &studyDesc) {
    if ( studyDesc != m_studyDesc ) {
        m_studyDesc = studyDesc ;
        emit studyDescChanged();
    }
}

QString QML_EditInfoObject::refPhysName() const {
     return m_refPhysName;
}
void QML_EditInfoObject::setRefPhysName(const QString &refPhysName) {
    if ( refPhysName != m_refPhysName ) {
        m_refPhysName = refPhysName ;
        emit refPhysNameChanged();
    }
}


QString QML_EditInfoObject::modality() const {
     return m_modality;
}
void QML_EditInfoObject::setModality(const QString &modality) {
    if ( modality != m_modality ) {
        m_modality = modality ;
        emit modalityChanged();
    }
}

QString QML_EditInfoObject::bodyPart() const {
     return m_bodyPart;
}
void QML_EditInfoObject::setBodyPart(const QString &bodyPart) {
    if ( bodyPart != m_bodyPart ) {
        m_bodyPart = bodyPart ;
        emit bodyPartChanged();
    }
}

QString QML_EditInfoObject::seriesDesc() const {
     return m_seriesDesc;
}
void QML_EditInfoObject::setSeriesDesc(const QString &seriesDesc) {
    if ( seriesDesc != m_seriesDesc ) {
        m_seriesDesc = seriesDesc ;
        emit seriesDescChanged();
    }
}


QString QML_EditInfoObject::patientPos() const {
     return m_patientPos;
}
void QML_EditInfoObject::setPatientPos(const QString &patientPos) {
    if ( patientPos != m_patientPos ) {
        m_patientPos = patientPos ;
        emit patientPosChanged();
    }
}

QString QML_EditInfoObject::laterality() const {
     return m_laterality;
}
void QML_EditInfoObject::setLaterality(const QString &laterality) {
    if ( laterality != m_laterality ) {
        m_laterality = laterality ;
        emit lateralityChanged();
    }
}

void QML_EditInfoObject::clear()
{
    m_patientID = "";
    m_patientName="";
    m_sex="";
    m_birthdate="";

    m_accessionNumber="";
    m_studyDate="";
    m_studyTime="";
    m_institutionName= "";
    m_readingPhysName = "";
    m_studyID = "";
    m_studyDesc = "";
    m_refPhysName = "";

    m_modality="";
    m_bodyPart="";
    m_seriesDesc = "";
    m_patientPos = "";
    m_laterality = "";
}



