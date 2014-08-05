#include "qml_serieslistobject.h"

QML_SeriesListObject::QML_SeriesListObject(QObject *parent) :
    QObject(parent)
{
}

QML_SeriesListObject::QML_SeriesListObject(
                                            const QString &_seriesInstanceUID,
                                            const QString &_seriesNumber,
                                            const QString &_modality,
                                            const QString &_bodyPart,
                                            const QString &_seriesDesc,
                                            const QString &_patientPos,
                                            const QString &_laterality,
                                            const QList<QObject *> &_imageList,
                                          QObject * parent)
            : QObject( parent )
            , m_seriesInstanceUID(_seriesInstanceUID )
            , m_seriesNumber( _seriesNumber)
            , m_modality(_modality )
            , m_bodyPart( _bodyPart)
            , m_seriesDesc(_seriesDesc )
            , m_patientPos(_patientPos )
            , m_laterality(_laterality )
            , m_imageList( _imageList )
{

}

QList<QObject *> QML_SeriesListObject::imageList() const {
     return m_imageList;
}
void QML_SeriesListObject::setImageList(const QList<QObject *> &imageList) {
    if ( imageList != m_imageList ) {
        m_imageList = imageList ;
        emit imageListChanged();
    }
}

QString QML_SeriesListObject::seriesInstanceUID() const {
     return m_seriesInstanceUID;
}

void QML_SeriesListObject::setSeriesInstanceUID(const QString &seriesInstanceUID) {
    if ( seriesInstanceUID != m_seriesInstanceUID ) {
        m_seriesInstanceUID = seriesInstanceUID ;
        emit seriesInstanceUIDChanged();
    }
}


QString QML_SeriesListObject::seriesNumber() const {
     return m_seriesNumber;
}

void QML_SeriesListObject::setSeriesNumber(const QString &seriesNumber) {
    if ( seriesNumber != m_seriesNumber ) {
        m_seriesNumber = seriesNumber ;
        emit seriesNumberChanged();
    }
}



QString QML_SeriesListObject::modality() const {
     return m_modality;
}

void QML_SeriesListObject::setModality(const QString &modality) {
    if ( modality != m_modality ) {
        m_modality = modality ;
        emit modalityChanged();
    }
}

QString QML_SeriesListObject::bodyPart() const {
     return m_bodyPart;
}

void QML_SeriesListObject::setBodyPart(const QString &bodyPart) {
    if ( bodyPart != m_bodyPart ) {
        m_bodyPart = bodyPart ;
        emit bodyPartChanged();
    }
}


QString QML_SeriesListObject::seriesDesc() const {
     return m_seriesDesc;
}
void QML_SeriesListObject::setSeriesDesc(const QString &seriesDesc) {
    if ( seriesDesc != m_seriesDesc ) {
        m_seriesDesc = seriesDesc ;
        emit seriesDescChanged();
    }
}


QString QML_SeriesListObject::patientPos() const {
     return m_patientPos;
}
void QML_SeriesListObject::setPatientPos(const QString &patientPos) {
    if ( patientPos != m_patientPos ) {
        m_patientPos = patientPos ;
        emit patientPosChanged();
    }
}

QString QML_SeriesListObject::laterality() const {
     return m_laterality;
}
void QML_SeriesListObject::setLaterality(const QString &laterality) {
    if ( laterality != m_laterality ) {
        m_laterality = laterality ;
        emit lateralityChanged();
    }
}

int QML_SeriesListObject::numOfImages() const {
     return m_imageList.length();;
}

QList<QObject *> QML_SeriesListObject::getImageList()
{
    return m_imageList;
}

