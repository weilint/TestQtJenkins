#ifndef QML_ExportPatObject_H
#define QML_ExportPatObject_H

#include <QObject>
#include <QDebug>

class QML_ExportPatObject : public QObject
{

    Q_OBJECT
    //患者
    Q_PROPERTY( QString studyDate READ studyDate WRITE setStudyDate NOTIFY studyDateChanged )
    Q_PROPERTY( QString modality READ modality WRITE setModality NOTIFY modalityChanged )
    Q_PROPERTY( QString bodyPart READ bodyPart WRITE setBodyPart NOTIFY bodyPartChanged )
    Q_PROPERTY( QString numSeries READ numSeries WRITE setNumSeries NOTIFY numSeriesChanged )
    Q_PROPERTY( QString numImg READ numImg WRITE setNumImg NOTIFY numImgChanged )
    Q_PROPERTY( QString imgSource READ imgSource WRITE setImgSource NOTIFY imgSourceChanged )
    Q_PROPERTY( bool isSelected READ isSelected WRITE setIsSelected NOTIFY isSelectedChanged )


public:
    explicit QML_ExportPatObject(QObject *parent = 0);

    explicit QML_ExportPatObject(const QString &_studyDate,
                         const QString &_modality,
                         const QString &_bodyPart,
                         const QString &_numSeries,
                         const QString &_numImg,
                         const QString &_imgSource,
                         const bool &_isSelected,
                         QObject * parent=0 );


    QML_ExportPatObject::QML_ExportPatObject(const QML_ExportPatObject &other)
    {
         *this=other;
    }

    QML_ExportPatObject & QML_ExportPatObject::operator =(const QML_ExportPatObject &other)
    {
        this->setStudyDate(other.studyDate());
        this->setModality(other.modality());
        this->setBodyPart(other.bodyPart());
        this->setNumSeries(other.numSeries());
        this->setNumImg(other.numImg());
        this->setImgSource(other.imgSource());
        this->setIsSelected(other.isSelected());

        return *this;
    }

    QString studyDate() const;
    void setStudyDate(const QString &);

    QString modality() const;
    void setModality(const QString &);

    QString bodyPart() const;
    void setBodyPart(const QString &);

    QString numSeries() const;
    void setNumSeries(const QString &);

    QString numImg() const;
    void setNumImg(const QString &);

    QString imgSource() const;
    void setImgSource(const QString &);

    bool isSelected() const;
    void setIsSelected(const bool &);

signals:
    void studyDateChanged();
    void modalityChanged();
    void bodyPartChanged();
    void numSeriesChanged();
    void numImgChanged();
    void imgSourceChanged();
    void isSelectedChanged();

private:
    QString m_studyDate;
    QString m_modality;
    QString m_bodyPart;
    QString m_numSeries;
    QString m_numImg;
    QString m_imgSource;
    bool m_isSelected;
};

#endif // QML_EXPORTPATOBJECT_H
