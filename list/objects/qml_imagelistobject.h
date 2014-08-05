#ifndef QML_IMAGELISTOBJECT_H
#define QML_IMAGELISTOBJECT_H

#include <QObject>
#include <QDebug>

class QML_ImageListObject : public QObject
{
    Q_OBJECT
    //image
    Q_PROPERTY( QString imageSource READ imageSource WRITE setImageSource NOTIFY imageSourceChanged )

    Q_PROPERTY( QString sopInstanceUID READ sopInstanceUID WRITE setSopInstanceUID NOTIFY sopInstanceUIDChanged )
    Q_PROPERTY( QString instanceNumber READ instanceNumber WRITE setInstanceNumber NOTIFY instanceNumberChanged )

public:
    explicit QML_ImageListObject(QObject *parent = 0);
    explicit QML_ImageListObject(
                                const QString &_sopInstanceUID,
                                const QString &_instanceNumber,
                                const QString &_imageSource,
                                QObject * parent=0 );

    QML_ImageListObject::QML_ImageListObject(const QML_ImageListObject &other)
    {
         *this=other;
    }

    QML_ImageListObject & QML_ImageListObject::operator =(const QML_ImageListObject &other)
    {
        this->setSopInstanceUID(other.sopInstanceUID());
        this->setInstanceNumber(other.instanceNumber());
        this->setImageSource(other.imageSource());
     }

    //Instance Numberの昇順
    static bool compare_instnum(const QObject *d1,const QObject *d2)
    {
        QML_ImageListObject *t1 = (QML_ImageListObject *)d1;
        QML_ImageListObject *t2 = (QML_ImageListObject *)d2;

        int n1  = 0;
        int n2 = 0;

        bool bRet = true;
        try{
            n1 = t1->instanceNumber().toInt();
            n2 = t2->instanceNumber().toInt();
        }catch(...){
        }

        bRet =  n1 <= n2? true:false;
        //qDebug() << n1 << n2 << "bRet=" <<bRet;

        return bRet;
    }


    //Properties --------------------------
    QString sopInstanceUID() const;
    void setSopInstanceUID(const QString &);

    QString instanceNumber() const;
    void setInstanceNumber(const QString &);

    QString imageSource() const;
    void setImageSource(const QString &);

    //-------------------------------------

signals:
    void sopInstanceUIDChanged();
    void instanceNumberChanged();
    void imageSourceChanged();

public slots:

private:
    QString m_sopInstanceUID;
    QString m_instanceNumber;
    QString m_imageSource;

};

#endif // QML_IMAGELISTOBJECT_H
