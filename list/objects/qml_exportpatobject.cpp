#include "qml_exportpatobject.h"

#include <QTextCodec>
#define JTR( localString ) QTextCodec::codecForLocale()->toUnicode( localString )

#include <QDebug>

QML_ExportPatObject::QML_ExportPatObject(QObject *parent) :
    QObject(parent)
{
}


QML_ExportPatObject::QML_ExportPatObject( const QString &_studyDate,
                                  const QString &_modality,
                                  const QString &_bodyPart,
                                  const QString &_numSeries,
                                  const QString &_numImg,
                                  const QString &_imgSource,
                                  const bool &_isSelected,
                                  QObject * parent)
    : QObject( parent )
    , m_studyDate( _studyDate )
    , m_modality( _modality )
    , m_bodyPart( _bodyPart )
    , m_numSeries( _numSeries )
    , m_numImg(_numImg )
    , m_imgSource(_imgSource )
    , m_isSelected(_isSelected)
{
}

QString QML_ExportPatObject::studyDate() const {
     return m_studyDate;
}

void QML_ExportPatObject::setStudyDate(const QString &studyDate) {
    if ( studyDate != m_studyDate ) {
        m_studyDate = studyDate ;
        emit studyDateChanged();
    }
}

QString QML_ExportPatObject::modality() const {
     return m_modality;
}

void QML_ExportPatObject::setModality(const QString &modality) {
    if ( modality != m_modality ) {
        m_modality = modality ;
        emit modalityChanged();
    }
}

QString QML_ExportPatObject::bodyPart() const {
     return m_bodyPart;
}

void QML_ExportPatObject::setBodyPart(const QString &bodyPart) {
    if ( bodyPart != m_bodyPart ) {
        m_bodyPart = bodyPart ;
        emit bodyPartChanged();
    }
}

QString QML_ExportPatObject::numSeries() const {
     return m_numSeries;
}

void QML_ExportPatObject::setNumSeries(const QString &numSeries) {
    if ( numSeries != m_numSeries ) {
        m_numSeries = numSeries ;
        emit numSeriesChanged();
    }
}

QString QML_ExportPatObject::numImg() const {
     return m_numImg;
}

void QML_ExportPatObject::setNumImg(const QString &numImg) {
    if ( numImg != m_numImg ) {
        m_numImg = numImg ;
        emit numImgChanged();
    }
}

QString QML_ExportPatObject::imgSource() const {
     return m_imgSource;
}

void QML_ExportPatObject::setImgSource(const QString &imgSource) {
    if ( imgSource != m_imgSource ) {
        m_imgSource = imgSource ;
        emit imgSourceChanged();
    }
}

bool QML_ExportPatObject::isSelected() const {
     return m_isSelected;
}

void QML_ExportPatObject::setIsSelected(const bool &isSelected) {
    if ( isSelected != m_isSelected ) {
        m_isSelected = isSelected ;        
        emit isSelectedChanged();
    }
}

