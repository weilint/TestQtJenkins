#include "qml_imagelistobject.h"

QML_ImageListObject::QML_ImageListObject(QObject *parent) :
    QObject(parent)
{
}

QML_ImageListObject::QML_ImageListObject( const QString &_sopInstanceUID,
                                          const QString &_instanceNumber,
                                          const QString &_imageSource,
                                          QObject * parent)
            : QObject( parent )
            , m_sopInstanceUID( _sopInstanceUID )
            , m_instanceNumber( _instanceNumber )
            , m_imageSource( _imageSource )
{

}


QString QML_ImageListObject::sopInstanceUID() const {
     return m_sopInstanceUID;
}
void QML_ImageListObject::setSopInstanceUID(const QString &sopInstanceUID) {
    if ( sopInstanceUID != m_sopInstanceUID ) {
        m_sopInstanceUID = sopInstanceUID ;
        emit sopInstanceUIDChanged();
    }
}


QString QML_ImageListObject::instanceNumber() const {
     return m_instanceNumber;
}
void QML_ImageListObject::setInstanceNumber(const QString &instanceNumber) {
    if ( instanceNumber != m_instanceNumber ) {
        m_instanceNumber = instanceNumber ;
        emit instanceNumberChanged();
    }
}

QString QML_ImageListObject::imageSource() const {
     return m_imageSource;
}
void QML_ImageListObject::setImageSource(const QString &imageSource) {
    if ( imageSource != m_imageSource ) {
        m_imageSource = imageSource ;
        emit imageSourceChanged();
    }
}

