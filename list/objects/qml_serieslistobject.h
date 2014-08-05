#ifndef QML_SERIESLISTOBJECT_H
#define QML_SERIESLISTOBJECT_H

#include "../objects/qml_imagelistobject.h"
//　Global values ------------------

#include <QObject>

class QML_SeriesListObject : public QObject
{
    Q_OBJECT
public:
    explicit QML_SeriesListObject(QObject *parent = 0);
    explicit QML_SeriesListObject(const QString &_seriesInstanceUID,
                                  const QString &_seriesNumber,
                                  const QString &_modality,
                                  const QString &_bodyPart,
                                  const QString &_seriesDesc,
                                  const QString &_patientPos,
                                  const QString &_laterality,
                                  const QList<QObject *> &_imageList,
                                  QObject * parent=0 );

    //シリーズ
    Q_PROPERTY( QString seriesInstanceUID READ seriesInstanceUID WRITE setModality NOTIFY seriesInstanceUIDChanged )
    Q_PROPERTY( QString seriesNumber READ seriesNumber WRITE setModality NOTIFY seriesNumberChanged )
    Q_PROPERTY( QString modality READ modality WRITE setModality NOTIFY modalityChanged )
    Q_PROPERTY( QString bodyPart READ bodyPart WRITE setBodyPart NOTIFY bodyPartChanged )
    Q_PROPERTY( QString seriesDesc READ seriesDesc WRITE setSeriesDesc NOTIFY seriesDescChanged )
    Q_PROPERTY( QString patientPos READ patientPos WRITE setPatientPos NOTIFY patientPosChanged )
    Q_PROPERTY( QString laterality READ laterality WRITE setLaterality NOTIFY lateralityChanged )

    //image list
    Q_PROPERTY( QList<QObject *> imageList READ imageList WRITE setImageList NOTIFY imageListChanged )


    Q_PROPERTY( int numOfImages READ numOfImages NOTIFY numOfImagesChanged )

    Q_INVOKABLE QList<QObject *> getImageList();


public:
    QML_SeriesListObject::QML_SeriesListObject(const QML_SeriesListObject &other)
    {
         *this=other;
    }

    QML_SeriesListObject & QML_SeriesListObject::operator =(const QML_SeriesListObject &other)
    {
        this->setImageList(other.imageList());

        this->setSeriesInstanceUID(other.seriesInstanceUID());
        this->setSeriesNumber(other.seriesNumber());
        this->setModality(other.modality());
        this->setBodyPart(other.bodyPart());
        this->setSeriesDesc(other.seriesDesc());
        this->setPatientPos(other.patientPos());
        this->setLaterality(other.laterality());

     }

    //シリーズ番号の昇順
    static bool compare_seriesnum(const QObject *d1,const QObject *d2)
    {
        QML_SeriesListObject *t1 = (QML_SeriesListObject *)d1;
        QML_SeriesListObject *t2 = (QML_SeriesListObject *)d2;

        int n1  = 0;
        int n2 = 0;

        bool bRet = true;

        try{
            n1 = t1->seriesNumber().toInt();
            n2 = t2->seriesNumber().toInt();
        }catch(...){
        }

        bRet =  n1 <= n2? true:false;
        //qDebug() << n1 << n2 << "bRet=" <<bRet;

        return bRet;
    }


    //Properties --------------------------
    QList<QObject *> imageList() const;
    void setImageList(const QList<QObject *> &);

    QString seriesInstanceUID() const;
    void setSeriesInstanceUID(const QString &);

    QString seriesNumber() const;
    void setSeriesNumber(const QString &);

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

    int numOfImages() const;


    //-------------------------------------

signals:
    void imageListChanged();

    void seriesInstanceUIDChanged();
    void seriesNumberChanged();

    void modalityChanged();
    void bodyPartChanged();
    void seriesDescChanged();
    void patientPosChanged();
    void lateralityChanged();

    void numOfImagesChanged();



public slots:

private:
    QList<QObject *> m_imageList;

    QString m_seriesInstanceUID;
    QString m_seriesNumber;
    QString m_modality;
    QString m_bodyPart;
    QString m_seriesDesc;
    QString m_patientPos;
    QString m_laterality;


};

#endif // QML_SERIESLISTOBJECT_H
