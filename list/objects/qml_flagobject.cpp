#include "qml_flagobject.h"

QML_FlagObject::QML_FlagObject(QObject *parent) :
    QObject(parent)
{
}

QML_FlagObject::QML_FlagObject( const int &_flagID,
                                  const QString &_flagName,
                                  const QString &_flagIcon,
                                  QObject * parent)
    : QObject( parent )
    , m_flagID( _flagID )
    , m_flagName( _flagName )
    , m_flagIcon( _flagIcon )
{
}

int QML_FlagObject::flagID() const {
     return m_flagID;
}
void QML_FlagObject::setFlagID(const int &flagID) {
    if ( flagID != m_flagID ) {
        m_flagID = flagID ;
    }
}

QString QML_FlagObject::flagName() const {
     return m_flagName;
}
void QML_FlagObject::setFlagName(const QString &flagName) {
    if ( flagName != m_flagName ) {
        m_flagName = flagName ;
    }
}

QString QML_FlagObject::flagIcon() const {
     return m_flagIcon;
}
void QML_FlagObject::setFlagIcon(const QString &flagIcon) {
    if ( flagIcon != m_flagIcon ) {
        m_flagIcon = flagIcon ;
    }
}
