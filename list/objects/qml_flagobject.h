#ifndef QML_FLAGOBJECT_H
#define QML_FLAGOBJECT_H

#include <QObject>

class QML_FlagObject: public QObject
{
    Q_OBJECT
    //patient
    Q_PROPERTY( int flagID READ flagID WRITE setFlagID )
    Q_PROPERTY( QString flagName READ flagName WRITE setFlagName )
    Q_PROPERTY( QString flagIcon READ flagIcon WRITE setFlagIcon )

public:
    explicit QML_FlagObject(QObject *parent = 0);
    explicit QML_FlagObject(const int &_flagID,
                         const QString &_flagName,
                         const QString &_flagIcon,
                         QObject * parent=0 );

    QML_FlagObject::QML_FlagObject(const QML_FlagObject &other)
    {
         *this=other;
    }

    QML_FlagObject & QML_FlagObject::operator =(const QML_FlagObject &other)
    {
        this->setFlagID(other.flagID());
        this->setFlagName(other.flagName());
        this->setFlagIcon(other.flagIcon());
        return *this;
    }

public:
        //Properties --------------------------
        int flagID() const;
        void setFlagID(const int &);

        QString flagName() const;
        void setFlagName(const QString &);

        QString flagIcon() const;
        void setFlagIcon(const QString &);

private:
        int m_flagID;
        QString m_flagName;
        QString m_flagIcon;

};

#endif // QML_FLAGOBJECT_H
